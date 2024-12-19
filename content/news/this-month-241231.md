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

## Self-Hosting Improvements

Anhad Singh successfully compiled GCC, GNU Binutils, GNU Make and GNU Bash with dynamic linking, this is one part of the goals to allow more programs to work on Redox and dynamically link relibc to speed up the Redox development.

He also implemented dynamic linking support for the Redox triple on GCC.

## Kernel Improvements

- Andrey Turkin fixed Raspberry Pi 3
- Zhouqi Jiang improved the [OpenSBI](https://github.com/riscv-software-src/opensbi) support for RISC-V

## Driver Improvements

- Andrey Turkin fixed the BCM2835 driver (Raspberry Pi 3 B+)

## System Improvements

- Tim Crawford updated the `redox_hwio` library to the Rust 2021 edition
- Tim Crawford removed the support for non-x86 architectures on PIO from the `redox_hwio` library

## Relibc Improvements

- Anhad Singh fixed the dynamic linker
- Anhad Singh implemented dynamic linker configuration through environment variables
- Anhad Singh fixed a delay on the Makefile
- Anhad Singh improved the debugging
- Josh Megnauth fixed a memory overflow
- Josh Megnauth implemented missing structs on `netinet.h` function group
- Josh Megnauth implemented the `stdnoreturn.h` function group
- bitstr0m implemented the `cpio.h` function group
- bitstr0m implemented the `glob.h` function group
- plimkilde added TODOs for the remaining POSIX functions

## Networking Improvements

- Steffen Butzer fixed some bugs in the implementation of the Address Resolution Protocol
- Guillaume Gielly implemented the `ifconfig` tool for network management on the Redox network stack
- Guillaume Gielly improved the `ping` tool
- Guillaume Gielly did a code cleanup and fixed compilation warnings

## Programs

- Josh Megnauth fixed and updated Lua
- Josh Megnauth ported the LZ4 compressor
- Josh Megnauth fixed GLib
- Josh Megnauth added a demo for OpenJazz
- Amir Ghazanfari improved the process to quit the Sodium text editor
- Ron Williams fixed the GNU Bash glob

## Build System Improvements

- Andrey Turkin fixed the recipe operations on the installer after `pkgutils` removal
- Andrey Turkin fixed the configuration for Raspberry Pi 3B emulation on QEMU
- Anhad Singh implemented dynamic linking functions on Cookbook
- Anhad Singh implement a way to install the runtime dependencies of recipes using the installer
- Ribbon fixed the Debian/Ubuntu target on the `native_bootstrap.sh` script
- Ron Williams improved the error messages from the installer

## Documentation Improvements

- Ribbon documented how to [download the relibc sources](https://gitlab.redox-os.org/redox-os/relibc#download-the-sources) and [build it](https://gitlab.redox-os.org/redox-os/relibc#build-instructions)
- Ribbon documented [how to mount a RedoxFS partition](https://gitlab.redox-os.org/redox-os/redoxfs#how-to-mount-a-partition)
- Jack Lin fixed broken links on the Cookbook README

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
