+++
title = "This Month in Redox - August 2026"
author = "Ribbon and Ron Williams"
date = "2026-08-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. August was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Ring Buffer Communication For More Parallelism

After some months of work Ibuki Omatsu and Anhad Singh implemented a ring buffer communication API equivalent to io_uring on Linux to improve performance, with guidance from 4lDO2 and help from Wildan Mubarok to fix bugs.

This work improve the general system performance and I/O performance by 10x!!

- redox-ring benchmark

<img src="/img/screenshot/ring-bench.png" class="img-responsive" alt=""/>

- In-memory filesystem (ramfs) benchmark

<img src="/img/screenshot/ring-ramfs-bench.png" class="img-responsive" alt=""/>

- redox-ring-dyn benchmark

<img src="/img/screenshot/ring-dyn-bench.png" class="img-responsive" alt=""/>

## QEMU on Redox!

Ribbon and Wildan Mubarok confirmed/tested the QEMU is working on Redox, Ribbon tested the server variant of Redox in QEMU terminal mode.

Currently the performance is not good because we lack CPU hardware acceleration (like Linux KVM) from Redox.

- Redox server on QEMU above Redox desktop

<img src="/img/screenshot/qemu-on-redox.jpg" class="img-responsive" alt=""/>

## Dual-boot Installation from Linux!

Wildan Mubarok improved the Linux support of Redox installer to allow a dual-boot installation of Redox.

- Redox running on triple-boot

<img src="/img/screenshot/triple-boot.jpg" class="img-responsive" alt=""/>

## Mednafen Showcase

Mednafen was ported by never showcased, see a screenshot below:

- Castlevania Symphony Of The Night running on Redox

<img src="/img/screenshot/castle-sotn.jpg" class="img-responsive" alt=""/>

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

- (app) 

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

<img src="/img/screenshot/file-name.type" class="img-responsive" alt=""/>

-->

<!--

The following template is for hardware photos

<img src="/img/hardware/file-name.type" class="img-responsive" alt=""/>

-->

<!--

The following template is for YouTube videos

## Title

<iframe width="800" height="640" src="insert-the-video-embed-link-here" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

-->
