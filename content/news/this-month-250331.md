+++
title = "This Month in Redox - March 2025"
author = "Ribbon and Ron Williams"
date = "2025-03-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. March was a very exciting month for Redox! Here's all the latest news.

<a href="/img/fans/jason-bowen-coffee-mug.jpg"><img class="img-responsive" alt="Jason Bowen Coffee Mug" src="/img/fans/jason-bowen-coffee-mug.jpg"/></a>

(This photo was taken by [Jason Bowen](https://mast.hpc.social/@jbowen/114060847319270451))

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## RSoC 2025



## Fixed USB Input Support

We had a regression that broke the USB HID support since the 0.9.0 version, Jeremy Soller successfully fixed the xHCI driver, USB 3.x support and completed the USB hub driver.

## Kernel Improvements

- 4lDO2 implemented the `SYS_CALL` system call to allow read/write buffers, simplifying scheme logic for RPC-like calls, unifying the logic, replacing the dup+read/write+close pattern, and technically all scheme calls that don't send or receive file descriptors
- bjorn3 restored the legacy scheme path format deprecation warnings
- bjorn3 reduced the verbosity of debug logs on boot

## Driver Improvements

- 4lDO2 added the x86 RTC driver
- 4lDO2 started to implemented multi-threading support on the NVMe driver
- bjorn3 updated the Bochs emulator/debugger and USB xHCI drivers to use the `redox-scheme` library
- bjorn3 updated the `inputd` daemon to use the `redox-scheme` library
- bjorn3 updated all drivers and daemons to the 0.4 version of the `redox-scheme` library
- bjorn3 moved the PCI driver spawning to the pci-spawner daemon
- bjorn3 fixed the `fbbootlogd` daemon crash preventing most system components and drivers from crashing and allows you to login on a serial console
- bjorn3 fixed a random crash on the VirtIO-GPU driver
- bjorn3 fixed the damage calculation on the terminal drawing
- bjorn3 improved the virtual terminal creation and fixed a bug where consumers couldn't get a virtual terminal because it was not available
- bjorn3 improved the handling when the boot framebuffer is missing
- bjorn3 did many code cleanup
- bjorn3 did some refactorings and cleanup on the `inputd` daemon
- bjorn3 did a code cleanup on the `fbbootlogd` and `fbcond` daemons
- bjorn3 implemented a global graphics driver to replace the graphics driver on each virtual terminal on the `inputd` daemon
- bjorn3 did a cleanup of the MBR/GPT library
- bjorn3 reduced the code duplication on storage drivers
- bjorn3 improved the graphics subsystem API
- bjorn3 unified most of the scheme code on storage drivers
- bjorn3 moved the aborts of drivers to the `pcid` daemon, simplifying the drivers
- bjorn3 removed the IBM PC speaker driver
- bjorn3 reduced the verbosity of debug logs on boot
- bjorn3 improved the `fmt.sh` script to apply code formatting in all drivers and libraries with Cargo

## System Improvements

- bjorn3 fixed a deadlock on the `logd` daemon
- bjorn3 updated Orbital and the audio daemon (audiod) to use the new scheme path format
- bjorn3 unified the architecture-specific commands on the init configuration
- bjorn3 removed a polution in the system environment from an unused environment variable on the boot loader
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
- bjorn3 fixed the USB 3.x support for storage devices

## Scheme Improvements

- bjorn3 implemented the `/pci/` scheme, quoting him from GitLab:

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

- bjorn3 implemented the CUBIC congestion control which increased the performance in 35%
- bjorn3 did a code cleanup and fixed many warnings

## Terminal Improvements

- Vlad implemented a way to get the terminal size from an alternative file descriptor

## Packaging Improvements

- Josh Megnauth updated the `pkgar` library to Rust 2021 and fixed most compilation warnings
- Marika added an explicit error message when some package manager command is executed with insufficient permissions

## Programs

- Josh Megnauth fixed the Vim compilation, fixed the download link, updated to the version 8.2 and converted the recipe to TOML
- Josh Megnauth fixed and updated the MPFR library to the 4.2.2 version
- Josh Megnauth fixed the `libuv` library
- Josh Megnauth simplified the OpenTyrian recipe configuration
- Ron Williams fixed the Git recipe
- Ron Williams fixed the dynamic linking of the curl recipe
- bjorn3 did a code cleanup in our `sudo` implementation
- bjorn3 updated our OpenSSL, libsodium forks and the Orbital utilities to use the new scheme path format

## Build System Improvements

- Ribbon enabled the installation of GNU Debugger (with support for multiple CPU architectures in some Linux distributions and Unix-like systems) by default on the Podman and Native builds
- bjorn3 fixed the QEMU configuration for when multiple displayes are attached to the GPU
- Josh Megnauth replaced the SHA256 hash by a BLAKE3 hash on the Cookbook unit tests
- bjorn3 unified the network stack (netstack) and the audio daemon (audiod) on the `base` recipe
- bjorn3 remove leaking to the user environment from unused environment variables

## Documentation Improvements

- Ron Williams documented [how to do system call tracing on Redox](https://doc.redox-os.org/book/syscall-debug.html)
- Ribbon documented the [system communication with programs](https://doc.redox-os.org/book/communication.html)
- Ribbon fixed a wrong information on the "Configuration Settings" page
- Artur Assis improved the diagram on the [Stitching it all together](https://doc.redox-os.org/book/stitching-it-all-together.html) page
- Miles Ramage improved and did a cleanup on the "Configuration Settings" page

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
