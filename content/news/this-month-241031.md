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

## Kernel Improvements

- 4lDO2 fixed the profiler

## Driver Improvements

- Kamil Koczurek updated the ACPI driver to serialize symbols to RON
- Kamil Koczurek updated the ACPI driver to use the new `redox_scheme` library

## Relibc Improvements

- Ron Williams fixed the `cbindgen` header building
- Ron Williams improved the tests to make them easier to run on Redox

## RISC-V Improvements

- Andrey Turkin sent the first batch of patches to implement the `riscv64gc-unknown-redox` triple on the Rust compiler fork of Redox
- Andrey Turkin implemented the RISC-V target on the build system

## Programs

- Eva Kurchatova ported the [RVVM](https://github.com/LekKit/RVVM) emulator

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
