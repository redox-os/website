+++
title = "This Month in Redox - October 2026"
author = "Ribbon and Ron Williams"
date = "2026-10-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. October was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Golang On Redox!

Wildan Mubarok ported the official Go programming language compiler after months of relibc improvements and system fixes.

<img src="/img/screenshot/file-name.type" class="img-responsive" alt=""/>

## Cloud Hypervisor On Redox!

MJ Pooladkhay finished the port of Cloud Hypervisor after some fixes and added integration to Redox build system, which makes testing more rich by using a modern virtualization environment used in production beyond development (QEMU is mostly used on development).

Read [this]() page to learn how to use it.

## WebKitGTK3 Video Support

Wildan Mubarok fixed the missing codecs in GStreamer for video playback.

<img src="/img/screenshot/file-name.type" class="img-responsive" alt=""/>

## GIMP On Redox!

Wildan Mubarok ported GIMP after some months of work.

<img src="/img/screenshot/file-name.type" class="img-responsive" alt=""/>

## Lazygit on Redox!

Wildan Mubarok ported Lazygit after the Golang port fix, which is the first tool written in Go to work on Redox.

<img src="/img/screenshot/file-name.type" class="img-responsive" alt=""/>

## Servo 0.7 Update

Wildan Mubarok updated our Servo fork to version 0.7 after months of work to fix regressions and new bugs.

<img src="/img/screenshot/file-name.type" class="img-responsive" alt=""/>

## Fixed RISC-V Dynamic Linking

lbecher fixed RISC-V dynamic linking, which is the last CPU architecture using static linking in our build system.

It will allow our application testing in RISC-V to scale.

## Initial Rootless Package Installation

Wildan Mubarok finished the first part of rootless package installation code, which create symbolic links of system-wide directories to user equivalent directories.

## virtiofs On Redox!

MJ Pooladkhay finished the virtiofs integration in Redox build system to speedup and ease testing of changes, it allow any Linux to be shared to the Redox QEMU or Cloud Hypervisor VM.

For example, the `make qemu share=redox` command share the Redox build system directory on Linux to Redox.

Read [this]() page to learn how to use it.

## Simplified AI Policy



## Ring Buffers Project Summary

Anhad Singh, Ibuki Omatsu, 4lDO2 and Ron Williams wrote a technical report of the conclusion of the Redox Ring Buffers project.

## Kernel Improvements

- (kernel) Wildan Mubarok fixed a CPU context-wide deadlock in futex code
- (kernel) Wildan Mubarok fixed thread lock ordering in futex code
- (kernel) 4lDO2 did a code cleanup
- (kernel) 4lDO2 fixed many code warnings
- (kernel) bjorn3 fixed some code warnings
- (kernel) Aadarsh fixed some code warnings
- (kernel) Aadarsh did a cleanup in NUMA code
- (kernel) Val Lorentz fixed some code warnings

## Driver Improvements

- (driver) bjorn3 did some code cleanup

## System Improvements

- (sys) bjorn3 moved the Unix domain socket code from the `ipcd` daemon to a new daemon called` udsd` because this code was not related to Redox IPC, simplifying the system
- (sys) Ibuki Omatsu replaced/unified the `fstat`, `unlinkat`, `flink`, and `frename` functions with `std_fs_call`
- (sys) Ibuki Omatsu replaced `dup2` with `FileTableVerb` type
- (sys) Wildan Mubarok fixed a panic in `getty` when writing to TTY

## Relibc Improvements

- (libc) Wildan Mubarok implemented EPOLLHUP and EPOLLER
- (libc) Wildan Mubarok fixed `EINTR` error handling behavior in futex and kill
- (libc) Wildan Mubarok reduced unsafe Rust code in poll, epoll, utimensat, futimens, nanosleep, fstat, fstatvfs, and inet_aton functions
- (libc) auronandace implemented `__fseterr` from Gnulib
- (libc) auronandace reduced more `as` casting usage to prevent problems in code refactorings
- (libc) auronandace enabled some Clippy lints

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (rfs) 

## Programs

- (app) Wildan Mubarok enabled FFMPEG and AAC codec support in GStreamer
- (app) Wildan Mubarok enabled multi-threading on XZ

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

### Programs

To test the changes on applications and libraries, see if the wanted program is available in the following lists and run the following command to install them: `sudo pkg install package-name`

- [x86-64 packages](https://static.redox-os.org/pkg/x86_64-unknown-redox/)
- [ARM64 packages](https://static.redox-os.org/pkg/aarch64-unknown-redox/)
- [RISC-V packages](https://static.redox-os.org/pkg/riscv64gc-unknown-redox/)
- [i586 packages](https://static.redox-os.org/pkg/i586-unknown-redox/)

There's also a package web interface if you want detailed package information:

- [x86-64 packages](https://static.redox-os.org/web/x86_64-unknown-redox/)
- [ARM64 packages](https://static.redox-os.org/web/aarch64-unknown-redox/)
- [RISC-V packages](https://static.redox-os.org/web/riscv64gc-unknown-redox/)
- [i586 packages](https://static.redox-os.org/web/i586-unknown-redox/)

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
