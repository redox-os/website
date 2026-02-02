+++
title = "This Month in Redox - January 2026"
author = "Ribbon and Ron Williams"
date = "2026-01-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. January was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Cargo Project Compilation in Redox!

Anhad Singh successfully applied enough fixes to allow the Cargo project compilation in Redox to work!

This is the third attempt to run the Rust compiler (rustc) and Cargo on Redox, the [first attempt](https://www.redox-os.org/news/gsoc-self-hosting-final/) did many progress but didn't finished due to many work still needed and the [second attempt](https://www.redox-os.org/news/focusing-on-rustc/) fixed the `rustc` compilation but didn't work in Redox yet.

He successfully built GNU nano, [ripgrep](https://github.com/BurntSushi/ripgrep), [cbindgen](https://github.com/mozilla/cbindgen) and [acid](https://gitlab.redox-os.org/redox-os/acid)

- ripgrep compilation in Redox

<img src="/img/screenshot/cargo-ripgrep.png" class="img-responsive"/>

## First Contribution From Redox!

Anhad Singh wrote (using the [COSMIC Edit](https://github.com/pop-os/cosmic-edit) text editor) and pushed the first relibc contribution from the Redox QEMU VM!

- Development in Redox

<img src="/img/screenshot/dev-on-redox.png" class="img-responsive"/>

## Capabilties on Redox!

Ibuki Omatsu successfully implemented the initial capability-based security infrastructure which allows our permission and sandbox system to be much more granular and secure.

It will be extended to other system interfaces in next months.

## Redox on VPS!

Wildan Mubarok successfully [hosted a Redox VM](https://gist.github.com/willnode/468f961602d96bef507e9f672250c7cc) in the [Vultr](https://www.vultr.com/) VPS with some tweaks.

- Redox running in a Vultr VM

<img src="/img/screenshot/vultr.png" class="img-responsive"/>

## Bootloader Environment Editor

Wildan Mubarok implemented a boot environment text editor in the bootloader to insert environment variables and options to change the boot environment.

- Bootloader environment editor with debug environment variables

<img src="/img/screenshot/bootloader-editor.png" class="img-responsive"/>

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
