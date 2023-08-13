+++
title = "RSoC: on-demand paging II"
author = "4lDO2"
date = "2023-08-11T12:00:00+02:00"
+++

# Introduction

Today is the end of the last week of RSoC, and most importantly, I'm happy to
announce that the [MVP for demand
paging](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/238) has
now been merged!

## aarch64 and i686

Before merging, the demand paging implementation was ported to i686 and
aarch64. The i686 port was trivial, due to its similarity to x86_64 (they are
to some extent the same arch). The page fault code was modeled after x86_64.

When porting it to aarch64 however, I did discover that (on master) the `x18`
register was being overwritten each time there was an exception or interrupt,
for debug purposes! Turns out that page faulting when accessing almost every
new page, is a great way to stress-test saving/restoring registers!

## Complete grant bookkeeping

The ownership of `Grant`s, which are the Redox equivalent of the entries in
`/proc/<pid>/maps` on Linux, is now properly tracked, fixing [this
issue](https://gitlab.redox-os.org/redox-os/kernel/-/issues/123). Each grant
has a _provider_, which is one of the following types:

```
pub enum Provider {
    /// The grant is owned, but possibly CoW-shared.
    ///
    /// The pages this grant spans, need not necessarily be initialized right away, and can be
    /// populated either from zeroed frames, the CoW zeroed frame, or from a scheme fmap call, if
    /// mapped with MAP_LAZY. All frames must have an available PageInfo.
    Allocated { cow_file_ref: Option<GrantFileRef> },

    /// The grant is owned, but possibly shared.
    ///
    /// The pages may only be lazily initialized, if the address space has not yet been cloned (when forking).
    ///
    /// This type of grants is obtained from MAP_SHARED anonymous or `memory:` mappings, i.e.
    /// allocated memory that remains shared after address space clones.
    AllocatedShared { is_pinned_userscheme_borrow: bool },

    /// The grant is not owned, but borrowed from physical memory frames that do not belong to the
    /// frame allocator.
    PhysBorrowed { base: Frame },

    /// The memory is borrowed directly from another address space.
    External { address_space: Arc<RwLock<AddrSpace>>, src_base: Page, is_pinned_userscheme_borrow: bool },

    /// The memory is MAP_SHARED borrowed from a scheme.
    ///
    /// Since the address space is not tracked here, all nonpresent pages must be present before
    /// the fmap operation completes, unless MAP_LAZY is specified. They are tracked using
    /// PageInfo, or treated as PhysBorrowed if any frame lacks a PageInfo.
    FmapBorrowed { file_ref: GrantFileRef, pin_refcount: usize },
}
```

## (almost) Complete frame bookkeeping

The kernel previously didn't store any metadata about physical memory frames,
allowing malicious schemes to continue using `munmap`ped pages that were
temporarily mapped to those schemes (automatically by the kernel, provided
those pages were used as syscall arguments to that scheme). A scheme that
unmapped its pages would also risk a use-after-free, if that scheme had
provided those pages when handling an fmap call. Although root is still
currently required to run schemes, this lack of frame bookkeeping was one of
the reasons root was required.

The current kernel stores a `PageInfo` for _each_ page that the kernel's frame
allocator can return.

```
pub struct PageInfo {
    /// Stores the reference count to this page, i.e. the number of present page table entries that
    /// point to this particular frame.
    ///
    /// Bits 0..=N-1 are used for the actual reference count, whereas bit N-1 indicates the page is
    /// shared if set, and CoW if unset. The flag is not meaningful when the refcount is 0 or 1.
    pub refcount: AtomicUsize,

    // (not currently used)
    pub _flags: FrameFlags,
}
```

The way they are organized is very similar to Linux, at least according to
their documentation. A global variable, called `SECTIONS`, contains an array of
"sections", i.e. `(base_frame: Frame, pages: &'static [PageInfo])`, based on
the bootloader memory map. The page arrays can be at most 32,768 entries, or
128 MiB with the x86_64 4096 byte page size (the optimal size is yet to be
determined).

The refcount is incremented/decremented for every new mapping created to or
removed from any frame, and those updates are as atomic (wait-free) as
`std::sync::Arc`.

However, there is one inconvenient exception to this: `physalloc` and
`physfree`. Until those syscalls are removed and replaced by e.g. `mmap(...,
MMAP_PHYS_CONTIGUOUS)`, the kernel cannot currently enforce that all allocator
pages are properly tracked.

Once this is done, it will be possible to enforce that `PhysBorrowed` grants,
obtained mostly by drivers to access MMIO, cannot access any owned memory by
other processes on the system. In particular, this will naturally sandbox the
AML interpreter from being able to (directly) maliciously modify memory it's
not supposed to access.

Another even more useful possibility, is to make `PageInfo` a union,
additionally encompassing other types of frames used by the kernel, such as
frames for the kernel heap, and most importantly, paging structures. By
tracking refcounts of paging structures, together with x86's TLB that ANDs the
"writable" flag of all tree levels, it will be possible to make the page tables
CoW as well in Redox's current `fork` equivalent, possibly even allowing O(1)
forks, with respect to the number of mapped pages.

While Redox does not yet allow userspace to map large (2 MiB on x86_64) and/or
huge (1 GiB on x86_64) pages, storing 511 or in the extreme case 262,143
useless `PageInfo`s, is of course not efficient. This can either be solved by
preallocating the expected number of `PageInfo`s, use the unused space for e.g.
opportunistic caches, or allow dynamically resizing `PageInfo`s.

## `physmap` deprecation

The `physunmap` system call was removed in the earlier usercopy MR, but now the
`physmap` system call has additionally been deprecated, and replaced by the
mmapping `memory:physical@<memory type>`. Possible memory types are
_uncacheable_, _write-combining_, and the regular _writeback_ memory type.

This comes with the benefit, once the `physmap` syscall is removed, of being
able to restrict the ability to borrow device physical memory via namespaces,
even for processes running as root (the concept of a root user on Redox is
temporary).

## improved fmap interface

The mmap interface used by schemes, have been improved, from

```
fn fmap(&self, id: usize, map: &Map) -> Result<usize>;
fn funmap(&self, address: usize, length: usize) -> Result<usize>;

struct Map {
    offset: usize,
    size: usize,
    flags: MapFlags,
    address: usize, // bad API: only used by the syscaller
}

```

to

```
fn mmap_prep(&self, id: usize, offset: u64, size: usize, flags: MapFlags) -> Result<usize>;
fn munmap(&self, id: usize, offset: u64, size: usize, flags: MunmapFlags) -> Result<usize>;
```

The kernel no longer needs to create a temporary mapping for the `Map` struct
to be read. Schemes are now expected to track the number of mappings to each
file range, which the new
[`range-tree`](https://gitlab.redox-os.org/redox-os/range-tree) crate can be
used for.

# TODO

Some of the TODOs I mentioned in the [previous blog post](/news/kernel-8), are still TODOs:

-   Proper synchronized TLB shootdown is still unimplemented. While the current
    excessive amount of TLB flushing makes TLB use-after-free bugs very rare, I
    did notice that when omitting some unnecessary flushes, page fault
    heisenbugs sometimes started appearing.
-   Although the current implementation is visibly faster in QEMU and on some
    real hardware, there has not yet been any significant performance tuning,
    such as eagerly mapping pages up to a certain limit, or making page faults
    map multiple sequential pages. Additionally, the CPU caches can be used
    better by using large or huge pages for the kernel's linear mapping of
    physical frames (like Linux does), and possibly using an LRU cache for
    frame allocation as well.
-   `madvise` and `mlock` are not implemented yet, and by extension, swap.
    - The scheme traits (`Scheme`, `SchemeMut`, `SchemeBlock`, and
        `SchemeBlockMut`) are not ideal, as they use rely on a shell script to
        autogenerate the latter three traits based on the first one. This makes
        extending the trait, e.g. to allow one-way kernel-to-scheme messages,
        much more time consuming than necessary.
-   OOM is still not handled. But since the current signal handler
    relies on `Vec::clone` to clone kernel stacks, which allocates memory
    before signals are even possible to send, it might make more sense to wait
    for [the signal
    MR](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/225) to be
    merged first. (OOM handling is tracked in [this
    issue](https://gitlab.redox-os.org/redox-os/kernel/-/issues/78).)
-   It would be a good idea to document this new memory management code, as the
    current "memory management" Book section is currently empty.
