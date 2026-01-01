+++
title = "This Month in Redox - December 2025"
author = "Ribbon and Ron Williams"
date = "2025-12-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. December was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## First GPU Driver!

Jeremy Soller created the first GPU driver for Intel Tiger Lake and Kaby Lake integrated GPUs after reading massive documentation, currently the driver only support [mode setting](https://en.wikipedia.org/wiki/Mode_setting)

It's probably the first Intel GPU driver written in Rust.

<img src="/img/hardware/intel-graphics.jpg" class="img-responsive"/>

## Linux DRM On Redox OS!

Jeremy Soller and bjorn3 started to implement some basic read-only APIs from Linux DRM to ease software porting and graphics drivers usage.

## Dynamic Linking On ARM64!

Anhad Singh and Wildan Mubarok implemented ARM64 support on dynamic linker and Cookbook which reduces memory usage, increase storage space and allow the ARM64 programs to scale with less effort.

## End Of Scheme Packet Protocol Migration

bjorn3 and Ibuki Omatsu finished the system components and drivers migration to the new scheme packet protocol which allows much more flexibility.

## Many Correctness Improvemens and More POSIX Conformance

Multiple contributors helped to fix the `os-test` tests and system bugs, which made many tests pass which improved the Redox OS score in the [os-test list](https://sortix.org/os-test/#results)

## Many CI Fixes

Wildan Mubarok and Anhad Singh fixed some things which made the GitLab CI jobs get success status instead of hangs or false errors.

Wildan Mubarok expanded Redoxer to test more things and is enabling ARM64 and RISC-V CI testing.

## Autonomous Build Server Compilation

Wildan Mubarok enabled the `REPO_NONSTOP` environment variable which allows the recipe compilation to continue by ignoring errors to fix them later, it keeps the pre-compiled packages and images up-to-date with much less effort.

He also improved Cookbook before to prepare for this, like a log file for each recipe and improve the outdated packages and images detection/information.

## Redox OS Trademark

The board of directors adopted a trademark for the "Redox OS" name which protect our name from abuse and misinformation, it was inspired by the COSMIC Desktop trademark policy.

You can read the trademark policy on [this](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/TRADEMARK.md?ref_type=heads) link.

## Kernel Improvements

- (kernel) Ibuki Omatsu implemented the `syscall6` system call to support system calls with up to 6 arguments
- (kernel) bjorn3 enabled the compiler builtins for the `memcpy()` functions to improve performance
- (kernel) Anhad Singh implemented error handling for the `futex_wait` function interruption which had `EINTR` before
- (kernel) AArch Angel enabled RISC-V MMU marker flags to ease booting on real hardware

## Driver Improvements

- (drivers) AArch Angel implemented initial ACPI embedded controller support
- (drivers) bjorn3 did many graphics infrastructure code refactorings and reduced code duplication
- (drivers) bjorn3 fixed some code warnings

## System Improvements

- (sys) Anhad Singh fixed a bug where `SIGCHLD` was not being sent under some circumstances
- (sys) Anhad Singh fixed the `sendmsg` zero-length payload behavior
- (sys) bjorn3 reduced the boot log flickering when scrolling
- (sys) bjorn3 merged the `redox-daemon` library code into the `base` repository for simplification
- (sys) bjorn3 reduced the boot drawing and logging code duplication
- (sys) Wildan Mubarok merged the `redoxerd` daemon into the `base` repository for simplification
- (sys) Ibuki Omatsu implemented the `unlinkat()` function for system components
- (sys) Ibuki Omatsu replaced the `unlink` and `rmdir` functions with the `unlinkat` function

## Relibc Improvements

- (libc) Josh Megnauth implemented the `timespect_get()` and `timespec_getres()` functions
- (libc) Wildan Mubarok implemented the `clock_getres` function
- (libc) Wildan Mubarok implemented more locale functions
- (libc) Wildan Mubarok reimplemented the `strtold()` function from C to Rust
- (libc) Wildan Mubarok enabled dynamic linking on tests, which reduced the storage usage from around ~900MB to ~5MB
- (libc) Wildan Mubarok enabled multi-threading on tests
- (libc) Wildan Mubarok improved the test runner to be almost hang-proof and report hanging tests
- (libc) Wildan Mubarok fixed the `fstatat()` tests
- (libc) Wildan Mubarok fixed tests hanging the x86_64 CI jobs by using a timeout
- (libc) Anhad Singh implemented error handling for missing libraries on dynamic linker to fix a page fault
- (libc) Anhad Singh fixed a register corruption in POSIX signals
- (libc) Anhad Singh fixed the futex wake interruption error handling
- (libc) Anhad Singh fixed a TLS (Thread Local Storage) overallocation
- (libc) Anhad Singh fixed a bug where the dynamic linker could fail to allocate non-PIE objects at their desired memory locations
- (libc) bjorn3 did a code cleanup on `redox-rt`
- (libc) auronandace fixed the `memccpy()`, `strlcpy()` and `strlcat()` functions
- (libc) auronandace improved coding style by making imports more explicit
- (libc) auronandace did a code cleanup in `timespec_get` and `timespec_getres` functions
- (libc) auronandace improved the documentation of the `locale`, `sched`, `sysstat`, `syssocket`, `netdb`, `poll`, `regex`, `grp`, `pthread`, `stdio`, `wchar`, `signal`, `float`, `fenv`, `setjmp`, `glob` and other functions
- (libc) auronandace did a documentation cleanup

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) Josh Megnauth implemented `RENAME_NO_REPLACE`

## Programs

- (programs) Jeremy Soller fixed `PATH_SEPARATOR` on GCC
- (programs) Wildan Mubarok fixed the LLVM benchmark tools compilation
- (programs) Wildan Mubarok fixed Neovim compilation
- (programs) Wildan Mubarok fixed GNU Make recompilation
- (programs) bjorn3 fixed `liburcu`

## Testing Improvements

- (test) Wildan Mubarok created a Docker container for ARM64 and i586 testing on Redoxer
- (test) Wildan Mubarok installed GNU Make and GNU Sed on the Redoxer image
- (test) Wildan Mubarok used RedoxFS resizing to reduce the Redoxer disk setup time
- (test) Wildan Mubarok created the [os-test-result](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/recipes/tests/os-test-result/recipe.toml) recipe to run the `os-test` tests on Linux (using relibc) and Redox (using Redoxer) to quickly get the results
- (test) Wildan Mubarok implemented a [quick way](https://gitlab.redox-os.org/redox-os/redox/-/merge_requests/1775) to run one test from `os-test` on Redoxer
- (test) Josh Williams added more POSIX signals tests

## Debugging Improvements

- (debug) AArch Angel fixed UART serial input on RISC-V

## Build System Improvements

- (build) Wildan Mubarok migrated the GCC prefix bootstrap to the Cookbook recipe, simplifyng configuration and updates to new GCC versions
- (build) Wildan Mubarok migrated the statically linked relibc compilation to the Cookbook recipe, avoiding conflicts and simplifyng configuration
- (build) Wildan Mubarok updated the Podman configuration to preserve the `sccache` objects in container rebuilds
- (build) Wildan Mubarok updated the `make c.relibc` and `make r.relibc` commands to also clean the relibc static objects and rebuild them to fix breaking changes on statically linked recipes
- (build) Wildan Mubarok implemented the `make repo_clean` (clean all recipe binaries) and `make fetch_clean` (clean all recipe binaries and sources) commands as an alternative to `make c.--all` and `make u.--all`
- (build) Wildan Mubarok improved the FreeBSD and MacOS support
- (build) Wildan Mubarok removed `cargo-binstall` in favor of manual downloads for simplicity and avoid possible missing binaries
- (build) Wildan Mubarok fixed the Cookbook TUI not updating with recipe changes
- (build) Wildan Mubarok fixed the `recipe = "binary"` configuration being ignore in the Cookbook TUI
- (build) Wildan Mubarok fixed a bug where rustup had repeated downloading
- (build) Wildan Mubarok fixed a limitation were the RustPython recipe were always recompiling because of patching on Git source
- (build) Wildan Mubarok did a cleanup in the Makefile configuration
- (build) Ojus Chugh added a script to mount RedoxFS partitions from dual-boot, as requested by Ribbon

## CI Improvements

- (ci) Wildan Mubarok fixed the website CI
- (ci) Petar Yordanov fixed the book CI

## Documentation Improvements

- (doc) Wildan Mubarok documented [how to use the RedoxFS tooling](https://doc.redox-os.org/book/redoxfs.html#tooling) to create a non-bootable/bootable disk, mount/unmount a disk and expand/shrink the disk capacity

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
