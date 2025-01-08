+++
title = "This Month in Redox - December 2024"
author = "Ribbon and Ron Williams"
date = "2024-12-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. December was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## FOSDEM 2025

Jacob Lorentzon (4lDO2) will be presenting his work on Redox Signals in the Microkernels room February 1 at FOSDEM in Brussels. He will also do a short introductory presentation in the Kernel room on February 2.

- https://fosdem.org/2025/schedule/event/fosdem-2025-5973-redox-os-a-microkernel-based-unix-like-os/
- https://fosdem.org/2025/schedule/event/fosdem-2025-5670-posix-signals-in-user-space-on-the-redox-microkernel/

## Funding Opportunity

The NGI Zero Commons Fund and NGI Zero Fediversity Fund each have a call for proposals with a Feb. 1 deadline.
If the proposal is successful, it would be to start roughly in June or July (based on our experience) and run for up to 12 months,
with an amount up to 50,000 EUR.
There must be a "European component", so a EU-based developer would be an ideal fit,
or perhaps a project where the maintainer is EU-based. Here are the links:

- [NGI Zero Commons Fund](https://nlnet.nl/commonsfund/)
- [NGI Zero Fediversity Fund](https://nlnet.nl/fediversity/)

Redox is looking for a part-time or short-term developer to help with implementing device drivers, ACPI support, and similar,
who would like to join our proposal.
You must be knowledgeable in Rust and drivers, and have good reputation in the open source community.
We have an existing relationship with NLnet, so we can craft the proposal, based on your skillset  and our priorities.
Please join us on Matrix and let us know you are interested:

- https://matrix.to/#/#redox-join:matrix.org

## Dynamic Linking for Redox

Anhad Singh's Summer of Code project to implement dynamic linking on Redox continues with huge strides.
He successfully compiled GCC, GNU Binutils, GNU Make and GNU Bash with dynamic linking.
He also implemented dynamic linking support for the Redox triple on GCC.

Dynamic linking is an key part of our Stable ABI strategy, and will help us in our work towards self-hosted development. It will also result in faster compilation time and more space efficient userspace programs.
Read his [report on the work so far](/news/01_rsoc2024_dynamic_linker).

## Kernel Improvements

- Andrey Turkin fixed a regression in the Raspberry Pi 3B support
- Zhouqi Jiang improved the [OpenSBI](https://github.com/riscv-software-src/opensbi) support for RISC-V

## Driver Improvements

- bjorn3 did many improvements and cleanup on video drivers
- bjorn3 did many refactorings on the graphics and input subsystems
- bjorn3 migrated all video drivers to the `redox-scheme` library
- bjorn3 created the `driver-graphics` library to unify code
- bjorn3 created the `graphics-ipc` library to unify code
- bjorn3 reduced the `fbcond` daemon and created the `fbbootlogd` daemon to fix boot deadlocks
- bjorn3 removed blocking on any graphics driver
- bjorn3 updated the `redox-scheme` library version
- bjorn3 fixed some warnings
- Andrey Turkin fixed the BCM2835 driver (Raspberry Pi 3 B+)

## VirtIO Improvements

- bjorn3 improved the VirtIO-GPU driver to allow Redox guest video size to follow the QEMU window size on the host system
- bjorn3 implemented window resizing support using VirtIO-GPU
Bjorn3 has been working on improvements to VirtIO-GPU.

He has improved the GPU driver to allow Redox guest video size to follow the QEMU window size on the host system.

Currently it only use the window size before boot, post-boot window resizing will be implemented soon.

He fixed a crash on the VirtIO-GPU driver when multiple displays are attached.

He also fixed a memory bug and improved the VirtIO-GPU driver performance.

Here is his [tracking issue for the work in progress](https://gitlab.redox-os.org/redox-os/redox/-/issues/1428).

## System Improvements

- bjorn3 implemented `sendfd` handling on the `redox-scheme` library
- The contributor rm-dr did a cleanup on RedoxFS
- Tim Crawford updated the `redox_hwio` library to the Rust 2021 edition
- Tim Crawford removed the support for non-x86 architectures on PIO from the `redox_hwio` library

## Relibc Improvements

- Anhad Singh fixed the dynamic linker
- Anhad Singh implemented lazy binding and scopes on the dynamic linker
- Anhad Singh implemented dynamic linker configuration through environment variables
- Anhad Singh fixed a delay on the Makefile
- Anhad Singh improved the debugging
- Josh Megnauth fixed a memory overflow
- Josh Megnauth fixed the shebang implementation
- Josh Megnauth implemented missing structs on `netinet.h` function group
- Josh Megnauth implemented the `stdnoreturn.h` function group
- bitstr0m implemented the `cpio.h` function group
- bitstr0m implemented the `glob.h` function group
- Guillaume Gielly implemented the `tar.h` function group
- Guillaume Gielly implemented the `monetary.h` function group
- Guillaume Gielly implemented the `strfmon()` function
- Darley Barreto implemented the missing functions on the `string.h` function group
- Ron Williams fixed the `popen()` function and fixed/improved its tests
- plimkilde reimplemented the `memcpy()` function using slices instead of raw pointers, fixed unaligned read/write and added a test
- plimkilde added TODOs for the remaining POSIX functions

## Networking Improvements

- Steffen Butzer fixed some bugs in the implementation of the Address Resolution Protocol
- Guillaume Gielly implemented the `ifconfig` tool for network management on the Redox network stack
- Guillaume Gielly improved the `ping` tool
- Guillaume Gielly did a code cleanup and fixed compilation warnings
- Josh Megnauth fixed an overflow on `MAX_DURATION`

## Programs

- Josh Megnauth fixed and updated Lua
- Josh Megnauth ported the LZ4 compressor
- Josh Megnauth fixed GLib
- Josh Megnauth added a demo for OpenJazz
- Amir Ghazanfari improved the process to quit the Sodium text editor
- Ron Williams fixed a GNU Bash glob regression

## Build System Improvements

- Andrey Turkin fixed the recipe operations on the installer after `pkgutils` removal
- Andrey Turkin fixed the configuration for Raspberry Pi 3B emulation on QEMU
- Anhad Singh implemented dynamic linking functions on Cookbook
- Anhad Singh implement a way to install the runtime dependencies of recipes using the installer
- Ribbon fixed the Debian/Ubuntu target on the `native_bootstrap.sh` script
- Ron Williams improved the error messages from the installer

## Documentation Improvements

- The contributor rm-dr improved the RedoxFS code documentation
- Ribbon documented how to [download the relibc sources](https://gitlab.redox-os.org/redox-os/relibc#download-the-sources) and [build it](https://gitlab.redox-os.org/redox-os/relibc#build-instructions)
- Ribbon documented [how to mount a RedoxFS partition](https://gitlab.redox-os.org/redox-os/redoxfs#how-to-mount-a-partition)
- Jack Lin fixed broken links on the Cookbook README

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

(Use the `server` variant for a terminal interface and the `desktop` variant for a graphical interface, if the `desktop` variant doesn't work use the `server` variant)

- If you want to test in a virtual machine use the "harddrive" images
- If you want to test on real hardware use the "livedisk" images

Sometimes the daily images are outdated and you need to build Redox from source, to know how to do this read the [Building Redox](https://doc.redox-os.org/book/podman-build.html) page.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

<!--
## Discussion

Here are some links to discussion about this news post:

- [Fosstodon @redox]()
- [Fosstodon @soller]()
- [Patreon]()
- [Phoronix]()
- [Reddit /r/redox]()
- [Reddit /r/rust]()
- [X/Twitter @redox_os]()
- [X/Twitter @jeremy_soller]()
- [Hacker News]()
-->
