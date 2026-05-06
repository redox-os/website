+++
title = "This Month in Redox - April 2026"
author = "Ribbon and Ron Williams"
date = "2026-04-30"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. April was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Improved Boot on Real Hardware

This month, we have made system boot more resilient and better able to avoid getting stuck.
Wildan Mubarok provided fixes and addressed some long-time regressions after the 0.9.0 release, allowing boot to continue even if certain important drivers exited or became blocked.

A summary of his changes are:

- Updated and rebased against the upstream [Rust-OSDev `acpi`](https://github.com/rust-osdev/acpi) crate to improve support for many computers, and VirtualBox
- Fixed the boot stuck by driver exits
- Reduced the boot time of computers with multiple CPU cores

If you had problems booting Redox on real hardware, or in VirtualBox, please test the daily images again and report the status to us.

## Better RISC-V Compatibility

AArch Angel improved the RISC-V real hardware compatibility by switching to the `Sv39` MMU scheme and adding bootloader workarounds

## tmux on Redox!

Wildan Mubarok successfully ported `tmux`, which allows terminal-agnostic multiplexing.

<img src="/img/screenshot/tmux.png" class="img-responsive"/>

## Accurate System Stats

Wildan Mubarok improved the accuracy of the CPU time stats reported to system monitors like `htop`.

- htop

<img src="/img/screenshot/accurate-htop-stats.png" class="img-responsive"/>

## Better Orbital Performance

Wildan Mubarok implemented the support for partial window pixel update (partial pixel blit) which improved performance by only redrawing window pixels that changed.

- Partial blit in NetSurf

The purple rectangles show the pixels being updated in the NetSurf window

<img src="/img/screenshot/netsurf-partial-blit.png" class="img-responsive"/>

## Package Web Interface

Wildan Mubarok has enabled Cookbook Web Mode which creates a website with package information, similar to the package search pages in Linux distribution websites. This website functionality was implemented some time ago, and is now available to everyone.

You can access it in the following links:

- [x86-64 Packages](https://static.redox-os.org/web/x86_64-unknown-redox/)
- [i586 Packages](https://static.redox-os.org/web/i586-unknown-redox/)
- [ARM64 (aarch64) Packages](https://static.redox-os.org/web/aarch64-unknown-redox/)
- [RISC-V (riscv64gc) Packages](https://static.redox-os.org/web/riscv64gc-unknown-redox/)

## Kernel Improvements

- (kernel) 4lDO2 fixed the performance profiler
- (kernel) Wildan Mubarok improved multi-threading stability
- (kernel) Wildan Mubarok implemented process shared memory stats
- (kernel) Wildan Mubarok improved vector allocation and removal performance
- (kernel) Wildan Mubarok improved `mmap` performance
- (kernel) Wildan Mubarok fixed many potential deadlocks
- (kernel) Wildan Mubarok fixed many stability and performance regressions
- (kernel) Wildan Mubarok fixed a memory leak
- (kernel) Wildan Mubarok fixed the process CPU affinity reporting being blank, now it works
- (kernel) Wildan Mubarok added more ordered locks
- (kernel) bjorn3 enabled more compile-time code checking to prevent accumulated breakage of disabled features
- (kernel) bjorn3 greatly reduced code duplication
- (kernel) bjorn3 fixed some code warnings
- (kernel) bjorn3 did many code cleanups
- (kernel) Speedy_Lex applied many Clippy lints

## Driver Improvements

- (drivers) Wildan Mubarok increased the IDE driver read timeout to fix COSMIC Terminal in the online demo async mode
- (drivers) bjorn3 updated the xHCI driver to load configuration files at runtime instead of compile-time to improve USB testing
- (drivers) bjorn3 did some code cleanups

## System Improvements

- (sys) 4lDO2 created a service for `profiled` to autostart when it's installed to ease performance profiling
- (sys) bjorn3 fixed `init` dynamic linking
- (sys) bjorn3 added a deadlock workaround in `initnsmgr`
- (sys) bjorn3 moved some filesystem configuration to the `base` repository to ease development
- (sys) bjorn3 improved the Makefile to build drivers/initfs and changed the `base` recipe to use it
- (sys) bjorn3 unified the `base` and `base-initfs` recipes, allowing the `initfs` image to be automatically updated in case of system component or driver changes (except RedoxFS, you need to use the `make rp.redoxfs,base` command) and simplifying configuration
- (sys) bjorn3 replaced the Bochs video driver with the VESA driver to reduce code duplication
- (sys) bjorn3 created the `scheme-utils` library and tooling to help in the implementation of new schemes
- (sys) Wildan Mubarok updated `ion` to be dynamically linked
- (sys) Wildan Mubarok merged the `installer-gui` repository into the `installer` repository

## Relibc Improvements

- (libc) Landon Propes implemented the `faccessat`, `fchownat`, `unlinkat`, `symlinkat`, and `linkat` functions
- (libc) Landon Propes exposed the `openat()` function to user applications
- (libc) Landon Propes added more `limits` header constants
- (libc) Landon Propes fixed the `printf()` float alternate
- (libc) Landon Propes fixed some conversions in `printf()` if a precision is used
- (libc) Landon Propes reduced code duplication
- (libc) Wildan Mubarok improved the Rust-based `math` header
- (libc) Wildan Mubarok fixed the `suseconds_t` definition in Linux
- (libc) Wildan Mubarok improved the testing script flexibility
- (libc) Wildan Mubarok added a test for `umask`
- (libc) Wildan Mubarok added kernel commit reporting in tests to ease regression investigation
- (libc) Wildan Mubarok implemented the `syscall()` function to expand Linux testing, which most programs on Linux use
- (libc) bjorn3 did some code cleanup
- (libc) Contributor Leibniz implemented the `alarm()` function
- (libc) Nicolás Antinori fixed the `wscanf()` function regressions
- (libc) Nicolás Antinori reduced code duplication in `scanf` and `wscanf` functions
- (libc) auronandace continued improving POSIX compliance
- (libc) auronandace eliminated more C header file fragments by including definitions in the `cbindgen` configuration file
- (libc) auronandace reduced namespace pollution
- (libc) auronandace cleaned up lots of headers and code
- (libc) sourceturner did some code cleanups
- (libc) sourceturner applied some Clippy lints
- (libc) plimkilde improved the `seed48()` function safety
- (libc) plimkilde improved and fixed many documentation issues

## Networking Improvements

- (net) Benton60 implemented `AF_UNSPEC`
- (net) bjorn3 moved the `dhcpd` daemon from `netutils` repository to `base`

## Packaging Improvements

- (pkg) Wildan Mubarok updated `pkgutils` to be dynamically linked
- (pkg) Migue Magic updated the package manager to update all packages when the `pkg update` command is used without arguments, before you needed to use the `--all` option

## Orbital Improvements

- (gui) Wildan Mubarok implemented the support for partial window update in the SDL 1.x and `softbuffer` libraries to improve performance
- (gui) Wildan Mubarok improved the maximized and fullscreen windows performance by around 3 times, by reducing the time needed to update windows (redraw)
- (gui) Wildan Mubarok implemented a damage border overlay to show what parts of the screen need to be redrawn, for performance analysis and debugging

## Programs

- (app) Wildan Mubarok finished the migration to OpenSSL 3.x and `ncursesw`
- (app) Wildan Mubarok pinned the COSMIC application versions to workaround the regression where mouse clicks don't work
- (app) Wildan Mubarok updated Neovim version from 0.11.5 to 0.13 (in development) and `tree-sitter` to fix build issues
- (app) Wildan Mubarok and auronandace fixed [DCSS](https://github.com/crawl/crawl) compilation

## Build System Improvements

- (build) bjorn3 hard-coded the `initfs` image creation time to improve build reproducibility
- (build) Wildan Mubarok implemented the `make i.recipe` and `make install` targets for recipe package system-wide installation inside of Redox when the self-hosted mode is used
- (build) Wildan Mubarok added the `*-unknown-linux-relibc` compiler target to build `relibc` binaries for Linux, to provide a comparison and improve testing
- (build) Wildan Mubarok allowed the `QEMU` environment variable to be changed in command line for the RHEL distribution that uses `qemu-kvm` instead of `qemu-system` as the QEMU executable name
- (build) Wildan Mubarok did more fixes to self-hosted compilation
- (build) Wildan Mubarok fixed the `source.rev` recipe data type updates not working because of Git caching
- (build) Wildan Mubarok fixed the build cache status when using pre-built packages
- (build) Wildan Mubarok improved the `installer` error reporting context
- (build) Wildan Mubarok improved logging to show what part of the recipe triggered a rebuild (recipe configuration, dependencies or source files)
- (build) Wildan Mubarok simplified the Cookbook error reporting to ease diagnostics
- (build) Wildan Mubarok updated the Native Build dependencies to match the Podman Build
- (build) Wildan Mubarok enabled deterministic archives in GNU Binutils toolchain to increase build reproducibility
- (build) Wildan Mubarok added BLAKE3 hashes in `sysroot` to allow partial/granular recipe library dependency updates if the dependency build system allow
- (build) Wildan Mubarok greatly reduced toolchain storage usage by moving `relibc-install` to `sysroot`
- (build) Ribbon created the `sys-build` filesystem configuration for automated self-hosted system compilation testing

## CI Improvements

- (ci) Wildan Mubarok added kernel commit reporting in `relibc` CI to ease regression investigation
- (ci) Wildan Mubarok enabled multi-threading testing in `base` CI
- (ci) Wildan Mubarok added a test for the `redoxer test` command in the Redoxer CI to prevent image building breakage

## Documentation Improvements

- (doc) Willem Grant submitted a [hardware compatibility](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md#broken) report for Framework Laptop 16 (status: Broken)
- (doc) Ribbon created the ["Notes"](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md#notes) section in `CONTRIBUTING.md` to quickly show important details and reduce unnecessary questions/problems
- (doc) Ribbon created the [Self-hosted Development](https://doc.redox-os.org/book/self-hosted.html) page to explain how to configure QEMU for development inside of Redox (still WIP)
- (doc) Ribbon updated the "How to update initfs" section in [How to update RedoxFS](https://doc.redox-os.org/book/coding-and-building.html#how-to-update-redoxfs)
- (doc) Ribbon documented the `general.repo_binary` (`repo_binary = true`) filesystem boolean data type to only enable pre-built packages in one filesystem configuration
- (doc) Ribbon documented the manual test suite execution and how to use the test images in the [Testing](https://doc.redox-os.org/book/testing-practices.html) page
- (doc) Ribbon documented the dependency condition where some Rust programs use CMake or Meson to find C/C++ libraries instead of `-sys` crates


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
