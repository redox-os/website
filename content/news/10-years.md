+++
title = "10 Years Of Redox"
author = "Jeremy Soller and Redox Developers"
date = "2025-05-04"
+++

In April Redox celebrated its 10th anniversary! The [first Redox commit](https://github.com/redox-os/redox/commit/0edea108a1d8112b3aa4e8ae7b3d8d41c5d0ed85) was on April 20, 2015.

We would like to thank all the people that made Redox possible. Developing an advanced general-purpose operating system from scratch is a very complex and time consuming task that wouldn't be possible without your help.

These years have shown us how the microkernel architecture and the Rust programming language enable an operating system to be much more correct, secure, reliable and maintainable, with substantially less effort.

Keep in mind that Redox evolved together with Rust (it was created before release 1.0 of the Rust compiler), so we didn't have a rich library ecosystem to build upon.

We were pioneers in Rust operating system development and didn't have the luxury or convenience of the very rich library ecosystem of the C and C++ programming languages.

You can see the first Redox screenshot from the [This Week in Redox 1](https://www.redox-os.org/news/this-week-in-redox-1/) post below:

<a href="/img/screenshot/first-screenshot.png"><img class="img-responsive" alt="First Redox Screenshot" src="/img/screenshot/first-screenshot.png"/></a>

## Achievements

- Internet support
- SATA/NVMe support
- PS/2 and USB support
- SMP support
- Efficient memory management
- Partial POSIX support
- Dozens of ported programs, games and libraries
- GUI support
- XDG compliance

## Opinions

- (Ribbon): I was doing a research in 2016 to discover the best operating systems technically. Once I discovered Redox OS, I was amazed, it had all technical decisions that I wanted which other operating systems lacked. It restored my excitement with a microkernel-based operating system because Redox could run advanced FOSS programs with recent versions (which is a struggle in most new operating systems), Minix could do that using the NetBSD packages but it was unmaintained and lacked system APIs to run programs and drivers with more complexity, thus couldn't be used as a daily driver operating system. Redox also had more advanced system APIs and modern CPU architecture support than GNU Hurd with much less development time, thus it became my focus as the most advanced and practical open-source microkernel-based operating system available.

