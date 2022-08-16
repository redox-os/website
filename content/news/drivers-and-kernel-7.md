+++
title = "RSoC: improving drivers and kernel - part 7"
author = "4lDO2"
date = "2022-08-16T12:00:00+02:00"
+++

# Introduction

In my last blog post, I introduced the `userspace_fexec`/`userspace_clone`
features. As the names suggest, they move the inherently complex
implementations of `fork(3)` and `execve(2)`, from the kernel into relibc,
giving userspace much more freedom while simplifying the kernel. There has been
considerable progress since last post; __the features
`userspace_fexec`/`userspace_clone`, `userspace_initfs`, and
`userspace_initfs`, have now all been merged!__

## RMM

After having thoroughly debugged the orbital/orblogin memory corruption bug
with little success, I decided to go as far as phase out the old paging code
(`ActivePageTable`/`InactivePageTable`/`Mapper` etc.) in favor of RMM (Redox
Memory Manager). Surprisingly, this fixed the bug entirely in the process, and
it turns out the issue was simply that parent page tables were not properly
unmapped (causing use-after-free), most likely due to the coexistence of RMM
and the old paging code, which did not agree on how the number of page table
entries were counted.

## Userspace initfs

I mentioned moving initfs to userspace as a TODO from last post. The changes
required were very simple: rather than having the bootloader pass a physical
address range containing the initfs image, and then letting the kernel load
bootstrap from within the filesystem, it now simply loads a "bootstrap/initfs
blob" into (virtual) memory at 0x0, and jumps to an address provided by the
bootloader. The bootloader loads both `/kernel`, `/bootstrap`, and `/initfs`,
the latter two of which are put adjacently in physical address space.

This also means `bootstrap` will now fork into both a scheme handler serving
`initfs:` from the initfs memory, and for executing init.

## Userspace cwd and userspace path canonicalization

Redox used to expose two system calls, `chdir` and `getcwd`, also a TODO from
last post, which get and set the current working directory (identical to
POSIX). This would modify an internal `cwd` string in each kernel context, used
for canonicalizing paths while handing path-based syscalls (`open`, `chmod`
(now removed in favor of `fchmod`), `unlink`, and `rmdir`), allowing e.g.
`open("./foo", O_RDONLY) => open("file:/path/to/foo", O_RDONLY)`. Now that
`userspace_cwd` is merged however, the kernel will only allow
already-canonicalized paths, i.e. enforce that both the scheme name and path
are present. Hence, relibc will instead canonicalize the paths itself, and
`chdir`/`getcwd` are implemented simply by accessing a global variable
(although `sigprocmask` is run before and after). This global variable is
passed in execve using auxiliary vectors.

But most importantly, the `SYS_OPEN` handler in the kernel, no longer resolves
cross-scheme symlinks (i.e. handles EXDEV internally), which has also been
moved to relibc. While also reducing the number of file operations initiated
from the kernel, it reduces the amount of state needed for syscall handlers,
which will be very helpful for a possible syscall multiplexing API
(userspace-to-kernel io_uring).

Hopefully at some point, most if not all syscalls on Redox will be fully
completion-based, i.e. the caller sends a request, waits (if blocking), and
then asynchronously runs completion code (either returning from a blocking
syscall, or in the future pushing an io_uring CQE). In the process, the kernel
may become "stackless", i.e. use the same kernel stack for all processes, and
thereby reduce the memory footprint of contexts (threads) by an order of
magnitude.

# TODO

Luckily, the userspace initfs TODO, and fixing the orbital/orblogin bug, have
both been finished!

On-demand paging is still not yet implemented, even though I have written a
large part of it. This would allow optimizing ld.so and relibc's execve, by
calling mmap with CoW in order to load ELF segments, which is especially
important when running rustc on Redox.

The syscall interface has also not been reworked either, but there is a clear
need for overcoming the limitations of `Packet` (such as being limited to 4
args per scheme op), so the io_uring SQE format will very likely be used by
scheme handlers soon, with or without using fancy ring buffers for passing
them.

`PTRACE_EVENT_CLONE` is now sent to tracers, although some work is still needed
there, and the `acid ptrace` test should be re-introduced (this was an issue
before userspace_fexec too).

I also tried implementing (basic) KASLR as a side project, and succeeded,
although with a visible performance cost (not sure why). It would also be
interesting to implement regular userspace ASLR in the relibc fexec handler and
possibly `ld.so`.
