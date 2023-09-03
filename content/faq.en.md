+++
title = "FAQ"
+++

This page covers questions/answers for newcomers and end-users.

- [What is Redox?](#what-is-redox)
- [What does Redox mean?](#what-does-redox-mean)
- [What features does Redox have?](#what-features-does-redox-have)
    - [Microkernel benefits](#microkernel-benefits)
    - [Rust benefits](#rust-benefits)
- [What is the purpose of Redox?](#what-is-the-purpose-of-redox)
- [What I can do with Redox?](#what-i-can-do-with-redox)
- [What is a Unix-like OS?](#what-is-a-unix-like-os)
- [How Redox is inspired by other systems?](#how-redox-is-inspired-by-other-systems)
    - [Plan 9](#plan-9)
    - [Minix](#minix)
    - [seL4](#sel4)
    - [BSD](#bsd)
    - [Linux](#linux)
- [What is a microkernel?](#what-is-a-microkernel)
- [What programs can Redox run?](#what-programs-can-redox-run)
- [How to install programs on Redox?](#how-to-install-programs-on-redox)
- [Which are the Redox variants?](#which-are-the-redox-variants)
- [Which devices does Redox support?](#which-devices-does-redox-support)
- [I have a low-end computer, would Redox work on it?](#i-have-a-low-end-computer-would-redox-work-on-it)
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

### Current status

Redox is a alpha/beta quality software, because we implement new features while fix the bugs.

Thus it's not ready for daily usage yet, feel free to test the system until its maturity and **don't store your sensitive data without a proper backup.**

The version 1.0 will be released once all system APIs are considered stable.

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

A mature microkernel changes very little (bug fixing), so you won't need to restart your system very often to update the system.

Since most of the system components are in userspace, they can be replaced on-the-fly (reducing downtime for server administrators).

#### Easy to develop and debug

Most of the system components run in userspace, simplifying testing/debugging.

### Rust benefits

#### Less likely to have bugs

The restrictive syntax and compiler suggestions reduce the probability of bugs a lot.

#### No need for C/C++ exploit mitigations

The microkernel design written in Rust protects against C/C++ memory defects.

By isolating the system components from the kernel, the [attack surface](https://en.wikipedia.org/wiki/Attack_surface) is very limited.

#### Improved security and reliability without significant performance impact

As the kernel is small, it uses less memory to do its work and the limited kernel code size helps to keep it close to bug-free status ([KISS](https://en.wikipedia.org/wiki/KISS_principle) goal).

Rust's safe and fast language design, combined with the small kernel code size, helps ensure a reliable, performant and easy to maintain core.

#### Thread-safety

The C/C++ support for thread-safety is quite fragile, and it is very easy to write a program that looks safe to run across multiple threads, but which introduces subtle bugs or security holes. If one thread accesses a piece of state at the same time that another thread is changing it, the whole program can exhibit some truly confusing and bizarre bugs.

But in Rust this kind of bug is easy to avoid, the same type system that keeps us from writing memory unsafety prevents us from writing dangerous concurrent access patterns

#### Rust-written Drivers

Drivers written in Rust are likely to have fewer bugs and therefore are more secure.

- [Currently supported devices](#which-devices-does-redox-support)

#### ZFS-inspired filesystem

Redox uses RedoxFS as the default filesystem, it supports similar features as [ZFS](https://docs.freebsd.org/en/books/handbook/zfs/) with a written-in-Rust implementation.

Expect high performance and data safety (copy-on-write, data integrity, volumes, snapshots, hardened against data loss).

## What is the purpose of Redox?

The main goal of Redox is to be a general-purpose OS, while maintaining security, reliability and correctness.

Redox aims to be an alternative to existing Unix systems (Linux/BSD), with the ability to run most Unix programs with only recompilation or minimal modifications.

- [Our Goals](https://doc.redox-os.org/book/ch01-01-our-goals.html)

## What I can do with Redox?

As a general-purpose operating system, you will be able to do almost any task on most devices with high performance/security.

Redox is still under development, so our list of supported applications is currently limited, but growing.

- [Use Cases](https://doc.redox-os.org/book/ch01-04-redox-use-cases.html)

## What is a Unix-like OS?

Any OS compatible with [Single Unix Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) and [POSIX](https://en.wikipedia.org/wiki/POSIX), expect a [shell](https://en.wikipedia.org/wiki/Unix_shell), "[everything is a file](https://en.wikipedia.org/wiki/Everything_is_a_file)" concept, multitasking and multiuser.

[Unix](https://en.wikipedia.org/wiki/Unix) was a highly influential multitasking system and impacted the design choices of most modern systems.

- [Wikipedia article](https://en.wikipedia.org/wiki/Unix-like)

## How Redox is inspired by other systems?

### [Plan 9](http://9p.io/plan9/index.html)

This Bell Labs OS brings the concept of "everything is a file" to the highest level, doing all the system communication from the filesystem.

- [Drew DeVault explains the Plan 9](https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html)
- [Plan 9's influence on Redox](https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html)

### [Minix](https://minix3.org/)

The most influential Unix-like system with a microkernel, it has advanced features such as system modularity, [kernel panic](https://en.wikipedia.org/wiki/Kernel_panic) resistence, driver reincarnation, protection against bad drivers and secure interfaces for [process comunication](https://en.wikipedia.org/wiki/Inter-process_communication).

Redox is largely inspired by Minix, it has a similar architecture and feature set written in Rust.

- [How Minix influenced the Redox design](https://doc.redox-os.org/book/ch04-01-microkernels.html)

### [seL4](https://sel4.systems/)

The most fast and simple microkernel of the world, it aims for performance and simplicity.

Redox follow the same principle, trying to make the kernel-space small as possible (moving components to user-space and reducing the number of system calls, passing the complexity to user-space) and keeping the overall performance good (reducing the context switch cost).

### [BSD](https://www.bsd.org/)

This Unix [family](https://en.wikipedia.org/wiki/Research_Unix) included several improvements on Unix systems, the open-source variants of BSD added many improvements to the original system (like Linux did).

[FreeBSD](https://www.freebsd.org/) is the most notable example, Redox took inspiration from [Capsicum](https://man.freebsd.org/cgi/man.cgi?capsicum(4)) (a capability-based system) and [jails](https://en.wikipedia.org/wiki/Freebsd_jail) (a sandbox technology) for the namespaces implementation.

### [Linux](https://www.kernel.org/)

The most advanced monolithic kernel and biggest open-source project of the world, it brought several improvements and optimizations to the Unix-like world.

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
- [SDL2](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/sdl2)

You can see all Redox components/ported programs [here](https://static.redox-os.org/pkg/x86_64-unknown-redox/).

## How to install programs on Redox?

Redox has a package manager similar to `apt` (Debian) and `pkg` (FreeBSD), you can see how to use it on this page:

- [Redox package manager](https://doc.redox-os.org/book/ch02-08-pkg.html)

## Which are  the Redox variants?

Redox has some variants for each task, take a look on them below:

- `server-minimal` - The most minimal variant with a basic system, aimed for embedded devices, very old computers and developers.

- `desktop-minimal` - The most minimal variant with the Orbital desktop environment included, aimed for embedded devices, very old computers and developers.

- `server` - The server variant with a complete system and network tools, aimed for server administrators, embedded devices, low-end computers and developers.

- `desktop` - The standard variant with a complete system, Orbital desktop environment and useful tools, aimed for daily usage, producers, developers and gamers.

- `dev` - The development variant with a complete system and development tools, aimed for developers.

- `demo` - The demo variant with a complete system, tools, players and games, aimed for testers, gamers and developers.

## Which devices does Redox support?

There are billions of devices with hundreds of models/architectures in the world, we try to write drivers for the most used devices to support more people, some drivers are device-specific and others are architecture-specific.

Have a look at [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) to see all tested computers.

### CPU

- Intel - 64-bit (x86_64) and 32-bit (i686) from Pentium II and after with limitations.
- AMD - 64-bit (AMD64) and 32-bit.
- ARM - 64-bit (Aarch64) with limitations.

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

(Wi-Fi/[Atheros ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/alxd) soon)

## I have a low-end computer, would Redox work on it?

A computer processor is the most complex machine of the world, even the most old processors are powerful for some tasks, it depends on the task.

The main problem with old computers is the amount of RAM available (they were sold in a epoch where RAM chips were expensive) and lack of SSE2 (programs use it to speed up the algorithms), thus some modern programs may not work or require a lot of RAM to perform complex tasks.

Redox will work normally (if the processor architecture is supported by the system) but you will need to test each program.

## Which virtual machines does Redox have integration with?

- [QEMU](https://www.qemu.org/)
- [VirtualBox](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vboxd)

In the future the microkernel could act as a hypervisor, similar to [Xen](https://xenproject.org/).

A [hypervisor](https://en.wikipedia.org/wiki/Hypervisor) is software providing the ability to run multiple isolated operating system instances simultaneously.

## How do I build Redox?

Currently Redox has a bootstrap script for Pop OS!, Ubuntu, Debian, Fedora, Arch Linux, openSUSE and FreeBSD with unmaintained support for other distributions.

We also offer Podman as our universal compilation method, it is the recommended build process for non-Debian systems because it avoids environment problems on the build process.

- [Redox Book Guide](https://doc.redox-os.org/book/ch02-05-building-redox.html) - (Pop OS!, Ubuntu, Debian, Fedora, Arch Linux, openSUSE and FreeBSD)
- [Redox Book Podman Guide](https://doc.redox-os.org/book/ch02-06-podman-build.html)

### How to launch QEMU without GUI

Run:

- `make qemu vga=no`

### How to troubleshoot your build in case of errors

Read [this](https://doc.redox-os.org/book/ch08-05-troubleshooting.html) page or join us on [Redox Chat](https://doc.redox-os.org/book/ch13-01-chat.html).

### How to report bugs on Redox

Check GitLab Issues first to see if your problem is already known.

- [Redox Book Bug Report Guide](https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html)

## How do I contribute to Redox?

You can contribute to Redox in many ways, you can see them on [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md).

## I have a problem/question for Redox team

- Have a look at the [Documentation](/docs/) page for more details of Redox internals.
- Have a look at the [Redox Book](https://doc.redox-os.org/book/) to see if it answers your questions/fixes your problem.
- If the book does not answer your question, ask your question/say your problem on the [Chat](https://doc.redox-os.org/book/ch13-01-chat.html).
