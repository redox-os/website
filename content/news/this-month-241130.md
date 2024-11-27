+++
title = "This Month in Redox - November 2024"
author = "Ribbon and Ron Williams"
date = "2024-11-30"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. November was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Redox On Redox

Andrey Turkin executed the RISC-V version of Redox Server from the [RVVM](https://github.com/LekKit/RVVM) RISC-V emulator running on the x86-64 version of Redox Desktop!!

<a href="/img/screenshot/redox-on-redox.png"><img class="img-responsive" alt="Redox On Redox" src="/img/screenshot/redox-on-redox.png"/></a>

## Compiling Redox on WSL

Charlie Philips from Georgia Tech did a video tutorial teaching how to build the Redox system on WSL, you can watch the video below:

<iframe width="560" height="315" src="https://www.youtube.com/embed/W_x49Qr-KdM?si=5AkAfJy6bpF9TUwP" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Kernel Improvements

- Jeremy Soller fixed a bug on MSI that allowed Meteor Lake CPUs to boot with USB keyboard support
- Arthur Paulino refactored the `switch` function for extra clarity
- Andrey Turkin changed the RISC-V PLIC compatible string from `riscv,plic0` to `sifive,plic-1.0.0`

## Driver Improvements

- Tim Finnegan fixed a deadlock on the USB device initialization

## Relibc Improvements

- Josh Megnauth fixed a panic with programs or games using deprecated POSIX functions
- Josh Megnauth fixed a multiplication overflow on the `setsockopt` function
- Josh Megnauth fixed a buffer overrun when parsing DNS
- Josh Megnauth removed unnecessary memory over-allocations and reallocations
- Josh Megnauth improved the generated C code for the return value of the `exit` functions
- Josh Megnauth allowed `cbindgen` to emit C attributes
- plimkilde implemented the `memmem()` function
- plimkilde implemented the `iso686` function group and its tests
- plimkilde added a test for errno constant macros
- plimkilde allowed `ENOTSUP` to be available for Rust programs?
- plimkilde added stubs for all missing functions from POSIX 2024
- plimkilde removed an unnecessary intrinsic in calloc
- plimkilde documented the `stdlib.h`, `crypt.h`, `elf.h`, `inttypes.h`, `pty.h`, `utmp.h`, `string.h`, `pwd.h`, `sys/random.h`, `sys/auxv.h` and `sys/file.h` function groups

## Programs

- bitst0rm fixed the libevent compilation
- Ribbon successsfully compiled more Rust programs and demos
- Josh Megnauth updated OpenJazz to the latest version and converted the recipe configuration to TOML
- Amir Ghazanfari improved the Sodium file selection

## Testing Improvements

- Ron Williams fixed the CI of the Redox build system
- Ron Williams created the [Benchmarks](https://gitlab.redox-os.org/redox-os/benchmarks) repository and recipe to store our performance data history to catch possible regressions

## Build System Improvements

- Ron Williams allowed the installer error handling to show the package name when a pre-built package can't be found on the Redox build server
- Ron Williams added some recipes on the build server configuration to allow the `desktop` variant image to be created with downloaded pre-built packages
- Ron Williams implemented the `source` value as an alternative for `recipe` when the `REPO_BINARY` environment variable is enabled, which removes confusion
- Andrey Turkin fixed some linker warnings on the GCC fork

## Documentation Improvements

- Ribbon explained the design and benefits of the Redox package management on the [Package Management](https://doc.redox-os.org/book/package-management.html) page
- Ribbon fixed problems on the tutorial from the [From Nothing to Hello World](https://doc.redox-os.org/book/nothing-to-hello-world.html) page, please read the page again
- Ribbon improved the [Security](https://doc.redox-os.org/book/security.html) page with more information
- Ribbon improved the documentation for accessibility
- Jeffrey Carter fixed the Raspberry Pi build instructions
- Brandon Konkle removed all outdated references for the `vga=no` option
- David Pfeiffer added a hardware report for the Lenovo Yoga S730-13IWL computer
- Matthew Croughan added a hardware report for the HP Compaq NC6120 computer

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
