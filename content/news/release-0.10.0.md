+++
title = "Redox OS 0.10.0"
author = "Ron Williams, Ribbon and Jeremy Soller"
date = "2025-03-01"
+++

Redox OS is an Unix-like general-purpose microkernel-based operating system written in Rust.

<!--
Image HTML Code

<a href="/img/screenshot/image-name.png"><img class="img-responsive" alt="Description" src="/img/screenshot/image-name.png"/></a>

-->

## Overview

The version 0.10.0 is packed with new features, improvements, bug fixes and cleanup. 

We would like to thank all maintainers and contributors whose hard work has made this release possible.

Here are just a few of the highlights!

- Complete dynamic linking support
- Better performance and stability
- Better hardware compatiblity
- Better software compatibility
- More ported programs

## Donations and Funding

We are seeking community donations to support more full-time developers, we need the help of generous donors like you!

If you want to help support Redox development, you can make a donation to our [Patreon](https://www.patreon.com/redox_os), [Donorbox](https://donorbox.org/redox-os), or choose one of the other methods in our [Donate](https://redox-os.org/donate/) page.

You can also buy Redox merch (T-shirts, hoodies and mugs!) at our [Redox store](https://redox-os.creator-spring.com/).

If you know an organization or foundation that may be interested in supporting Redox, please contact us on Matrix or the email: donate@redox-os.org

## Overview Video

If you want to avoid the setup work of running Redox on real hardware or in a virtual machine, have a look at our [Software Showcase X]() where we show off programs running on Redox.

## Running Redox

It is recommended to try Redox OS in a virtual machine before trying on real hardware. See
the [supported hardware](https://www.redox-os.org/faq/#which-devices-does-redox-support) section for details on what
hardware to select for the best experience.

- Read [this](https://doc.redox-os.org/book/running-vm.html) page to learn how to run the Redox images in a virtual machine
- Read [this](https://doc.redox-os.org/book/real-hardware.html) page to learn how to run the Redox images on real hardware
- Read [this](https://doc.redox-os.org/book/installing.html) page to learn how to install Redox

### Demo

A 1536 MiB image containing the Orbital desktop environment as well as pre-installed demonstration programs.

- [Real Hardware Image](https://static.redox-os.org/releases/x.y.z/x86_64/redox_demo_x86_64_*_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/x.y.z/x86_64/redox_demo_x86_64_*_harddrive.img.zst)

The demo image includes these additional packages:

- [DOSBox](https://www.dosbox.com/) - A DOS emulator
- Games using PrBoom:
    - DOOM (Shareware)
    - [FreeDOOM](https://freedoom.github.io/)
- [Neverball and Neverputt](https://neverball.org/) - OpenGL games using LLVMPipe (performance may vary!)
- [orbclient](https://gitlab.redox-os.org/redox-os/orbclient) - An Orbital client demo
- [Periodic Table](https://gitlab.redox-os.org/redox-os/periodictable) - A program for viewing information about chemical elements
- [Terminal games](https://gitlab.redox-os.org/redox-os/games) - Command-line games
- [rodioplay](https://gitlab.redox-os.org/redox-os/rodioplay) - A FLAC/WAV music player
- [Sodium](https://gitlab.redox-os.org/redox-os/sodium): A vi-like text editor
- [sopwith](http://www.sopwith.org/): A classic PC air combat game
- syobonaction - A freeware platforming game

### Desktop

A 512 MiB image containing the Orbital desktop environment and some programs for common tasks. Use this if you want to download a smaller image.

- [Real Hardware](https://static.redox-os.org/releases/x.y.z/x86_64/redox_desktop_x86_64_*_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/x.y.z/x86_64/redox_desktop_x86_64_*_harddrive.img.zst)

### Server

A 512 MiB image containing only the command-line environment. Use this if the desktop image is not working well for you.

- [Real Hardware](https://static.redox-os.org/releases/x.y.z/x86_64/redox_server_x86_64_*_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/x.y.z/x86_64/redox_server_x86_64_*_harddrive.img.zst)

## Key Improvements for Release x.y.z

- Item 1
- Item 2

## This Month in Redox

The monthly reports offer more details about the changes present on this release post.

You can read them on the following links:

- [This Month in Redox - (Month) (Year)]()

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

## Changes

There have been quite a lot of changes since x.y.z. We have manually enumerated
what we think is important in this list. Links to exhaustive source-level change
details can be found in the [Changelog](#changelog) section.

## In Depth

The most important changes are shown below.

## Kernel Improvements



## Driver Improvements



## System Improvements



## Relibc Improvements



## Networking Improvements



## Filesystem Improvements



## Programs



## Build System Improvements



## Documentation Improvements



## Changelog

As many changes happened it's not possible to write everything on this post, this section contains all commits since the 0.8.0 version generated by the [changelog](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/changelog.sh) script:

- [redox](https://gitlab.redox-os.org/redox-os/redox/-/compare/first-8-values-current-commit-hash...f2fc8e6)
- [cookbook](https://gitlab.redox-os.org/redox-os/cookbook/-/compare/first-8-values-current-commit-hash...29bf5784)
- [audiod](https://gitlab.redox-os.org/redox-os/audiod/-/compare/first-8-values-current-commit-hash...f7c2426)
- [bootloader](https://gitlab.redox-os.org/redox-os/bootloader/-/compare/first-8-values-current-commit-hash...c7588a1)
- [bootstrap](https://gitlab.redox-os.org/redox-os/bootstrap/-/compare/first-8-values-current-commit-hash...94ac220)
- [ca-certificates](https://gitlab.redox-os.org/redox-os/ca-certificates/-/compare/first-8-values-current-commit-hash...4df67f2)
- [contain](https://gitlab.redox-os.org/redox-os/contain/-/compare/first-8-values-current-commit-hash...e6b8856)
- [coreutils](https://gitlab.redox-os.org/redox-os/coreutils/-/compare/first-8-values-current-commit-hash...b52a1b2)
- [cosmic-edit](https://github.com/pop-os/cosmic-edit)
- [cosmic-files](https://github.com/pop-os/cosmic-files)
- [cosmic-icons](https://github.com/pop-os/cosmic-icons)
- [cosmic-term](https://github.com/pop-os/cosmic-term)
- [curl](https://gitlab.redox-os.org/redox-os/curl/-/compare/first-8-values-current-commit-hash...f50c28394)
- [drivers](https://gitlab.redox-os.org/redox-os/drivers/-/compare/first-8-values-current-commit-hash...897866d)
- [escalated](https://gitlab.redox-os.org/redox-os/escalated/-/compare/first-8-values-current-commit-hash...06fe299)
- [extrautils](https://gitlab.redox-os.org/redox-os/extrautils/-/compare/first-8-values-current-commit-hash...2218a14)
- [findutils](https://gitlab.redox-os.org/redox-os/findutils/-/compare/first-8-values-current-commit-hash...116c044)
- [initfs](https://gitlab.redox-os.org/redox-os/redox-initfs/-/compare/first-8-values-current-commit-hash...7dd9b2e)
- [installer](https://gitlab.redox-os.org/redox-os/installer/-/compare/first-8-values-current-commit-hash...087810a)
- [installer-gui](https://gitlab.redox-os.org/redox-os/installer-gui)
- [ion](https://gitlab.redox-os.org/redox-os/ion/-/compare/first-8-values-current-commit-hash...b1b9475f)
- [ipcd](https://gitlab.redox-os.org/redox-os/ipcd/-/compare/first-8-values-current-commit-hash...db2322c)
- [kernel](https://gitlab.redox-os.org/redox-os/kernel/-/compare/first-8-values-current-commit-hash...0c99e1b)
- [netstack](https://gitlab.redox-os.org/redox-os/netstack/-/compare/first-8-values-current-commit-hash...640e548)
- [netutils](https://gitlab.redox-os.org/redox-os/netutils/-/compare/first-8-values-current-commit-hash...c78b13c)
- [orbdata](https://gitlab.redox-os.org/redox-os/orbdata/-/compare/first-8-values-current-commit-hash...3ca60ee)
- [orbital](https://gitlab.redox-os.org/redox-os/orbital/-/compare/first-8-values-current-commit-hash...8b5497a)
- [orbutils](https://gitlab.redox-os.org/redox-os/orbutils/-/compare/first-8-values-current-commit-hash...4878e07)
- [pkgutils](https://gitlab.redox-os.org/redox-os/pkgutils/-/compare/first-8-values-current-commit-hash...87e2dc8)
- [pop-icon-theme](https://github.com/pop-os/icon-theme/-/compare/first-8-values-current-commit-hash...3126c6a3f6)
- [ptyd](https://gitlab.redox-os.org/redox-os/ptyd/-/compare/first-8-values-current-commit-hash...ab26604)
- [redoxfs](https://gitlab.redox-os.org/redox-os/redoxfs/-/compare/first-8-values-current-commit-hash...5c8f22b)
- [relibc](https://gitlab.redox-os.org/redox-os/relibc/-/compare/first-8-values-current-commit-hash...7a86d101)
- [resist](https://gitlab.redox-os.org/redox-os/resist/-/compare/first-8-values-current-commit-hash...1a09fad)
- [userutils](https://gitlab.redox-os.org/redox-os/userutils/-/compare/first-8-values-current-commit-hash...7a96dab)
- [init](https://gitlab.redox-os.org/redox-os/init/-/compare/first-8-values-current-commit-hash...f5aaf7f)
- [logd](https://gitlab.redox-os.org/redox-os/logd/-/compare/first-8-values-current-commit-hash...e0f930a)
- [ramfs](https://gitlab.redox-os.org/redox-os/ramfs/-/compare/first-8-values-current-commit-hash...f404d64)
- [randd](https://gitlab.redox-os.org/redox-os/randd/-/compare/first-8-values-current-commit-hash...1c88eea)
- [zerod](https://gitlab.redox-os.org/redox-os/zerod/-/compare/first-8-values-current-commit-hash...286bd4a)
