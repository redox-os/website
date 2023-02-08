+++
title = "Features"
+++

## True modularity

You can change every system component without a system restart, similar to [livepatching]).

[livepatching]: https://en.wikipedia.org/wiki/Kpatch

## Bug isolation

Most system components run in user-space on a microkernel system, a bug on any system component can't [crash the system/kernel].

[crash the system/kernel]: https://en.wikipedia.org/wiki/Kernel_panic

## No-reboot design

The kernel change very little (bug fixing), then you don't need to restart your system to update the system, since most of the system components are on user-space, they can be replaced on-the-fly (it helps a lot server administrators).

Expect less kernel updates too (less chance to more bugs).

## No need for exploit mitigations

The microkernel design written in Rust makes most C/C++ security bugs irrelevant/useless, with this design the attacker can't use these bugs to exploit the system.

## ZFS-inspired filesystem

Redox uses RedoxFS as the default filesystem, it support the same features of [ZFS] with changes on implementation.

Expect high performance and data safety (copy-on-write, data integrity, volumes, snapshots, hardened against data loss).

[ZFS]: https://docs.freebsd.org/en/books/handbook/zfs/

## Better system performance and less memory usage

As the kernel is small, it uses less memory to do his work and close to bug-free status ([KISS] goal).

Beyond being small, the system is written in Rust, this language helps the programmer to write better code that don't cause performance problems.

Rust implement performance optimization with safety by default.

[KISS]: https://en.wikipedia.org/wiki/KISS_principle

## Rust-written drivers

Drivers written in Rust have less bugs, more security and performance (less bugs can bring more performance of the device).

- [Currently supported devices](/faq/#which-devices-redox-support)

## Easy to develop and debug

Most of the system components run on user-space, you don't need virtualization to test/debug them, more quick to develop.