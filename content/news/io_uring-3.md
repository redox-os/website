+++
title = "RSoC: improving drivers and kernel - part 3 (largely io_uring)"
author = "4lDO2"
date = "2020-07-17T16:49:39+02:00"
+++

# Introduction
After the last week where I was mainly blocked by the bug about blocking init,
I've now been able to make further progress with the io_uring design. I have
improved the `redox-iou` crate, which is Redox's own liburing alternative, to
support a fully-features buffer pool allocator meant for userspace-to-userspace
io_urings (where the kernel can't manage memory); to work with multiple
secondary rings other than the main kernel ring; and to support spawning which
you would expect from a proper executor in `tokio` or `async-std`.

# `AsyncScheme`
So, one of the main issues with writing a new completely non-blocking interface
where the previous interface sometimes blocks (or rather, blocks on syscall
level, not operation level; Redox does have event queues and
nonblocking I/O mainly for networking, but the syscalls aren't asynchronous in
the way that one can do multiple at at time without internally blocking, like
io_uring requires). I quickly realized as I started to implement the io_uring
opcodes, that I would have to reimplement every syscall from scratch, which
obviously isn't that good, especially for an already quite complex API like
io_uring.

So, the Redox syscalls are mainly based on the `Scheme` trait (and other
related traits), which is used both by userspace processes like `redoxfs` or
`nvmed` for their schemes, and for internal kernel schemes, such as `event:`,
`irq:` or `debug:`, and the in-kernel `UserScheme`, that abstracts away buffer
management and such when a process is involved in handling a syscall. The
`Scheme` trait is mainly blocking, but it does support toggling the
`O_NONBLOCK` flag by using `fcntl`.

However, even though the kernel schemes _can_ be nonblocking, almost every
single one of them will block the current context (which means either process
or a thread. Redox is quite flexible with the actual difference of a thread and
a process; they are all contexts, that decide what to share and what not to
share between each other when forking). The current way that the kernel handles
situations where blocking is required, is by calling `context::switch`, which
will tell the scheduler to keep continuing and update more processes, until the
context that was switched away due to blocking, is unblocked, and can continue
the syscall.

So, I came up with the `AsyncScheme` trait, which defines only a single new
function, namely `poll_handle`. What this function is supposed to be doing, is
to let the scheme know beforehand, that the caller does not want the scheme to
block during the processing of that packet. It's defined as the following:

```rust
pub trait AsyncScheme: Scheme {
    #[allow(unused_variables)]
    unsafe fn poll_handle(&self, packet: &mut Packet, cx: &mut task::Context<'_>) -> task::Poll<()> {
        task::Poll::Ready(self.handle(packet))
    }
}
```

As you can see, this looks quite like the `AsyncRead` and `AsyncWrite` traits
from `futures`; instead of directly returning a future, which Rust currently
doesn't support, they force the implementor to keep track of the state
themselves. While this is not the ideal solution in all cases, it actually
works pretty well for schemes, since most schemes in userspace store a vec of
syscalls to process once they get updatable.

This also comes with the `AsyncSchemeExt` trait, that wraps every scheme
method, into a method returning a future.

# Asyncifying the kernel syscalls
As previously mentioned, to avoid having to rewrite every syscall as an async
fn, I changed the existing syscalls to be `async fn`, and wrote a macro that
defines a corresponding `.*_sync` function, that will poll the syscall future,
and then context switch when the future returns `Poll::Pending`. This changes
nothing whatsoever for regular syscalls, except that they block outside the
syscall function, rather than inside. This means that the io_uring kernel
handler, can use the async functions instead, and prevent complete blocking.

Since the io_uring has three different modes, userspace-to-kernel,
kernel-to-userspace, userspace-to-userspace, this would also allow these async
syscall handlers, to _maybe_ use the kernel's kernel-to-userspace ring, as a
replacement for the regular scheme packet mechanism, for the schemes that
support io_urings.

# Better `pcid` IPC
I also began to improve the IPC between `pcid` and subdrivers, like `xhcid` and
`nvmed`, to support io_uring. This is what lead to writing a buffer pool with
an included general-purpose size+align allocator (which in fact should be able
to function as the global allocator for a Rust program, although it would
presumably be quite slow for that purpose). The `pcid` IPC is one of the main
examples of where io_uring gives additional benefits, mostly since it needs to
be called by another process every time an MSI interrupt is masked or unmasked.

# TODO
While the current `redox-iou` executor and reactor works fine for processes
that _use_ io_urings, it doesn't yet have the functionality for processes that
are the producers of an io_uring, for example `pcid`, which needs to do IPC. It
should be straitforward to implement this, for the most part.

I also need to implement buffer pool sharing within the kernel, to let the
producer process be able to automatically access new buffers that the consumer
process needs. This is not _that_ important for `pcid`, but a file system and
its disk driver would certainly want to have a fast buffer pool between them,
where the kernel would automagically mmap the buffers for the other process
directly.

I should probably also update the RFC at some point.

And yes, the `pcid` <=> `xhcid` <=> `usbscsid` io_uring-backed IPC remains.
