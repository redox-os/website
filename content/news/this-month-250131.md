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

## LOVE on Redox

Jeremy Soller ported the [LOVE](https://www.love2d.org/) game engine to Redox, to achieve this he did the following tasks:

- Ported the libmodplug, libtheora, and openal-soft libraries
- Fixed bugs and implemented some functions in relibc

You can see the Balatro game running on Redox below:

<a href="/img/screenshot/balatro-redox.png"><img class="img-responsive" alt="Balatro on Redox" src="/img/screenshot/balatro-redox.png"/></a>

<a href="/img/screenshot/balatro-gameplay.png"><img class="img-responsive" alt="Balatro Gameplay" src="/img/screenshot/balatro-gameplay.png"/></a>

## Relibc Improvements

- Anhad Singh improved the dynamic linker performance up to 1000%
- Anhad Singh fixed undefined behavior on the error handling
- Bendeguz Pisch implemented the `sigsetjmp` function
- Bendeguz Pisch implemented the `siglongjmp` function
- Guillaume Gielly implemented the `langinfo.h` function group
- Guillaume Gielly refactored the `strftime()` function to use the `langinfo` constants
- Darley Barreto implemented the `tzset` function
- Darley Barreto implemented timezone awareness

## Programs

libmodplug, libtheora, and openal-soft

- Jeremy Soller ported the LOVE game engine
- Jeremy Soller ported the libmodplug library
- Jeremy Soller ported the libtheora library
- Jeremy Soller ported the openal-soft library
- Josh Megnauth improved the portability of GNU programs
- Josh Megnauth simplified the GNU Make recipe configuration

## Build System Improvements

- Daniel Axtens fixed the bootstrapping on Ubuntu 24.04

## Documentation Improvements

- Ron Williams implemented a test for unused pages on the Redox book
- Ron Williams improved the chat documentation
- Ribbon added guides about how to contribute and do development on the README of the system components for people that access their repositories and forget to read the Redox book

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

(Use the `server` variant for a terminal interface and the `desktop` variant for a graphical interface, if the `desktop` variant doesn't work use the `server` variant)

- If you want to test in a virtual machine use the "harddrive" images
- If you want to test on real hardware use the "livedisk" images

Sometimes the daily images are outdated and you need to build Redox from source, to know how to do this read the [Building Redox](https://doc.redox-os.org/book/podman-build.html) page.

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
-->
