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

## Kernel Improvements

- 4lDO2 implemented the `SYS_CALL` system call to allow read/write buffers, simplifying scheme logic for RPC-like calls, unifying the logic, replacing the dup+read/write+close pattern, and technically all scheme calls that don't send or receive file descriptors

## Driver Improvements

- bjorn3 moved the PCI driver spawning to the pci-spawner daemon
- bjorn3 fixed the `fbbootlogd` daemon crash preventing most system components and drivers from crashing and allows you to login on a serial console
- bjorn3 improved the virtual terminal creation and fixed a bug where consumers couldn't get a virtual terminal because it was not available
- bjorn3 improved the handling when the boot framebuffer is missing
- bjorn3 did some graphics code cleanup
- bjorn3 did some refactorings and cleanup on the `inputd` daemon
- bjorn3 implemented a global graphics driver to replace the graphics driver on each virtual terminal on the `inputd` daemon
- bjorn3 did a cleanup of the MBR/GPT library
- bjorn3 reduced the code duplication on storage drivers
- bjorn3 improved the graphics subsystem API
- bjorn3 moved the aborts of drivers to the `pcid` daemon, simplifying the drivers
- bjorn3 improved the `fmt.sh` script to apply code formatting in all drivers and libraries with Cargo

## Scheme Improvements

- bjorn3 implemented the `/pci/` scheme, quoting him from GitLab:

"This allows a single PCI daemon to run on the whole system, prevents multiple drivers from claiming the same PCI device and makes it possible for userspace to enumerate all available PCI devices. In the future this will enable an `lspci` tool, possibly PCIe hot plugging and more"

## RedoxFS Improvements

- James Matlik implemented a garbage collector for the allocation log to prevent it from growing excessively

## Relibc Improvements



## Networking Improvements



## Filesystem Improvements



## Packaging Improvements

- Josh Megnauth updated the `pkgar` library to Rust 2021 and fixed most compilation warnings

## Programs

- Josh Megnauth fixed the Vim compilation, fixed the download link, updated to the version 8.2 and converted the recipe to TOML
- Josh Megnauth simplified the OpenTyrian recipe configuration
- Ron Williams fixed the Git recipe

## Build System Improvements

- Ribbon enabled the installation of GNU Debugger (with support for multiple CPU architectures in some Linux distributions and Unix-like systems) by default on the Podman and Native builds
- bjorn3 fixed the QEMU configuration for when multiple displayes are attached to the GPU

## Documentation Improvements



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
