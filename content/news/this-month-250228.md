+++
title = "This Month in Redox - February 2025"
author = "Ribbon and Ron Williams"
date = "2025-02-28"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. February was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## FOSDEM 2025

[FOSDEM 2025](https://fosdem.org/2025/) took place in Brussels on Feb. 1 and 2.

Kernel maintainer Jacob Lorentzon (@4lDO2) presented his project [Redox OS Unix-Style Signals](https://nlnet.nl/project/RedoxOS-Signals/),
which is being funded by a grant from [NLnet](https://nlnet.nl/) as part of [NGI Zero Core](https://nlnet.nl/core/).
The presentation took place in the "Microkernel and Component-based OS" room.
A video is not yet available but it will be posted
[on the FOSDEM page for the talk](https://fosdem.org/2025/schedule/event/fosdem-2025-5670-posix-signals-in-user-space-on-the-redox-microkernel/)
when it is ready (barring further technical difficulties).

Jacob also presented a brief overview of Redox for those unfamiliar with the project.
The presentation took place in the "Kernel" room.
You can watch [the video here](https://fosdem.org/2025/schedule/event/fosdem-2025-5973-redox-os-a-microkernel-based-unix-like-os/).

The slides PDFs of the presentations are available on the following links:

- [Redox OS - a Microkernel-based Unix-like OS](https://fosdem.org/2025/events/attachments/fosdem-2025-5973-redox-os-a-microkernel-based-unix-like-os/slides/238806/redoxos-a_VThTapJ.pdf)

- [POSIX Signals in User Space on the Redox Microkernel](https://fosdem.org/2025/events/attachments/fosdem-2025-5670-posix-signals-in-user-space-on-the-redox-microkernel/slides/238302/posix-sig_whCJBqp.pdf)

Thanks for representing us Jacob! Great job!

## GitLab Activity

Now you can monitor our GitLab activity from Matrix!

You can join the new room in the following link:

- [Redox OS/GitLab Activity](https://matrix.to/#/#redox-gitlab-updates:matrix.org)

## Kernel Improvements

- Ron Williams improved the nanosleep() system call to return the time remaining after a software interrupt
- Matej Bozic improved the consistency in memory page representation

## Driver Improvements

- Alice Shelton fixed the Intel HD Audio driver initialization
- Alice Shelton fixed the PS/2 touchpad support on some laptops
- bjorn3 simplified the `fbbootlogd` daemon code
- bjorn3 fixed the standalone compilation of the `driver-network` library
- bjorn3 fixed the PCI/PCIe device function scanning
- bjorn3 fixed potential misbehavior in future versions of the Rust compiler
- bjorn3 removed unnecessary feature gates
- bjorn3 did some code refactorings
- bjorn3 reduced code duplication

## RedoxFS Improvements

- James Matlik fixed a tree node leak on file deletion

## Scheme Improvements

- 4lDO2 replaced the close() scheme call by a one-way message
- 4lDO2 implemented the `/sys/fdstat` scheme resource to know the percentage of file descriptors shared between multiple processes
- Vincent Berthier implemented the `/sys/stat` scheme resource (`/proc/stat` equivalent)

## Relibc Improvements

- plimkilde implemented the pvalloc() function
- plimkilde documented the unistd.h, netinet/in.h, netinet/ip.h and netinet/tcp.h function groups
- plimkilde added documentation and deprecations for the sys/time.h function group
- plimkilde added documentation, deprecations and missing functions for the strings.h function group
- plimkilde fixed the type of the clock_id parameter on the clock_getcpuclockid() function
- Nicolás Antinori implemented the wscanf(), swscanf(), vswscanf() and vwscanf() functions
- Ron Williams fixed the sigqueue() function test
- Josh Megnauth removed an obsolete workaround for `varargs`
- Josh Megnauth fixed the wrong signature of the vsscanf() function emitted by cbindgen
- Darley Barreto improved the time.h function group

## Terminal Improvements

- Orhun Parmaksiz implemented the [NO_COLOR](https://no-color.org/) environment variable on the termion library

## Programs

- Anhad Singh converted the PrBoom and terminfo recipes to TOML
- Anhad Singh updated the Cargo, LLVM, Rust, libssh2, OpenSSL, zlib, COSMIC Terminal and NetSurf recipes to support dynamic linking
- Anhad Singh updated the Rust and OpenSSL forks to allow dynamic linking
- Josh Megnauth updated the libpng, bzip2 and DevilutionX recipes to support dynamic linking
- Jeremy Soller converted the Git recipe to TOML
- Leny implemented dynamic linking support on the LuaJIT recipe

## Build System Improvements

- Anhad Singh fixed the Cookbook runtime dependencies support
- Anhad Singh fixed the build server (CI) Makefile to support dynamic linking
- Anhad Singh added the "patchelf" tool on the Podman container
- Leandro Santiago allowed the Podman build to be used when SELinux is disabled
- Ron Williams updated the Cookbook dependencies to the latest version
- bjorn3 started a build system unification for system components to allow faster contributions and more configuration flexibility
- Vincent Berthier implemented a [Nix flake](https://nixos.wiki/wiki/flakes) for the Podman build
- Leny implemented the GNU patch support for recipes using Git repositories

## Documentation Improvements

- Ron Williams and Ribbon updated the [Redox Summer Of Code project suggestions](https://www.redox-os.org/rsoc-project-suggestions)
- Ronald Weber removed a leftover from the redox repository README
- Jesper Moller fixed a broken link on the drivers repository README
- Hubert Kwitowski replaced the PeaZip recommendation by 7-Zip to extract the Redox images on Windows
- Hubert Kwitowski documented the SHA256 checksum hashes of the Redox daily images
- Vadim Vodopolov fixed a wrong link in the "Introduction" page of the book
- Vincent Berthier documented the process to use the Podman build on NixOS

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

(Use the `server` variant for a terminal interface and the `desktop` variant for a graphical interface, if the `desktop` variant doesn't work use the `server` variant)

- If you want to test in a virtual machine use the "harddrive" images
- If you want to test on real hardware use the "livedisk" images

Sometimes the daily images are outdated and you need to build Redox from source, to know how to do this read the [Building Redox](https://doc.redox-os.org/book/podman-build.html) page.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

<!--
Image HTML Code

<a href="/img/screenshot/image-name.png"><img class="img-responsive" alt="Description" src="/img/screenshot/image-name.png"/></a>

-->

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
