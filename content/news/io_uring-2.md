+++
title = "RSoC: improving drivers and kernel - part 2 (largely io_uring)"
author = "4lDO2"
date = "2020-07-09T21:18:10+02:00"
+++

# Introduction
This week has initially been mostly minor bug fixes for the redox_syscall and
kernel parts. I began the week by _trying_ to get pcid to properly do _all_ of
its scheme logic, which it hasn't previously done (its IPC is currently, only
based on passing command line arguments, or pipes). This meant that the kernel
could no longer simply process the syscalls immediately (which I managed to do
with non-blocking syscalls such as SYS_OPEN and SYS_CLOSE) by invoking the
scheme functions directly from the kernel. So for [the `FilesUpdate`
opcode](https://doc.redox-os.org/io_uring/syscall/io_uring/v1/enum.StandardOpcode.html#variant.FilesUpdate),
I then tinkered a bit with the built-in event queues in the kernel, by adding a
method to register interest of a context that will block on the event, and by
allowing non-blocking polls of the event queues. Everything seemed to work
fine, until:

## The overestimated bug
At the very moment I added `context::switch` to the `io_uring_enter` syscall
impl, and ran it, the entire system became blocked. While it would make perfect
sense for `pcid` itself to block, since that was the process calling
`io_uring_enter`, the rest of the system just... froze. Since I had experienced
a similar freeze when working with interrupts in the drivers (which were
deadlock related), I unconciously assumed that it had something to do with
faulty event queues or a faulty scheduler, also due to a more recent freeze
seen my me and jD91mZM2, where `ahcid` blocked and the entire system froze.

After about four days of debugging, as I had kept failing to find the bug in
the kernel that caused this, I saw that `init` actually blocked on every
process it spawned, and simply assumed that they would eventually fork (or
finish, like pcid did previously). So, the solution was four lines of code that
forked `pcid` after its initialization, but before it began to block on scheme
requests. That said, I still think the scheduler could get some extra care...

## Progress!
After I had solved the bug, I experimented with writing an executor for this
new kernel API for async I/O, which can be found
[here](https://gitlab.redox-os.org/redox-os/redox-iou.git). Since Rust futures
are based on the readiness model, where futures are polled once, and when they
return `Poll::Pending`, they tell their reactor to begin using their waker, and
to eventually notify them. This is very easy to implement for readiness-based
I/O, since they only have to poll, and then add their waker to an `epoll` loop.
However, since `io_uring` is completion based, there has to be some state
management going on, since the `io_uring` doesn't remember what a syscall did
when it's complete.

Inspired by [withoutboats's blog
post](https://without.boats/blog/ringbahn-ii/), I came up with an executor that
_either_ associated syscalls with a unique tag that's increment upon every new
future, and then let the reactor (which can be integrated or not into the
executor) wake up the corresponding future when it receives a completion entry,
or stored `Weak` references as a raw pointer directly in the user data of each
submission/completion entry. The former is meant for the scenario when you
don't trust the scheme you are using, while the latter allows the producer to
modify pointers, which is obviously unsafe, and should only be allowed when the
kernel is the producer.

## TODO
Even though I was delayed by a few days due to this extremely simple bug, __I
did manage to get `pcid` to properly operate on a scheme socket, solely by
using my executor and `io_uring`!__ Still, everything isn't completely async
yet within the kernel (`FilesUpdate` is though!), but it would probably not be
that hard to get Redox's event queues to properly use a dedicated `Waker` to
make the rest of the syscalls asynchronous. I also plan on getting the rest of
the Rust async ecosystem to work asynchronously with this, but for me, it's a
higher priority to get this interface to the drivers first.

So last week's TODO still applies here: getting the `pcid` <=> `xhcid` <=>
`usbscsisd` communication to be completely based on `io_uring`.
