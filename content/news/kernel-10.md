+++
title = "Significant performance and correctness improvements to the kernel"
author = "Jacob Lorentzon (4lDO2)"
date = "2024-03-29T17:00:00+01:00"
+++

# Introduction

Ever since my demand paging RSoC project was completed last summer, there have
been numerous additional incremental improvements to the kernel, including
fixes, simplifications, and some significant optimizations. The changes can be
divided into the "correctness" and "performance" categories, even though there
is a relatively large overlap.

# Correctness

## Physalloc replacement and complete frame bookkeeping

Although the demand paging MR did formalize the different types of grants,
which previously merely indicated _where_ user memory areas were, and frames
got proper bookkeeping such as the refcount, that __was very much not the case
for physallocated frames.__ Requiring root, they were simply treated as "borrowed
physical memory" (`PhysBorrowed`), which is intended to be used by drivers to
map device memory or other pages, not controlled by the frame allocator. As a
result, some checks had to be worked around, and __driver bugs could cause kernel
memory corruption__.

This was fixed in the [phys_contiguous mmap
MR](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/265), which
replaces the physalloc syscalls with a special memory scheme file,
`/scheme/memory/phys_contiguous?<memory type>`, instead used together with
regular mmap. As a result, deallocation is fully automatic, and most
importantly, the kernel will now __deny any attempt to map allocator-owned
memory as "physically borrowed"__! This should protect against e.g. faulty ACPI
AML code, but if this rule turns out to be too restrictive, it only requires
one line of code to disable.

## TLB shootdown

Virtually all CPUs supporting virtual memory, have a Translation Lookaside
Buffer to cache commonly used mappings. This makes page unmaps in multithreaded
programs more complex, as they need to ensure the TLB is up-to-date in all
other threads before they can free the frames, a mechanism called _TLB
shootdown_. That involves interrupting the other CPUs to get them to flush
their TLBs, in a synchronized way. The signals MR described below
initially did not work due to double frees elsewhere, caused by the lack of TLB
shootdown. This has now been fixed.

## Improved signal handling

The previous signal code was problematic, in that it simply implemented
userspace-like signals except also in the kernel, by copying and restoring the
kernel stacks. This meant that a Ctrl-C interrupt could cause a thread to
`exit()` before running destructors, for example resulting in a bug [where
Orbital windows were not properly
closed](https://gitlab.redox-os.org/redox-os/kernel/-/issues/117).

This was fixed in the [signals
MR](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/283). Some
schemes need to implement scheme call cancellation, however, before interrupted
syscalls can fully work.

## Misc

Additionally, bjorn3 has fixed a lot of UB and other bugs in the kernel,
including the part that bootstraps into userspace, as well as deduplicate most
i686 and x86_64 code. The userspace-bootstrap change makes it easier to add
support for other bootloaders, such as GRUB, by integrating the bootstrap
executable (which is responsible for setting up a stack, opening standard file
descriptors, and creating the environment necessary to start the relibc
userspace, and execute init) into the initfs image.

An important fix as part of that, is that the initfs image including bootstrap,
is no longer mapped to address 0x0. This proves once again how important it is
not to create any Rust reference to NULL, which in this case confused bootstrap
thinking a `Some(&initfs_memory)` was `None`, as the slice pointed to NULL!

# Performance

## Kernel profiling

Normally when optimizing userspace applications, profiling can be done easily
using e.g. `perf record` or an integrated tool such as `cargo flamegraph`. When
profiling a kernel however, the sampling part needs to be implemented from
scratch. The current implementation uses non-maskable interrupt IPIs to
interrupt other CPUs at scheduled intervals, which is necessary since
interrupts are disabled almost everywhere in kernel mode. The NMI handler
tracks whether the CPU was interrupted in user or kernel mode, and in the
latter case, performs a stack trace and sends it to a ring buffer, which a new
daemon `profiled` reads from, and extracts into a `perf`-compatible text
format.

Profiling userspace is yet to be implemented, possibly both as combined
userspace and kernel profiling, or just userspace.

With profiling enabled, this allows producing awesome
[flamegraphs](https://brendangregg.com/flamegraphs.html), using
[inferno](https://github.com/jonhoo/inferno)! At the time profiling was
implemented, __the following is what it looked like when booting and starting
NetSurf:__

[![Profiling SVG for boot and starting NetSurf](/img/flamegraphs/boot-and-netsurf-before.svg)](/img/flamegraphs/boot-and-netsurf-before.svg)

(Click on the flamegraphs to open them interactively.)

As the flamegraph suggests, a very significant part of the time spent in the
kernel, is spent allocating frames, in `rmm::BuddyAllocator`. In fact, in
some cases a massive performance boost from [demand paging](/news/kernel-9) may
have been strengthened in part because frame allocation was simply very slow.
But even with demand paging, __it accounted for roughly 35% of total boot
time__ (in the kernel, after the arch-specific initialization):

[![Profiling SVG for boot](/img/flamegraphs/boot-before.svg)](/img/flamegraphs/boot-before.svg)

## New p2buddy frame allocator

The obvious optimization target, apart from context switching (which at the
time was blocked by the problematic signal handling code), was therefore the
frame allocator.

Originally, pre-2020, the Redox kernel used a recycling allocator on top of a
bump allocator, which essentially stored an array (a `Vec`) of `(base, frame
count)` that could be merged or split. In 2020, the Redox Memory Manager (RMM)
[was
introduced](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/155#5c18a8ea7df607b2fa2c8d143a8eced7e7449795),
which provided a more optimized _buddy allocator_.

However, __both the recycling allocator and RMM's buddy allocator, were _O(n)___,
w.r.t. the __total number of allocatable frames__. The recycling allocator had
to iterate through an array that could theoretically grow to half of the
allocatable frames (maximum fragmentation), whereas the RMM buddy allocator had
to iterate through _usage arrays_ to find a sufficient number of contiguous
frames, without an optimized way to allocate in larger units. Since the
majority of frame allocations were only single-frame, as they had to be
allocatable and deallocatable independently, even the RMM buddy allocator
turned out to be relatively slow.

Although the RMM buddy allocator could probably have been optimized further, it
would be advantegous to reuse the already existing `PageInfo`s, which store the
refcount of userspace-owned pages to implement both CoW `MAP_PRIVATE` and
`MAP_SHARED` mmaps. That space is __not used when the frame is free, so why not
use it as the frame allocator data structure__?

The power-of-two buddy (p2buddy) allocator, uses the two words in each
`PageInfo` to implement a doubly-linked list per _order_, i.e. the
log<sub>2</sub> of the number of frames for an allocation, and stores that
order in the unused pointer bits. One bit is used to distinguish between used
and free frames, and must not be overwritten except by the allocator. The list
heads are stored as a global array. This p2buddy allocator is similar to buddy
allocators found in other kernels, such as Linux and FreeBSD.

The allocator now only supports power-of-two allocation sizes, called
_p2frames_, where the orders can currently range from 0 to 10, inclusive. It
looks for the smallest possible p2frame large enough for the allocation, and
possibly splits it into smaller p2frames. Freeing frames makes it look for free
neighboring p2frames, merging them into a higher-order p2frame if possible.
This algorithm is guaranteed to take _O(k)_ steps, w.r.t. the (constant) number
of orders _k_. Thus, __the new allocator is _O(1)_ w.r.t. the total number
total frames available__.

The new flamegraph when simply booting, is now instead:

[![Profiling SVG for boot, p2buddy](/img/flamegraphs/boot-after.svg)](/img/flamegraphs/boot-after.svg)

The time spent inside the frame allocator, has almost disappeared entirely, and
comprises only the 0.9% slice in the bottom-left corner. Additionally, NetSurf
now starts significantly faster, and the boot time has also been reduced. For
Jeremy, the boot time was reduced from 4s to 3s!

Of course, memory allocation overhead can still be significant for other
workloads, and there are lots of future optimizations to be made.

## Syscall optimization

With the signal MR having flattened the kernel stacks, the syscall prologue and
epilogue code that kept track of where the userspace registers were, could be
removed. Most of the ptrace and debug logic was moved to the context switch
code, and some other improvements were made. On a CPU where the hardware
`syscall`+`sysret` latency is 56 cycles, the latency changed (roughly) as
follows, from these optimizations:

- August 2023, initial: 344 cycles (-0%, cumulative)
- After signal MR: 236 cycles (-31%)
- Caching ptrace breakpoint state: 184 cycles (-47%)
- Using saved regs directly for syscall debugging: 116 cycles (-66%)

Thus, the majority of the syscall latency on Redox __is now almost spent in the
syscall/sysret microcode itself__. It can probably be optimized further, even
though performance may be reduced slightly once Spectre mitigations are
properly implemented. Worth noting that this is the _base syscall latency_,
i.e. the time it takes to do an invalid syscall that returns `ENOSYS`, and not
the time spent in the various syscalls themselves. That said, most simple
syscalls, such as `sigprocmask`, do not take more than a few hundred cycles to
run.

# Conclusion

This year, there have been numerous improvements both to the kernel's
correctness, as well as raw performance. The signal and TLB shootdown MRs have
significantly improved kernel memory integrity and possibly eliminated many
hard-to-debug and nontrivial [heisenbugs](https://en.wikipedia.org/wiki/Heisenbug). Nevertheless, there is still a lot of
work to be done optimizing and fixing bugs in relibc, in order to improve
compatibility with ported applications, and most importantly of all, getting
closer to a self-hosted Redox.

<style>
img[alt="Profiling SVG for boot and starting NetSurf"] { width: 100% }
img[alt="Profiling SVG for boot"] { width: 100% }
img[alt="Profiling SVG for boot, p2buddy"] { width: 100% }
</style>
