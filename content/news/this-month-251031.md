+++
title = "This Month in Redox - October 2025"
author = "Ribbon and Ron Williams"
date = "2025-10-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. October was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Servo on Redox!

Wildan Mubarok successfully ported Servo after some effort to fix bugs and missing functionality, thanks for all contributors that made it possible.

<img src="/img/screenshot/servo.png" class="img-responsive"/>

## htop on Redox!

Wildan Mubarok successfully ported htop with help from Jeremy Soller to improve the port, it's the first advanced system monitor to work on Redox.

<img src="/img/screenshot/htop.png" class="img-responsive"/>

- htop and ffplay

<img src="/img/screenshot/htop-ffplay.jpg" class="img-responsive"/>

## bottom on Redox!

Jeremy Soller ported the [bottom](https://github.com/ClementTsang/bottom) system monitor.

<img src="/img/screenshot/bottom.jpg" class="img-responsive"/>

## GoAccess on Redox

The rsm92 (Rafael) contributor ported [GoAccess](https://goaccess.io/), it's the first web analytics program to work on Redox.

<img src="/img/screenshot/goaccess.jpg" class="img-responsive"/>

## Kernel Improvements

- (kernel) 

## Driver Improvements

- (drivers) 

## System Improvements

- (system) 

## Relibc Improvements

- (relibc) 

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) 

## Filesystem Improvements

- (fs) 

## Terminal Improvements

- (term) Stephen Seo implemented the support for temporary environment variables (`ENVIVAR=some-value command) in the Ion shell

## Programs

- (programs) 

## Build System Improvements

- (build) Wildan Mubarok installed C++ headers in the toolchain to fix C++ programs and libraries
- (build) Wildan Mubarok implemented offline mode in the installer when remote packages aren't used

## Documentation Improvements

- (doc) 

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

Use the `desktop` variant for a graphical interface. If you prefer a terminal-style interface, or if the `desktop` variant doesn't work, please try the `server` variant.

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
