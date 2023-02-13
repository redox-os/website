+++
title = "FAQ"
+++

This page covers the most asked questions.

- [What is Redox?](#what-is-redox)
- [What features does Redox have?](#what-features-does-redox-have)
- [What is the purpose of Redox?](#what-is-the-purpose-of-redox)
- [What I can do with Redox?](#what-i-can-do-with-redox)
- [What is a Unix-like OS?](#what-is-a-unix-like-os)
- [How Redox is inspired by other systems?](#how-redox-is-inspired-by-other-systems)
- [What is a microkernel?](#what-is-a-microkernel)
- [What programs can Redox run?](#what-programs-can-redox-run)
- [Which devices does Redox support?](#which-devices-does-redox-support)
- [Which virtual machines does Redox have integration with?](#which-virtual-machines-does-redox-have-integration-with)
- [How do I build Redox?](#how-do-i-build-redox)
 - [How to update the sources and compile the changes](#how-to-update-the-sources-and-compile-the-changes)
 - [How to launch QEMU without GUI](#how-to-launch-qemu-without-gui)
 - [How to insert files inside Redox QEMU harddisk](#how-to-insert-files-inside-redox-qemu-harddisk)
 - [How to troubleshoot your build in case of errors](#how-to-troubleshoot-your-build-in-case-of-errors)
 - [How to report bugs on Redox](#how-to-report-bugs-on-redox)
- [How do I contribute to Redox?](#how-do-i-contribute-to-redox)
- [I have a problem/question for Redox team](#i-have-a-problemquestion-for-redox-team)

## What is Redox?

Redox is a microkernel-based operating system, a complete, fully-functioning, general-purpose operating system with a focus on safety, freedom, reliability, correctness, and pragmatism.

Wherever possible, the system components are written in Rust and run in user-space.

## What features does Redox have?

### Microkernel benefits

#### True modularity

You can modify/change many system components without a system restart, similar to but safer than [livepatching].

[livepatching]: https://en.wikipedia.org/wiki/Kpatch

#### Bug isolation

Most system components run in user-space on a microkernel system, a bug in a non-kernel component won't [crash the system/kernel].

[crash the system/kernel]: https://en.wikipedia.org/wiki/Kernel_panic

#### No-reboot design

The kernel changes very little (bug fixing), so you won't need to restart your system very often to update the system.

Since most of the system components are in user-space, they can be replaced on-the-fly (reducing downtime for server administrators).

#### Easy to develop and debug

Most of the system components run in user-space, simplifying testing/debugging.

### Rust benefits

#### No need for exploit mitigations

The microkernel design written in Rust protects against C/C++ memory defects.

By isolating the system components from the kernel, the [attack surface] is very limited.

[attack surface]: https://en.wikipedia.org/wiki/Attack_surface

#### Improved security and reliability without significant performance impact

As the kernel is small, it uses less memory to do its work and the limited kernel code helps keep it close to bug-free status ([KISS] goal).

Rust's safe and fast language design, combined with the small size of the kernel code base, helps ensure a reliable, performant and easy to maintain core.

[KISS]: https://en.wikipedia.org/wiki/KISS_principle

#### Rust-written drivers

Drivers written in Rust are likely to have fewer bugs, better security and performance (fewer bugs can bring more performance on the device).

- [Currently supported devices](/faq/#which-devices-redox-support)

#### ZFS-inspired filesystem

Redox uses RedoxFS as the default filesystem, it supports similar features as [ZFS] with a written-in-Rust implementation.

Expect high performance and data safety (copy-on-write, data integrity, volumes, snapshots, hardened against data loss).

[ZFS]: https://docs.freebsd.org/en/books/handbook/zfs/

## What is the purpose of Redox?

The main goal of Redox is to be a general-purpose OS for any kind of task/computer, while maintaining security, reliability and correctness.

Redox aims to be an alternative for existing Unix systems (Linux/BSD), with the ability to run most Unix programs too, with only recompilation or minimal modifications.

[Our Goals]

[Our Goals]: https://doc.redox-os.org/book/ch01-01-our-goals.html

## What I can do with Redox?

As a general-purpose operating system, you will be able to do almost anything on most devices with high performance/security.

Redox is still under development, so our list of supported applications is currently limited, but growing.

[Use Cases]

[Use Cases]: https://doc.redox-os.org/book/ch01-04-redox-use-cases.html

## What is a Unix-like OS?

Any OS compatible with [Single Unix Specification] and [POSIX], expect a shell, "everything is a file" concept, multitasking and multiuser.

[Unix] was a highly influential multitasking system and impacted the design choices of most modern systems.

- [Wikipedia article]

[Single Unix Specification]: https://en.wikipedia.org/wiki/Single_UNIX_Specification
[POSIX]: https://en.wikipedia.org/wiki/POSIX
[Unix]: https://en.wikipedia.org/wiki/Unix
[Wikipedia article]: https://en.wikipedia.org/wiki/Unix-like

## How Redox is inspired by other systems?

[Plan 9] - This Bell Labs OS bring the concept of "everything is a file" to the highest level, doing all the system communication from the filesystem.

You just need to mount your software on some path and it have the required functionality, any software can work with this interface.

- [Drew DeVault explain the Plan 9]
- [How Redox use the Plan 9 design]

[Plan 9]: http://9p.io/plan9/index.html
[Drew DeVault explain the Plan 9]: https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html
[How Redox use the Plan 9 design]: https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html

[Minix] - the most influential Unix-like system with a microkernel, it has advanced features such as system modularity, [kernel panic] resistence, driver reincarnation, protection against bad drivers and secure interfaces for [process comunication].

Redox is largely inspired by Minix, it have basically the same features but written in Rust.

[Minix]: https://minix3.org/
[kernel panic]: https://en.wikipedia.org/wiki/Kernel_panic
[process comunication]: https://en.wikipedia.org/wiki/Inter-process_communication
[How Redox implement the Minix microkernel design]: https://doc.redox-os.org/book/ch04-01-microkernels.html

[BSD] - This Unix OS [family] did several improvements on Unix systems, the most notable is [BSD sockets], that brings network communication inside the Unix filesystem (before Plan 9).

- [FreeBSD documentation]

[BSD]: https://www.bsd.org/
[family]: https://en.wikipedia.org/wiki/Research_Unix
[BSD sockets]: https://en.wikipedia.org/wiki/Berkeley_sockets
[FreeBSD documentation]: https://docs.freebsd.org/en/books/developers-handbook/sockets/

[Linux] - the most advanced monolithic kernel of the world and biggest open-source project of the world, it brings several improvements/optimizations to Unix-like systems.

Redox tries to implement the Linux performance improvements in a microkernel design.

[Linux]: https://www.kernel.org/

## What is a microkernel?

A microkernel is the near-minimum amount of software that can provide the mechanisms needed to implement an operating system, which run on the highest privilege of the processor.

This approach to OS design brings more stability and security, with a small cost on performance.

- [Redox Book explanation]

[Redox Book explanation]: https://doc.redox-os.org/book/ch04-01-microkernels.html

## What programs can Redox run?

Redox is designed to be source-compatible with most Unix, Linux and POSIX-compilant applications, only requiring compilation.

Currently, most GUI applications require porting, as we don't support X11 or Wayland yet.

Some important software that Redox support:

- [Bash](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/bash)
- [ffmpeg](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/ffmpeg)
- [GCC](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/gcc)
- [Git](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/git)
- [LLVM](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/llvm)
- [Mesa3D](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/mesa)
- [OpenSSL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/openssl)
- [Python](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/python)
- [SDL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/sdl2)

You can see all Redox components/ported programs [here].

[here]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes

## Which devices does Redox support?

There are billions of devices with hundreds of models/architectures in the world, we try to write drivers for the most used devices to support more people, some drivers are device-specific and others are architecture-specific (better to port).

### CPU

- [x86_64/AMD64] - (Intel/AMD)
- [x86/i686] - (Intel/AMD from Pentium II and after, incomplete)
- [ARM64] - (WIP, incomplete)

[x86_64/AMD64]: https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86_64
[x86/i686]: https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86
[ARM64]: https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/aarch64

### Hardware Interfaces

- [ACPI]
- [PCI]

(USB soon)

[ACPI]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/acpid
[PCI]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcid

### Video

- [VGA] - (BIOS)
- GOP (UEFI)
- [LLVMpipe] - Software Rendering

(Intel/AMD and others in the future)

[VGA]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vesad
[LLVMpipe]: https://docs.mesa3d.org/drivers/llvmpipe.html

### Sound

- [Intel chipsets]
- [Realtek chipsets]
- [PC speaker]

([Sound Blaster] soon)

[Intel chipsets]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ihdad
[Realtek chipsets]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ac97d
[Sound Blaster]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/sb16d
[PC speaker]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcspkrd

### Storage

- [IDE] - (PATA)
- [AHCI] - (SATA)
- [NVMe]

(USB soon)

[IDE]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ided
[AHCI]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ahcid
[NVMe]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/nvmed

### Input

- [PS/2 keyboards]
- [PS/2 mouse]
- [PS/2 touchpad]

(USB soon)

[PS/2 keyboards]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d
[PS/2 mouse]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d
[PS/2 touchpad]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d

### Internet

- [Intel Gigabit ethernet]
- [Intel 10 Gigabit ethernet]
- [Realtek ethernet]

(Wi-Fi/[Atheros ethernet] soon)

[Intel Gigabit ethernet]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/e1000d
[Intel 10 Gigabit ethernet]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ixgbed
[Realtek ethernet]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/rtl8168d
[Atheros ethernet]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/alxd

## Which virtual machines does Redox have integration with?

- [QEMU]
- [VirtualBox]

In the future the microkernel can act as a hypervisor, similar to [Xen].

A [hypervisor] is a software that manage virtual machines, it can be a "compatibility layer" for any operating system.

[QEMU]: https://www.qemu.org/
[VirtualBox]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vboxd
[Xen]: https://xenproject.org/
[hypervisor]: https://en.wikipedia.org/wiki/Hypervisor

## How do I build Redox?

Currently Redox has a bootstrap script for Debian/Ubuntu/Pop OS! with unmaintained support for other distributions.

We are moving to use Podman as our main compilation method, it is the recommended build process for non-Debian systems.

(Podman avoids environment problems on compilation)

- [Redox Book Guide] - (Debian/Ubuntu/Pop OS!)
- [Redox Book Advanced Guide] - (Debian/Ubuntu/Pop OS!)
- [Redox Book Podman Guide]
- [Redox Book Podman Advanced Guide]

[Redox Book Guide]: https://doc.redox-os.org/book/ch02-05-building-redox.html
[Redox Book Advanced Guide]: https://doc.redox-os.org/book/ch08-01-advanced-build.html
[Redox Book Podman Guide]: https://doc.redox-os.org/book/ch02-06-podman-build.html
[Redox Book Podman Advanced Guide]: https://doc.redox-os.org/book/ch08-02-advanced-podman-build.html

### How to launch QEMU without GUI

Run:

- `make qemu vga=no`

QEMU terminal will looks like a container/chroot.

### How to troubleshoot your build in case of errors

Refer to the Redox Book before to see if the problem is your build configuration or toolchain, if you still have problems, see the following or join us on [Redox Chat](https://doc.redox-os.org/book/ch13-01-chat.html).

- [GitLab Troubleshooting Guide]
- [Redox Book Troubleshooting Guide]

[Redox Book Troubleshooting Guide]: https://doc.redox-os.org/book/ch08-05-troubleshooting.html
[GitLab Troubleshooting Guide]: https://gitlab.redox-os.org/redox-os/redox#help-redox-wont-compile

### How to report bugs on Redox

Check GitLab Issues first to see if your problem is already known.

- [Redox Book Bug Report Guide]
- [CONTRIBUTING.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md)

[Redox Book Bug Report Guide]: https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html

## How do I contribute to Redox?

You can contribute to Redox in many ways, here some of them:

- [GitLab Guide]
- [Documentation](/docs/)
- [Redox Book Contribution Guide]
- [How to make pull requests properly]
- [Redox Dev room]

[Redox Book Contribution Guide]: https://doc.redox-os.org/book/ch10-02-low-hanging-fruit.html
[How to make pull requests properly]: https://doc.redox-os.org/book/ch12-04-creating-proper-pull-requests.html
[GitLab Guide]: https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md
[Redox Dev room]: https://matrix.to/#/#redox-dev:matrix.org

## I have a problem/question for Redox team

- Have a look at the [Documentation](/docs/) page for more details of Redox internals.
- Have a look at the [Redox Book] to see if it answers your questions/fixes your problem.
- If the book does not answer your question, ask your question/say your problem in [Redox Support] or [Redox Dev] rooms on Matrix.

[Redox Book]: https://doc.redox-os.org/book/
[Redox Support]: https://matrix.to/#/#redox-support:matrix.org
[Redox Dev]: https://matrix.to/#/#redox-dev:matrix.org
