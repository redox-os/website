+++
author = "Ticki"
date = "2016-09-26T13:54:15+02:00"
title = "This Summer in Redox"

+++

Lately, we've been kind of silent, because we've focused on the coding, and we have a lot of exciting news for everyone.

# A complete rewrite of the kernel ([@jackpot51](http://github.com/jackpot51))

The kernel is going through a complete rewrite, which makes the kernel space ultra-small (about the size of [L4](https://en.wikipedia.org/wiki/L4_microkernel_family)). Everything which can run outside the kernel in practice, will do so.

It is almost complete and will likely be merged in the coming week.

Thanks to [@jackpot51](http://github.com/jackpot51) for the great implementation work.

## A new syscall interface

The new system call interface resembles [SeL4's](https://wiki.sel4.systems/FrequentlyAskedQuestions), it has only a tiny set of system calls allowing for message passing, registering schemes, registering interrupts, etc.

There will no longer be any file-specific system calls. These will be replaced by more general resource management system calls.

## Bulk syscalls

One problem of microkernels is the many context switches, so you have to apply various techniques to limit the number of context switches. Bulk syscalls are one of these.

The basic idea is that you enable chaining of syscalls without repeatedly leaving in entering kernel space. An array of system call packages is passed, and they're serially executed without leaving kernel space.

This can greatly reduce the number of syscalls made through one observation: programs tends to make syscalls next to each other. Consider the following piece of code:

```rust
// == Start of the process ==

// Initially, we have no heap available, so we need to allocate that:
let buf = sbrk(200);
// Then we open some file.
let file = fopen("/dev/random");
// Then we read the fiel into the buffer.
file.read(&mut buf);
```

Note how the `sbrk` and the `fopen` are independent, and could be executed in the same bulk:

```rust
let (buf, file) = bulk2(syscall::Sbrk(200), syscall::Fopen("/dev/random"));
file.read(&mut buf);
```

So we successfully reduced three syscalls to two.

(note that these are Linux system calls not Redox syscalls)

## Userspace emulation

One thing we envision is being able to emulate other kernels in userspace, with a reasonable performance. We believe this is necessary to make Redox easier to adopt to your own computer without giving up certain platform-dependent software.

The way we will achieve this is providing system calls for registering interrupts and system calls, such that the userspace can set up a fake kernel environment where the kernel binary can be mapped.

## Typed URLs

Instead of being stringly typed, URLs (resource descriptors) are now described by two buffers, neither of which has any constraints. As such, the kernel is path agnostic and doesn't assume any particular syntax.

## Better documentation and codestyle

Overall, the code quality of the new kernel is much better.

# Work-in-progress: Capabilities ([@ticki](http://github.com/ticki))

Capabilities are an interesting way of managing privileges and permissions in many modern kernels. Redox is planning to adopting this. [Scheme-centric capabilities](https://github.com/ticki/kernel) are being designed and implemented.

Capabilities themself are simply a byte buffer and some restrictions on how they can be cloned and sent between processes. The idea of scheme-centric capabilities is that each scheme has a set of capabilities to work with.

The scheme can then check if the user of the scheme has the correct capabilities to do a particular action.

# Ralloc is now 2x faster! ([@ticki](http://github.com/ticki))

[Ralloc, the memory allocator of Redox](https://github.com/redox-os/ralloc/tree/skiplist) is going through a major performance pass. I've been working on this for some time now, and the big deal-breaker is really that I switch from a flat array to skiplists. More information can be found [here](http://ticki.github.io/blog/skip-lists-done-right/).

## Logarithmic allocation tree traversal

The skiplist's nodes contain information about the biggest descendant block allowing to do cheap traversal.

Especially when the heap is fragmented and a lot of allocations/deallocations have been done, this gives a significant improvement in performance.

## Fast insertions

Previously, insertions into the memory table were O(n), because they needed to shift everything to the right. Now, due to the nature of skiplists, insertions are done in logarithmic time.

## Better logging

Logging is now scalable beyond debugging. This is due to the addition of buffering, better filtering, and custom target.

## Dynamic programming

The code has been made significantly more complex. The algorithms are extremely messy. Ralloc is likely the single most complex component in Redox right now.

If we did not care about performance this code could be a lot simpler, but it's a very performance critical component unfortunately.

Dynamic programming is used a lot in order to avoid recalculating the same value repeatedly. Instead of calculating the "fat value" (the maximum of the descendant blocks' size), we use the algorithm in such a way that we reuse this value as much as possible.

## Paper

A WIP paper on the design and implementation of ralloc can be found [here](https://github.com/redox-os/ralloc/tree/skiplist/paper). Eventually, ralloc will be formally verified as well.

# Formal verification ([@ticki](http://github.com/ticki))

A major step towards formalizing and verifying the kernel has been made. In particular, I've constructed a model of the Rust MIR's semantics in terms of Hoare logic and seperation logic.

You can read more about this [here](http://ticki.github.io/blog/a-hoare-logic-for-rust/).

# An important update on the ZFS implementation (([@ticki](http://github.com/ticki)))

The work on the ZFS implementation has been limited in the past few months. This can be attributed to mainly the fact that following the specification word-by-word is a big limitation without significant benefits.

In order to continue the development in a reasonable speed, we stop conforming to the specification of ZFS. As such, we can no longer call it a ZFS implementation.

In fact, we have redesigned a lot, while preserving the spirit and ideas behind ZFS. The new file system is named **TFS**.

The outline is the same: it is an extent-based COW file system with 128-bit address space and checksums stored in the pointers. However, there are many changed things and it is only loosly based on ZFS.

TFS has more focus on disk drivers and a lot of things ZFS implements as integrated into the file system is implemented in TFS as disk drivers. This makes TFS a lot more modular and hence more compatible with the Redox way.

TFS presents many other cool features like random-access LZ4 compression, better memory caching, non-hacky file monitoring, better redundancy and error correction, constant-time snapshts and more.

The ongoing work on the specification, design, and implementation can be found [here](https://github.com/ticki/tfs).

# Major refactoring in coreutils ([@stratact](http://github.com/stratact))

A lot of things in Redox's [coreutils](https://github.com/redox-os/coreutils) has been changed. [@stratact](http://github.com/stratact) has implemented a command-line flag parser and added multiple new features to various utilities, as well as fixing bugs and cleaning up code.

# Porting stuff

Multiple new applications has been ported (including the [Smith text editor](https://github.com/IGI-111/Smith) by IGI-111).

# What's next?

- Finish the kernel and merge it into the main repository!
- Complete the design document and first version of TFS.
- Merge the new ralloc into the master branch.
