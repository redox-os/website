+++
title = "This Month in Redox - June 2026"
author = "Ribbon and Ron Williams"
date = "2026-06-30"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. June was a very exciting month for Redox! Here's all the latest news.

## Help Fund Redox Development!

The Redox community is growing rapidly, and we need your help to keep things running smoothly.

We are currently spending more than $3,000 per month on general operations,
which far exceeds our monthly revenue of less than $1,000.
Our monthly expenses include hosting, build engineering, community management and release management.
Although we are currently able to cover our deficit with past donations,
we would greatly appreciate your help to allow us to support our growing community.

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## NGI Zero and NLnet Funding for Virtualization

Redox has been selected for a grant from the NGI Zero Commons fund and [NLnet](https://nlnet.nl/), for our proposal ["Virtualized Redox"](https://nlnet.nl/project/Redox-virtualised-microservices/).
The project goal is to take major strides towards using Redox as a web server and microservices runtime, running in a [`rust-vmm`](https://github.com/rust-vmm/rust-vmm)/[QEMU](https://www.qemu.org/) container.
This grant of €50000 will cover four developers working part-time over the next 12 months, to complete the following sub-projects.
- Networking improvements, including better `virtio-net` support, RSS, TCP/IP segmentation and checksum offloading, and performance improvements for our network stack implementation. Redox uses [`smoltcp`](https://github.com/smoltcp-rs/smoltcp), a written-in-rust Rust embedded network stack, as the basis for our network stack implementation. We will upstream any improvements where appropriate.
- RedoxFS improvements, including improved concurrency, better internal support for our recent Capabilities work, and performance improvements.
- [`virtiofs`](https://virtio-fs.gitlab.io/) support, allowing us to share files with the host safely. This is a full bidirectional implementation, including security, mapping between namespaces, and other advanced `virtiofs` features.
- Other `virtio` improvements
- Support for microservices using [WASM](https://webassembly.org/)/[WASI](https://wasi.dev/) and wasmtime.
- Further improvements to our POSIX compliance, to allow porting and management of more server-side applications.

The team will include Anhad Singh, auronandace, MJ Pooladkhay, and Ron Williams, with kernel support from 4lDO2.

As well, we have received an additional €11,500, for work on Capability-based security.
That continuing work is being done by Ibuki and 4lDO2.

You can read more about this round of [NGI Zero Commons grants here](https://nlnet.nl/news/2026/20260616-67-new-projects.html).
NLnet will be launching several brand new funds in the upcoming months, including [OSI Restack](https://nlnet.nl/restack/), part of the Open Internet Stack initiative of the European Union. If you are an open source developer looking for funding,
please [visit their site for more information](https://nlnet.nl/).

## Userspace File Descriptor Allocation

Ibuki Omatsu moved the file descriptor allocation from the kernel to userspace, which improves reliability, eliminates some race conditions, and reduces kernel complexity (reducing the kernel attack surface, and the opportunity for kernel bugs).

This substantial piece of work also unified more code, reducing code size and maintenance cost.

## USB Gamepad Support and More USB Compatibility!

Jeremy Soller implemented USB gamepad support with generic and Xbox layouts, he tested on Mednafen, Neverball, Neverputt, and sm64ex. Currently it can only be used in emulators and games using SDL2 for input.

He also fixed xHCI endpoint handling using Rust newtypes, which increased general compatibility.

## GTK 3 on Orbital!

Wildan Mubarok ported GTK 3 backend (GDK) to Orbital to improve performance, reduce bugs within Orbital, and remove X11 overhead. The port is similar to how SDL2 and Mesa3D were ported to Orbital.

Only GTK 3 demos are currently known to work.

<img src="/img/screenshot/gtk3-orbital.png" class="img-responsive"/>

## Tcl on Redox!

Wildan Mubarok and Ribbon ported the [Tcl](https://www.tcl-lang.org/) programming language.

<img src="/img/screenshot/tcl.jpg" class="img-responsive"/>

## Flycast on Redox!

Wildan Mubarok fixed and updated Jeremy Soller's port of the [Flycast](https://github.com/flyinghead/flycast) emulator to version 2.6 and Ribbon did some tweaks to workaround bugs,
this port was a work in progress for a long time due to lingering Redox issues and bad performance.

Unfortunately we had to disable JIT to workaround a crash, which reduced performance to around 15 FPS.

- Resident Evil Code Veronica

<img src="/img/screenshot/re-cv-flycast.png" class="img-responsive"/>

- Resident Evil 3

<img src="/img/screenshot/re3-flycast.png" class="img-responsive"/>

- JVM cube demo

<img src="/img/screenshot/jvm-demo-flycast.png" class="img-responsive"/>

## Orbital Fractional Scaling

Wildan Mubarok implemented per-window fractional scaling in Orbital, for better viewing in high DPI displays. The fractional scaling only works for windows that support it, which is currently only GTK 3 via Orbital. It's also planned to be implemented for other GUI libraries.

<img src="/img/screenshot/orbital-dpi.jpg" class="img-responsive"/>

## Mixed Kernel-Userspace Performance Profiling

4lDO2 implemented mixed kernel-userspace performance profiling. This [flamegraph](https://gitlab.redox-os.org/-/project/17/uploads/a1721c7730b625c5136f72879aa4c347/mixed_getppid_flamegraph.svg) gives an example of the output that is available.
In SVG format, it provides clickable drill-down for additional performance details.

<img src="/img/flamegraphs/mixed-kernel-userspace-prof.png" class="img-responsive"/>

## Boot Improvements

- (boot) arjache fixed the bootloader not being able to decrypt a encrypted RedoxFS partition

## Kernel Improvements

- (kernel) 4lDO2 simplified the ACPI code
- (kernel) 4lDO2 did a code cleanup
- (kernel) Akshit Gaur started to optimize the EEVDF scheduler
- (kernel) Wildan Mubarok fixed a context switch memory leak

## Driver Improvements

- (drivers) bjorn3 did a code cleanup

## System Improvements

- (sys) 4lDO2 fixed a possible deadlock in ACPI driver
- (sys) Landon Propes implemented the POSIX method to open a `pty`
- (sys) Landon Propes implemented `TIOCGPTN`, `TIOCSPTLCK`, and `TIOCGPTLCK` in `ptyd`
- (sys) Wildan Mubarok improved path handling performance
- (sys) Wildan Mubarok removed unnecessary path string allocation and improved performance

## Relibc Improvements

- (libc) 4lDO2 finished the migration from filesystem system calls to the unified `SYS_CALL` system call
- (libc) Aadarsh implemented the `posix_spawn` and `posix_spawnp` functions for Redox, with a few fixes from Wildan Mubarok
- (libc) Wildan Mubarok implemented error handling in `posix_exit` function
- (libc) Wildan Mubarok improved process CWD handling and `PATH` environment variable parsing performance by removing and reducing dynamic memory allocation
- (libc) Wildan Mubarok fixed a crash in `pthread_getschedparam` function
- (libc) Wildan Mubarok fixed `NULL` usage for C++ code
- (libc) Wildan Mubarok fixed `nullptr` missing for C++03 or older code on GCC
- (libc) Wildan Mubarok fixed POSIX thread initialization on GCC C++ frontend
- (libc) Wildan Mubarok fixed the error handling of `sem_trywait`, `sem_clockwait` and `sem_wait` functions, which fixed the `threading` module in Python
- (libc) Wildan Mubarok implemented error handling for size overflow in `shmget` function
- (libc) Marsman fixed a crash in `crypt` functions if the key contained non-UTF-8 bytes
- (libc) Marsman fixed a crash when using a short SHA setting in `crypt_sha` function
- (libc) Marsman fixed a crash in `crypt_md5` function
- (libc) Marsman fixed a crash in `mktime` function by using POSIX system timezone
- (libc) sourceturner fixed `inttypes` and `wcstoumax`
- (libc) auronandace continued improving POSIX compliance
- (libc) auronandace eliminated more C header file fragments by including definitions in the `cbindgen` configuration file
- (libc) auronandace moved more definitions written in C to Rust via cbindgen 
- (libc) auronandace added documentation to more functions and definitions
- (libc) auronandace reduced the use of `as` casting to prevent problems in code refactorings
- (libc) auronandace cleaned up lots of headers and code

## Networking Improvements

- (net) Anhad Singh updated `smoltcp` version from 0.12.0 to 0.13.1

## RedoxFS Improvements

- (redoxfs) Wildan Mubarok improved file operation performance by reducing dynamic memory allocation

## Desktop Improvements

- (desk) Wildan Mubarok created the `xfce4-full` meta-package to install the full XFCE desktop environment
- (desk) Wildan Mubarok fixed applications crashing when Orbital screen resolution is too small
- (desk) Ribbon configured Orbital to open C/C++ header, JSON, XML, Perl, and log files in COSMIC Editor

## Programs

- (app) Jeremy Soller ported [Mednaffe](https://github.com/AmatCoder/mednaffe) (a Mednafen emulator GUI)
- (app) Jeremy Soller enabled dynamic linking on Schism Tracker, OpenTTD, and OpenJazz
- (app) Jeremy Soller updated most COSMIC programs to latest versions
- (app) Wildan Mubarok fixed duplicated keyboard input in recent COSMIC application code
- (app) Wildan Mubarok ported Mesa3D demos for Wayland
- (app) Wildan Mubarok enabled partial dynamic linking on `gitoxide`
- (app) Wildan Mubarok updated GNU Bash version from 5.2.15 to 5.3 and enabled dynamic linking
- (app) Wildan Mubarok updated SDL2 version to 2.0.33
- (app) Wildan Mubarok unified the `libxkbcommon-x11` recipe into `libxkbcommon` to scale X11 build configuration
- (app) Wildan Mubarok removed the `getrlimit` warnings from GNU Bash logging
- (app) auronandace updated `libarchive` version from 3.6.2 to 3.8.7

## Build System Improvements

- (build) Wildan Mubarok updated the `make lc.recipe` command to automatically download the recipe source for easier development setup
- (build) Wildan Mubarok fixed `host:recipe` packages (build tools compiled to Linux) being wrongly pushed to Redox
- (build) Wildan Mubarok fixed a possible crash in Cookbook Web Mode
- (build) Wildan Mubarok fixed a SHA hash difference from CDN when downloading the Redoxer toolchain to ensure it always downloads the newest file

## Documentation Improvements

- (doc) Ribbon improved the [Quickstart](https://www.redox-os.org/quickstart/) page and renamed to "Download" to help testers
- (doc) Ribbon improved the [security documentation](https://doc.redox-os.org/book/security.html) with unsafe Rust and POSIX/Linux APIs information
- (doc) Ribbon fixed, updated, and improved the [kernel performance profiling guide](https://doc.redox-os.org/book/performance.html#kernel)
- (doc) Ribbon improved the software portability criteria using BSD ports for reference
- (doc) Ribbon documented the practice to use the latest source of Rust applications to automatically receive dependency updates with fixed or implemented Redox support
- (doc) Ribbon documented that, when porting an application or library, always prefer the source code tarball or repository build instructions (commonly a section in the `README.md` or `INSTALL` files), as build instructions on the application's website tend to be outdated.
- (doc) Ribbon documented the tip to verify minimum application or library dependencies from build system logs, to avoid unnecessary dependencies due to lack of build instructions or build tools separation from library dependencies on build instructions
- (doc) Ribbon documented how to find the original tarball of split Debian packages for reference
- (doc) Ribbon documented how to determine source code tarballs (no operating system or CPU architecture on its naming, with some exceptions)
- (doc) Ian Wagner fixed outdated/broken driver URLs in website pages

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
