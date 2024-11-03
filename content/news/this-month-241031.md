+++
title = "This Month in Redox - October 2024"
author = "Ribbon and Ron Williams"
date = "2024-10-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. October was a very exciting month for Redox! Here's all the
latest news.

## Support Redox - Merch Sale

A very early Season's Greetings! Redox Merch is on sale!
15% off everything at our [Merch](https://redox-os.creator-spring.com/) store
when you use the discount code "REDOX2025" during checkout.
T-Shirts, Hoodies and Mugs, all with the Redox logo.

Look for the field labelled "Promo Code", enter REDOX2025, and press "Apply".
The discount will show up in the "Order Summary".

Order now to be sure they arrive by the holidays.
Certain product size/color combinations may take longer to arrive.

The discount comes from the Redox portion of your purchase,
so if you are only buying one item, please consider not using the discount code.

Or donate to help support the Redox team.

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Redox Architecture

Announcing the [Redox OS/RFCs](https://matrix.to/#/#redox-rfcs:matrix.org) room on Redox Matrix.
The RFCs room is for discussion about architectural concepts and proposed new features.

If you have expertise in capability-based security, sandboxing, microkernel performance
or other architectural concepts that have been implemented in other major operating systems,
we would love for you to contribute to our RFC process.

If the above link does not work for you,
please ask for an [invitation to the Redox Matrix space](https://matrix.to/#/#redox-join:matrix.org).

## Redox runs on RISC-V!!

RISC-V is now a supported target for Redox!

Andrey Turkin has done extensive work on RISC-V support in the kernel, toolchain and elsewhere.
Thanks very much Andrey for the excellent work!

Jeremy Soller has incorporated RISC-V support into the toolchain and build process,
has begun some refactoring of the kernel and device drivers to better handle all the supported architectures,
and has gotten the Orbital Desktop working when running in QEMU.

<a href="/img/screenshot/orbital-riscv64gc.png"><img class="img-responsive" alt="Orbital on RISC-V" src="/img/screenshot/orbital-riscv64gc.png"/></a>

<a href="/img/screenshot/riscv-terminal.png"><img class="img-responsive" alt="Terminal on RISC-V" src="/img/screenshot/riscv-terminal.png"/></a>

## Raspberry Pi 4 Is Booting!!

Jeremy Soller got the Raspberry Pi 4 board to show the Orbital login screen.
We still need to work on USB support to make it fully usable.

## COSMIC Store

The COSMIC Store was ported!

We updated our configuration files to be compliant with the FreeDesktop standards.
This allows the COSMIC Store to show and install our packages.

<a href="/img/screenshot/cosmic-store.png"><img class="img-responsive" alt="COSMIC Store running on Redox" src="/img/screenshot/cosmic-store.png"/></a>

## Kernel Improvements

- 4lDO2 fixed the profiler
- Ron Williams fixed a regression in the serial console login
- James Francis added a small optimization to how the vector containing open files is resized

## Driver Improvements

- Andrey Turkin sent initial code for RISC-V support on drivers
- Kamil Koczurek updated the ACPI driver to serialize symbols to RON
- Kamil Koczurek updated the ACPI driver to use the new `redox_scheme` library

## RedoxFS Improvements

- Andrey Turkin fixed a troublesome bug on the FUSE backend,
which was causing issues with both the build and CI.
Thanks for finding this Andrey!

## Relibc Improvements

- plimkilde refactored the `strcasecmp` and `strncasecmp` functions with iterators
- plimkilde documented more functions
- Ron Williams fixed detection of errors during the `cbindgen` header building
- Ron Williams improved the tests to make them easier to run on Redox

## ARM64 Improvements

Jeremy Soller enabled the ARM64 [packages](https://static.redox-os.org/pkg/aarch64-unknown-redox/) on the build server!!

## RISC-V Improvements

- Andrey Turkin sent the first batch of patches to implement the `riscv64gc-unknown-redox` triple on the Rust compiler fork of Redox
- Andrey Turkin implemented the RISC-V target on the build system
- Andrey Turkin added RISC-V code on most user-space components
- Jeremy Soller enabled the [RISC-V toolchain](https://static.redox-os.org/toolchain/riscv64gc-unknown-redox/)
- Jeremy Soller enabled [RISC-V packages](https://static.redox-os.org/pkg/riscv64gc-unknown-redox/) on the build server

## Package Improvements

We finally enabled the `pkgar` package format by default and dropped the `tar.gz` packages.

If you want to know all features of the `pkgar` package format please read the [pkgar introduction](https://www.redox-os.org/news/pkgar-introduction/) news post.

## Programs and Porting


- LekKit ported the [RVVM](https://github.com/LekKit/RVVM) RISC-V emulator to Redox. Thanks LekKit!
- bitstr0m ported LuaJIT
- Josh Megnauth ported the [QuakeSpasm](https://github.com/sezero/quakespasm) engine
- Josh Megnauth ported the [OpenTyrian](https://github.com/opentyrian/opentyrian) game
- Josh Megnauth ported the GLEW library

## Build System Improvements

- 4lDO2 modernized the installer code and implemented support for local binary packages

## CI Improvements

- Jeremy Soller fixed the pre-built packages installation not working after the pkgar transition
- Andrey Turkin packaged all toolchains on the Docker image

## From Nothing To Hello World

Ribbon wrote a page to explain the most quick way to test Redox and run a "Hello World" program, have a look at [From Nothing To Hello World](https://doc.redox-os.org/book/nothing-to-hello-world.html) in the Redox Book.

## Documentation Improvements

- Ribbon moved the items of the [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) document to status tables that are much more easy to maintain (thanks for the suggestion contributor J. Craft)
- Ribbon [explained](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md#why-hardware-reports-are-needed) why we need hardware reports

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

## Discussion

Here are some links to discussion about this news post:

- [Fosstodon @redox](https://fosstodon.org/@redox/113419641456133383)
- [Fosstodon @soller](https://fosstodon.org/@soller/113419640065800067)
- [Patreon](https://www.patreon.com/posts/115280896)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/1gioy0r/this_month_in_redox_os_october_2024/)
- [Reddit /r/rust](https://www.reddit.com/r/rust/comments/1gioyq5/this_month_in_redox_os_october_2024/)
- [X/Twitter @redox_os](https://x.com/redox_os/status/1853091214423126174)
- [X/Twitter @jeremy_soller](https://x.com/jeremy_soller/status/1853091063981920600)
