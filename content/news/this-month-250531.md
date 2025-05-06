+++
title = "This Month in Redox - May 2025"
author = "Ribbon and Ron Williams"
date = "2025-05-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. May was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## X11 on Redox

Jeremy Soller implemented X11 support in the Orbital display server!!

This allow programs using X11 to work on Redox without GUI porting, the process is like what XWayland does to run X11 programs above a Wayland compositor.

The code will be reused once we support Wayland.

## Kernel Improvements

- (kernel) 

## Driver Improvements

- (drivers) Arne de Bruijn implemented the support for the Right+Ctrl key combination on the PS/2 driver

## System Improvements

- (system) Jeremy Soller created the `/var` directory and its sub-directories to comply with the Linux [FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html) standard and make some programs work

## Relibc Improvements

- (relibc) 

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) 

## Filesystem Improvements

- (fs) 

## Programs

- (programs) Jeremy Soller ported the [PCRE2](https://github.com/PCRE2Project/pcre2) library
- (programs) Jeremy Soller updated the Pango version to 1.56.3
- (programs) Jeremy Soller updated the Cairo version to 1.18.4
- (programs) Jeremy Soller updated the Pixman version to 0.46
- (programs) Jeremy Soller updated the Fontconfig version to 2.16.0
- (programs) Jeremy Soller enabled dynamic linking on libnettle, GnuTLS, libxml2, XZ, libogg, libvorbis, libjpeg, PCRE, libexpat, gdk-pixbuf and jansson
- (programs) Jeremy Soller enabled more features on GStreamer
- (programs) Jeremy Soller converted the gdk-pixbuf recipe to TOML

## Build System Improvements

- (build-system) Jeremy Soller implemented a Cookbook template for Meson to simplify the recipe configuration

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

- [Fosstodon @redox]()
- [Fosstodon @soller]()
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
