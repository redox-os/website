+++
title = "This Month in Redox - January 2025"
author = "Ribbon and Ron Williams"
date = "2025-01-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. January was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Dynamic Linking

Thanks to Anhad Singh for his amazing work on Dynamic Linking!
In this southern-hemisphere-Redox-Summer-of-Code project,
Anhad has implemented dynamic linking as the default build method for many recipes,
and all new porting can use dynamic linking with relatively little effort.

This is a huge step forward for Redox,
because relibc can now become a stable ABI.
And having a stable ABI is one of the prerequisites for Redox to reach "Release 1.0".

Congratulations and many thanks Anhad!

## LOVE on Redox

Jeremy Soller ported the [LOVE](https://www.love2d.org/) game engine to Redox, to achieve this he did the following tasks:

- Ported the libmodplug, libtheora, and openal-soft libraries
- Fixed bugs and implemented some functions in relibc

You can see the [Balatro game](https://www.playbalatro.com/) running on Redox below:

<a href="/img/screenshot/balatro-redox.png"><img class="img-responsive" alt="Balatro on Redox" src="/img/screenshot/balatro-redox.png"/></a>

<a href="/img/screenshot/balatro-gameplay.png"><img class="img-responsive" alt="Balatro Gameplay" src="/img/screenshot/balatro-gameplay.png"/></a>

## Toolchain Upgrade

The Rust compiler version was updated from 1.80 to 1.86 to fix many programs.

## Kernel Improvements

- Anhad Singh fixed the chunk size of the `ITimer` scheme

## System Improvements

- Ron Williams updated the `ptyd` daemon to use the latest version of the `redox-scheme` library
- Anhad Singh implemented dynamic linking support on the `liborbital` library

## Relibc Improvements

- Anhad Singh improved the dynamic linker performance up to 1000%
- Anhad Singh fixed undefined behavior on the error handling
- Anhad Singh fixed the dynamic linker's copy relocations
- Anhad Singh implemented `DT_RELR` on the dynamic linker
- Anhad Singh fixed the dynamic linker multi-threading
- Bendeguz Pisch implemented the `sigsetjmp` and `siglongjmp` functions
- Guillaume Gielly implemented the `langinfo.h` function group
- Guillaume Gielly refactored the `strftime()` function to use the `langinfo` constants
- Darley Barreto implemented the `tzset` function
- Darley Barreto implemented timezone awareness
- Josh Megnauth implemented the support for arguments on shebangs
- Jeremy Soller implemented the `setlinebuf()` function
- Ron Williams fixed the interrupt handling of the `nanosleep` and `sleep` functions
- Ron Williams fixed the `alarm` function to match the POSIX specification
- plimkilde documented the dirent.h and arpa/inet.h function groups
- plimkilde implemented a way to test deprecated functions

## Networking Improvements

- Guillaume Gielly fixed the DHCP server identifier
- Guillaume Gielly fixed the time calculation of the `ping` tool

## Programs

- Jeremy Soller ported the LOVE game engine
- Jeremy Soller ported the libmodplug library
- Jeremy Soller ported the libtheora library
- Jeremy Soller ported the openal-soft library
- Josh Megnauth improved the portability of GNU programs
- Josh Megnauth simplified the GNU Make recipe configuration
- Josh Megnauth partially ported the Boost library
- Anhad Singh ported the [patchelf](https://github.com/NixOS/patchelf) tool
- Anhad Singh updated more recipes to support dynamic linking

## Build System Improvements

- Anhad Singh implemented the support for dynamic linking on Cookbook
- Anhad Singh implemented a switch to enable/disable static linking
- Anhad Singh implemented a recipe data type (`shared-deps`) for dynamically linked libraries
- Ron Williams fixed a toolchain desynchronization
- Daniel Axtens fixed the bootstrapping on Ubuntu 24.04
- Anhad Singh updated the Redoxer version

## Documentation Improvements

- Ron Williams implemented a test for unused pages on the Redox book
- Ron Williams improved the chat documentation
- Ribbon improved the README of most system components to include guidance on how to contribute and do Redox development,
to encourage people to read and follow the method in the [Redox book](https://doc.redox-os.org/book/)
- Anhad Singh documented the [recipe dynamic linking configuration](https://doc.redox-os.org/book/porting-applications.html#dynamically-linked-programs)
- Andrew Lygin fixed typos on the book

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

## Discussion

Here are some links to discussion about this news post:

- [Fosstodon @redox](https://fosstodon.org/@redox/113946345608075943)
- [Fosstodon @soller](https://fosstodon.org/@soller/113946343181557832)
- [Patreon](https://www.patreon.com/posts/121495184)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/1ihkan9/this_month_in_redox_os_january_2025/)
- [Reddit /r/rust](https://www.reddit.com/r/rust/comments/1ihkbaa/this_month_in_redox_os_january_2025/)
- [X/Twitter @redox_os](https://x.com/redox_os/status/1886800124350976067)
