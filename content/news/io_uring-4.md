+++
title = "RSoC: improving drivers and kernel - part 4 (largely io_uring)"
author = "4lDO2"
date = "2020-07-26T10:47:50+02:00"
+++

# Introduction
This week has been mostly about advancing the interface as much as possible,
with the goal of being the default for pcid, xhcid, and usbscisd, as I
previously mentioned. With the introduction of the `AsyncScheme` trait, I have
now actually been able to operate the `pci:` scheme socket (well, `:pci`)
completely asynchronously and with io_uring, by making the in-kernel
`RootScheme` async too.

## Consumer/producer instances
I began this week by making it clearer in-kernel, which contexts are known as
"producers", and which ones are known as "consumers". As the names imply, the
producers are the processes or usually the kernel, that receives SQEs,
processes them, and sends CQEs. Similarly, the producers, also being either a
process or the kernel (direct kernel-to-kernel io_uring communication never
happens though), sends SQEs and receives CQEs. Having separated these types of
rings into separate enum variants, it became much easier reasoning about
in-kernel io_uring handles.

## `impl AsyncScheme for RootScheme`
The RootScheme is now the first kernel scheme to implement the `poll_handle`
fn! This means, that io_uring will not block within the kernel if the file
descriptors used in system calls belong to that scheme. While the biggest and
the most important challenge is making `UserScheme` async, there is at least
one scheme now that has requests that can wake a possible infinite time to
complete, that doesn't block internally. Consequently, `pcid` was now able to
receive an SQE directly from `xhcid`, albeit with now handling for that.

## Almost there, PCI!
The `pcid_interface` part should already be finished for the most part; it now
supports io_uring, with the predecessor, pipes where the fds are shared using
environment variables, deprecated (I presume I would also deprecate the old
process-arguments interface as well). There is a possibility that a few
arguments of some functions may change there, but apart from that, that part
needs not that much more work.

However, most of the io_uring code actually happens within
[`redox-iou`](https://gitlab.redox-os.org/redox-os/redox-iou), and the
newly-separated crate
[`redox-buffer-pool`](https://gitlab.redox-os.org/redox-os/redox-buffer-pool),
which handle the actual OS interface. The goal someday, is for these to
eventually be integrated into `mio`, and hence, `tokio`. While I managed to get
all types of io_urings, be it userspace-to-userspace, userspace-to-kernel, and
kernel-to-userspace working (not tested, and not fully implemented in the
kernel yet), there is one limitation currently: memory and buffer management.

## `redox-buffer-pool`
Userspace-to-userspace and kernel-to-userspace is easy; the kernel manages all
the memory for us, as it's man-in-the-middle for all syscalls there! With
userspace-to-userspace io_urings however, all the kernel can do is to make
io_uring memory management easier, but the processes will still need some
method of systematically sharing buffers for syscalls.

Initially included within `redox-iou`, `redox-buffer-pool` has become it's own
crate, with the purpose of providing a memory allocator that gives out chunks
with an arbitrary size and alignment, from larger chunks of memory that
originate from e.g. mmap. It also supports "guards", which prevent slices
within a buffer pool from being reclaimed (dropping may also leak if it has
to), until the guard allows that. For io_uring futures, this would mean that
the future will have a guard tied to its state-`Arc`, that is released when the
`Arc` has been dropped (it stores a `Weak`), or when the future has
transitioned to the `Finished` or `Canceled` states.

This crate may and will probably also be used for drivers to manage physical
memory shared between drivers and hardware, which is conceptually similar, but
requires some extra functionality (like making sure a single buffer slice
doesn't overlap the underlying physical memory allocations).

It's not completely finished yet (in fact the allocator is currently O(n) in
worst case, but this is something that I _will_ fix soon).

# TODO
Now that I have gotten producers and secondary consumers to work with
`redox-iou` (the "secondary" means that it's a userspace-to-userspace ring,
controlled by a userspace-to-kernel ring), I also need to get the buffer pool
working as well, so that the `pcid` interface can transfer data between
drivers, safely and fast.

And, I also unfortunately need to get the new compiler submodule merged, with
all the patches required for that.
