+++
title = "FAQ"
+++

This page covers questions and answers for newcomers and end-users.

- [What is Redox?](#what-is-redox)
- [What does Redox mean?](#what-does-redox-mean)
- [What is a microkernel?](#what-is-a-microkernel)
- [What features does Redox have?](#what-features-does-redox-have)
    - [Microkernel benefits](#microkernel-benefits)
    - [Rust benefits](#rust-benefits)
    - [Other benefits](#other-benefits)
    - [Comparison with other operating systems](#comparison-with-other-operating-systems)
- [What is the purpose of Redox?](#what-is-the-purpose-of-redox)
- [What I can do with Redox?](#what-i-can-do-with-redox)
- [What is an Unix-like OS?](#what-is-an-unix-like-os)
- [How Redox was influenced by other systems?](#how-redox-was-influenced-by-other-systems)
- [What programs can Redox run?](#what-programs-can-redox-run)
- [How to install programs on Redox?](#how-to-install-programs-on-redox)
- [Which are the Redox variants?](#which-are-the-redox-variants)
- [Which devices does Redox support?](#which-devices-does-redox-support)
- [I have a low-end computer, would Redox work on it?](#i-have-a-low-end-computer-would-redox-work-on-it)
- [Which virtual machines does Redox have integration with?](#which-virtual-machines-does-redox-have-integration-with)
- [How do I build Redox?](#how-do-i-build-redox)
- [How to troubleshoot your build in case of errors](#how-to-troubleshoot-your-build-in-case-of-errors)
- [How to report bugs on Redox](#how-to-report-bugs-on-redox)
- [How do I contribute to Redox?](#how-do-i-contribute-to-redox)
- [I have a problem/question for Redox team](#i-have-a-problemquestion-for-redox-team)

## What is Redox?

Redox is a microkernel-based, complete, fully-functioning and general-purpose operating system created in 2015, with a focus on safety, freedom, reliability, correctness, and pragmatism. Wherever possible, the system components are written in Rust and run in user-space.

It aims to be a complete alternative to Linux and BSD.

### Current status

Redox is in alpha development phase, we implement new features and fix bugs.

Because of this it's not ready for daily usage yet. Feel free to test the system until its maturity and **don't store your sensitive data without a proper backup.**

The 1.0 version will be released once all system APIs are considered stable.

## What does Redox mean?

[Redox](https://en.wikipedia.org/wiki/Redox) is the chemical reaction (reduction–oxidation) that creates rust. As Redox is an operating system written in Rust, it makes sense.

It sounds like Minix and Linux too.

## What is a microkernel?

A microkernel is the near-minimum amount of software that can provide the mechanisms needed to implement an operating system, which runs on the highest privilege of the processor.

This approach to OS design brings more stability and security, with a small cost on performance.

You can read more about it on the [Microkernels](https://doc.redox-os.org/book/microkernels.html) page.

## What features does Redox have?

### Microkernel benefits

- **True modularity**

You can modify/change many system components without a system restart, similar to but safer than some modules in monolithic kernels and [livepatching](https://en.wikipedia.org/wiki/Kpatch).

- **Bug isolation**

Most system components run in user-space on a microkernel system. Because of this some types of bugs in most system components won't [crash or damage the system or kernel](https://en.wikipedia.org/wiki/Kernel_panic).

- **Restartless design**

A mature microkernel changes very little (except for bug fixes), so you won't need to restart your system very often to update it.

Since most of the system components are in user-space they can be replaced on-the-fly, reducing the downtime of servers a lot.

- **Easy to develop and debug**

Most of the system components run in user-space, simplifying the testing and debugging.

You can read more about the above benefits on the [Microkernels](https://doc.redox-os.org/book/microkernels.html) page.

### Rust benefits

- **Less likely to have bugs**

The restrictive syntax and compiler requirements to build the code reduce the probability of bugs a lot.

- **Less vulnerable to data corruption**

The Rust compiler helps the programmer to avoid memory errors and race conditions, which reduces the probability of data corruption bugs due to implementation errors.

- **No need for C/C++ exploit mitigations on system components**

As Redox is written in Rust we don't need C/C++ exploit mitigations for the system components, reducing the system complexity and increasing the program compatibility.

The microkernel design written in Rust protects against memory defects that one might see in operating systems written in C/C++.

By isolating the system components from the kernel, the [attack surface](https://en.wikipedia.org/wiki/Attack_surface) is very limited.

- **Improved security and reliability without significant performance impact**

As the kernel is small it uses less memory to do its work. The limited kernel code size helps us work towards a bug-free status ([KISS](https://en.wikipedia.org/wiki/KISS_principle)).

Rust's safe and fast language design, combined with the small kernel code size, helps ensure a reliable, performant and easy to maintain system core.

- **Thread-safety**

The C/C++ support for thread-safety is quite fragile. As such, it is very easy to write a program that looks safe to run across multiple threads, but which introduces subtle bugs or security holes. If one thread accesses a piece of state at the same time that another thread is changing it, the whole program can exhibit some truly confusing and bizarre bugs.

You can see [this Wikipedia example](https://en.wikipedia.org/wiki/Time_of_check_to_time_of_use) of a serious class of security bugs that thread-safety fixes.

In Rust, this kind of bug is easy to avoid: the same type system that keeps us from writing memory unsafety prevents us from writing dangerous concurrent access patterns

- **Rust-written Drivers**

Drivers written in Rust are likely to have fewer bugs and are therefore more stable and secure.

### Other benefits

- **ZFS-inspired filesystem**

Redox uses RedoxFS as the default filesystem. It supports similar features as [ZFS](https://docs.freebsd.org/en/books/handbook/zfs/) with a written-in-Rust implementation.

Expect high performance and data safety (copy-on-write, data integrity, volumes, snapshots, hardened against data loss).

### Comparison with other operating systems

You can see how Redox is compared to Linux, FreeBSD and Plan 9 on these pages:

- [Redox OS Features](https://doc.redox-os.org/book/features.html)
- [Comparing Redox to Other OSes](https://doc.redox-os.org/book/how-redox-compares.html)

## What is the purpose of Redox?

The main goal of Redox is to be a general-purpose OS, while maintaining security, stability and correctness.

Redox aims to be an alternative to existing Unix systems (Linux/BSD), with the ability to run most Unix programs with only recompilation or minimal modifications.

- [Our Goals](https://doc.redox-os.org/book/our-goals.html)

## What I can do with Redox?

As a general-purpose operating system, you will be able to do almost any task on most devices with high performance and security.

Redox is still under development, so our list of supported applications is currently limited, but growing.

- [Use Cases](https://doc.redox-os.org/book/redox-use-cases.html)

## What is an Unix-like OS?

Any OS compatible with the [Single Unix Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) and [POSIX](https://en.wikipedia.org/wiki/POSIX). You can expect a [shell](https://en.wikipedia.org/wiki/Unix_shell), the "[Everything is a File](https://en.wikipedia.org/wiki/Everything_is_a_file)" concept, multitasking and multiuser support.

[Unix](https://en.wikipedia.org/wiki/Unix) was a highly influential multitasking system and impacted the design choices of most modern systems.

- [Wikipedia article](https://en.wikipedia.org/wiki/Unix-like)

## How Redox was influenced by other systems?

### [Plan 9](http://9p.io/plan9/index.html)

This Bell Labs OS brings the concept of "Everything is a File" to the highest level, doing all the system communication from the filesystem.

- [Drew DeVault explains the Plan 9](https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html)
- [Plan 9's influence on Redox](https://doc.redox-os.org/book/urls-schemes-resources.html)

### [Minix](https://minix3.org/)

The most influential Unix-like system with a microkernel. It has advanced features such as system modularity, [kernel panic](https://en.wikipedia.org/wiki/Kernel_panic) resistence, driver reincarnation, protection against bad drivers and secure interfaces for [process comunication](https://en.wikipedia.org/wiki/Inter-process_communication).

Redox is largely influenced by Minix - it has a similar architecture but with a feature set written in Rust.

- [How Minix influenced the Redox design](https://doc.redox-os.org/book/microkernels.html)

### [seL4](https://sel4.systems/)

The most performant and simplest microkernel of the world.

Redox follow the same principle, trying to make the kernel-space small as possible (moving components to user-space and reducing the number of system calls, passing the complexity to user-space) and keeping the overall performance good (reducing the context switch cost).

### [BSD](https://en.wikipedia.org/wiki/Berkeley_Software_Distribution)

This Unix [family](https://en.wikipedia.org/wiki/Research_Unix) included several improvements on Unix systems and the open-source variants of BSD added many improvements to the original system (like Linux did).

- [FreeBSD](https://www.freebsd.org/) - The [Capsicum](https://man.freebsd.org/cgi/man.cgi?capsicum(4)) (a capability-based system) and [jails](https://en.wikipedia.org/wiki/Freebsd_jail) (a sandbox technology) influenced the Redox namespaces implementation.

- [OpenBSD](https://www.openbsd.org/) - The [system call](https://man.openbsd.org/pledge.2), [filesystem](https://man.openbsd.org/unveil.2), [display server](https://www.xenocara.org/) and [audio server](https://man.openbsd.org/sndiod.8) sandbox and [others](https://www.openbsd.org/innovations.html) influenced the Redox security.

### [Linux](https://www.kernel.org/)

The most advanced monolithic kernel and biggest open-source project of the world. It brought several improvements and optimizations to the Unix-like world.

Redox tries to implement the Linux performance improvements in a microkernel design.

## What programs can Redox run?

Redox is designed to be source-compatible with most Unix, Linux and POSIX-compliant applications, only requiring compilation.

(Wayland will be supported soon)

Some important software that Redox supports:

- GNU Bash
- FFMPEG
- Git
- RustPython
- SDL2
- OpenSSL
- Mesa3D
- X11
- GCC
- LLVM

You can see all Redox components and ported programs on the [build server list](https://static.redox-os.org/pkg/x86_64-unknown-redox/).

## How to install programs on Redox?

Redox has a package manager similar to `apt` (Debian) and `pkg` (FreeBSD), you can see how to use it on the [Downloading packages with pkg](https://doc.redox-os.org/book/pkg.html) page.

## Which are the Redox variants?

Redox has some variants for a group of tasks, take a look at them below:

- `minimal` - The most minimal variant with a basic system without network support. Aimed for embedded devices, very old computers, testers and developers.

- `minimal-net` - The most minimal variant with a basic system and network support. Aimed for embedded devices, very old computers, testers and developers.

- `desktop-minimal` - The most minimal variant with the Orbital desktop environment included. Aimed for embedded devices, very old computers, testers and developers.

- `server` - The server variant with a complete system and network tools. Aimed for servers, embedded devices, low-end computers, testers and developers.

- `desktop` - The standard variant with a complete system, Orbital desktop environment and useful tools. Aimed for end-users, producers, gamers, testers and developers.

- `dev` - The development variant with a complete system and development tools. Aimed for developers and testers.

- `demo` - The demo variant with a complete system, tools, players and games. Aimed for end-users, gamers, testers and developers.

## Which devices does Redox support?

There are billions of devices with hundreds of models and architectures in the world. We try to write drivers for the most used devices to support more people. Support depends on the specific hardware, since some drivers are device-specific and others are architecture-specific.

Have a look at [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) to see all tested computers.

### Compatibility Table

| **Category**        | **Items**                                                                                                                                            |
|---------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| CPU                 | - Intel 64-bit (x86_64) <br>- Intel 32-bit (i686) from Pentium II and after with limitations <br>- AMD 32/64-bit <br>- ARM 64-bit (Aarch64) with limitations |
| Hardware Interfaces | - ACPI, PCI, USB                                                                                                                                       |
| Storage             | - IDE (PATA), SATA (AHCI), NVMe                                                                                                                        |
| Video               | - BIOS VESA, UEFI GOP                                                                                                                                  |
| Sound               | - Intel, Realtek chipsets                                                                                                                              |
| Input               | - PS/2 keyboards, mouse and touchpad <br> - USB keyboards, mouse and touchpad                                                                          |
| Ethernet            | - Intel Gigabit and 10 Gigabit ethernet <br>- Realtek ethernet                                                                                        |

## I have a low-end computer, would Redox work on it?

A CPU is the most complex machine of the world: even the oldest processors are powerful for some tasks but not for others.

The main problem with old computers is the amount of RAM available (they were sold in a era where RAM chips were expensive) and the lack of SSE/AVX extensions (programs use them to speed up the algorithms). Because of this some modern programs may not work or require a lot of RAM to perform complex tasks.

Redox itself will work normally if the processor architecture is supported by the system, but the performance and stability may vary per program.

## Which virtual machines does Redox have integration with?

- QEMU
- VirtualBox

We can also have a hypervisor variant in the future, similar to [Xen](https://xenproject.org/).

A [hypervisor](https://en.wikipedia.org/wiki/Hypervisor) is a program providing the ability to run multiple isolated operating systems instances simultaneously.

## How do I build Redox?

Read the following pages:

- [Podman Build](https://doc.redox-os.org/book/podman-build.html)
- [Native Build](https://doc.redox-os.org/book/building-redox.html)

## How to troubleshoot your build in case of errors

Read the [Troubleshooting](https://doc.redox-os.org/book/troubleshooting.html) page or join us on the [Redox Chat](https://doc.redox-os.org/book/chat.html).

## How to report bugs on Redox

Read the [Creating Proper Bug Reports](https://doc.redox-os.org/book/creating-proper-bug-reports.html) page and check the GitLab Issues to see if your problem was reported.

## How do I contribute to Redox?

You can contribute to Redox in many ways, you can see them on [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md).

## I have a problem/question for Redox team

- Have a look at the [Documentation](/docs/) page for more details of Redox internals.
- Have a look at the [Redox Book](https://doc.redox-os.org/book/) to see if it answer your question or solve your problem.
- If the documentation or the book does not answer your question, ask your question or say your problem on the [Chat](https://doc.redox-os.org/book/chat.html).
