+++
title = "RSoC: improving drivers and kernel - part 1 (largely io_uring)"
author = "4lDO2"
date = "2020-07-02T19:26:00+02:00"
+++

# Introduction
This week has been quite productive for the most part. I continued updating
[the RFC](https://gitlab.redox-os.org/redox-os/rfcs/-/merge_requests/15), with
some newer ideas that I came up while working on the implementation, most
imporantly how the kernel is going to be involved in `io_uring` operation.

I also came up with a set of standard opcodes, that schemes are meant to use
when using `io_uring`, unless in some special scenarios (like general-purpose
IPC between processes). The opcodes at this point in time, can be found
[here](https://doc.redox-os.org/io_uring/syscall/io_uring/v1/enum.StandardOpcode.html).

## The three attachment modes
The most notable change that I made, is that instead of always attaching an
`io_uring` between two userspace processes, there can be attachments directly
from the userspace to the kernel (and vice versa), which is much more similar
to how `io_uring` on Linux works, except that Redox has two additional
"attachment modes".  The three of them are:

* userspace-to-kernel, where the userspace is the producer and the kernel is
  the consumer. In this mode, the ring can (or rather, is supposed to be able
  to) either be polled by the kernel at the end of scheduling, for e.g. certain
  ultra-low-latency drivers, or the default: the kernel only processes the
  entries during the `SYS_ENTER_IORING` syscall. The reason behind this mode,
  is that if the `io_uring` interface is going to be used more by the Redox
  userspace, it may not be that efficient to have one ring per consumer process
  per producer process; with this mode, there only has to be one ring (or more)
  from the userspace to kernel, and then the kernel can designate syscalls
  directed to other schemes, when those are used by the file descriptors. Then,
  there will be only one ring from the kernel to that producer scheme.
* kernel-to-userspace, which is nothing but the opposite of the
  userspace-to-kernel mode. Schemes can be attached by other userspace
  processes, or the kernel (as mentioned above), and when attached, they
  function the exact same way as with regular scheme handles; they
* userspace-to-userspace, the both the producer and consumer of an `io_uring`
  are regular userspace processes. Just as with the userspace-to-kernel mode,
  these are attached with the `SYS_ATTACH_IORING` syscall, and except for
  realtime polling, one process waits for the other using `SYS_ENTER_IORING` as
  with userspace-to-kernel. The primary usecase for this type of ring is
  low-latency communication between drivers, e.g. between pcid and xhcid when
  masking MSI interrupts. One potential alternative to this would be futexes.

## Updating `rustc`
This was probably the least fun part of this week. Not that it is required for
`io_uring`s to function properly, but async/await could really help in some
situtations, for example when storing pending submissions to handle. While
async/await has been there since stable 1.39, only recently has it worked in
`#![no_std]`. It turned out that the nightly version that Redox used for
everything, was nigthly-2019-11-25, and so I decided to use the latest version
(also for the newer `asm!` macro). Somehow the master branch from the official
rust repository was capable of compiling all of Redox (there may be some parts
that require patching anyways, but I could run the system out-of-the-box, just
like with the older compiler). I hope that it won't be too hard to correctly
submit the patches to every repo with the `llvm_asm` change, and get it to
integrate with the cookbook. Anyways, hooray!

## TODO
Currently only a few opcodes are implemented by the kernel, and my next goal is
to implement a superset of the scheme syscalls, and allow most of the regular
syscalls to be bypassed as an `io_uring` submission, but completely
non-blocking. Additionally, I'm trying to get an asynchronous executor to work
with the API, which would be really nice to have for nearly every usecase (both
nvmed and xhcid already use async, but it'd be nicer not having to write your
own executor for every driver).

With this executor, I'm going to try getting `usbscsid` to be completely async
and talk to `xhcid` uring `io_uring`, and let `xhcid` mask MSI interrupts by
talking to `pcid` with `io_uring` as well.

I'll also see whether at some point in the future, it could be possible to be
compatible with the Linux `io_uring` API; perhaps it won't have to be syscall
compatible (even if that would work), but porting `liburing` would certainly
benefit.

I'd really appreciate any kind of feedback if possible.
