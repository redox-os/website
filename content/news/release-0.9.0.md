+++
title = "Redox OS 0.9.0"
author = "Jeremy Soller and Ron Williams"
date = "2024-04-18"
+++

(The following image needs to be uploaded, like the previous release it should show the Jeremy computers running the current Redox version)

![Computers running the 0.9.0 version](/static/img/release/computers-0.9.0.png)
![Orbital in the 0.9.0 version](/static/img/screenshot/orbital-0.9.0.png)

## Overview

It's been a while since we had our last release, but we have been heads-down working hard this whole time,
and Release 0.9.0 is packed with many improvements and cleanup. Here are just a few of the highlights!

- Huge improvements to the portability of Linux/BSD programs
- Phase-One of the creation of a stable API
- Improved paging and memory management
- Faster system calls
- Wide-ranging clean-up and debugging of the kernel, drivers and PCIe support
- Improved USB HID support
- Improved filesystem performance
- VirtIO drivers for better performance in virtual machines
- Relibc (our C library implementation) is now almost 100% Rust and much more complete
- The `libm` is now 100% written-in-Rust
- Significant progress on the ARM64 (Aarch64) support, including partial support for Raspberry Pi 3B+
- Contain (Redox's sandboxing driver) has been expanded and is available as a demo (`desktop-contain.toml`)
- Slint, Iced and winit GUI libraries support the Redox Orbital Window Manager
- Key COSMIC Desktop programs available as demos
- GNU Nano and [Helix](https://helix-editor.com/) editors now supported
- [RustPython](https://rustpython.github.io/) is enabled by default
- New build system options and improvements
- Lots of new documentation, a complete book review and cleanup, almost 100% up-to-date information
- A [FAQ](https://www.redox-os.org/faq/) was added to the website
- A [developer FAQ](https://doc.redox-os.org/book/ch09-07-developer-faq.html) was added to the book

## Stability and Performance Improvements

Jeremy Soller and 4lDO2 did massive improvements to stability and security, fixed many bugs, from easy to very hard.

We would like to thank 4lDO2 a lot for his massive work to improve the kernel and user-space daemons.

You can read about part of the 4lDO2 journey to improve the kernel on the following posts:

- [RSoC: on-demand paging](https://www.redox-os.org/news/kernel-8/)
- [RSoC: on-demand paging II](https://www.redox-os.org/news/kernel-9/)
- [Significant performance and correctness improvements to the kernel](https://www.redox-os.org/news/kernel-10/)

Jeremy rarely write posts and prefer to contribute in silence and report the progress later in the Matrix community.

## Software Updates

Our toolchains received some updates and currently our Rust, C and C++ toolchains use the latest stable versions or close to it, it's a great achievement compared to other OS projects that use very old toolchain versions (limiting the program compatibility)

Beyond the toolchain updates, we also updated important cross-platform libraries used by most programs and some important programs.

## Rust-first Program Porting!

We focus on Rust programs as they are more easy to port, Ribbon quickly ported hundreds of emerging Rust programs in 2023.

## C/C++ Programs

Ribbon also partially-ported the classic and widely-used C and C++ programs and libraries, he focused to package the most used (and best) programs of the Linux/BSD world.

Currently there are 1,646 work-in-progress software ports, we need to write cross-compilation scripts and port/update some libraries to make them work.

## Relibc Improvements

The Redox contributors improved relibc a lot, from new functions to important bug fixes.

This increased our software compatibility and fixed many programs, from Rust to C/C++

## Better ARM Support

uvnn cleaned and improved our ARM support a lot, we would like to thank his massive work in 2023.

We also would like to thank Ivan Tan to achieve the Redox support on the Raspberry Pi 3 B+ !

Jeremy also improved the ARM support to the level where we can start the Orbital session on the QEMU emulation.

## Better PCI Express Support

We would like to thank bjorn3 for his excellent work to improve our PCI Express support.

## Better Driver Organization and Code Cleanup

bjorn3 cleaned our driver code, deduplicated some drivers and moved our driver code to category folders, like Linux and BSD.

## Better USB Support!

Jeremy and 4lDO2 improved our USB support to the level where most USB HID devices can work!

Like mouse, keyboards, game controllers and other things.

## VirtIO Support

Anhad Singh from the [Aero](https://github.com/Andy-Python-Programmer/aero) project participated in our RSoC program from 2023 and implemented the VirtIO support on Redox.

He wrote some VirtIO drivers and improved the VirtIO GPU 2D acceleration to speed up our QEMU performance.

You can read about his work on the following posts:

- [RSoC: virtio drivers - 1](https://www.redox-os.org/news/rsoc-virtio-1/)
- [RSoC: virtio drivers - 2](https://www.redox-os.org/news/rsoc-virtio-2/)

## Build System Improvements

We would like to thank Ron Williams, bjorn3, Jeremy and 4lDO2 for their massive improvements to our build system configuration and tooling.

Ron Williams and Jeremy implemented new commands to ease the life of developers, packagers and testers.

bjorn3 simplified our filesystem configuration system, reducing duplication and our maintenance cost.

4lDO2 improved the performance of our recipe verification and image building process.

## Documentation

Our documentation was improved massively thanks to Ron Williams and Ribbon, in 2023 we covered many missing things in the website and book, removed most of the obsolete information and documented almost all build system commands.

Ron Williams and Ribbon did a hard work to make our website and book extremely rich in information for end-users, Rust programming newbies and veterans, and operating system development newbies and veterans.

We are glad to say that our website and book answer most of the end-user and developer questions about Redox.

You can read about the Ribbon's documentation adventure on [this](https://www.redox-os.org/news/documentation-improvements/) post and on the monthly updates.

## Matrix

In 2023 we migrated from Mattermost to Matrix to fix some management problems, this big change helped us to improve many aspects of our community interaction.

You can read more about it on [this](https://www.redox-os.org/news/community-announcements-1/) post.

## Discussion

Links where this release is discussed will be added here.

(To contact us, join in our Matrix space on [this](https://www.redox-os.org/community/) page)

- [Hacker News]()
- [Mastodon]()
- [Patreon]()
- [Reddit /r/redox]()
- [Reddit /r/rust]()
- [Redox OS Chat]()
- [X (previously known as Twitter)]()

## Images

It is recommended to try Redox OS in a virtual machine before trying on real hardware. See
the [supported hardware](https://www.redox-os.org/faq/#which-devices-does-redox-support) section for details on what
hardware to select for the best experience.

Remember to verify the images checksum with the `sha256sum` tool, use [this](https://static.redox-os.org/releases/0.9.0/x86_64/SHA256SUM) link for the x86_64 images.

### Demo

A 1536 MiB image containing the Orbital desktop environment as well as pre-installed demonstration programs.

- [Real Hardware Image](https://static.redox-os.org/releases/0.9.0/x86_64/redox_demo_x86_64_*_livedisk.iso)
- [Virtual Machine Image](https://static.redox-os.org/releases/0.9.0/x86_64/redox_demo_x86_64_*_harddrive.img)

The demo image includes these additional packages:

- [DOSBox](https://www.dosbox.com/) - A DOS emulator
- Games using PrBoom:
    - DOOM (Shareware)
    - [FreeDOOM](https://freedoom.github.io/)
- [Neverball and Neverputt](https://neverball.org/) - OpenGL games using LLVMPipe (performance may vary!)
- [orbclient](https://gitlab.redox-os.org/redox-os/orbclient) - An Orbital client demo
- [Periodic Table](https://gitlab.redox-os.org/redox-os/periodictable) - A program for viewing information about chemical elements
- [Terminal games](https://gitlab.redox-os.org/redox-os/games) - Command-line games
- [rodioplay](https://gitlab.redox-os.org/redox-os/rodioplay) - A FLAC/WAV music player
- [Sodium](https://gitlab.redox-os.org/redox-os/sodium): A vi-like text editor
- [sopwith](http://www.sopwith.org/): A classic PC air combat game
- syobonaction - A freeware platforming game

### Desktop

A 512 MiB image containing the Orbital desktop environment and some programs for common tasks. Use this if you want to download a smaller image.

- [Real Hardware](https://static.redox-os.org/releases/0.9.0/x86_64/redox_desktop_x86_64_*_livedisk.iso)
- [Virtual Machine Image](https://static.redox-os.org/releases/0.9.0/x86_64/redox_desktop_x86_64_*_harddrive.img)

### Server

A 512 MiB image containing only the command-line environment. Use this if the desktop image is not working well for you.

- [Real Hardware](https://static.redox-os.org/releases/0.9.0/x86_64/redox_server_x86_64_*_livedisk.iso)
- [Virtual Machine Image](https://static.redox-os.org/releases/0.9.0/x86_64/redox_server_x86_64_*_harddrive.img)

## Changes

There have been quite a lot of changes since 0.8.0. We have manually enumerated
what we think is important in this list. Links to exhaustive source-level change
details can be found in the [Changelog](#changelog) section.

## In Depth

The most important changes are shown below.

### Kernel

- The memory performance was improved a lot by the introduction of a new buddy allocator (p2buddy)
- The CPU cost of many system calls was reduced, improving the overral performance
- The kernel image became bootloader-agnostic

### RedoxFS

- The reading and writting performance was improved a lot by the introduction of the "records" concept, where RedoxFS use an optimal block size for the context switch
- The context switch roundtrips were reduced
- The copy-on-write reliability was improved with some bugs fixed

### System API

- All system components migrated from `redox_syscall` to `libredox` to have a stable ABI
- The scheme path format is now converted at runtime (relibc/kernel) to avoid the patching of many libraries and programs, the Redox system interfaces are treated like the Linux target now
- New user-space schemes were introduced
- Many improvements to the scheme interface

### Programs

- A lot of new functions were added to relibc, improving the software compatibility
- Many bugs were fixed
- Many programs started to work
- More than 1600 programs and libraries were packaged (work-in-progress)

### Build System

- New recipe options
- New cleanup options
- New QEMU options
- New scripts
- A new filesystem configuration was added, it helped us to deduplicate files and improved the flexbility a lot
- The `rust` submodule fetch was disabled, reducing the download time a lot

### Documentation

- Porting documentation was added
- A developer FAQ was added
- The build system dependencies for each supported Unix-like system was documented
- A feature comparison was added
- A page to learn Rust, OS development, driver development and computer science was added
- The driver descriptions and interfaces was documented
- The RedoxFS features were documented
- The current security system was documented
- The "Quick Workflow" page for advanced testers and developers was added

### Community

- Our chat migrated from Mattermost to Matrix
- A moderation system was implemented
- A nonprofit organization was created to help our money management

## Changelog

This section contains all commits since the 0.8.0 version, generated by the [changelog](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/changelog.sh) script:

- [redox]
- [cookbook]
- [rust]
- [audiod]
- [bootloader]
- [bootstrap]
- [contain]
- [coreutils]
- [drivers]
- [escalated]
- [extrautils]
- [installer]
- [ion]
- [ipcd]
- [kernel]
- [netstack]
- [netutils]
- [orbital]
- [orbterm]
- [orbutils]
- [pkgutils]
- [ptyd]
- [redoxfs]
- [relibc]
- [resist]
- [smith]
- [userutils]
- [uutils]
- [init]
- [logd]
- [nulld]
- [ramfs]
- [randd]
- [zerod]