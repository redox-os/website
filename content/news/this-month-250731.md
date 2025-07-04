+++
title = "This Month in Redox - July 2025"
author = "Ribbon and Ron Williams"
date = "2025-07-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. July was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Secure Disk Encryption!

Jeremy Soller fixed the weak encryption security on RedoxFS using AES-XTS, like [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) (the Linux disk encryption system) does.

## Massive Performance Improvement

James Matlik did a massive performance improvement to RedoxFS

## Kernel Improvements

- (kernel) 

## Driver Improvements

- (drivers) bjorn3 implemented window resizing on the VirtIO-GPU driver, allowing the host system to change the virtual machine resolution in real-time

## System Improvements

- (system) 

## Relibc Improvements

- (relibc) 

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) Darley Barreto implemented the upcoming `openat` API

## Orbital Improvements

- bjorn3 fixed a bug in the wallpaper program which duplicated the image causing massive memory usage, reducing it from ~149 MB to ~6 MB

## Programs

- (programs) Ashton Kemerling packaged the [sqllogictest-rs](https://github.com/risinglightdb/sqllogictest-rs) tool

## Build System Improvements

- (build-system) Josh Megnauth fixed a bug where some runtime dependencies of recipes weren't added to the Redox image
- (build-system) auronandace fixed some warnings in the installer

## Documentation Improvements

- (doc) 

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
