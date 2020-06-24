+++
title = "RSoC: improving drivers and kernel (largely io_uring)"
author = "4lDO2"
date = "2020-06-24T00:45:43+02:00"
+++

# Introduction
This is my first year of Redox Summer of Code, and my intent is continuing my
prior work (outside of RSoC) on improving the Redox drivers and the kernel. I
started this week by quite a minor change: implementing a more advanced syscall
for allocating physical memory, namely `physalloc3`. Unlike the more basic
`physalloc` which only takes a size as parameter, `physalloc3` also takes a
flags and minimal size; this allows a driver to request a large range and fall
back to multiple small ranges, if the physical memory space were to be too
fragmented, by using scatter-gather lists (a form of vectored I/O like `preadv`
for hardware). It also adds support for 32-bit-only allocation for devices that
do not support the entire 64-bit physical address space.

# `io_uring`
However, the arguably most interesting thing that I have worked on this week,
is a Redox-flavored `io_uring` interface, which is very similar to [the Linux
`io_uring` kernel interface for asynchronous
I/O](https://kernel.dk/io_uring.pdf), although with a few major differences.
The idea, just as with Linux, is to use two kernel-managed SPSC queues (rings)
as an alternative syscall interface, rather than relying on a direct context
switch to the kernel, via register parameters and the syscall instruction;
instead, a syscall is made by pushing a new entry onto the _Completion Queue_,
then doing other useful work, and then eventually popping an entry from the
_Completion Queue_, which indicates that the syscall has completed with a
specific return value. This has numerous advantages, apart from being more
complicated than traditional syscalls:

* A userspace process __has its own control of whether to proceed execution__,
  or to `SYS_YIELD` to the kernel, since making a syscall does not involve
  context switching to the scheme serving the syscall, and then context
  switching back, if the scheduling time has not already passed.
* The API is __completion-based rather than readiness-based__, which might be
  unnecessary for networking applications where events are triggered from the
  outside, but for disk I/O it is much more performant and suitable, since a
  disk will not initiate a read before the filesystem has asked for that disk
  block. By using the readiness-model the filesystem will have to initially
  read once, then register the fd to an event queue, and then read again.
  Writes are even more complex, since there is not really a way to consistently
  poll the progress of a write without passing the entire buffer again to the
  scheme.
* __The context switches are heavily reduced__; the only syscall taking place
  at all is the one for waiting (frequent), and one for attaching an `io_uring`
  onto a scheme capable of responding to the requests (initialization).
* __Latency can be heavily lowered__, due to the queues being lock-free and with
  more sophisticated kernel scheduling, it is not impossible for a realtime audio
  driver to be run in parallel with an application using it, only reading and writing
  to shared memory.

Unlike the Linux implementation, the Redox `io_uring` is mainly focused on
being between userspace schemes (and between userspace and kernel for things
like faster event queues), rather than being a bridge between the monolithic
kernel and userspace.

I will not cover all details, but I have started writing [a work-in-progress
RFC for that](https://gitlab.redox-os.org/redox-os/rfcs/-/merge_requests/15)
which is intended to cover all the details.

As of now, I have managed to get ring initialization and the preliminary data
structures to work properly, together with a successfully sent dummy submission
from `usbscsid` to `xhcid`, albeit with neither any notification system nor any
proper buffer management (required since schemes obviously do not have access
to the entire address space of the user process).

This week I will figure out how the notification system is going to work; the
problem with no _direct_ kernel involvement is that the kernel will have to
poll the ring header itself. Additionally, I will add additional opcodes, and
try getting `usbscsid` to talk to `xhcid` using the API.
