+++
title = "RSoC: improving drivers and kernel - part 5 (largely io_uring)"
author = "4lDO2"
date = "2021-07-11T12:00:00+02:00"
+++

# Introduction

It's been some time since my last blog post last summer, so in this one I will
attempt to summarize everything that I have done related to io_uring this first
month of RSoC, but also a bit during the year.

## Nearly full block-freedom

Last summer, while the interface was at least more or less usable at that time,
many schemes still internally blocked, thus limiting the number of SQEs that
can run simultaneously, to one. With the help of some Async Rust, all schemes
except some ptrace logic in `proc:` no longer blocks. That said, I am probably
not going to use async in the near future, as it may not be that flexible for
kernel code, especially when the only existing "leaf future" is
`WaitCondition`.

Not directly related to blocking, but I have also fixed io_uring when
`#[cfg(feature = "multi_core")]` is used, where a synchronization problem
arises since you don't want to have ten thousand locked mutexes. This requires
an additional flag in each context, and in fact I discovered a [data
race](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/167),
although it only became a problem on the io_uring branch.

## Various interface improvements

The first thing I did, was to cleanup the interface itself. Previously I used
two different types of SQEs and CQEs, one for 32-bit and 64-bit values each.
This turned out to be quite messy in the codebase, both kernel and userspace,
especially when every function had to be generic over the SQE and CQE types,
and could potentially also hurt performance if there would have to be runtime
branching between the different two structures. Now, there is only the 64-byte
`SqEntry` and a 16-byte `CqEntry`, which are the same sizes as the Linux
io_uring entries. However, as Redox allows full 64-bit return values e.g. from
mmap, two CQEs can be chained into an "extended" CQE if a single one is not
sufficient.

Additionally, I have removed the push/pop epochs, as they have very little
benefit compared to simply reading the head and tail indices directly when
figuring out whether to notify or not, in polling mode. In the extreme case of
64-bit index overflow, there would simply have to be lock and blocking
notification somewhere. I have also added support for an indirect SQE array,
which the Linux interfaces currently forces, but on Redox it will remain
optional. And finally, optimized some operations at ring structure level,
mostly reducing sometimes-expensive atomic operations.

# TODO

Outside of simply cleaning up a lot of code that currently uses async, I am
also going to spend a lot of time trying to optimize io_uring. The problem with
the current approach of using `async fn`, is that regular blocking syscalls
will have extra overhead due to io_uring requiring async, and at the moment the
size of the futures is quite embarrasing (6192 bytes, but this is because [some
functions](https://gitlab.redox-os.org/4lDO2/kernel/-/blob/7e5e1818662b0c5c814345f648ab8d70097659e3/src/syscall/fs.rs#L169)
normally allocate on the stack. Moving these allocations to the heap, the size
would probably still be a couple hundred bytes due to the complex
compiler-generated state machines, but that would hurt performance of blocking
syscalls as well). Instead, I will be using regular functions, but instead
store the state in a per-context runqueue, which hopefully can be no more than
32 bytes.

As of now, the only real userspace components that I have used io_uring in is a
forked `drivers` branch. I used that mainly to test the interface, but now I
will instead start using it in the NVME driver. The NVME hardware interface is
conceptually similar to io_uring (as are many other hardware interfaces), so
ideally it would at a high level only have to "forward" SQEs sent, onto the
device, and then forward the device completion events back to CQEs.

Additionally, I plan on completely phasing out kernel handling of
userspace-to-userspace rings, since as the name implies, those are meant to be
independent of the kernel. Instead, these secondary rings will be handled by
userspace applications, where they have the choice which interface they will
use, and that does not necessarily have to be identical to the current io_uring
interface. Therefore, I have submitted a bunch of futex-related MRs, where
applications will open shared memory via `ipcd`'s `shm:` scheme, and then wait
for new entries via cooperatively doing `FUTEX_WAIT64` and `FUTEX_WAKE` on the
head and tail indices, respectively (or abuse virtual memory to get the
processor to show which memory locations have been modified, although I am not
so sure that is practical enough). Just like the first kernel opcode,
`Waitpid`, `Futex` would also become an io_uring opcode, allowing possibly
direct notification where the only overhead is reading one CQE from shared
memory.

I'll update [the
RFC](https://gitlab.redox-os.org/4lDO2/rfcs/-/blob/io_uring/text/0000-io_uring.md)
as soon as possible too.
