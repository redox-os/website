+++
title = "This Month in Redox - July 2025"
author = "Ribbon and Ron Williams"
date = "2025-07-31"
+++

<a href="/img/screenshot/kernel-debug-gui.png"><img class="img-responsive" alt="Kernel Debugger GUI" src="/img/screenshot/kernel-debug-gui.png"/></a>

(A screenshot of the kernel debugger GUI from Wildan Mubarok)

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. July was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Redox is hiring!

Redox is seeking an OS/kernel developer, paid through a combination of grants and contract work.
If you are a committed FOSS developer, with expertise in Rust, device drivers and performance-optimized software, we are interested in hearing from you.

This is a fully remote position. There are some geographic preferences and limitations, described below.

### Responsibilities

- Implement performance improvements such as ring-buffer based device drivers and services, smart schedulers and techniques to reduce context switching
- Implement POSIX, WASI and other OS APIs
- Implement security and virtualization features
- Improve hardware support
- Port important applications
- Write blog posts and other documentation describing the work
- Participate in developer chat related to the work
- Support applications for grants, create deliverables and report milestone completion

### Qualifications

- University degree in Computer Science or a related field, or self-taught equivalent
- Demonstrated track record in operating system or low level software development
- Rust expertise, especially in no_std and bare-metal contexts
- Substantial body of work in open source
- Able to work independently at a high level of productivity
- Able to interact positively with community members of varying skills and backgrounds
- Flexibility in how payments are received - a portion of your compensation may be in the form of grants from other foundations, and there may be some adjustments in the compensation amounts due to differences in the tax treatments for grants
- You must be eligible for work in the region where you live, and you must be eligible for payment by a US-based organization.
- Preference may be given to those who are eligible for EU-based grants, especially those in an area with beneficial tax treatment of grants.

Please email your resume/CV, and a list of your most significant open source contributions, with links, to info@redox-os.org and president@redox-os.org

## New Board Member

The Redox OS Nonprofit would like to welcome a new member to the board. Mathew John Roberts (AKA auronandace), joins the board as a director. Welcome!

*Mathew is an open source enthusiast who loves the colour green. He was present for the transition from Mattermost to Matrix as the primary communication platform for the Redox project where he has helped out as a moderator ever since. Mathew has learned to code in Rust in his spare time and really enjoys the benefits of working with a strong type system. He thinks a microkernel architecture provides stability and resilience and is excited to see Redox succeed. He still lurks on the #minix IRC channel on the libera.chat network hoping others are also interested in microkernels.*

<a href="/img/board/auronandace.jpeg"><img class="img-responsive" style="width:256px;height:auto" alt="auronandace photo" src="/img/board/auronandace.jpeg"/></a>

## os-test and POSIX compliance testing

Redox has added Sortix's [os-test](https://sortix.org/os-test/) suite and the [Open POSIX Test Suite](https://posixtest.sourceforge.net/)
to its suite of correctness tests.
Although we don't plan for 100% POSIX compliance, we would like to comply wherever it's practical.
There's still lots of work to do, some of it easy and some of it a little harder.
Join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org) if you would like to help out.
And a special congratulations and thanks to Sortie on [receiving a grant](https://sortix.org/blog/os-test-funding/) from the [NGI Zero Commons fund](https://nlnet.nl/commonsfund/).

## Unix Domain Sockets

Ibuki's Redox Summer of Code project to implement key parts of [Unix Domain Sockets (UDS)](https://en.wikipedia.org/wiki/Unix_domain_socket) is wrapping up,
and it has been a big step forward for Redox. You can read all about it in his [latest news post](https://www.redox-os.org/news/rsoc-2025-fdtbl/).
There are a few more [TODOs](https://gitlab.redox-os.org/redox-os/redox/-/issues/1595) to make it complete and be ready for Wayland support.
If you would like to help out, join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

## Secure Disk Encryption!

Jeremy Soller fixed the weak encryption security on RedoxFS using AES-XTS, like [LUKS](https://en.wikipedia.org/wiki/Linux_Unified_Key_Setup) (the Linux disk encryption system) does.

## First Benchmark Report

Ron Williams [reported](https://gitlab.redox-os.org/redox-os/benchmarks#tests) a ~500-700% performance improvement of basic file copy between November 2024 and July 2025.
Performance is increasingly becoming a focus for us, and a wide variety of work has been done to make improvements,
including reduced context switching times and file system improvements.

## Kernel Debugger GUI

Wildan Mubarok added a kernel debugger GUI for the Podman Build to ease debugging!

## Kernel Improvements

- (kernel) bjorn3 fixed the deallocation of contiguous memory pages
- (kernel) bjorn3 fixed file descriptor closing
- (kernel) Darley Barreto implemented the `openat` system call

## Driver Improvements

- (drivers) bjorn3 implemented window resizing on the VirtIO-GPU driver, allowing the host system to change the virtual machine resolution in real-time
- (drivers) bjorn3 updated most libraries and drivers to redox-scheme 0.6
- (drivers) bjorn3 did a general code cleanup in the graphics subsystem
- (drivers) bjorn3 improved handling of kernel logs
- (drivers) Wildan Mubarok fixed the `exampled` driver

## System Improvements

- (sys) Ibuki Omatsu implemented most Unix Domain Socket features
- (sys) Ibuki Omatsu implemented a new file table system, introducing bulk file descriptor passing
- (sys) Ibuki Omatsu implemented new functions (`call_ro`, `call_wo`, `call_rw`) to make `SYS_CALL` callable from user programs
- (sys) James Matlik pinned a uutils commit to keep the tools stable

## Relibc Improvements

- (relibc) 4lDO2 fixed a bad POSIX signal number
- (relibc) Jeremy Soller fixed `___tls_get_addr` on x86-64
- (relibc) Bendeguz Pisch implemented the syslog functionality
- (relibc) Josh Megnauth implemented Linux support in the syslog.h function group
- (relibc) Josh Megnauth implemented more functions for CStr's manipulation
- (relibc) Ron Williams fixed the CI
- (relibc) Ron Williams added signal.h constants
- (relibc) Wildan Mubarok fixed the grp.h headers
- (relibc) Wildan Mubarok fixed the `pthread_attr_getstacksize` function
- (relibc) Ibuki Omatsu updated `get_proc_credentials` function to a more secure capability-based security approach

## RedoxFS Improvements

- (redoxfs) Darley Barreto implemented the upcoming `openat` API

## Testing Improvements

- (tests) Ibuki Omatsu added new file table tests to the `acid` test suite

## Terminal Improvements

- (term) Ellen Zscheile fixed the `dmesg` log ANSI escape sequences when using the `less` tool

## Packaging Improvements

- (pkg) Wildan Mubarok implemented the support for meta-packages
- (pkg) Wildan Mubarok fixed the download length of the package manager
- (pkg) Wildan Mubarok fixed the "Network Error" and "Package Not Found" error messages
- (pkg) Wildan Mubarok improved the permission error message when not running as root

## Orbital Improvements

- (orbital) bjorn3 fixed a bug in the wallpaper program which duplicated the image causing massive memory usage, reducing it from ~149 MB to ~6 MB
- (orbital) Wildan Mubarok implemented mouse accessibility keys

## Programs

- (programs) Wildan Mubarok fixed and enabled dynamic linking in the Rust compiler
- (programs) Ron Williams fixed GCC, with help from 4lDO2
- (programs) Wildan Mubarok fixed the GCC C++ frontend (g++)
- (programs) Wildan Mubarok fixed RustPython, **Zstd**, libuv, and libsodium
- (programs) Wildan Mubarok fixed the LLVM 19 compilation
- (programs) Wildan Mubarok fixed the Git recipe dynamic linking
- (programs) Wildan Mubarok fixed and updated CMake (4.0.3 version), NetSurf (3.11 version), and Protobuf (31.1 version)
- (programs) Wildan Mubarok updated ncdu (1.22 version)
- (programs) Josh Megnauth updated the Mesa3D, Mesa GLU, OpenTyrian, QuakeSpasm, and Duke Nukem recipes to use dynamic linking
- (programs) Josh Megnauth fixed the Neverball dynamic linking
- (programs) Josh Megnauth replaced deprecated functions in Redox binutils
- (programs) Ribbon added the `dev-essential` (development tools, equivalent to `build-essential` in Debian/Ubuntu) and `redox-tests` (relibc, acid and resist tests) meta-packages
- (programs) Wildan Mubarok promoted Zstd to working recipes
- (programs) auronandace promoted the [Onefetch](https://github.com/o2sh/onefetch) and [lsd](https://github.com/lsd-rs/lsd) recipes to working recipes
- (programs) Wildan Mubarok enabled the Onefetch recipe in the x86-64 package server
- (programs) auronandace enabled the lsd recipe in the x86-64 package server
- (programs) Ashton Kemerling packaged the [sqllogictest-rs](https://github.com/risinglightdb/sqllogictest-rs) tool

## Build System Improvements

- (build-system) Jeremy Soller fixed libtool-build not removing old directories
- (build-system) Wildan Mubarok implemented support for [sccache](https://github.com/mozilla/sccache) to speedup frequent recompilation
- (build-system) Wildan Mubarok reimplemented the recipe builder in Rust and added support for incremental compilation
- (build-system) Wildan Mubarok implemented a mechanism to sync all submodules (by updating them to their latest commits) from the GitLab CI
- (build-system) Wildan Mubarok implemented an option (REPO_OFFLINE) to disable recipe updates when running the `make rebuild` command for offline compilation and testing
- (build-system) Wildan Mubarok implemented support for installation of custom host toolchains on Redoxer
- (build-system) Wildan Mubarok improved the Cookbook template for Meson
- (build-system) Wildan Mubarok added LDFLAGS for nested library linking
- (build-system) Wildan Mubarok fixed the Redoxer daemon
- (build-system) Wildan Mubarok fixed the relibc sysroot folder
- (build-system) Wildan Mubarok fixed the downloaded package cache
- (build-system) Josh Megnauth fixed a bug where some runtime dependencies of recipes weren't added to the Redox image
- (build-system) Josh Megnauth implemented TOML and folder naming sanitization in recipes to avoid invalid syntax usage
- (build-system) auronandace applied some Clippy lints to the installer

## CI Improvements

- (ci) Wildan Mubarok added tests in the installer, Cookbook, and pkgutils CI
- (ci) Wildan Mubarok disabled test image creation in forks and branches to save server resources
- (ci) Wildan Mubarok fixed the pipeline status in the build system CI
- (ci) Wildan Mubarok added the [Lychee](https://github.com/lycheeverse/lychee) tool in the website CI

## Documentation Improvements

- (doc) Ribbon documented the policy for [recipe naming](https://gitlab.redox-os.org/redox-os/cookbook#naming)
- (doc) Ribbon did some improvements, cleanup and fixes to the porting documentation
- (doc) Ribbon did some improvements and cleanup to the "Libraries and APIs" page
- (doc) Ribbon improved the [redox_syscall crate explanation](https://doc.redox-os.org/book/libraries-apis.html#redox_syscall)
- (doc) Ribbon documented [how to do MR reviews](https://doc.redox-os.org/book/developer-faq.html#how-to-properly-review-mrs) in the Developer FAQ
- (doc) Ribbon added a summary in the "Configuration Settings" page
- (doc) Petr Hrdina documented the command used to perform actions in multiple recipes
- (doc) Rodrigo Tobar fixed the "Microkernel Benefits" section formatting

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

- [floss.social @redox]()
- [floss.social @soller]()
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
