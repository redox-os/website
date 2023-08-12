+++
title = "RSoC: on-demand paging"
author = "4lDO2"
date = "2023-07-07T12:00:00+02:00"
+++

# Introduction

Today it's been three weeks since my 4th RSoC started, where the main focus
this time is to speed up Redox by implementing on-demand paging in the kernel.

But first...

# `usercopy`

Yesterday, [a huge (+2356 -1724)
MR](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/219) was
merged, that fundamentally changed the way the kernel accessed user memory,
mainly passed from of syscall arguments, but also to some extent when handling
signals.

Previously, the kernel relied on `validate_*` functions, e.g. (not the exact
kernel code):

```rust
pub unsafe fn validate_slice<'a>(base: *const u8, len: usize) -> Result<&'a [u8]> {
    check_pages_tables_or_return_efault(base, len)?;
    Ok(core::slice::from_raw_parts(base, len))
}

pub unsafe fn validate_str<'a>(base: *const u8, len: usize) -> Result<&'a str> { ... }

pub fn syscall(num: usize, b: usize, c: usize, d: usize, ...) -> Result<usize> {
    match num {
        SYS_OPEN => open(unsafe { validate_str(b as *const u8, c) }, d),
        // ...
    }
}

pub fn open(path: &str, flags: usize) -> Result<usize> {
    // parse scheme_name:path from `path`, then call scheme.open(...)
}
```

However, there are multiple downsides with this approach. First, checking page
tables can be relatively expensive, not necessarily because tree walking is
slow, but also since the page table needs to be locked. Secondly, one of the
requirements for creating both `&[u8]`s and `&mut [u8]`s, is that the memory is
not allowed to be mutated (except when using the `&mut [u8]` itself), which is
not necessarily true for multithreaded programs, and very impractical to
enforce. Worse, when such slices are converted to strings, they are
utf8-checked once, which is valid under the assumption that immutable slices
cannot be mutated, but if another userspace thread would "de-utf8-ize" the
string between the time-of-check and time-of-use, kernel UB was theoretically
possible.

The current post-usercopy kernel, instead uses a different API (again pseudocode):

```rust
pub fn syscall(num: usize, b: usize, c: usize, d: usize, ...) -> Result<usize> {
    match num {
        SYS_OPEN => open(UserSlice::ro(b, c)?, d),
        SYS_PIPE2 => pipe2(UserSlice::wo(b, 2 * size_of::<usize>())?, c),
        // ...
    }
}

pub fn open(path_raw: UserSliceRo, flags: usize) -> Result<usize> {
    let path: String = path_raw.copy_to_string()?;

    // parse scheme_name:path from `path`, then scheme.open(...)
}
// (deprecated syscall, but a good example)
pub fn pipe2(fds_out: UserSliceWo, flags: usize) -> Result<()> {
    let (new_read_fd, new_write_fd) = { ... };

    let (read_fd_out, write_fd_out) = fds_out.split_at(size_of::<usize>())
        .ok_or(Error::new(EINVAL))?;

    read_fd_out.write_usize(new_read_fd)?;
    write_fd_out.write_usize(new_write_fd)?;
    
    Ok(())
}
```

Rather than verifying page tables, the kernel copies memory between userspace
and kernel buffers, inside an arch-specific assembly-written function. Should a
page fault occur, if it was caused by an invalid read or write, and if the
instruction pointer happens to be inside that function, the handler will make
it return early, and setting the return value to an error code. The fast path
is almost as fast as memcpy, and does not need to lock anything. (On aarch64,
the usercopy function is implemented as an unoptimized byte-granular loop,
simply because I don't know how to write a fast one.)

The places where UTF-8 is required, there are now some unnecessary heap
allocations, but since path-based system calls are not as common as data-based
system calls, there is no visible performance regression at least.

Since the kernel strictly separates user (`< USER_END_OFFSET`) and kernel
memory, so that no Rust slices/references can point to anything but kernel
memory, the `UserSlice` API is, excluding the functions that read a struct
(which can be fixed by using a safe transmute crate), entirely Safe Rust.

### UMIP, SMEP, and SMAP

The `usercopy` MR also enables, on x86_64, the UMIP, SMEP, and SMAP features if
available.

- UMIP forbids certain harmless system instructions (e.g. `SGDT` and
    `SIDT`) that can nevertheless leak kernel addresses.
- SMEP forbids the kernel
    from executing memory on any page that is also accessible from userspace.
- SMAP forbids the kernel from similarly _accessing_ any user memory, with the
    necessary exception of when `EFLAGS.AC == 1`. That flag can be cleared and
    set, respectively, using `CLAC` and `STAC`, and is only set inside the
    usercopy function. This feature both protects against exploits, and
    enforces the invariant that user memory can only be accessed by usercopy.

## Head/tail buffers

The current `UserScheme` implementation, which is currently the main IPC
primitive the Redox kernel provides, maps the buffer pages from the caller to
the scheme directly. Mapping pages does nevertheless require page-alignment,
and [head/tail pages have previously been able to leak data to the scheme
handlers](https://gitlab.redox-os.org/redox-os/kernel/-/issues/82). A temporary
workaround has been to require scheme handlers to run as root. The fix is to
use the syscall_head/syscall_tail pages, present in each context, copy
head/tail bytes into those pages, and then separately map those pages and the
middle pages, contiguously into the range the scheme handler can use. The
root-only restriction has not yet been lifted, but it may be soon.

This fix was also included in the `usercopy` MR.

## Pipe scheme

While this change is not nearly as significant as `usercopy`, on-demand paging,
or the other upcoming kernel MRs, the `pipe:` scheme has been rewritten, and
new pipes can now be opened using `open("pipe:", ...)`, to create a new pipe
and get the read fd, and `dup(read_fd, "write")` to get the write fd.

As a result, the `SYS_PIPE2` syscall has been deprecated, and replaced with
open+dup in relibc, and will eventually be removed when userspace no longer
uses it.

# On-demand paging

Aside from finishing the usercopy MR, I have primarily been working on
on-demand paging.

When allocating new memory using `mmap`, the redox kernel currently allocates
all memory up front, and populates the page tables directly. Most modern
kernels on the other hand implement on-demand paging, i.e. remember what
mappings are present in an address space, but allocate or copy-on-write pages
lazily when page faults occur. As a result, system calls such as _fork(2)_, or
Redox's corresponding `dup(addr_space_fd, "exclusive")`, will copy pages by
reference, remap them as immutable, and then copy on write.

Redox's memory management system needs to support MAP_PRIVATE/MAP_SHARED
anonymous mmaps, non-allocator-owned physmap, borrowing pages from one address
space into another (for `UserScheme`), and managing `UserScheme`-provided fmaps
(used when mmapping `UserScheme`-owned file descriptors).

Although the current usercopy branch temporarily needs to disable `multi_core`,
and does not yet fully re-implement partial fmap, it does decrease the boot
time, including qemu and bootloader, from 4.4s to 3.2s.

# TODO

As previously stated, the short-term goal is to make the on-demand paging
branch ready enough for an MVP MR to be submitted. This would entail fixing
page refcount synchronization, maybe TLB shootdown (unimplemented both on my
branch and on master), partial-size mmap, and verify the implementation is
correct.

Some features are not yet implemented, such as `msync`, `madvise`, swap, page
fault readahead, and perhaps necessarily, TLB shootdown. It would also be
interesting to see how much performance can be improved by using x86_64
process-context identifiers, huge pages, and although not as
performance-related, maybe even implement 5-level paging.

Additionally, I have been working on other kernel MRs, e.g. [simplifying kernel
stacks and improving signal
handling](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/225),
and [dynamic CPU-based kernel code
optimization](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/203),
which I plan on finishing either directly after the MVP on-demand paging MR has
been merged, or after working on additional memory-management features.

Out-of-memory conditions are not handled either, but they aren't handled on the
master branch yet, so that shouldn't at least be required for the MVP.
