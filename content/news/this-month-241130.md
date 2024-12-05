+++
title = "This Month in Redox - November 2024"
author = "Ribbon and Ron Williams"
date = "2024-11-30"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. November was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!
Use code REDOX2025 at checkout for 15% off (it comes out of Redox's share of the profit,
so consider not using the code if you are only buying one item).

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Getting Funding to be a Redox Contributor

If you are a current Redox contributor, or if you are a student who would like to contribute to Redox,
there are opportunities for funding.

[NLnet](https://nlnet.nl/) is an excellent organization, and the [NGI Zero Commons](https://nlnet.nl/commonsfund/)
fund seems like a great fit for Redox.
Up to 50,000 EUR is available for a first project.
There should be a "European dimension" to your project,
so if you are based in the EU, this might be a great opportunity for you.
There's a new call for proposals on the 1st of every even numbered month.
It can take about 5 months to get funding in place, so apply early.
You can apply directly to the fund,
but if you are a Redox contributor and would like our help with writing a proposal,
please contact Ron Williams on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

Redox currently has one project funded by NLnet's NGI Zero Core fund,
and we have applied for two NGI Zero Commons projects to start this summer.
However, if both proposals are accepted, we will need a second developer,
so if you are a Redox kernel contributor and want to help,
please contact Ron Williams on Matrix.
The projects will run roughly from June 2025 to May 2026.

Redox has a enough money to fund one or two projects, up to $5,000 each.
We are looking for current Redox contributors who would like to help us with some of our priorities.
The work can be done part-time as long as it is done in a reasonable timeframe.
You must be eligible to receive funds from a US organization.
Here are a few of our priorities, but we are open to anything that helps us get one step closer to a release.
If you are already working on one of these,
don't be afraid to ask about funding,
or let us know if you would like to collaborate with someone who is funded.

- Device drivers - ACPI, AML, GPU, USB, IOMMU, WiFi
- Graphics and Web - Gtk, Qt, Wayland, WebKitGTK, SpiderMonkey
- Redox as a Hypervisor - Podman, Docker, Buildah, FUSE, Linux-on-Redox
- Database support - Filesystem improvements, MySQL, Postgres, MongoDB
- Performance - Scheduler, Filesystem performance, Network stack performance

If you are a student or new graduate, we are planning to have our Redox Summer of Code (RSoC) program again in 2025.
It's **too early** to apply for that,
however, if you are not able to participate in the summer but would like to do a project sooner than that,
please let us know.
We are looking for projects from 6 to 10 weeks in duration,
and you must be eligible to receive funds from a US organization.
Feel free to bring your own ideas, but here are a few suggestions.

- Testing Redox - Performance, compliance, CI, test management
- Porting Linux/POSIX programs - add more POSIX functionality, port popular libraries, write a porting guide
- Web server support - NodeJS, Database support

## COSMIC Alpha 4

COSMIC Desktop has just released [Alpha 4](https://blog.system76.com/post/cosmic-alpha-4)!
Redox includes COSMIC Editor, Files, Terminal and Store,
and the Redox nightly build has all the latest improvements.

## Redox On Redox

Andrey Turkin executed the RISC-V version of Redox Server from the [RVVM](https://github.com/LekKit/RVVM) RISC-V emulator running on the x86-64 version of Redox Desktop!! And thanks again to LekKit for the awesome emulator!

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

- bitstr0m fixed the libevent compilation
- Ribbon successsfully compiled more Rust programs and demos
- Josh Megnauth updated OpenJazz to the latest version and converted the recipe configuration to TOML
- Amir Ghazanfari improved the Sodium file selection

## Testing Improvements

- Ron Williams fixed the CI of the Redox build system
- Ron Williams created the [Benchmarks](https://gitlab.redox-os.org/redox-os/benchmarks) repository and recipe to measure and record our performance data history. More tests are needed, please feel free to add.

## Build System Improvements

- Ron Williams allowed the installer error handling to show the package name when a pre-built package can't be found on the Redox build server
- Ron Williams added some recipes on the build server configuration to allow the `desktop` variant image to be created with downloaded pre-built packages
- Ron Williams implemented the `"source"` value as an alternative for `"recipe"` in the filesystem config files when the `REPO_BINARY` environment variable is enabled, to reduce confusion
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
