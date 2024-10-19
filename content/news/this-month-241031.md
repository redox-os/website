+++
title = "This Month in Redox - October 2024"
author = "Ribbon and Ron Williams"
date = "2024-10-31"
+++

October was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## COSMIC Store

The COSMIC Store was ported!

We updated our configuration files to be compliant with the FreeDesktop standards, it allowed the COSMIC Store to show and install our packages.

<a href="/img/screenshot/orbital-visual.png"><img class="img-responsive" alt="New Orbital Visual" src="/img/screenshot/cosmic-store.png"/></a>

## Kernel Improvements

- 4lDO2 fixed the profiler
- Ron Williams fixed the serial console login
- James Francis optimized the files vector

## Driver Improvements

- Andrey Turkin sent initial code for RISC-V support on drivers
- Kamil Koczurek updated the ACPI driver to serialize symbols to RON
- Kamil Koczurek updated the ACPI driver to use the new `redox_scheme` library

## Relibc Improvements

- plimkilde refactored the `strcasecmp` and `strncasecmp` functions with iterators
- Ron Williams fixed the `cbindgen` header building
- Ron Williams improved the tests to make them easier to run on Redox

## ARM64 Improvements

Jeremy Soller enabled the ARM64 images and [packages](https://static.redox-os.org/pkg/aarch64-unknown-redox/) on the build server!!

## RISC-V Improvements

- Andrey Turkin sent the first batch of patches to implement the `riscv64gc-unknown-redox` triple on the Rust compiler fork of Redox
- Andrey Turkin implemented the RISC-V target on the build system
- Andrey Turkin added RISC-V code on most user-space components
- Jeremy Soller enabled the [RISC-V toolchain](https://static.redox-os.org/toolchain/riscv64gc-unknown-redox/)
- Jeremy Soller enabled [RISC-V packages](https://static.redox-os.org/pkg/riscv64gc-unknown-redox/) on the build server

## Package Improvements

We finally enabled the `pkgar` package format by default and dropped the `tar.gz` packages.

If you want to know all features of the `pkgar` package format open [this](https://www.redox-os.org/news/pkgar-introduction/) article.

## Programs

- Eva Kurchatova ported the [RVVM](https://github.com/LekKit/RVVM) emulator
- Josh Megnauth ported the [QuakeSpasm](https://github.com/sezero/quakespasm) engine
- bitstr0m fixed LuaJIT

## Build System Improvements

- 4lDO2 modernized the installer code and implemented support for local binary packages

## Documentation Improvements

- Ribbon moved the items of the [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) document to status tables that are much more easy to maintain (thanks for the suggestion contributor J. Craft)
- Ribbon [explained](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md#why-hardware-reports-are-needed) why we need hardware reports

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
