+++
title = "This Month in Redox - September 2025"
author = "Ribbon and Ron Williams"
date = "2025-09-30"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. September was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Multi-threaded By Default!

Jeremy Soller and bjorn3 fixed the remaining bugs in multi-threading and enabled it by default for x86, this can give a massive performance improvement depending on the hardware specifications.

- ffplay playing a 1080p video with good CPU decoding performance after multi-core and multi-threading support was enabled

<a href="/img/screenshot/ffplay-1080p-video.png"><img class="img-responsive" alt="ffplay playing a 1080p video" src="/img/screenshot/ffplay-1080p-video.png"/></a>

## Redox on BlackBerry!

sajattack [ported Redox to BlackBerry KEY2 LE](https://chaos.social/@sajattack/115155756125794494), currently the keyboard is not working.

- Redox running on Blackberry KEY2 LE

<a href="/img/hardware/blackberry-key2-le.jpg"><img class="img-responsive" alt="Redox running on Blackberry KEY2 LE" src="/img/hardware/blackberry-key2-le.jpg"/></a>

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

## Programs

- (programs) 

## Build System Improvements

- (build-system) 

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
