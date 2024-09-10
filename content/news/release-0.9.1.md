+++
title = "Redox OS 0.9.1"
author = "Ron Williams, Ribbon and Jeremy Soller"
date = "2024-09-09"
+++

## Overview

This point release contain fixes for the remaining bugs of the 0.9.0 release.

## Running Redox

It is recommended to try Redox OS in a virtual machine before trying on real hardware. See
the [supported hardware](https://www.redox-os.org/faq/#which-devices-does-redox-support) section for details on what
hardware to select for the best experience.

- Read [this](https://doc.redox-os.org/book/ch02-01-running-vm.html) page to learn how to run the Redox images in a virtual machine
- Read [this](https://doc.redox-os.org/book/ch02-02-real-hardware.html) page to learn how to run the Redox images on real hardware
- Read [this](https://doc.redox-os.org/book/ch02-03-installing.html) page to learn how to install Redox

### Demo

A 1536 MiB image containing the Orbital desktop environment as well as pre-installed demonstration programs.

- [Real Hardware Image](https://static.redox-os.org/releases/0.9.0/x86_64/redox_demo_x86_64_2024-09-07_1225_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/0.9.0/x86_64/redox_demo_x86_64_2024-09-07_1225_harddrive.img.zst)

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

- [Real Hardware](https://static.redox-os.org/releases/0.9.0/x86_64/redox_desktop_x86_64_2024-09-07_1225_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/0.9.0/x86_64/redox_desktop_x86_64_2024-09-07_1225_harddrive.img.zst)

### Server

A 512 MiB image containing only the command-line environment. Use this if the desktop image is not working well for you.

- [Real Hardware](https://static.redox-os.org/releases/0.9.0/x86_64/redox_server_x86_64_2024-09-07_1225_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/0.9.0/x86_64/redox_server_x86_64_2024-09-07_1225_harddrive.img.zst)

## Bug Fixes



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

