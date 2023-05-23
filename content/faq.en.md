+++
title = "FAQ"
+++

This page covers the most asked questions.

- [What is Redox?](#what-is-redox)
- [What does Redox mean?](#what-does-redox-mean)
- [What features does Redox have?](#what-features-does-redox-have)
- [What is the purpose of Redox?](#what-is-the-purpose-of-redox)
- [What I can do with Redox?](#what-i-can-do-with-redox)
- [What is a Unix-like OS?](#what-is-a-unix-like-os)
- [How Redox is inspired by other systems?](#how-redox-is-inspired-by-other-systems)
- [What is a microkernel?](#what-is-a-microkernel)
- [What programs can Redox run?](#what-programs-can-redox-run)
- [How to install programs on Redox?](#how-to-install-programs-on-redox)
- [Which devices does Redox support?](#which-devices-does-redox-support)
- [Which virtual machines does Redox have integration with?](#which-virtual-machines-does-redox-have-integration-with)
- [How do I build Redox?](#how-do-i-build-redox)
 - [How to launch QEMU without GUI](#how-to-launch-qemu-without-gui)
 - [How to troubleshoot your build in case of errors](#how-to-troubleshoot-your-build-in-case-of-errors)
 - [How to report bugs on Redox](#how-to-report-bugs-on-redox)
- [How do I contribute to Redox?](#how-do-i-contribute-to-redox)
- [I have a problem/question for Redox team](#i-have-a-problemquestion-for-redox-team)

## What is Redox?

Redox is a microkernel-based operating system, a complete, fully-functioning, general-purpose operating system with a focus on safety, freedom, reliability, correctness, and pragmatism.

Wherever possible, the system components are written in Rust and run in user-space.

## What does Redox mean?

[Redox](https://en.wikipedia.org/wiki/Redox) is the chemical reaction (reduction–oxidation) that creates rust, as Redox is an operating system written in Rust, it makes sense.

It sounds like Minix/Linux too.

## What features does Redox have?

### Microkernel benefits

#### True modularity

You can modify/change many system components without a system restart, similar to but safer than [livepatching](https://en.wikipedia.org/wiki/Kpatch).

#### Bug isolation

Most system components run in user-space on a microkernel system, a bug in a non-kernel component won't [crash the system/kernel](https://en.wikipedia.org/wiki/Kernel_panic).

#### No-reboot design

The kernel changes very little (bug fixing), so you won't need to restart your system very often to update the system.

Since most of the system components are in user-space, they can be replaced on-the-fly (reducing downtime for server administrators).

#### Easy to develop and debug

Most of the system components run in user-space, simplifying testing/debugging.

### Rust benefits

#### No need for exploit mitigations

The microkernel design written in Rust protects against C/C++ memory defects.

By isolating the system components from the kernel, the [attack surface](https://en.wikipedia.org/wiki/Attack_surface) is very limited.

#### Improved security and reliability without significant performance impact

As the kernel is small, it uses less memory to do its work and the limited kernel code helps keep it close to bug-free status ([KISS](https://en.wikipedia.org/wiki/KISS_principle) goal).

Rust's safe and fast language design, combined with the small size of the kernel code base, helps ensure a reliable, performant and easy to maintain core.

#### Rust-written drivers

Drivers written in Rust are likely to have fewer bugs and better security.

- [Currently supported devices](#which-devices-does-redox-support)

#### ZFS-inspired filesystem

Redox uses RedoxFS as the default filesystem, it supports similar features as [ZFS](https://docs.freebsd.org/en/books/handbook/zfs/) with a written-in-Rust implementation.

Expect high performance and data safety (copy-on-write, data integrity, volumes, snapshots, hardened against data loss).

## What is the purpose of Redox?

The main goal of Redox is to be a general-purpose OS, while maintaining security, reliability and correctness.

Redox aims to be an alternative to existing Unix systems (Linux/BSD), with the ability to run most Unix programs with only recompilation or minimal modifications.

- [Our Goals](https://doc.redox-os.org/book/ch01-01-our-goals.html)

## What I can do with Redox?

As a general-purpose operating system, you will be able to do almost anything on most devices with high performance/security.

Redox is still under development, so our list of supported applications is currently limited, but growing.

- [Use Cases](https://doc.redox-os.org/book/ch01-04-redox-use-cases.html)

## What is a Unix-like OS?

Any OS compatible with [Single Unix Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) and [POSIX](https://en.wikipedia.org/wiki/POSIX), expect a [shell](https://en.wikipedia.org/wiki/Unix_shell), "[everything is a file](https://en.wikipedia.org/wiki/Everything_is_a_file)" concept, multitasking and multiuser.

[Unix](https://en.wikipedia.org/wiki/Unix) was a highly influential multitasking system and impacted the design choices of most modern systems.

- [Wikipedia article](https://en.wikipedia.org/wiki/Unix-like)

## How Redox is inspired by other systems?

[Plan 9](http://9p.io/plan9/index.html) - This Bell Labs OS brings the concept of "everything is a file" to the highest level, doing all the system communication from the filesystem.

- [Drew DeVault explains the Plan 9](https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html)
- [Plan 9's influence on Redox](https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html)

[Minix](https://minix3.org/) - The most influential Unix-like system with a microkernel, it has advanced features such as system modularity, [kernel panic](https://en.wikipedia.org/wiki/Kernel_panic) resistence, driver reincarnation, protection against bad drivers and secure interfaces for [process comunication](https://en.wikipedia.org/wiki/Inter-process_communication).

Redox is largely inspired by Minix, it has a similar architecture and feature set written in Rust.

- [How Minix influenced the Redox design](https://doc.redox-os.org/book/ch04-01-microkernels.html)

[BSD](https://www.bsd.org/) - This Unix OS [family](https://en.wikipedia.org/wiki/Research_Unix) included several improvements on Unix systems, the most notable is [BSD sockets](https://en.wikipedia.org/wiki/Berkeley_sockets), that brings network communication with file-like operation (before Plan 9).

- [FreeBSD documentation](https://docs.freebsd.org/en/books/developers-handbook/sockets/)

[Linux](https://www.kernel.org/) - the most advanced monolithic kernel of the world and biggest open-source project of the world, it brings several improvements/optimizations to Unix-like systems.

Redox tries to implement the Linux performance improvements in a microkernel design.

## What is a microkernel?

A microkernel is the near-minimum amount of software that can provide the mechanisms needed to implement an operating system, which runs on the highest privilege of the processor.

This approach to OS design brings more stability and security, with a small cost on performance.

- [Redox Book explanation](https://doc.redox-os.org/book/ch04-01-microkernels.html)

## What programs can Redox run?

Redox is designed to be source-compatible with most Unix, Linux and POSIX-compilant applications, only requiring compilation.

Currently, most GUI applications require porting, as we don't support X11 or Wayland yet.

Some important software that Redox supports:

- [Bash](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/bash)
- [ffmpeg](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/ffmpeg)
- [GCC](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/gcc)
- [Git](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/git)
- [LLVM](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/llvm)
- [Mesa3D](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/mesa)
- [OpenSSL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/openssl)
- [Python](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/python)
- [SDL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/sdl2)

You can see all Redox components/ported programs [here](https://static.redox-os.org/pkg/x86_64-unknown-redox/).

## How to install programs on Redox?

Redox has a package manager similar to `apt` (Debian) and `pkg` (FreeBSD), you can see how to use it on this page:

- [Redox package manager](https://doc.redox-os.org/book/ch02-08-pkg.html)

## Which devices does Redox support?

There are billions of devices with hundreds of models/architectures in the world, we try to write drivers for the most used devices to support more people, some drivers are device-specific and others are architecture-specific.

Have a look at [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) to see all tested computers.

### CPU

- [x86_64/AMD64](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86_64) - (Intel/AMD)
- [x86/i686](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86) - (Intel/AMD from Pentium II and after supported with limitations)
- [ARM64](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/aarch64) - (supported with limitations)

### Hardware Interfaces

- [ACPI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/acpid)
- [PCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcid)

(USB soon)

### Video

- [VGA](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vesad) - (BIOS)
- GOP (UEFI)
- [LLVMpipe](https://docs.mesa3d.org/drivers/llvmpipe.html) - Software Rendering

(Intel/AMD and others in the future)

### Sound

- [Intel chipsets](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ihdad)
- [Realtek chipsets](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ac97d)
- [PC speaker](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcspkrd)

([Sound Blaster](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/sb16d) soon)

### Storage

- [IDE](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ided) - (PATA)
- [AHCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ahcid) - (SATA)
- [NVMe](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/nvmed)

(USB soon)

### Input

- [PS/2 keyboards](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [PS/2 mouse](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [PS/2 touchpad](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)

(USB soon)

### Internet

- [Intel Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/e1000d)
- [Intel 10 Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ixgbed)
- [Realtek ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/rtl8168d)

(Wi-Fi/[Atheros ethernet]((https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/alxd)) soon)

## Which virtual machines does Redox have integration with?

- [QEMU](https://www.qemu.org/)
- [VirtualBox](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vboxd)

In the future the microkernel could act as a hypervisor, similar to [Xen](https://xenproject.org/).

A [hypervisor](https://en.wikipedia.org/wiki/Hypervisor) is software providing the ability to run multiple isolated operating system instances simultaneously.

## How do I build Redox?

Currently Redox has a bootstrap script for Debian/Ubuntu/Pop OS! with unmaintained support for other distributions.

We are moving to use Podman as our main compilation method, it is the recommended build process for non-Debian systems because it avoids environment problems on compilation.

- [Redox Book Guide](https://doc.redox-os.org/book/ch02-05-building-redox.html) - (Debian/Ubuntu/Pop OS!)
- [Redox Book Podman Guide](https://doc.redox-os.org/book/ch02-06-podman-build.html)

### How to launch QEMU without GUI

Run:

- `make qemu vga=no`

### How to troubleshoot your build in case of errors

Refer to the Redox Book to see if the problem is your build configuration or toolchain, if you still have problems, see the following or join us on [Redox Chat](https://doc.redox-os.org/book/ch13-01-chat.html).

- [Redox Book Troubleshooting Guide](https://doc.redox-os.org/book/ch08-05-troubleshooting.html)
- [GitLab Troubleshooting Guide](https://gitlab.redox-os.org/redox-os/redox#help-redox-wont-compile)

### How to report bugs on Redox

Check GitLab Issues first to see if your problem is already known.

- [Redox Book Bug Report Guide](https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html)
- [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md)

## How do I contribute to Redox?

You can contribute to Redox in many ways, you can see them on [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md).

## I have a problem/question for Redox team

- Have a look at the [Documentation](/docs/) page for more details of Redox internals.
- Have a look at the [Redox Book](https://doc.redox-os.org/book/) to see if it answers your questions/fixes your problem.
- If the book does not answer your question, ask your question/say your problem in [Redox Support](https://matrix.to/#/#redox-support:matrix.org) or [Redox Dev](https://matrix.to/#/#redox-dev:matrix.org
) rooms on Matrix.
