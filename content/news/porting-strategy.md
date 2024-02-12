+++
title = "Porting Strategy"
author = "Ribbon and Ron Williams"
date = "2024-02-12"
+++

As Redox functionality becomes more complete,
we have been working hard to get a wide variety of software working.

This post will cover our porting strategy for Linux/BSD programs.

## Donate to Redox

If you would like to support Redox please consider donating or buying some merch.

- [Donate](https://www.redox-os.org/donate/)
- [Merch](https://redox-os.creator-spring.com/)

## Terminology

- "Porting" means making software work on Redox, which may involve as little as cross-compiling,
or it may require changes to either the software or to Redox.
- [POSIX](https://en.wikipedia.org/wiki/POSIX) is a standardized definition of Unix, that was intended to keep software portable between Unix variants.
Not all Unix variants, such as Linux, fully support POSIX, and Linux has important features that are not included in the POSIX standard.
- Many Linux programs use libraries that can be limited to POSIX compatibility or allowed to use Linux-specific interfaces.
- The BSDs are several variants of Unix, derived from the [Berkeley Software Distribution](https://en.wikipedia.org/wiki/Berkeley_Software_Distribution). Most BSDs do not support Linux extensions.
FreeBSD has merged some Linux-specific interfaces.
- A patch is a change to a program's source code or build system to make that program work on Redox.
A patch may be small and applied during the build,
or larger and require a fork (permanent edit) of the source code.
- Source code compatibility means that a program will work without a patch,
and only need to be recompiled.
This is the objective for Redox support of most Linux applications.

## Relibc

On Unix systems, `libc` includes functions described in Sections 2 and 3 of the Unix man pages.
Section 2 of the man pages covers "system calls", which are services provided directly by the kernel.
Section 3 covers a standard library of functions, some that are layered on top of system calls, and some that are not.

[Relibc](https://gitlab.redox-os.org/redox-os/relibc) is a Rust implementation of `libc` that covers both this Section 2 (platform services)
and Section 3 (standard library) functionality.
It is intended to work on both Linux and Redox.
For Linux, Relibc's platform services are just a thin wrapper on system calls.
However, Redox makes a conscious effort to move as much functionality as possible into userspace.
As a result, some Redox platform services have a large part of their implementation in Relibc.

For example, to implement [fork(2)](https://man7.org/linux/man-pages/man2/fork.2.html) on Redox,
Relibc performs file operations (open, read, write) on a scheme called `thisproc` to create a
new process context.
The Relibc `fork` API is essentially identical to the Linux `fork` API,
in spite of the significant difference in the actual system calls.

So, Relibc implements Linux or POSIX compatible variants of Redox platform services.
Compiling against Relibc allows many Linux programs to run on Redox without modification.

## CLI and TUI Programs

Many programs depend on libraries for significant parts of the implementation details.
The effort to port each program is quite straightforward,
if those libraries are working.

In most cases the library objects only need to be compiled with the Redox C Library (relibc).
Our C library implementation contains many POSIX/Linux APIs, removing the need for patches.

Sometimes a platform service is missing, or a known bug prevents a program from working correctly.
This may require a patch to a library or to the program itself.
In some cases,
we may have to postpone porting the program until the platform service is implemented.

Programs that require Linux-specific features can be patched to use our equivalent, if one exists.
In the future, Redox may implement performance optimizations from Linux,
like io_uring, for example.

## GUI Programs

For GUI programs, the situation is still limited, but improving.

- Redox provides the Orbital display server and window manager, which is unique and not directly compatible with Linux GUI software.
- Orbital is heavily optimized for software rendering, and does it well.
- The [winit](https://github.com/rust-windowing/winit) and [softbuffer](https://github.com/rust-windowing/softbuffer) libraries supports Orbital,
and is allowing us to port many Rust programs and components of the [Cosmic Desktop](https://github.com/pop-os/cosmic-epoch).
- The [SDL](https://www.libsdl.org/) framework is compatible with Orbital, allowing some emulators and many open-source games to work.

We plan to port [GTK](https://gtk.org/) and [Qt](https://www.qt.io/) to Orbital,
which will allow us to port many Linux GUI apps.

### Accelerated Graphics and Wayland

Support for Wayland is an important part of full support for Linux apps with accelerated graphics.

Redox does not yet have accelerated GPU drivers,
due to their complexity and the wide variety of hardware that needs to be supported.

There are also some important platform services that are required for Wayland,
such as file descriptor transfer over sockets,
that are not yet implemented on Redox.

As part of our work to support accelerated graphics,
we plan to port [Smithay](https://github.com/Smithay/smithay),
which gives us a path to enable almost all Linux GUI software to work with good performance.

But it will take some time before Wayland support is available.

## Games and Emulators

Redox OS can run games and emulators using the SDL1 and SDL2 frameworks with the Orbital backend, which does not require X11 or Wayland. Currently this is done using Mesa's llvmpipe software rendererer, once we have hardware-accelerated rendering porting will be easier.

We have ported the following games and emulators:

- [2048](https://play2048.co/)
- [ClassiCube](https://www.classicube.net/)
- [DevilutionX](https://github.com/diasurgical/devilutionX)
- [DOSBox](https://www.dosbox.com/)
- [eduke32](http://www.eduke32.com/)
- [FreeCiv](http://freeciv.org/)
- [Gigalomania](https://gigalomania.sourceforge.net/)
- [Hematite](https://github.com/PistonDevelopers/hematite)
- [Mednafen](https://mednafen.github.io/)
- [Neverball](https://neverball.org/)
- [OpenJK](https://github.com/JACoders/OpenJK)
- [OpenTTD](https://www.openttd.org/)
- [PrBoom](https://prboom.sourceforge.net/) (Doom engine)
- [ScummVM](https://www.scummvm.org/)
- [Space Cadet Pinball](https://github.com/k4zmu2a/SpaceCadetPinball)
- and others.

We also have work-in-progress ports for [RetroArch](https://www.retroarch.com/), [Flycast](https://github.com/flyinghead/flycast), [OpenSpades](https://github.com/yvt/openspades), [Xonotic](https://xonotic.org/), [Veloren](https://veloren.net/), and others. There is a work-in-progress port of Wine stable to run Windows games, though this will require hardware acceleration to be useful. In the future, we can add a microkernel-based implementation of the Linux kernel optimizations for Wine such as [FUTEX2](https://www.phoronix.com/news/Futex2-System-Call-RFC) and [NTSync](https://www.phoronix.com/news/Windows-NT-Sync-RFC-Linux).

## Patches

Programs and libraries that use platform-aware build systems
sometimes need to be patched to correctly handle a Redox target.

That's the case for GNU Make and Meson, while GNU Autotools and Cargo only require a template in most cases.

When a Rust crate needs to be patched, for example to include `#[cfg(target_os = "redox")]`,
we try to send the patches to upstream in most cases, to avoid forks with local patches.

There are some situations where Redox is missing functionality that is planned, and rather than push a temporary change upstream,
we will maintain a fork.

We have also patched some C/C++ libraries using Redox-specific forks.
The patches will be removed or sent to upstream once our APIs are ready.

## The Redox Toolchain

The Redox build system is currently designed for [cross-compilation](https://en.wikipedia.org/wiki/Cross_compiler)
that takes place on Linux.
A Redox filesystem image is created, containing program executables.
There is also a package manager that allows you to download cross-compiled binaries onto Redox.

In order to set up cross-compilation of an application,
a Redox developer creates a "recipe",
which is a short script that invokes the build system with the correct options.
The recipe can contain custom instructions to apply simple patches when needed.

In most cases, "porting" an application is just the exercise of setting up the recipe correctly,
and does not require any change to the original source code.

## Linux Compatibility Layer?

### What is a Linux Compatibility Layer?

A Linux Compatibility Layer does on-the-fly translation of system calls and APIs to natively-supported services.
In this way, the Linux binaries don't need to be recompiled and will think that they are running on Linux.

### Why Not a Linux Compatibility Layer?

In short, effort and benefit.
Because our plan is to be mostly source compatible with Linux,
it's a better use of resources to focus on Redox platform services, and port libraries and programs,
than to write a Linux translation layer, which will require the same system services anyway.

While a translation layer could run many programs,
some software is designed specifically for Linux, 
like drivers and filesystems,
or requires extensive low-level support, like user-space containers for Podman and Docker.

We would also need to keep all APIs up to date to match the current Linux kernel state, like Wine does for Windows,
which would add a large maintenance effort.

### FreeBSD has a Linux Compatibility Layer!

The BSD family is a close relative of Linux, they share a similar monolithic kernel architecture.

This architectural similarity allowed FreeBSD (and other BSDs) to port the Linux kernel API as a kernel module,
and to run Linux binaries and DRM drivers without major kernel changes.

Because Redox uses a microkernel architecture, this strategy would not be a good fit for Redox,
and our current porting strategies will require less effort with a more beneficial result.

## Current State and Future

Porting is a major part of the Redox development effort.
We are using porting as a way to prioritize and validate Redox functionality.

Currently dozens of programs and many more libraries work.
Our initial focus has been on porting Rust programs,
but we also recognize the importance of supporting programs written in other languages.

In last year [Ribbon](https://gitlab.redox-os.org/hatred_45) began the porting of more than 1000 programs and libraries to Redox!
They are still work-in-progress and many require customized cross-compilation scripts
or improved library support.
You can see them [here](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/wip).

With our [recent change](https://www.redox-os.org/news/this-month-240131/#redox-path-format) to a Linux-compatible path format,
we have removed a major hurdle to supporting Linux applications.
In the future we plan to expand our POSIX support, port more Rust crates and continue to improve Relibc.

Some thought is being given to virtual machines and Wine as possible mechanisms
for running proprietary binaries and possibly even proprietary drivers.
However, there are no specific plans for that capability at this time.
