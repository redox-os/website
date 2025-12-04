+++
title = "This Month in Redox - November 2025"
author = "Ribbon and Ron Williams"
date = "2025-11-30"
+++

<img src="/img/screenshot/bottom-webkitgtk3.png" class="img-responsive"/>

- WebKitGTK3 web browser example and bottom system monitor

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. November was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Wayland on Redox!

Jeremy Soller successfully ported the [Smallvil](https://github.com/Smithay/smithay/tree/master/smallvil)
Wayland compositor example from the [Smithay](https://github.com/Smithay/smithay) framework and GTK3 Wayland to Redox.
Special thanks to Ibuki Omatsu (Unix Domain Socket implementation and bug fixing),
Wildan Mubarok (bug fixing and implementation of missing functions),
and other contributors for making it possible.
Smallvil performance on Redox is not adequate, so we still have work to do on Wayland support,
but this represents a huge step forward.

<img src="/img/screenshot/gtk3-wayland.png" class="img-responsive"/>

- GTK3 Wayland Demo running on Smallvil compositor

## WebKitGTK on Redox!

Jeremy Soller and Wildan Mubarok successfully ported and fixed WebKitGTK (GTK 3.x frontend) and its web browser example on Redox. Thanks again to other contributors which helped us to achieve this.

This is first full-featured browser engine ported to Redox, allowing most websites to work.

<img src="/img/screenshot/webkitgtk3.png" class="img-responsive"/>

## MATE Desktop on Redox!

Jeremy Soller was porting MATE Marco for a better X11 window manager and decided to port a basic MATE desktop.

<img src="/img/screenshot/mate-desktop.png" class="img-responsive"/>

## More Boot Fixes

Jeremy Soller added and fixed many driver timeouts to block more infinite loop bugs and continue booting, he also updated system components and drivers to deamonize after starting and moved the hardware initialization to their child process to fix hangs and allow the boot to continue in more hardware.

If you have a computer that hangs on Redox boot we recommend that you test again with the latest daily image.

## Migration to i586

The Rust upstream migrated the i686 CPU targets to i586. The Redox build system and documentation have been updated to use `i586` as the CPU architecture target name for 32-bit x86 computers.

## Self Build Tooling Bootstraping

Jeremy Soller and Wildan Mubarok implemented a feature to allow recipes to configure what build tools they need,
and these build tools being available as recipes. It will allow the following benefits:

- Simplifies the Redox build system, so applications, libraries, and build tools use the same build environment and packaging system
- Greatly reduces build system configuration time in both Podman and Native builds,
as developers will only install the build tools for the recipes that they are using
- Removes the maintenance effort of updating the list of build tool packages required for each Unix-like platform whenever a build tool package is added for the Native Build
- Eases relibc testing on Linux
- Allows the future implementation of [full source bootstraping](https://en.wikipedia.org/wiki/Bootstrapable_builds) to avoid compiler backdoors, like [Guix](https://guix.gnu.org/)

## Build System Submodule Removal

Jeremy Soller unified the build system repositories,
merging the submodules into the [main build system repository](https://gitlab.redox-os.org/redox-os/redox).
This will help to simplify build system improvements, keep everything synchronized, and allow faster development and testing.

If you haven't updated your build system yet, you should backup your changes,
and either run the `make distclean pull container_clean all` command, or download a new build system copy (`git clone https://gitlab.redox-os.org/redox-os/redox.git`)
and build from scratch.

## More GitLab Protection

After suffering frequent GitLab slowdowns, we discovered that bots were using our CI for cryptomining (again)
and AI scrapers were consuming the server resources making it very slow.
As a consequence, we increased our protection, which changed some things:

- By default, only maintainers can run CI jobs.
If you are working on solving CI problems, let us know and we can discuss temporary access to CI.
- Git code push using SSH has been disabled until we find a way to fix it.
All contributors will need to use HTTPS with a PAT (Personal Access Token) for `git push` usage.

The book has been updated with instructions on [how to configure your PAT](https://doc.redox-os.org/book/signing-in-to-gitlab.html#setting-up-pat).

## Kernel Improvements

- (kernel) 4lDO2 fixed a memory allocator panic and data corruption bug
- (kernel) Jeremy Soller enabled serial interrupts in ARM64 ACPI
- (kernel) Jeremy Soller implemented nested event queues
- (kernel) Jeremy Soller implemented `kfpath` in some schemes
- (kernel) Jeremy Soller implemented `F_DUPFD_CLOEXEC`
- (kernel) Jeremy Soller improved the futex lockup performance
- (kernel) Jeremy Soller improved CPU stat accuracy
- (kernel) Jeremy Soller improved the i586 CPU stats
- (kernel) Jeremy Soller fixed an event queue race condition with pipes
- (kernel) Jeremy Soller reduced warnings for legacy scheme path on GUI applications
- (kernel) Anhad Singh fixed some deadlocks
- (kernel) bjorn3 did some code cleanups
- (kernel) AArch Angel implemented `kfpath` on DTB scheme

## Driver Improvements

- (drivers) Jeremy Soller fixed missing PCI devices in Intel Arrow Lake computers
- (drivers) Jeremy Soller improved the PS/2 driver stability
- (drivers) Jeremy Soller improved the Intel HD Audio driver error handling
- (drivers) Jeremy Soller implemented unaligned access on the PCI driver
- (drivers) Ibuki Omatsu updated the `alxd`, `ihdad`, `ac97d`, and `sb16d` drivers to use the `redox-scheme` library, which makes them up-to-date
- (drivers) bjorn3 unified the interrupt vector handling code between the Intel HD Audio and Realtek ethernet drivers
- (drivers) bjorn3 merged the `drivers` repository into the `base` repository. It will allow faster development and testing, especially for driver initialization, and simplify configuration.

## System Improvements

- (sys) Jeremy Soller improved log verbosity on system bootstrap
- (sys) Jeremy Soller implemented support for `MSG_DONTWAIT` in Unix Domain Sockets
- (sys) Jeremy Soller implemented `SO_PEERCRED` in Unix streams
- (sys) Jeremy Soller implemented the `fpath()` function in the `proc` scheme
- (sys) Jeremy Soller implemented the `fstat()` function in the IPC daemon
- (sys) Jeremy Soller did a refactor of `fevent()` function handling
- (sys) Jeremy Soller fixed `SO_SNDBUF` in IPC daemon
- (sys) Jeremy Soller replaced the Smith text editor by Kibi in the `minimal` variants
- (sys) bjorn3 reduced the uutils compilation time by a third (2m50s to 1m56s on his computer) by using [ThinLTO](https://clang.llvm.org/docs/ThinLTO.html) instead of [FatLTO](https://llvm.org/docs/FatLTO.html)
- (sys) bjorn3 fixed some code warnings

## Relibc Improvements

- (libc) 4lDO2 implemented a macro to verify if the relibc internal definitions match the Rust libc crate definitions
- (libc) Jeremy Soller implemented the `sys/queue.h` function group
- (libc) Jeremy Soller improved the TLS alignment reliability
- (libc) Jeremy Soller improved the safety of programs that close file descriptors in a range
- (libc) Jeremy Soller implemented the `ppoll()` function
- (libc) Jeremy Soller fixed a possible POSIX thread key collision
- (libc) Jeremy Soller fixed the `ai_addrlen` and `socklen_t` type definitions
- (libc) Josh Megnauth implemented the `posix_fallocate()` function
- (libc) Ibuki Omatsu fixed the `getpeername()` function in Unix Streams
- (libc) Wildan Mubarok fixed the `getsubopt()` function
- (libc) auronandace improved the documentation of some POSIX functions

## Networking Improvements

- (net) Wildan Mubarok improved the network stack error handling

## RedoxFS Improvements

- (redoxfs) Jeremy Soller updated the `fpath()` function to use the new scheme format
- (redoxfs) Jeremy Soller fixed a panic due to inline data overflow

## Orbital Improvements

- (gui) bjorn3 did some code refactorings
- (gui) Wildan Mubarok fixed the `orbclient` example
- (gui) Wildan Mubarok optimized the `orbclient` library gradient calculation

## Programs

- (programs) Jeremy Soller updated the Rust recipe version to match the Redox cross-compiler on Linux
- (programs) Jeremy Soller enabled DRI3 on Mesa3D and X11
- (programs) Jeremy Soller updated GnuTLS to use dynamic linking
- (programs) Jeremy Soller fixed the Luanti and `librsvg` compilation
- (programs) Wildan Mubarok ported the EGL code from Mesa3D
- (programs) Wildan Mubarok fixed OpenLara and Rustual Boy compilation
- (programs) Anhad Singh fixed the Fish shell execution

## Packaging Improvements

- (pkg) Wildan Mubarok started to implement recipe features which will allow more flexibility with software options
- (pkg) Wildan Mubarok implemented recursive recipe dependencies which will allow us to use implicit dependencies (remove duplicated dependencies) and reduce maintenance cost
- (pkg) Wildan Mubarok implemented package size and BLAKE3 hash on package information, which allow accurate download progress bar and package update verification
- (pkg) Wildan Mubarok fixed the package manager not detecting installed packages from the build system

## Debugging Improvements

- (debug) Jeremy Soller implemented the support for userspace stack traces
- (debug) Jeremy Soller reduced unnecessary logging on system components and drivers to ease boot problem reporting

## Build System Improvements

- (build) Wildan Mubarok implemented an option (`FSTOOLS_IN_PODMAN` environment variable) to build and run the filesystem tools in the Podman container, it fixes a problem with FUSE on MacOS, NixOS and GuixSD
- (build) Wildan Mubarok updated the Cargo recipe template to use dynamic linking
- (build) Wildan Mubarok improved `REPO_BINARY` option to cache downloaded packages between image rebuilds
- (build) Wildan Mubarok updated Cookbook unfetch to also clean recipe binaries, removing the need to use the `uc.recipe` recipe target
- (build) Wildan Mubarok did a code simplification in Cookbook which reduced dependencies
- (build) Wildan Mubarok did a code simplification in the installer which reduced most dependencies
- (build) Wildan Mubarok fixed some breaking changes after the Rust implementation of Cookbook
- (build) Wildan Mubarok fixed the Nix flake (not tested on NixOS, only the package manager on Debian)
- (build) Wildan Mubarok fixed the MacOS support on Apple Silicon
- (build) Wildan Mubarok configured the default GNU FTP mirror as Berkeley university to fix very slow download speed when downloading source tarballs sometimes
- (build) Ribbon fixed missing ARM64 and RISC-V emulators and reduced the QEMU installation time and size by only installing the emulators for the CPU architectures supported by Redox

## Redoxer Improvements

- (redoxer) Wildan Mubarok implemented a way to build and run tests from C/C++ programs
- (redoxer) Wildan Mubarok fixed the toolchain downloading for Linux ARM64 distributions
- (redoxer) Wildan Mubarok did a code simplification in Redoxer which reduced dependencies by half

## Documentation Improvements

- (doc) Ribbon updated and improved the [Coding and Building](https://doc.redox-os.org/book/coding-and-building.html) page, now it has fully up-to-date information
- (doc) Ribbon updated and improved some book pages to use the new recipe push feature to save development time
- (doc) Ribbon documented the `REPO_OFFLINE` (offline mode) environment variable
- (doc) Ribbon documented the `make cook` (Build the filesystem enabled recipes), `make push` (only install recipe packages with changes in an existing QEMU image), `make tree` (show the filesystem configuration recipes and recipe dependencies tree
), `make find` (show recipe packages location), and `make mount_live` (mount the live disk ISO) commands
- (doc) Ribbon documented the `make x.--all` (run a recipe option in all recipes) and `make x.--category-category-name` (run a recipe option in a recipe category folder) commands
- (doc) Ribbon documented the `source.shallow_clone` data type (to enable Git shallow clone in recipes)
- (doc) Ribbon moved the Cookbook package policy to the [Application Porting](https://doc.redox-os.org/book/porting-applications.html#package-policy) page and improved the recipe TODO suggestions
- (doc) Ribbon updated and fixed the [Build Process](https://doc.redox-os.org/book/build-phases.html) page
- (doc) Ribbon updated [how to contribute using the GitLab web interface](https://doc.redox-os.org/book/creating-proper-pull-requests.html#using-gitlab-web-interface)
- (doc) Ribbon explained [how to write book documentation](https://doc.redox-os.org/book/developer-faq.html#how-can-i-write-book-documentation-properly) and improved [how to review MRs](https://doc.redox-os.org/book/developer-faq.html#how-to-properly-review-mrs) in the Developer FAQ
- (doc) Ribbon documented [how to create diagrams for Hugo](https://doc.redox-os.org/book/developer-faq.html#how-can-i-create-diagrams) in the Developer FAQ
- (doc) Wildan Mubarok expanded and improved the [Important Programs](https://doc.redox-os.org/book/important-programs.html) and [Our Goals](https://doc.redox-os.org/book/our-goals.html) pages
- (doc) Wildan Mubarok improved the [pre-i586 CPU support](https://doc.redox-os.org/book/hardware-support.html#why-choosing-i586-as-the-minimal-supported-x86-cpu) information with more details
- (doc) Wildan Mubarok updated and improved the [Configuration Settings](https://doc.redox-os.org/book/configuration-settings.html) page with new options
- (doc) Wildan Mubarok documented the new/better method to [prevent breakage of local recipe changes](https://doc.redox-os.org/book/configuration-settings.html#local-recipe-changes)
- (doc) Wildan Mubarok documented the [Cookbook offline mode](https://doc.redox-os.org/book/configuration-settings.html#cookbook-offline-mode)
- (doc) Wildan Mubarok documented the [Cookbook configuration](https://doc.redox-os.org/book/configuration-settings.html#cookbook-configuration)
- (doc) Wildan Mubarok documented the `CI` (disable parallel recipe fetch/build and Cookbook TUI), `COOKBOOK_MAKE_JOBS` (set the number of CPU threads for recipe compilation), `COOKBOOK_VERBOSE` (enable more recipe log information) and `COOKBOOK_LOGS` (option to save recipe logs at `build/logs/$TARGET`) environment variables
- (doc) Wildan Mubarok moved the Cookbook recipe tarball mirror documentation to the "Configuration Settings" page
- (doc) Timmy Douglas documented [how to build Redox on GuixSD](https://doc.redox-os.org/book/advanced-build.html#gnu-guix-users)
- (doc) Jonathan McCormick applied alphabetical order in the [hardware compatibility](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) tables and improved grammar

## Hardware Updates

- (hw) Jonathan McCormick tested Lenovo ThinkCentre M83 and reported the "Broken" status using an image from 2025-11-09

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
