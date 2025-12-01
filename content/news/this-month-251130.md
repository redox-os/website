+++
title = "This Month in Redox - November 2025"
author = "Ribbon and Ron Williams"
date = "2025-11-30"
+++

Redox OS is an complete Unix-like general-purpose microkernel-based operating system
written in Rust. November was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Wayland on Redox!

Jeremy Soller successfully ported the [Smallvil](https://github.com/Smithay/smithay/tree/master/smallvil) Wayland compositor example from the [Smithay](https://github.com/Smithay/smithay) framework and GTK3 Wayland to Redox, thanks Ibuki Omatsu (Unix Domain Socket implementation and bug fixing), Wildan Mubarok (bug fixing and implementation of missing functions), and other contributors for making it possible.

<img src="/img/screenshot/gtk3-wayland.png" class="img-responsive"/>

## WebKitGTK on Redox!

Jeremy Soller and Wildan Mubarok successfully ported and fixed the WebKitGTK (GTK 3.x frontend) and the web browser example on Redox, also thanks to other contributors which helped us to achieve this.

This is the first mature and advanced web browser to work on Redox, which allow most types of websites to be used.

<img src="/img/screenshot/webkitgtk3.png" class="img-responsive"/>

<img src="/img/screenshot/bottom-webkitgtk3.png" class="img-responsive"/>

## MATE Desktop on Redox!

Jeremy Soller was porting MATE Marco for a better X11 window manager and decided to port a basic MATE desktop.

<img src="/img/screenshot/mate-desktop.png" class="img-responsive"/>

## Migration to i586

The Rust upstream migrated the i686 targets to i586.

## Kernel Improvements

- (kernel) 

## Driver Improvements

- (drivers) 

## System Improvements

- (sys) 

## Relibc Improvements

- (libc) 

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) 

## Programs

- (programs) 

## Build System Improvements

- (build) 

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

The following template is for screenshots

<img src="/img/screenshot/file-name.type" class="img-responsive"/>

-->

<!--

The following template is for hardware photos

<img src="/img/hardware/file-name.type" class="img-responsive"/>

-->

<!--

The following template is for YouTube videos

## Title

<iframe width="800" height="640" src="insert-the-video-embed-link-here" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

-->
