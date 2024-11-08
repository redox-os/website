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

## Driver Improvements

- Tim Finnegan fixed a deadlock on the USB device initialization

## Relibc Improvements

- Josh Megnauth fixed a panic with programs or games using deprecated POSIX functions

## Testing Improvements

Ron Williams created the [Benchmarks](https://gitlab.redox-os.org/redox-os/benchmarks) repository and recipe to store our performance data history to catch possible regressions.

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
