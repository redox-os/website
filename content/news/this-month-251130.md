+++
title = "This Month in Redox - November 2025"
author = "Ribbon and Ron Williams"
date = "2025-11-30"
+++

Redox OS is an complete Unix-like general-purpose microkernel-based operating system
written in Rust. November was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Wayland on Redox!

Jeremy Soller successfully ported the [Smallvil](https://github.com/Smithay/smithay/tree/master/smallvil) Wayland compositor example from the [Smithay](https://github.com/Smithay/smithay) framework and GTK3 Wayland to Redox, thanks Ibuki Omatsu (Unix Domain Socket implementation and bug fixing), Wildan Mubarok (bug fixing and implementation of missing functions), and other contributors for making it possible.

<img src="/img/screenshot/gtk3-wayland.png" class="img-responsive"/>

## WebKitGTK on Redox!

Jeremy Soller and Wildan Mubarok successfully ported and fixed the WebKitGTK (GTK 3.x frontend) and the web browser example on Redox, also thanks to other contributors which helped us to achieve this.

This is the first mature and advanced web browser to work on Redox, which allow most types of websites to be used.

<img src="/img/screenshot/webkitgtk3.png" class="img-responsive"/>

<img src="/img/screenshot/bottom-webkitgtk3.png" class="img-responsive"/>

## MATE Desktop on Redox!

Jeremy Soller was porting MATE Marco for a better X11 window manager and decided to port a basic MATE desktop.

<img src="/img/screenshot/mate-desktop.png" class="img-responsive"/>

## Migration to i586

The Rust upstream migrated the i686 targets to i586.

## Self Build Tooling Bootstraping

Jeremy Soller and Wildan Mubarok started to migrate the build configuration of recipes to use build tools in recipes, it will allow the following benefits:

- Simplify the Redox build system as applications, libraries, and build tools use the same build environment and packaging system
- Big reduction of build system dependency installation time and maintenance cost as contributors will only install the build tools from the recipes that they are using and we don't need to search equivalent package for multiple Unix-like system as new build tools are added
- Allow the future implementation of [full source bootstraping](https://en.wikipedia.org/wiki/Bootstrapable_builds) to avoid compilation backdoors, like [Guix](https://guix.gnu.org/)

## Build System Submodule Removal

Jeremy Soller moved the submodules to the build system repository to allow faster development and testing, who didn't updated the build system yet should backup your changes and run the `make distclean pull container_clean all` command or download a new build system copy and build from scratch.

## More GitLab Protection

After frequent GtiLab slowdowns we discovered that bots were using our CI for cryptomining (again) and AI scrapers consuming the server resources making it very slow, thus we increased our protection which cnaged some things:

- Only maintainers can run CI jobs
- Git code push using SSH was disabled, now all contributors need to use HTTPS with a PAT (Personal Access Token)

Read [this](https://doc.redox-os.org/book/signing-in-to-gitlab.html#setting-up-pat) section to learn how to configure your PAT on Git.

## Kernel Improvements

- (kernel) Anhad Singh fixed some deadlocks
- (kernel) bjorn3 did some code cleanups

## Driver Improvements

- (drivers) bjorn3 updated the Bochs emulator graphics driver (bgad) to use a memory-mapped based IO interface instead of a port-mapped based IO interface

## System Improvements

- (sys) bjorn3 reduced the uutils compilation time by using [ThinLTO](https://clang.llvm.org/docs/ThinLTO.html) instead of [FatLTO](https://llvm.org/docs/FatLTO.html)

## Relibc Improvements

- (libc) Josh Megnauth implemented the `posix_fallocate()` function
- (libc) Ibuki Omatsu fixed the `getpeername()` function

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) 

## Programs

- (programs) Wildan Mubarok ported the EGL code from Mesa3D

## Build System Improvements

- (build) Wildan Mubarok implemented an option (`FSTOOLS_IN_PODMAN` environment variable) to build and run the filesystem tools in the Podman container, it fixes a problem with FUSE on MacOS, NixOS and GuixSD
- (build) Wildan Mubarok fixed some breaking changes after the Rust implementation of Cookbook
- (build) Ribbon fixed missing ARM64 and RISC-V emulators and reduced the QEMU installation time and size by only installing the emulators for the CPU architectures supported by Redox

## Documentation Improvements

- (doc) Ribbon updated and improved the [Coding and Building](https://doc.redox-os.org/book/coding-and-building.html) page, now it has fully up-to-date information
- (doc) Ribbon explained [how to write book documentation](https://doc.redox-os.org/book/developer-faq.html#how-can-i-write-book-documentation-properly) and improved [how to review MRs](https://doc.redox-os.org/book/developer-faq.html#how-to-properly-review-mrs) in the Developer FAQ
- (doc) Ribbon documented [how to create diagrams for Hugo](https://doc.redox-os.org/book/developer-faq.html#how-can-i-create-diagrams) in the Developer FAQ
- (doc) Wildan Mubarok expanded the [Important Programs](https://doc.redox-os.org/book/important-programs.html) page
- (doc) Wildan Mubarok updated and improved the [Configuration Settings](https://doc.redox-os.org/book/configuration-settings.html) page
- (doc) Jonathan McCormick applied alphabetical order in the [hardware compatibility](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) tables and improved grammar

## Hardware Updates

- (hw) Jonathan McCormick tested Lenovo M83

## Website Improvements

- (web) Ribbon added a basic [comparison with other microkernel projects](https://www.redox-os.org/faq/#comparison-with-other-microkernel-projects)

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
