+++
title = "This Month in Redox - August 2025"
author = "Ribbon and Ron Williams"
date = "2025-08-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. August was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Bootloader Improvements

- (boot) Bjorn Beishline fixed DMA bugs in ARM64 virtualization

## Kernel Improvements

- (kernel) Wildan Mubarok implemented the ARM virtual timer
- (kernel) Wildan Mubarok fixed the formatting check on CI
- (kernel) lebakassemmerl fixed the ARM64 compilation

## Driver Improvements

- (drivers) Wildan Mubarok allowed drivers to be debugged with GDB

## System Improvements

- (sys) bjorn3 fixed network booting from Debian
- (sys) Ron Williams fixed the `which` tool
- (sys) Wildan Mubarok fixed the root scheme (`:`) creation in `exampled`

## Virtualization Improvements

- (virt) Wildan Mubarok enabled [HVF](https://wiki.qemu.org/Features/HVF) for QEMU on MacOS Silicon

## Relibc Improvements

- (relibc) Josh Megnauth implemented the `paths.h` function group
- (relibc) Josh Megnauth did several improvements to the `syslog` functionality
- (relibc) Josh Megnauth added the `%m` format to `printf()`, to print the correct error string for `errno`
- (relibc) Josh Megnauth implemented the `_POSIX_VDISABLE` extension
- (relibc) Wildan Mubarok fixed the `trace` feature
- (relibc) Darley Barreto enabled some tests for Redox
- (relibc) Ron Williams increased the POSIX signals compliance

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) 

## Filesystem Improvements

- (fs) 

## Orbital Improvements

- (gui) Wildan Mubarok disabled the launcher bar overlap when maximizing a window
- (gui) Wildan Mubarok optimized graphical debug scrolling

## Programs

- (programs) Wildan Mubarok fixed and updated Vim (9.1 version)
- (programs) Wildan Mubarok added dynamic linking support to our SDL2 fork
- (programs) Wildan Mubarok reduced the size of the terminfo dependency to speed up the Redox image creation and installation
- (programs) Josh Megnauth fixed and updated SDL2_mixer to 2.8.1 version
- (programs) Petr Hrdina fixed the libtool compilation by updating it to version 2.5.4
- (programs) Ribbon enabled meta-packages in the x86-64 package server
- (programs) Ribbon added "minimal" and "full" meta-package variants for X11

## Debugging Improvements

- (debug) Wildan Mubarok implemented a way to debug any recipe using QEMU

## Testing Improvements

- (tests) auronandace packaged the [os-test](https://gitlab.com/sortix/os-test) POSIX test suite

## Build System Improvements

- (build) Wildan Mubarok updated the Podman container to Debian 13 to fix it
- (build) Wildan Mubarok fixed the meta-packages
- (build) Wildan Mubarok fixed the `make clean` command
- (build) Wildan Mubarok fixed a GNU Make misconfiguration in the Podman Build on MacOS
- (build) Wildan Mubarok did a cleanup on Cookbook
- (build) Ribbon simplified the `dev` variant configuration with meta-packages

## Documentation Improvements

- (doc) Wildan Mubarok improved the [system boot documentation](https://doc.redox-os.org/book/boot-process.html)

## Website Improvements

- (web) Wildan Mubarok changed the CSS framework from Bootstrap 3 to [Bulma](https://bulma.io/) to allow better design
- (web) Wildan Mubarok fixed the font colors of dark and light modes

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

(Use the `server` variant for a terminal interface and the `desktop` variant for a graphical interface, if the `desktop` variant doesn't work use the `server` variant)

- If you want to test in a virtual machine use the "harddrive" images
- If you want to test on real hardware use the "livedisk" images

Read the following pages to learn how to use the images in a virtual machine or real hardware:

- [Running Redox in a virtual machine](https://doc.redox-os.org/book/running-vm.html)
- [Running Redox on real hardware](https://doc.redox-os.org/book/real-hardware.html)

Sometimes the daily images are outdated and you need to build Redox from source.
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
