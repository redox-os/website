+++
title = "This Month in Redox - March 2025"
author = "Ribbon and Ron Williams"
date = "2025-03-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. March was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## RSoC 2025

It's that time of year again! Redox Summer of Code is now open for applications!

We have funding for one or two people to work on some of [our priorities](https://redox-os.org/rsoc-project-suggestions/). We are also open to your ideas. If you are an undergrad, grad student or are about to graduate, and have good Rust skills and experience with open source, kernels and/or low-level software, we would love to hear from you.

Join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org), tell us that you are interested in RSoC, and post a message in our [Summer of Code](https://matrix.to/#/#redox-soc:matrix.org) room to let us know what you want to work on, and what your skills and technical experience are. If you prefer to discuss your skills and experience privately, let us know and we will contact you by private chat.

Redox OS is a US-based nonprofit, and is required to comply with US law regarding financial transactions.

## NLnet Project - Process Manager

Last summer, Redox was awarded a grant from [NLnet/NGI Zero](https://nlnet.nl/NGI0/) for our project [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/). The work has been conceived and implemented by 4lDO2, with backup from the Redox team.

The NGI grant is divided into (1) a signal handling part and (2) a process management part. The signal handling was largely completed last summer.
As part of the work on process management, 4lDO2 has recently made great progress towards re-implementing the Redox kernel/userspace runtime layer, _where the system can now start almost all daemons, and properly boot to prompt (both dynamically linked ion and static bash)_.
This means the concept of Process IDs is now entirely a userspace thing.

As well, the _process and signal services formerly accessible as specialized system calls, are now accessed via file descriptors_, using the thread and process fds which are now present in (virtually) every file table. This has allowed the removal of **close to 20** system calls from the Redox kernel, replacing them with messages to/from the process manager and other fd-based services.

The major obstacles before this work can be merged are:

- Signal handling. Because the procmgr does not control its clients to the same extent the kernel does, new interfaces need to be created, and while most of the code from the kernel has been moved to userspace, there is still missing logic and bugs left to be fixed.
- Exception handling. This is important for being able to properly handle any program that crashes, custom userspace-handled page faults, and a few other situations. To implement this, the state machines will need to be reworked slightly.
- Fixing bugs and ensuring relevant tests pass.

One TODO item is to separate these `proc` file descriptors (and some other file descriptors that Redox uses internally) from the POSIX file descriptor space. That work is outside the scope of this project, but it is planned as part of another proposal to [NGI Zero Commons](https://nlnet.nl/commonsfund/).

Although there are some other performance bottlenecks related to process management, it is obviously preferable if this new set of changes does not significantly affect the performance of the full system. So far, no significant performance issues have been observed, but we will be doing benchmarking when the process management work is closer to completion. Eventually Redox may benefit from L4-like [synchronous IPC](https://microkerneldude.org/2019/03/07/how-to-and-how-not-to-use-sel4-ipc/), given the synchronous nature of POSIX functions in the proc category, but this is a bit farther in the future.

## Fixed USB Input Support

Jeremy Soller has made substantial improvements to our USB xHCI driver, USB 3.x support and completed a USB hub driver. Our USB HID implementation has had some issues, and was not working in the 0.9.0 version. It is much better now, and can support more real-world hardware.

We would love your help testing external USB mouse and keyboards, as well as the keyboard and touchpad on your laptop, especially if they use USB internally instead of PS/2.
You can do this by [following the instructions below](#how-to-test-the-changes) to download the daily images.
Please be aware that we are bumping into a few other issues, so if the daily images don't boot for you today,
they may work better in the next few days.

Send a message in the [Support](https://matrix.to/#/#redox-support:matrix.org) room to let us know if it worked.
If you have problems, please provide the brand and model code, for both the computer and the device (mouse or keyboard).
Please join our [GitLab](https://doc.redox-os.org/book/signing-in-to-gitlab.html) and add your computer to our [Hardware Compatibility](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md?ref_type=heads) list, if you have the time.


## Fan Photos

We will showcase some fan photos in the monthly reports when we don't have screenshots to show.
Let us know on Matrix if you have some Redox-themed photos you want to share (send a link, don't post the photo on Matrix).
This photo of the Redox OS Coffee Mug was taken by [Jason Bowen](https://mast.hpc.social/@jbowen/114060847319270451).

<a href="/img/fans/jason-bowen-coffee-mug.jpg"><img class="img-responsive" alt="Jason Bowen Coffee Mug" src="/img/fans/jason-bowen-coffee-mug.jpg"/></a>

## Kernel Improvements

- 4lDO2 implemented the `SYS_CALL` system call to unify several different means of setting or getting parameters or invoking actions on a resource. It allows bidirectional read/write buffers, simplifying scheme logic for providing RPC-like interfaces, as well as replacing the dup+read/write+close pattern, and technically all scheme calls that don't send or receive file descriptors.
- bjorn3 restored the legacy scheme path format deprecation warnings
- bjorn3 reduced the verbosity of debug logs on boot

## Driver Improvements

- 4lDO2 added the x86 real-time clock (RTC) driver in userspace, moving it out of the kernel. ARM and RISC-V RTC still need to be moved.
- 4lDO2 started to implement asynchronous support for the NVMe driver which improved performance by about 13-14%
- bjorn3 updated the USB xHCI drivers to use the `redox-scheme` library
- bjorn3 updated the `inputd` daemon to use the `redox-scheme` library
- bjorn3 updated all drivers and daemons to the 0.4 version of the `redox-scheme` library
- bjorn3 moved the PCI driver spawning to the pci-spawner daemon
- bjorn3 fixed the `fbbootlogd` daemon crash which was causing occasional system components and drivers to crash, and it allows you to login on a serial console
- bjorn3 fixed a random crash on the VirtIO-GPU driver
- bjorn3 fixed the damage calculation on the display drawing
- bjorn3 improved the virtual terminal creation and fixed a bug where consumers couldn't get a virtual terminal because it was not available
- bjorn3 improved the handling when the boot framebuffer is missing
- bjorn3 did lots of general code cleanup
- bjorn3 did some refactorings and cleanup on the `inputd` daemon
- bjorn3 did a code cleanup on the `fbbootlogd` and `fbcond` daemons
- bjorn3 implemented a global graphics driver to replace the graphics driver on each virtual terminal on the `inputd` daemon
- bjorn3 did a cleanup of the MBR/GPT library
- bjorn3 reduced the code duplication on storage drivers
- bjorn3 improved the graphics subsystem API
- bjorn3 unified most of the scheme code on storage drivers
- bjorn3 moved the aborts of drivers to the `pcid` daemon, simplifying the drivers
- bjorn3 removed the archaic IBM PC speaker driver
- bjorn3 reduced the verbosity of debug logs on boot
- bjorn3 improved the `fmt.sh` script to apply code formatting in all drivers and libraries with Cargo

## System Improvements

- bjorn3 fixed a deadlock on the `logd` daemon
- bjorn3 updated Orbital and the audio daemon (audiod) to use the new scheme path format
- bjorn3 unified the architecture-specific commands for the init configuration
- bjorn3 removed the pollution of the system environment by an unused environment variable in the boot loader
- bjorn3 removed some obsolete code in the `ptyd`, `logd`, `ramfs` and, `zerod` daemons
- bjorn3 improved error messages for the `init` command shell
- Ron Williams updated the `bootstrap` program to use the 0.2.3 version of the `redox-scheme` library and other new library versions
- Ron Williams updated the libraries of the `escalated` daemon to fix bugs
- 4lDO2 improved the logic of the `shutdown` tool
- 4lDO2 implemented a way to install Redox in a partition instead of the entire storage device in the installer

## USB Improvements

- Jeremy Soller fixed the USB hub driver
- Jeremy Soller fixed the xHCI driver
- Jeremy Soller fixed the USB 3.x support for input devices
- bjorn3 fixed the USB 3.x support for storage devices (currently only tested on QEMU)

## Scheme Improvements

- bjorn3 implemented the `/pci/` scheme, partially based on an earlier attempt by 4lDO2. Quoting bjorn3 from GitLab:

"This allows a single PCI daemon to run on the whole system, prevents multiple drivers from claiming the same PCI device and makes it possible for userspace to enumerate all available PCI devices. In the future this will enable an `lspci` tool, possibly PCIe hot plugging and more"

## RedoxFS Improvements

- James Matlik implemented a garbage collector for the allocation log to prevent it from growing excessively

## Relibc Improvements

- bjorn3 fixed the ARM64 and RISC-V compilation
- bjorn3 improved the correctness of a function
- bjorn3 fixed some warnings
- Satoru Shimazu implemented the `%b` and `%B` formats in the printf() function
- Satoru Shimazu documented the format of the printf() function
- Josh Megnauth implemented support for "ISO-8601 leap weeks" in the strftime() function
- Josh Megnauth implemented the `%T` format and did cleanups in the strptime() function
- Josh Megnauth updated the code to use C string literals
- Josh Megnauth added tests for the strptime() function
- Josh Megnauth deprecated `c_str!`
- Nicolás Antinori updated the `posix-regex` library to fix a bug
- Darley Barreto implemented the `z` and `Z` timezone formats and fixed how day of the year is shown for the `j` format (which is 1 based) on the strftime() function

## Networking Improvements

- bjorn3 enabled the CUBIC congestion control which improved network performance by up to 35%
- bjorn3 did a code cleanup and fixed many warnings

## Terminal Improvements

- Vlad implemented a way to get the terminal size from an alternative file descriptor

## Packaging Improvements

- Josh Megnauth updated the `pkgar` library to Rust 2021 and fixed most compilation warnings
- Marika added an explicit error message when some package manager command is executed with insufficient permissions

## Programs

- Jeremy Soller fixed our `sudo` implementation, where the "setuid" bit was lost during package installation
- Josh Megnauth fixed the Vim compilation, fixed the download link, updated to the version 8.2 and converted the recipe to TOML
- Josh Megnauth fixed and updated the MPFR library to the 4.2.2 version
- Josh Megnauth fixed the `libuv` library
- Josh Megnauth simplified the OpenTyrian recipe configuration
- Ron Williams fixed the Git recipe
- Ron Williams fixed the dynamic linking of the curl recipe
- bjorn3 did a code cleanup in our `sudo` implementation
- bjorn3 updated our OpenSSL, libsodium forks and the Orbital utilities to use the new scheme path format

## Build System Improvements

- Ribbon enabled the installation of GNU Debugger by default on the Podman and Native builds, with support for multiple CPU architectures in some Linux distributions and Unix-like systems
- bjorn3 fixed the QEMU configuration for when multiple displays are attached to the GPU
- Josh Megnauth replaced the SHA256 hash by a BLAKE3 hash on the Cookbook unit tests
- bjorn3 continued the migration of drivers into a unified `base` package, including the network stack (netstack) and the audio daemon (audiod). This substantially simplifies driver development and common-code improvements.
- bjorn3 fixed the leaking of environment variables from a recipe into the overall build scope

## Documentation Improvements

- Ron Williams documented [how to do system call tracing on Redox](https://doc.redox-os.org/book/syscall-debug.html)
- Ribbon documented the [system communication with programs](https://doc.redox-os.org/book/communication.html)
- Artur Assis improved the diagram on the [Stitching it all together](https://doc.redox-os.org/book/stitching-it-all-together.html) page
- Miles Ramage improved and did a cleanup on the "Configuration Settings" page
- Ribbon made a correction on the "Configuration Settings" page

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

Use the `server` variant for a terminal interface and the `desktop` variant for a graphical interface. If you try the `desktop` variant and it doesn't work for you, please try the `server` variant, and let us know in our [Support](https://matrix.to/#/#redox-support:matrix.org) room on Matrix.

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
