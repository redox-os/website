+++
title = "This Month in Redox - August 2025"
author = "Ribbon and Ron Williams"
date = "2025-08-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. August was a very exciting month for Redox! Here's all the latest news.

- COSMIC Reader running on Redox

<a href="/img/screenshot/cosmic-reader.png"><img class="img-responsive" alt="COSMIC Reader running on Redox" src="/img/screenshot/cosmic-reader.png"/></a>

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## RustConf 2025

Jeremy will be presenting at [RustConf 2025](https://rustconf.com/schedule/#1472) in Seattle!
Jeremy Soller, the creator of Redox, will be presenting [10 Years of Redox and Rust](https://github.com/jackpot51/rustconf2025).
His presentation is on Thursday, September 4 at 10:55am.

If you can attend in person, please feel free to [DM Jeremy](https://soller.dev/) to organize a meetup.
There are also free tickets for virtual attendees.

## New Build Engineer

Redox has hired a part-time build engineer.
Wildan Mubarok (`willnode` on Matrix Chat) will be responsible for monitoring our GitLab,
ensuring our packages and images are being built correctly, and tracking down CI problems.
He will also be improving our build system and contributing to Redox as his time allows.
Welcome Wildan!

## Redox is Hiring!

We are still looking for an experienced Kernel/Core engineer.
Please check out the [July report](/news/this-month-250731) for details.
If you think you are a good fit, please send your resume/CV and a link to your open source projects
to president@redox-os.org, cc info@redox-os.org .

## Fixed Dynamically Linked Package Size

Wildan Mubarok fixed a problem where some dynamically linked program packages were carrying static library objects making them very big in size. This fix reduced the size of packages and images a lot!

## COSMIC Reader on Redox!

Jeremy Soller ported the COSMIC Reader (document viewer) and will be using it for his upcoming presentation at RustConf.

## Bootloader Improvements

- (boot) Bjorn Beishline fixed DMA bugs in ARM64 virtualization

## Kernel Improvements

- (kernel) Wildan Mubarok implemented the ARM virtual timer
- (kernel) Wildan Mubarok fixed the formatting check on CI
- (kernel) lebakassemmerl fixed the ARM64 compilation

## Driver Improvements

- (drivers) Wildan Mubarok allowed drivers to be debugged with GDB
- (drivers) Wildan Mubarok fixed possible panic in device enumeration
- (drivers) Wildan Mubarok fixed a `fbcond` panic when `vim` quit
- (drivers) bjorn3 fixed the EHB flag reading for debugging logs in the xHCI driver
- (drivers) bjorn3 did a code cleanup in the xHCI and NVMe interrupt handling
- (drivers) bjorn3 did a code deduplication and cleanup in the MSI/MSI-X handling

## System Improvements

- (sys) bjorn3 fixed network booting in QEMU with Debian 13
- (sys) Ron Williams fixed the `which` tool exit code
- (sys) Wildan Mubarok fixed the root scheme (`:`) creation in `exampled`

## Virtualization Improvements

- (virt) bjorn3 enabled QEMU UEFI by default for x86-64
- (virt) bjorn3 fixed the QEMU terminal mode in ARM64 and RISC-V
- (virt) bjorn3 fixed multi-display support on QEMU BIOS
- (virt) bjorn3 added support for using the [ramfb](https://wiki.osdev.org/Ramfb) QEMU device on x86
- (virt) Wildan Mubarok enabled [HVF](https://wiki.qemu.org/Features/HVF) for QEMU on MacOS Silicon

## Relibc Improvements

- (relibc) Josh Megnauth implemented the `fstatat()` and `confstr()` functions
- (relibc) Josh Megnauth implemented the `paths.h` function group
- (relibc) Josh Megnauth did several improvements to the `syslog` functionality
- (relibc) Josh Megnauth added the `%m` format to `printf()`, to print the correct error string for `errno`
- (relibc) Josh Megnauth implemented the `_POSIX_VDISABLE` extension
- (relibc) Josh Megnauth fixed the `sysconf.h` function group in Linux
- (relibc) Wildan Mubarok implemented the `getnameinfo()`, `getaddrinfo()`, `sem_timedwait()`, and `sem_clockwait()` functions
- (relibc) Wildan Mubarok fixed the `trace` feature
- (relibc) Darley Barreto enabled some tests for Redox
- (relibc) Ron Williams added a few constants to allow some POSIX Signals tests to pass
- (relibc) Jeremy Soller implemented some additional basic types to improve compatibility
- (relibc) Jeremy Soller fixed a typo that was causing the `connect()` function to fail

## Networking Improvements

- (net) voedipus fixed the logic of counting received records in the `ping` tool

## Orbital Improvements

- (gui) Jeremy Soller implemented fullscreen support
- (gui) Wildan Mubarok disabled the launcher bar overlap when maximizing a window
- (gui) Wildan Mubarok optimized graphical debug scrolling

## Programs

- (programs) Wildan Mubarok fixed the OpenSSH compilation
- (programs) Wildan Mubarok fixed and updated Vim (9.1 version)
- (programs) Wildan Mubarok added dynamic linking support to our SDL2 fork
- (programs) Wildan Mubarok reduced the size of the terminfo dependency to speed up the Redox image creation and installation
- (programs) Josh Megnauth fixed and updated SDL2_mixer to 2.8.1 version
- (programs) Petr Hrdina fixed the libtool compilation by updating it to version 2.5.4
- (programs) Ribbon enabled meta-packages in the x86-64 package server
- (programs) Ribbon added "minimal" and "full" meta-package variants for X11

## Debugging Improvements

- (debug) Wildan Mubarok implemented a way to debug any recipe using QEMU
- (debug) bjorn3 implemented a way to start a debuggable QEMU VM without waiting for GDB

## Testing Improvements

- (tests) bjorn3 improved the Redoxer daemon error reporting reliability and messages
- (tests) bjorn3 did a code cleanup in the Redoxer daemon
- (tests) auronandace packaged the [os-test](https://gitlab.com/sortix/os-test) POSIX test suite

## Build System Improvements

- (build) Wildan Mubarok updated the Podman container to Debian 13 to fix it
- (build) Wildan Mubarok updated `cbindgen` in the Podman container to support [a feature for Rust 2024 edition](https://github.com/mozilla/cbindgen/issues/1040)
- (build) Wildan Mubarok changed the Podman Rust tooling installation script to use precompiled binaries and speedup recipe compilation
- (build) Wildan Mubarok enabled dynamic linking by default for GNU Autotools, CMake and Meson templates
- (build) Wildan Mubarok implemented Cookbook templates for CMake and Meson
- (build) Wildan Mubarok implemented the `configureflags`, `cmakeflags`, and `mesonflags` data types for GNU Autotools, CMake and Meson flags when using their Cookbook templates
- (build) Wildan Mubarok added an option (QEMU_ON_WINDOWS) to run QEMU on Windows from WSL2
- (build) Wildan Mubarok fixed the meta-packages
- (build) Wildan Mubarok fixed the `make clean` command
- (build) Wildan Mubarok fixed a GNU Make misconfiguration in the Podman Build on MacOS
- (build) Wildan Mubarok improved the performance of the `make rebuild` command by 50% or more by caching recipe dependencies
- (build) Wildan Mubarok disabled the `rustdoc` installation in Podman to reduce the setup time
- (build) Wildan Mubarok did a cleanup on Cookbook
- (build) Ribbon simplified the `dev` variant configuration with meta-packages

## Documentation Improvements

- (doc) Wildan Mubarok improved the [system boot documentation](https://doc.redox-os.org/book/boot-process.html)
- (doc) Ribbon added the "Easy and quick to expand" [microkernel benefit](https://doc.redox-os.org/book/why-a-new-os.html#benefits-1)

## Website Improvements

- (web) Wildan Mubarok changed the CSS framework from Bootstrap 3 to [Bulma](https://bulma.io/) to allow better design
- (web) Wildan Mubarok fixed the font colors of dark and light modes

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

Use the `desktop` variant for a graphical interface. If you prefer a terminal-style interface,
or if the `desktop` variant doesn't work, please try the `server` variant.

- If you want to test in a virtual machine use the "harddrive" images
- If you want to test on real hardware use the "livedisk" images

Read the following pages to learn how to use the images in a virtual machine or real hardware:

- [Running Redox in a virtual machine](https://doc.redox-os.org/book/running-vm.html)
- [Running Redox on real hardware](https://doc.redox-os.org/book/real-hardware.html)

Sometimes the daily images are outdated and you may want to build Redox from source.
For instructions on how to do this, read the [Building Redox](https://doc.redox-os.org/book/podman-build.html) page.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

<!--

## Discussion

Here are some links to discussion about this news post:

- [floss.social @redox]()
- [floss.social @soller]()
- [Patreon]()
- [Phoronix]()
- [Reddit /r/redox]()
- [Reddit /r/rust]()
- [X/Twitter @redox_os]()

-->

<!--

The following template is for screenshots or photos

<a href="/img/screenshot/image-name.png"><img class="img-responsive" alt="Description" src="/img/screenshot/image-name.png"/></a>

-->

<!--

The following template is for YouTube videos

## Title

<iframe width="800" height="640" src="insert-the-video-embed-link-here" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

-->
