+++
title = "Redox OS 0.8.0"
author = "Jeremy Soller"
date = "2022-11-23"
+++

<a href="/img/release/0.8.0.jpg"><img class="img-responsive" src="/img/release/0.8.0.jpg"/></a>

## Overview

We have a lot to show since the [0.7.0](/news/release-0.7.0/) release! This
release, care has been taken to ensure real hardware is working, i686 support
has been added, features like audio and preliminary multi-display support have
been enabled, and the boot and install infrastructure has been simplified and
made more robust. I highly recommend skimming through the [changes](#changes)
listed below before jumping into the [images](#images), if you want more
details. It is also recommended to read through the
[Redox OS book](https://doc.redox-os.org/book/) if you want more information on
how to build and use Redox OS.

For this release, I would like to personally thank Ron Williams, who goes by
`rw_van` in the Redox OS chat and GitLab. Ron has provided many valuable
contributions for this release, including vast updates to the
[book](https://doc.redox-os.org/book/), support for building with `podman`,
improvements to the build infrastructure, performing hardware testing, and more.
I would also like to thank our Redox OS Summer of Code (RSoC) students, whose
work was detailed in prior news posts and much of this work is included in this
release. Finally, I would like to thank the donors to Redox OS, for it is their
contributions that keep our RSoC program and our infrastructure running. Please
consider donating to Redox OS using the links on the [Donate page](/donate/)!

## Discussion

Links where this release is discussed will be added here. To contact me
directly, view the links on my personal website: https://soller.dev/

- [Hacker News](https://news.ycombinator.com/item?id=33724712)
- [Mastodon](https://fosstodon.org/@soller/109395197521419157)
- [Patreon](https://www.patreon.com/posts/redox-os-0-8-0-75033993)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/z30uv5/redox_os_080_is_now_released/)
- [Reddit /r/rust](https://www.reddit.com/r/rust/comments/z4epwa/redox_os_080_is_now_released/)
- [Redox OS Chat](https://chat.redox-os.org/redox/pl/sfz4mfeiqfy7imyd1uiuwxiq3r)
- [Twitter](https://twitter.com/redox_os/status/1595527019608973312)

## Supported Hardware

Redox OS generally supports the following hardware, and any issues should be
reported as bugs:

- CPUs
    - Any x86_64 CPU is supported
    - i686 CPUs from the Pentium II and up are supported, however, support is
    not as complete as x86_64 support
- Audio
    - Audio out is supported with 16-bit samples at 44100 Hz
    - AC'97 chipsets are supported (via ac97d)
    - Intel HD Audio chipsets are supported (via ihdad)
- Display
    - Any BIOS supporting VESA BIOS extensions or UEFI system supporting GOP
    will be supported. Advanced features like multi-display are only available
    on UEFI systems where the firmware assigns a GOP instance to each display
- Ethernet
    - Intel Gigabit Ethernet is supported (via e1000d)
    - Realtek RTL8168 is supported (via rtl8168d)
    - There is an Intel 10 Gigabit Ethernet (via ixgbed) driver that I cannot
    test but may work
- Input
    - PS/2 keyboards, mice, and touchpads are supported. Laptops generally use
    PS/2 for the keyboard, and most use PS/2 for the touchpad
- Storage
    - AHCI (SATA) is supported (via ahcid)
    - IDE (PATA) is supported (via ided)
    - NVMe is supported (via nvmed)

Redox OS as of this release generally *does not* support Wi-Fi, USB, and
any other hardware not listed above. Please do not report the lack of support
until it is specified as generally supported.

Please consider contributing to our hardware compatibility list here:
https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md

## Images

It is recommended to try Redox OS in a VM before trying on real hardware. See
the [supported hardware](#supported-hardware) section for details on what
hardware to select for the best experience. For this release, only x86_64 images
are provided, as there is still work to be done on i686 and aarch64 support.

Remember to verify images with sha256sum: https://static.redox-os.org/releases/0.8.0/x86_64/SHA256SUM

### Demo

A 768 MiB image containing the standard desktop environment as well as pre-installed
demo applications

- **Live (recommended)**: https://static.redox-os.org/releases/0.8.0/x86_64/redox_demo_x86_64_2022-11-23_638_livedisk.iso
- Pre-installed: https://static.redox-os.org/releases/0.8.0/x86_64/redox_demo_x86_64_2022-11-23_638_harddrive.img

The demo image includes these additional packages:

- [DOSBox](https://www.dosbox.com/): A DOS emulator
- Games using PrBoom:
    - DOOM (Shareware)
    - [FreeDOOM](https://freedoom.github.io/)
- [Neverball and Neverputt](https://neverball.org/): OpenGL games using llvmpipe
(performance may vary!)
- [`orbclient`](https://gitlab.redox-os.org/redox-os/orbclient): demo orbital
application
- [Periodic Table](https://gitlab.redox-os.org/redox-os/periodictable): an app
for viewing information about chemical elements
- [Redox OS Games](https://gitlab.redox-os.org/redox-os/games): command line
games for Redox OS
- [`rodioplay`](https://gitlab.redox-os.org/redox-os/rodioplay): a music player
capable of loading FLAC and WAV files
- [Sodium](https://gitlab.redox-os.org/redox-os/sodium): a vi-like editor
- [`sopwith`](http://www.sopwith.org/): a classic PC air combat game
- `syobonaction`: a freeware platforming game

### Desktop

A 256 MiB image containing only the standard desktop environment. Use this if
you want to download a smaller image

- Live: https://static.redox-os.org/releases/0.8.0/x86_64/redox_desktop_x86_64_2022-11-23_638_livedisk.iso
- Pre-installed: https://static.redox-os.org/releases/0.8.0/x86_64/redox_desktop_x86_64_2022-11-23_638_harddrive.img

### Server

A 256 MiB image containing only the command-line environment. Use this if the
desktop image is not working well for you

- Live: https://static.redox-os.org/releases/0.8.0/x86_64/redox_server_x86_64_2022-11-23_638_livedisk.iso
- Pre-installed: https://static.redox-os.org/releases/0.8.0/x86_64/redox_server_x86_64_2022-11-23_638_harddrive.img

## Changes

There have been quite a lot of changes since 0.7.0. I have manually enumerated
what I think is important in this list. Links to exhaustive source-level change
details can be found in the [Exhaustive Details section](#exhaustive-details)

### General

- Vast improvements to the [book](https://doc.redox-os.org/book/)
- Support for i686 (32-bit x86 from the Pentium II and up) has been added, and
is generally working on real hardware
- Support for aarch64 (64-bit ARM) has been improved, and is booting to login on
QEMU. Real hardware is not working yet
- Support for multiple displays, if firmware provides framebuffer information
- Audio is now generally supported
- BIOS and EFI images have been merged, one install can boot on either
- The clone and exec syscalls have been moved to userspace. This change also
involved the introduction of
[bootstrap](https://gitlab.redox-os.org/redox-os/bootstrap) and
[escalated](https://gitlab.redox-os.org/redox-os/escalated). `bootstrap` is a
very simply linked program the kernel loads into userspace, that can then handle
loading ELF files such as `init`. `escalated` provides support for `setuid`
programs like `sudo`.
- Use the [redox-daemon crate](https://gitlab.redox-os.org/redox-os/redox-daemon)
to simplify setting up daemons
- Update cargo lock files on most repositories

### `redox`

- A work in progress hardware compatibility list was added, please consider
contributing your own information: https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md
- The build system was refactored to allow building multiple architectures in
one source tree
- Multiple filesystem configs are provided, and can be built side by side in the
same source tree. The default is at `config/ARCH/desktop.toml`, where `ARCH` is
by default `x86_64`
- A demo configuration, providing example applications not present in the
desktop configuration, has been added
- A `build.sh` script was added to make building for different architectures and
configurations easier
- An option for building with `podman` was added. This option will eventually
become the default, as it eliminates many issues with ensuring a clean build
environment on any potential Linux distribution a user may want to build on
- The bootloader, kernel, and initfs packages are now built by the cookbook like
every other package
- BIOS and UEFI images have been merged
- ISOLinux has been removed, now the `bootloader` supports booting from CD-ROM
and images always have valid ISO headers

### `cookbook`

- Support for i686 was added
- Builds now happen in a architecture specific folder, so multiple architectures
can be built in the same source tree
- Icons and manifests were added for a number of GUI programs, making them show
up in the launcher
- Various new recipes were added and many recipes were updated, see detailed
link: https://gitlab.redox-os.org/redox-os/cookbook/-/compare/c9e203a...3d72057

### `audiod`

- Support for software volume control was added, with the default being 50%, as
this ends up working well on real hardware. This volume control works by
multiplying the samples by the cube of the volume as a ratio. So, for the
default of 50%, each sample is multiplied by 0.125.

### `bootloader`

- Support for i686 (BIOS) was added
- Support for aarch64 (UEFI) was improved
- Read performance was increased for BIOS systems
- The bootloader can now boot from the same disk image for both BIOS and UEFI
systems
- CHS (cylinder, head, sector) support has been added for CD boot
- ISO metadata was added to all disk images
- Framebuffer stride is now provided to the OS
- Multiple displays can now be supported, if using UEFI and there is a GOP
driver for each display
- Various fixes for problems on real hardware, see detailed link:
https://gitlab.redox-os.org/redox-os/bootloader/-/compare/c92ba0b...d398e37

### `drivers`

- Support for i686 was added
- Support for aarch64 was improved
- Added AC'97 and IDE drivers, which are common on i686 systems
- Intel HD Audio driver has been enabled by default, and has had various
improvements:
    - Improved detection of best output path. Pin sense information is used, and
    headphones are prioritized over speakers if they are plugged in
    - Improved buffer sizing and usage. This prevents static while ensuring
    latency is still low. The ac97 driver has identical buffer sizing for
    consistency
    - Ensure all widgets in output path are in power state D0 (on)
    - Set headphone amp enable on output pins
    - Fix output stream cyclic buffer length
    - Ensure all input and output amps in output path are set to 0 dB, based on
    their reported capabilities
    - Wait for output stream to start before completing initialization
    - Add a file where codec information can be read `audiohw:codec`
    - Add MSI support
- NVMe driver has had fixes to improve real hardware support
- PCI driver now supports both 32-bit and 64-bit memory BARs
- PS/2 driver has had fixes to ensure more touchpads are working properly
- PS/2 driver now handles extended scancodes, providing volume up/down/mute
support
- RTL8168 driver now supports MSI and MSI-X
- USB HID driver can now support QEMU's USB keyboard, mouse, and touchpad. Real
hardware support is blocked pending fixes in the XHCI driver
- VESA driver can now handle multiple displays, if information is provided by
firmware

### `installer`

- bootloader, bootstrap, kernel, and initfs are installed from packages and are
now placed in /boot
- Installs can support both BIOS and UEFI boot
- Various fixes for issues on real hardware, see detailed link:
https://gitlab.redox-os.org/redox-os/installer/-/compare/2418286...f710fa7

### `kernel`

- Support for i686 was added
- Support for aarch64 was improved
- clone syscall was removed, replaced by userspace
- exec syscall was removed, replaced by userspace
- Support for userspace manipulation of address spaces was added
- Kernel memory space was greatly simplified
- [RMM](https://gitlab.redox-os.org/redox-os/rmm) integration was completed, old
recursive paging code has been removed
- Support for reading partial time between timer ticks, with very high accuracy
- Highly accurate CPU time is now stored per context and shown in `sys:context`
- Internal time tracking changed to u128 of nanoseconds
- Preemptive context switch timer reduced to 6.75ms, to reduce latency
- llvm_asm replaced with new asm macro
- initfs scheme moved to userspace
- Fixes for real hardware issues
- The kernel in particular had a lot of changes this cycle, see detailed link:
https://gitlab.redox-os.org/redox-os/kernel/-/compare/b5a9301...d298459. The
syscall crate also changed to support these kernel changes, and those changes
are included

### `orbital`

- Support for multiple displays, if firmware provides information
- Pass super keypresses to launcher, which allows the launcher to specify
shortcuts like `Super+T` for launching a terminal, `Super+B` for launching a
browser, and `Super+F` for launching a file manager
- Improvements for relative mouse cursor handling (used often by games)
- Improved reliability when displays are resized (supported by VirtualBox)
- Volume can be changed with volume keys or `Super+[` for volume down, `Super+]`
for volume up, and `Super+\\` for volume toggle
- On-screen display when volume changes

### `orbutils`

- Autofill username if there is only one user (usually `user` on a Redox image)
- Do not keep login background resident in memory
- Support loading background on multiple displays
- Show categories in start menu if defined in manifests. `Games` is a new
category, for example

### `redoxfs`

- Modify disk cache size for lower memory systems, it is now 16 MiB and is
pre-allocated
- Various improvements, see detailed link:
https://gitlab.redox-os.org/redox-os/redoxfs/-/compare/0e0ae52...f601b2a

### `relibc`

- Support for i686 was added
- Support for aarch64 was improved
- clone and exec syscall implemented with `redox-exec` crate
- Varous fixes for dynamic linking and C applications, see detailed link:
https://gitlab.redox-os.org/redox-os/relibc/-/compare/7f3f2fa...ee0193a

### Exhaustive Details

Here is an exhaustive list of changes, generated by the new
[changelog script](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/changelog.sh):

- redox: https://gitlab.redox-os.org/redox-os/redox/-/compare/8f210bb...c8634bd
- cookbook: https://gitlab.redox-os.org/redox-os/cookbook/-/compare/c9e203a...3d72057
- rust: https://gitlab.redox-os.org/redox-os/rust/-/compare/45e40dd6819...3e6631a06e7
- audiod: https://gitlab.redox-os.org/redox-os/audiod/-/compare/e05506d...20474ef
- bootloader: https://gitlab.redox-os.org/redox-os/bootloader/-/compare/c92ba0b...d398e37
- bootstrap: New repository at https://gitlab.redox-os.org/redox-os/bootstrap
- contain: https://gitlab.redox-os.org/redox-os/contain/-/compare/2840700...42b381b
- coreutils: https://gitlab.redox-os.org/redox-os/coreutils/-/compare/0010276...690460d
- drivers: https://gitlab.redox-os.org/redox-os/drivers/-/compare/465aaa6...fc4a69c
- escalated: New repository at https://gitlab.redox-os.org/redox-os/escalated
- extrautils: https://gitlab.redox-os.org/redox-os/extrautils/-/compare/3424cda...1f9cf9c
- installer: https://gitlab.redox-os.org/redox-os/installer/-/compare/2418286...f710fa7
- ion: https://gitlab.redox-os.org/redox-os/ion/-/compare/63dc0c3...b9c354e
- ipcd: https://gitlab.redox-os.org/redox-os/ipcd/-/compare/3aa2415...c930dfd
- kernel: https://gitlab.redox-os.org/redox-os/kernel/-/compare/b5a9301...d298459
- netstack: https://gitlab.redox-os.org/redox-os/netstack/-/compare/8669516...54d64d6
- netutils: https://gitlab.redox-os.org/redox-os/netutils/-/compare/55c55eb...34d1ec9
- orbital: https://gitlab.redox-os.org/redox-os/orbital/-/compare/2ebe592...e93c270
- orbterm: https://gitlab.redox-os.org/redox-os/orbterm/-/compare/1e30d3d...8e95662
- orbutils: https://gitlab.redox-os.org/redox-os/orbutils/-/compare/9bb13b4...b5aaf1e
- pkgutils: https://gitlab.redox-os.org/redox-os/pkgutils/-/compare/226cb67...8cc4d84
- ptyd: https://gitlab.redox-os.org/redox-os/ptyd/-/compare/1c1eccd...d1709e5
- redoxfs: https://gitlab.redox-os.org/redox-os/redoxfs/-/compare/0e0ae52...f601b2a
- relibc: https://gitlab.redox-os.org/redox-os/relibc/-/compare/7f3f2fa...ee0193a
- resist: https://gitlab.redox-os.org/redox-os/resist/-/compare/ef02eca...8d420dc
- smith: https://gitlab.redox-os.org/redox-os/Smith/-/compare/b3d650c...52bdeef
- userutils: https://gitlab.redox-os.org/redox-os/userutils/-/compare/cbed606...0621709
- uutils: https://gitlab.redox-os.org/redox-os/uutils/-/compare/1bf3019e...7ed2657e
- init: https://gitlab.redox-os.org/redox-os/init/-/compare/44f7557...0c87d80
- logd: https://gitlab.redox-os.org/redox-os/logd/-/compare/1991764...734bb92
- nulld: https://gitlab.redox-os.org/redox-os/nulld/-/compare/28b4d1c...5af44eb
- ramfs: https://gitlab.redox-os.org/redox-os/ramfs/-/compare/1af1a59...d3fd7f2
- randd: https://gitlab.redox-os.org/redox-os/randd/-/compare/1804f1a...934f130
- zerod: https://gitlab.redox-os.org/redox-os/zerod/-/compare/d5a9818...4b1b17c
