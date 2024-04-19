+++
title = "Redox OS 0.9.0"
author = "Jeremy Soller and Ron Williams"
date = "2024-04-18"
+++

(The following image needs to be uploaded, like the previous release it should show the Jeremy computers running the current Redox version)

<a href="/img/release/0.9.0.jpg"><img class="img-responsive" src="/img/release/0.9.0.jpg"/></a>

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

## Discussion

Links where this release is discussed will be added here. To contact me
directly, view the links on my personal website: https://soller.dev/

- [Hacker News]()
- [Mastodon]()
- [Patreon]()
- [Reddit /r/redox]()
- [Reddit /r/rust]()
- [Redox OS Chat]()
- [X (previously known as Twitter)]()

## Images

It is recommended to try Redox OS in a VM before trying on real hardware. See
the [supported hardware](#supported-hardware) section for details on what
hardware to select for the best experience. For this release, only x86_64 images
are provided, as there is still work to be done on i686 and aarch64 support.

Remember to verify images with sha256sum: https://static.redox-os.org/releases/0.8.0/x86_64/SHA256SUM

### Demo

A 768 MiB image containing the standard desktop environment as well as pre-installed
demo applications

- **Live (recommended)**: https://static.redox-os.org/releases/0.8.0/x86_64/redox_demo_x86_64_2022-11-23_638_livedisk.iso
- Pre-installed: https://static.redox-os.org/releases/0.8.0/x86_64/redox_demo_x86_64_2022-11-23_638_harddrive.img

The demo image includes these additional packages:

- [DOSBox](https://www.dosbox.com/): A DOS emulator
- Games using PrBoom:
    - DOOM (Shareware)
    - [FreeDOOM](https://freedoom.github.io/)
- [Neverball and Neverputt](https://neverball.org/): OpenGL games using llvmpipe
(performance may vary!)
- [`orbclient`](https://gitlab.redox-os.org/redox-os/orbclient): demo orbital
application
- [Periodic Table](https://gitlab.redox-os.org/redox-os/periodictable): an app
for viewing information about chemical elements
- [Redox OS Games](https://gitlab.redox-os.org/redox-os/games): command line
games for Redox OS
- [`rodioplay`](https://gitlab.redox-os.org/redox-os/rodioplay): a music player
capable of loading FLAC and WAV files
- [Sodium](https://gitlab.redox-os.org/redox-os/sodium): a vi-like editor
- [`sopwith`](http://www.sopwith.org/): a classic PC air combat game
- `syobonaction`: a freeware platforming game

### Desktop

A 256 MiB image containing only the standard desktop environment. Use this if
you want to download a smaller image

- Live: https://static.redox-os.org/releases/0.8.0/x86_64/redox_desktop_x86_64_2022-11-23_638_livedisk.iso
- Pre-installed: https://static.redox-os.org/releases/0.8.0/x86_64/redox_desktop_x86_64_2022-11-23_638_harddrive.img

### Server

A 256 MiB image containing only the command-line environment. Use this if the
desktop image is not working well for you

- Live: https://static.redox-os.org/releases/0.8.0/x86_64/redox_server_x86_64_2022-11-23_638_livedisk.iso
- Pre-installed: https://static.redox-os.org/releases/0.8.0/x86_64/redox_server_x86_64_2022-11-23_638_harddrive.img

## Changes

There have been quite a lot of changes since 0.7.0. I have manually enumerated
what I think is important in this list. Links to exhaustive source-level change
details can be found in the [Exhaustive Details section](#exhaustive-details)

## In Depth

### Kernel

- The memory performance was improved a lot by the introduction of a new buddy allocator (p2buddy)
- The CPU cost of many system calls was reduced, improving the overral performance
- The kernel image became bootloader-agnostic

### RedoxFS

- The reading and writting performance was improved a lot by the introduction of the "records" concept, where RedoxFS use an optimal block size for the context switch
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
- More than 1500 programs and libraries were packaged (work-in-progress)

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