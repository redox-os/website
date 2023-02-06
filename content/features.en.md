+++
title = "Features"
+++

## True modularity

You can change every system component without a system restart, similar to [livepatching]).

[livepatching]: https://en.wikipedia.org/wiki/Kpatch

## Bug isolation

The kernel is small and are close to bug-free status ([KISS] goal), a bug on any system service can't [crash the system].

[KISS]: https://en.wikipedia.org/wiki/KISS_principle
[crash the system]: https://en.wikipedia.org/wiki/Kernel_panic

## No-reboot design

The kernel is small and change very little (bug fixing), then you don't need to restart your system to update the system, since most of the system services are on user-space, they can be replaced on-the-fly.

Expect less kernel updates too (less chance to more bugs).

## No need for exploit mitigations

The microkernel design written in Rust makes most C/C++ security bugs irrelevant/useless, with this design the attacker can't use these bugs to exploit the system.

## ZFS-inspired filesystem

Redox uses RedoxFS as the default filesystem, it support the same features of [ZFS] (copy-on-write, data integrity, volumes, snapshots, etc) with changes on implementation.

Expect high performance and data safety (hardened against data loss).

[ZFS]: https://docs.freebsd.org/en/books/handbook/zfs/

## Best system performance and less memory usage

As the kernel is small, it uses less memory to do his work.

Beyond being small, the system is written in Rust, this language helps the programmer to write better code that don't cause performance problems.

Rust implement performance optimization with safety by default.
