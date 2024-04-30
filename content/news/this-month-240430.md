+++
title = "This Month in Redox - April 2024"
author = "Ribbon and Ron Williams"
date = "2024-04-30"
+++

April was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Merch](https://redox-os.creator-spring.com/)

## Self-Hosting Improvements

Jeremy fixed a "copy-on-write" bug in his recent RedoxFS performance optimizations, where small data chunks could truncate records. This was causing page faults on small executables built inside of Redox (like a Hello World program).

As our dynamic linking support is a work-in-progress, he configured GCC to build static binaries by default (Rust builds static binaries by default).

## USB HID

USB input devices (keyboard and mouse) are working!
Jeremy reworked our USB HID driver to complete keyboard and mouse support.

The host controller driver is using polling currently, so there is a small performance penalty when using USB input devices.
Further work on USB interrupts is planned.
USB Hubs are not well supported yet, so if your system routes the USB input through a hub,
it may not work for you.
Most mice and keyboards should work, but there may be some hardware combinations that don't work,
due to edge cases and HID complexity.
Try it out and let us know!

## ARM64 Improvements

Jeremy's USB improvements enabled the Orbital desktop environment to run on ARM64 QEMU for the first time!

The next step is to test on real hardware.

## Kernel

4lDO2 has improved our `futex` implementation,
including fixes to both the kernel and `relibc` parts of the implementation.
Futex timeouts are now absolute rather than relative,
and a bug was fixed where copy-on-write of the target memory was preventing the futex from waking.

4lDO2 also fixed a kernel panic that caused a page fault loop and restarted the system.

## Ion

nice_graphic has written an LSP language server for the Ion scripting language.
Setup instructions are [here](https://gitlab.redox-os.org/redox-os/ion#lsp-ide-support).

## Users and Groups

Wildan added handling of group passwords to our `redox-users` crate.

## Documentation

Ribbon did a big book review and cleanup, the changes include:

- Less redundancy
- Less ambiguity
- More simple explanations
- More accurate information
- Better information
- Fixed typos
- Fixed commands
- Almost 100% of the information is up-to-date

He improved the debugging documentation for QEMU and real hardware, and added the [cpu.land](https://cpu.land/) website as reference.

He also documented how to setup Redox CI in a non-Redox Git repository using Redoxer,
and improved the documentation of the Redoxer commands.

Ron wrote a tutorial for performance profiling of the kernel,
using tools and hooks developed by 4lDO2, and with the [inferno](https://github.com/jonhoo/inferno) flamegraph.

## Programs

Ribbon packaged more programs as usual, see below:

- Most tools from the Rust language
- Many little-known Rust programs
- A [repository](https://github.com/leachim6/hello-world) with "Hello World" examples in more than 1000 languages!

## Artwork

Ribbon packaged the Ubuntu and PopOS wallpapers.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).
