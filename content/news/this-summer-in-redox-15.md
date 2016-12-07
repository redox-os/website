+++
author = "Ticki & Jackpot51"
date = "2016-09-26T13:54:15+02:00"
title = "This Summer in Redox"
+++

Lately, we've been kind of silent, because we've focused on the coding, and we have a lot of exciting news for everyone.

# A Complete Rewrite of the Kernel ([@jackpot51](http://github.com/jackpot51))

Since August 13, the kernel is going through a complete rewrite, which makes the kernel space ultra-small (about the size of [L4](https://en.wikipedia.org/wiki/L4_microkernel_family)). Everything which can run outside the kernel in practice, will do so.

It is almost complete and will likely be merged in the coming week. [You can find it on GitHub here.](https://github.com/redox-os/redox/)

Thanks to [@jackpot51](http://github.com/jackpot51) for the great [implementation work](https://github.com/redox-os/redox/commits/master).

## Reasons for the Rewrite

### Memory Management

The major reason for the rewrite was incorrect and inefficient memory management in the old kernel. This causes crashes in userspace where the kernel has not mapped pages correctly. Eventually, it was evident that in order to permanently solve these issues, we had to throw away the old code entirely and start from scratch, which is what we did.

In the new kernel, there are no similar crashes in memory management, mainly due to not sharing page tables among processes.

### Concurrent Design

Another reason for the rewrite was the lack of concurrent design, meaning that the old kernel could not be entered by multiple processors. This has been fixed by using Mutex, Once, and RwLock from the `spin` crate, instead of UnsafeCell like the old kernel does.

### SMP Support

The concurrent design allowed immediate usage of SMP, although inter-processor interrupts are not yet used to control scheduling across processors.

### 64-bit by Default

Finally, we are able to use x86_64 by default, giving us access to more processor features as well as a large virtual memory space.

## What happens to the old kernel?

For historic reasons, the old kernel will be kept around in a branch of the [Redox repository](https://github.com/redox-os/redox/) even after the new kernel is merged.

At the moment, the new kernel has reimplemented everything from the old kernel, and added additional features as well.

## New Features

### Init

The startup of the system is controlled by `init`, which loads [an init.rc file](https://github.com/redox-os/redox/blob/master/initfs/etc/init.rc). This starts with initfs initialization (to load the filesystem), and then transfers to the [filesystem init.rc](https://github.com/redox-os/redox/blob/master/filesystem/etc/init.rc) to load the rest.

### Permissions Model

The Redox kernel now tracks the user ID of each process. RedoxFS uses this ID to provide Unix permissions support for the filesystem. We have added a login manager for both the terminal and Orbital, as well as password authentication using Octavo (which we hope will have bcrypt soon!).

The user accounts are stored, with passwords hashed, in [/etc/passwd](https://github.com/redox-os/redox/blob/master/filesystem/etc/passwd). There is also support for groups in [/etc/group](https://github.com/redox-os/redox/blob/master/filesystem/etc/group), as well as support for `sudo` and `su` using `setuid`.

### I/O multiplexing with fevent

A new system call has been added, `fevent`, which allows a process to handle a large number of file descriptors (anything that can be opened with `open`, including IRQs, sockets, and files) without spawning one thread for each descriptor. [You can see the abstraction in the `event` crate here](https://github.com/redox-os/redox/blob/master/crates/event/src/lib.rs)

### Drivers in userspace

There are very few drivers in kernel space now. Those include the PIT and RTC drivers, for clock functions, and a small ACPI driver that handles just the MADT table to bring up other processors.

#### Physical memory

The display driver, PS/2 driver, PCI driver, network stack, network drivers, and disk drivers have all been moved into userspace with the use of a new syscall for giving a process access to physical memory (if it is privileged).

#### IRQ handling

There is an irq scheme that allows a driver to handle IRQs without putting the system into an infinite loop. In Linux, userspace drivers have no such facility and cannot handle interrupts.

#### PCI Driver Manager

You can see in the init.rc that pcid (the PCI driver) has a [configuration file](https://github.com/redox-os/redox/blob/master/filesystem/etc/pcid.toml) which gives the paths of drivers and information about how to identify which driver runs for which devices.

### Multiple screen support in `vesad`

We now have virtual screens, defined in the init.rc file with the line `vesad T T T G`. You can add a text screen with T, and a graphic screen with G. At the moment, F1 - F12 switch between the screens, and they can be accessed as files with `display:1` through `display:12`.

### A new syscall interface

The new system call interface resembles [SeL4's](https://wiki.sel4.systems/FrequentlyAskedQuestions), it has only a tiny set of system calls allowing for message passing, registering schemes, registering interrupts, etc.

There will no longer be any file-specific system calls. These will be replaced by more general resource management system calls.

### Bulk syscalls

One problem of microkernels is the many context switches, so you have to apply various techniques to limit the number of context switches. Bulk syscalls are one of these.

The basic idea is that you enable chaining of syscalls without repeatedly leaving in entering kernel space. An array of system call packages is passed, and they're serially executed without leaving kernel space.

This can greatly reduce the number of syscalls made through one observation: programs tends to make syscalls next to each other. Consider the following piece of code:

```rust
// == Start of the process ==

// Initially, we have no heap available, so we need to allocate that:
let buf = sbrk(200);
// Then we open some file.
let file = fopen("/dev/random");
// Then we read the file into the buffer.
file.read(&mut buf);
```

Note how the `sbrk` and the `fopen` are independent, and could be executed in the same bulk:

```rust
let (buf, file) = bulk2(syscall::Sbrk(200), syscall::Fopen("/dev/random"));
file.read(&mut buf);
```

So we successfully reduced three syscalls to two.

(note that these are Linux system calls not Redox syscalls)

### Userspace emulation

One thing we envision is being able to emulate other kernels in userspace, with a reasonable performance. We believe this is necessary to make Redox easier to adopt to your own computer without giving up certain platform-dependent software.

The way we will achieve this is providing system calls for registering interrupts and system calls, such that the userspace can set up a fake kernel environment where the kernel binary can be mapped.

### Typed URLs

Instead of being stringly typed, URLs (resource descriptors) are now described by two buffers, neither of which has any constraints. As such, the kernel is path agnostic and doesn't assume any particular syntax.

### Better documentation and codestyle

Overall, the code quality of the new kernel is much better.

### Work-in-progress: Capabilities ([@ticki](http://github.com/ticki))

Capabilities are an interesting way of managing privileges and permissions in many modern kernels. Redox is planning to adopting this. [Scheme-centric capabilities](https://github.com/ticki/kernel) are being designed and implemented.

Capabilities themselves are simply a byte buffer and some restrictions on how they can be cloned and sent between processes. The idea of scheme-centric capabilities is that each scheme has a set of capabilities to work with.

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

## Now arena backed

Ralloc's memory bookkeeper will now avoid most allocations by using SLOBs/arenas. This allows efficient internal memory management without excessive memcpys.

## Better testing

The test suite of ralloc has been expanded significantly.

## Paper

A WIP paper on the design and implementation of ralloc can be found [here](https://github.com/redox-os/ralloc/tree/skiplist/paper). Eventually, ralloc will be formally verified as well.

# Formal verification ([@ticki](http://github.com/ticki))

A major step towards formalizing and verifying the kernel has been made. In particular, I've constructed a model of the Rust MIR's semantics in terms of Hoare logic and separation logic.

You can read more about this [here](http://ticki.github.io/blog/a-hoare-logic-for-rust/).

# An important update on the ZFS implementation ([@ticki](http://github.com/ticki))

The work on the ZFS implementation has been limited in the past few months. This can be attributed to mainly the fact that following the specification word-by-word is a big limitation without significant benefits.

In order to continue the development in a reasonable speed, we stop conforming to the specification of ZFS. As such, we can no longer call it a ZFS implementation.

In fact, we have redesigned a lot, while preserving the spirit and ideas behind ZFS. The new file system is named **TFS**.

The outline is the same: it is an extent-based COW file system with 128-bit address space and checksums stored in the pointers. However, there are many changed things and it is only loosely based on ZFS.

TFS has more focus on disk drivers and a lot of things ZFS implements as integrated into the file system is implemented in TFS as disk drivers. This makes TFS a lot more modular and hence more compatible with the Redox way.

TFS presents many other cool features like random-access LZ4 compression, better memory caching, non-hacky file monitoring, better redundancy and error correction, constant-time snapshots and more.

The ongoing work on the specification, design, and implementation can be found [here](https://github.com/ticki/tfs).

## Concurrent

The implementation puts a lot of effort into doing things concurrently, preferably without locks. This is by observing the failure of especially older file systems.

Today, most computers has more than one core. Naturally, this should be taken advantage of.

## Boilerplate

TFS requires a lot of boilerplate. These components will be published separately, so other crates can take advantage of them.

### Caching

PLRU caching will be the initial cache replacement strategy. This is partially because it has a good cache-behavior/bookkeeping-overhead compromise, but more importantly it can be implemented concurrently entirely without locks.

The implementation can be found [here](https://docs.rs/crate/plru/), and can be used in your own projects as well.

### LZ4 compression

LZ4 is a high-performance dedup-class (Lempel-Ziv to be exact) compression algorithm. This will be used throughout TFS.

Implementation is in progress.

### Rabin-Karp rolling hash

Rabin-Karp hashing is used for checksums.

## Snapshots

TFS will allow the user to snapshot so called "zones", which is the file system or a subset thereof. Due to the copy-on-write nature of TFS, it is cheap (in fact, it is constant time).

These snapshot can easily be reverted.

## Disk drivers

TFS implements a significant part of the stack as disk drivers, transforming the disk into a virtual device translating virtual reads and writes into actual disk I/O.

This is a major improvement over the approach taken by most other file systems, not because of any semantic changes, but simply because it simplifies the implementation a great deal.

# Major refactoring in coreutils ([@stratact](http://github.com/stratact))

A lot of things in Redox's [coreutils](https://github.com/redox-os/coreutils) has been changed. [@stratact](http://github.com/stratact) has implemented a command-line flag parser and added multiple new features to various utilities, as well as fixing bugs and cleaning up code.

[@stratact](http://github.com/stratact) also removed a hack in `libextra`'s `GetSlice` implementation since the `std` crate introduce `Option<T>` conversion since Rust 1.12. He improve `Orbtk`'s API to be more user friendly.

# Porting stuff

Multiple new applications has been ported (including the [Smith text editor](https://github.com/IGI-111/Smith) by IGI-111).

# And probably a lot more...

meh, I can't remember.

Please contact me (ticki) on IRC to add things we forgot.

# What's next?

- Finish the kernel and merge it into the main repository!
- Complete the design document and first version of TFS.
- Merge the new ralloc into the master branch.
