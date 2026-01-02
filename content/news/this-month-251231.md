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

Jeremy Soller created the first GPU driver for Intel Tiger Lake and Kaby Lake integrated GPUs after reading massive documentation, currently the driver only supports [mode setting](https://en.wikipedia.org/wiki/Mode_setting)

It's probably the first Intel GPU driver written in Rust.

(This shouldn't be confused with video drivers for BIOS VESA and UEFI GOP, which are necessary to show any video after bootloader kernel bootstraping in a personal computer and are supported by Redox for years)

- Intel GPU driver running in a System76 Galago Pro with an external monitor

<img src="/img/hardware/intel-graphics.jpg" class="img-responsive"/>

## First steps for Linux DRM support

Jeremy Soller and bjorn3 started to implement some basic read-only APIs from Linux DRM to ease software porting and graphics drivers usage.

## Dynamic Linking On ARM64!

Anhad Singh and Wildan Mubarok implemented ARM64 support in the dynamic linker and Cookbook which reduces memory usage, increase storage space and allow the ARM64 programs to scale with less effort.

## End Of Scheme Packet Protocol Migration

bjorn3 and Ibuki Omatsu finished the system components and drivers migration to the new scheme packet protocol which allows much more flexibility.

## Optional Package Features

Wildan Mubarok implemented the support for optional package features which allows the same package configuration to be customized and built into multiple compilation options.

The `recipe.toml` syntax is the following:

```toml
[[optional-packages]]
name = "cxx"
dependencies = []
files = [
    # ...files in glob pattern...
]
```

For example: the `gcc13` recipe configuration has the `cxx` optional feature which can be compiled with the `make r.gcc13.cxx` command and will create the `gcc13.cxx` package which depends on the `gcc13` primary package. It allows users and developers to only install the features that they need, saving storage space and Internet usage.

In this example the primary `gcc13` package was reduced from 892MB to 597MB.

The optional feature packages can be installed in the Redox image by using a different syntax with quotation marks for TOML correctness, for example: `"gcc13.cxx" = {}`

## Many Correctness Improvemens and More POSIX Conformance

Multiple contributors helped to fix the `os-test` tests and system bugs, which made many tests pass which improved the Redox OS score in the [os-test list](https://sortix.org/os-test/#results)

## Linux Binaries On Cookbook!

Wildan Mubarok implemented the `make r.host:recipe-name` command to build recipes for Linux to quickly test relibc and their cross-compilation configuration, this is also part of the migration to build the recipe build tools from source using our package system.

## Many CI Fixes

Wildan Mubarok and Anhad Singh fixed some things which made the GitLab CI jobs get success status instead of hangs or false errors.

Wildan Mubarok expanded Redoxer to test more things and is enabling ARM64 and RISC-V CI testing.

## Autonomous Build Server Compilation

Wildan Mubarok enabled the `REPO_NONSTOP` environment variable which allows the recipe compilation to continue by ignoring errors to fix them later, it keeps the pre-compiled packages and images up-to-date with much less effort.

He also improved Cookbook before to prepare for this, like a log file for each recipe and improve the outdated packages and images detection/information.

## Redox OS Trademark

The board of directors adopted a trademark for the "Redox OS" name which protects our project name from abuse and misinformation. It was inspired by the COSMIC Desktop trademark policy.

You can read the trademark policy on [this](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/TRADEMARK.md?ref_type=heads) link.

## Kernel Improvements

- (kernel) Ibuki Omatsu implemented the `syscall6` system call to support system calls with up to 6 arguments
- (kernel) bjorn3 enabled the compiler builtins for the `memcpy` functions to improve performance
- (kernel) bjorn3 fixed `MAP_FIXED` behavior
- (kernel) Anhad Singh implemented error handling for the `futex_wait` function interruption which had `EINTR` before
- (kernel) Anhad Singh fixed a thread context race condition
- (kernel) AArch Angel enabled RISC-V MMU marker flags to ease booting on real hardware

## Driver Improvements

- (drivers) Jeremy Soller disabled the USB SCSI driver until it's more reliable
- (drivers) AArch Angel implemented initial ACPI embedded controller support
- (drivers) bjorn3 did many graphics infrastructure code refactorings and reduced code duplication
- (drivers) bjorn3 fixed some code warnings

## System Improvements

- (sys) Anhad Singh implemented error handling in process group killing
- (sys) Anhad Singh fixed the child process exit behavior
- (sys) Anhad Singh fixed a bug where `SIGCHLD` was not being sent under some circumstances
- (sys) Anhad Singh fixed the `sendmsg` zero-length payload behavior
- (sys) bjorn3 fixed a possible file descriptor leak to init
- (sys) bjorn3 reduced the boot log flickering when scrolling
- (sys) bjorn3 merged the `redox-daemon` library code into the `base` repository for simplification
- (sys) bjorn3 reduced the boot drawing and logging code duplication
- (sys) Wildan Mubarok merged the `redoxerd` daemon into the `base` repository for simplification
- (sys) Ibuki Omatsu implemented the `unlinkat` function for system components
- (sys) Ibuki Omatsu replaced the `unlink` and `rmdir` functions with the `unlinkat` function
- (sys) bjorn3 and Ibuki Omatsu updated all system components and drivers to use the `redox-scheme` library, which makes the whole system up-to-date with latest scheme improvements and fixes

## Relibc Improvements

- (libc) Jeremy Soller implemented the `tcgetwinsize`, `tcgetsid`, `fwscanf`, and `vfwscanf` functions
- (libc) Jeremy Soller implemented the `fexecve` function for Linux
- (libc) Jeremy Soller implemented `_Fork` (fork without `pthread_atfork` hooks)
- (libc) Jeremy Soller implemented POSIX limits
- (libc) Jeremy Soller did some POSIX compatibility fixes
- (libc) Jeremy Soller fixed the `tcsetwinsize` function
- (libc) Jeremy Soller fixed `chown` on Linux
- (libc) Josh Megnauth implemented the `timespec_get` and `timespec_getres` functions
- (libc) Wildan Mubarok implemented the `clock_getres` function
- (libc) Wildan Mubarok implemented more locale functions
- (libc) Wildan Mubarok reimplemented the `strtold` function from C to Rust
- (libc) Wildan Mubarok enabled dynamic linking on tests, which reduced the storage usage from around ~900MB to ~5MB
- (libc) Wildan Mubarok enabled multi-threading on tests
- (libc) Wildan Mubarok improved the test runner to be almost hang-proof and report hanging tests
- (libc) Wildan Mubarok fixed the `fstatat` function tests
- (libc) Wildan Mubarok fixed tests hanging the x86_64 CI jobs by using a timeout
- (libc) Anhad Singh implemented error handling for missing libraries on dynamic linker to fix a page fault
- (libc) Anhad Singh fixed a register corruption in POSIX signals
- (libc) Anhad Singh fixed the futex wake interruption error handling
- (libc) Anhad Singh fixed a TLS (Thread Local Storage) overallocation
- (libc) Anhad Singh fixed a bug where the dynamic linker could fail to allocate non-PIE objects at their desired memory locations
- (libc) Anahd Singh fixed a hang in the process group killing
- (libc) Anhad Singh fixed the `fstatat` function
- (libc) Anhad Singh fixed ARM64 compilation for Linux
- (libc) Bendeguz Pisch fixed the `getopt_long` function
- (libc) bjorn3 did some code simplification and cleanup on `redox-rt`
- (libc) Landon Propes implemented precision modifiers and negative value precision handling
- (libc) auronandace fixed the `memccpy`, `strlcpy`, `strlcat` and `dlfcn` functions
- (libc) auronandace improved coding style by making imports more explicit
- (libc) auronandace did some code cleanup in `timespec_get` and `timespec_getres` functions
- (libc) auronandace improved the documentation of the `locale`, `sched`, `sysstat`, `syssocket`, `netdb`, `poll`, `regex`, `grp`, `pthread`, `stdio`, `wchar`, `signal`, `float`, `fenv`, `setjmp`, `glob`, and other headers

## RedoxFS Improvements

- (redoxfs) Josh Megnauth implemented `RENAME_NO_REPLACE`

## Programs

- (programs) Jeremy Soller fixed `PATH_SEPARATOR` on GCC
- (programs) Wildan Mubarok reduced the Rust compiler compilation time significantly
- (programs) Wildan Mubarok updated Mesa3D to use LLVM 21 which improves LLVMPipe performance
- (programs) Wildan Mubarok fixed the LLVM benchmark tools compilation
- (programs) Wildan Mubarok fixed Neovim compilation
- (programs) Wildan Mubarok fixed GNU Make recompilation
- (programs) bjorn3 fixed `liburcu`

## Testing Improvements

- (test) Wildan Mubarok created a Docker container for ARM64 and i586 testing on Redoxer
- (test) Wildan Mubarok installed GNU Make and GNU Sed on the Redoxer image
- (test) Wildan Mubarok used RedoxFS resizing to reduce the Redoxer disk setup time
- (test) Wildan Mubarok created the [os-test-result](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/recipes/tests/os-test-result/recipe.toml) recipe to run the `os-test` tests on Linux using relibc (`make r.host:os-test-result` command) and Redox using Redoxer (`make r.os-test-result` command) to quickly get the results
- (test) Wildan Mubarok implemented a [quick way](https://gitlab.redox-os.org/redox-os/redox/-/merge_requests/1775) to run each test from `os-test` on Redoxer
- (test) Josh Williams added more POSIX signals tests

## Build System Improvements

- (build) Wildan Mubarok migrated the GCC prefix bootstrap to the Cookbook recipe, simplifyng configuration and updates to new GCC versions
- (build) Wildan Mubarok migrated the statically linked relibc compilation to the Cookbook recipe, avoiding conflicts and simplifyng configuration
- (build) Wildan Mubarok updated the Podman configuration to preserve the `sccache` objects in container rebuilds
- (build) Wildan Mubarok added tags to `sysroot` to make the recipe dependencies reliable and avoid unnecessary recipe recompilation (`make cr.recipe`) to update dependencies
- (build) Wildan Mubarok updated the `make c.relibc` and `make r.relibc` commands to also clean the relibc static objects and rebuild them to fix breaking changes on statically linked recipes
- (build) Wildan Mubarok implemented the `make repo_clean` (clean all recipe binaries) and `make fetch_clean` (clean all recipe binaries and sources) commands as an alternative to `make c.--all` and `make u.--all`
- (build) Wildan Mubarok implemented filesystem support for pre-compiled packages on meta-packages
- (build) Wildan Mubarok improved the FreeBSD and MacOS support
- (build) Wildan Mubarok removed `cargo-binstall` in favor of manual downloads for simplicity and avoid possible missing binaries
- (build) Wildan Mubarok fixed the Cookbook TUI not updating after recipe changes when retrying compilation
- (build) Wildan Mubarok fixed the `recipe = "binary"` configuration being ignore in the Cookbook TUI
- (build) Wildan Mubarok fixed a bug where the Cookbook TUI compilation couldn't be stopped due to keyboard key clobbering
- (build) Wildan Mubarok fixed a bug where rustup had repeated downloading
- (build) Wildan Mubarok fixed a limitation where the RustPython recipe was always recompiling because of patching on Git source
- (build) Wildan Mubarok fixed Git shallow clone for recipes using tags, pinned commit hashes or when their branch is changed
- (build) Wildan Mubarok simplified the Cookbook code
- (build) Wildan Mubarok did a cleanup in the Makefile configuration
- (build) Ojus Chugh added a script to mount RedoxFS partitions from dual-boot, as requested by Ribbon
- (build) Ribbon reduced the source code download size of some heavy recipes

## CI Improvements

- (ci) Wildan Mubarok fixed the website CI
- (ci) Petar Yordanov fixed the book CI

## Documentation Improvements

- (doc) Wildan Mubarok documented [how to use the RedoxFS tooling](https://doc.redox-os.org/book/redoxfs.html#tooling) to create a non-bootable/bootable disk, mount/unmount a disk and expand/shrink the disk capacity
- (doc) Ribbon fixed and updated [how to update initfs](https://doc.redox-os.org/book/coding-and-building.html#how-to-update-initfs) with your changes
- (doc) Ribbon improved the [drivers README](https://gitlab.redox-os.org/redox-os/base/-/blob/main/drivers/README.md?ref_type=heads) information and updated the drivers list with new drivers and locations
- (doc) Ribbon documented that comments are supported in the `.config` file using the `#` character
- (doc) Ribbon improved the [book documentation rules](https://doc.redox-os.org/book/developer-faq.html#how-can-i-write-book-documentation-properly)
- (doc) Ribbon did a cleanup in the book

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

- [floss.social @redox]
- [floss.social @soller]
- [Patreon]
- [Phoronix]
- [Reddit /r/redox]
- [Reddit /r/rust]
- [X/Twitter @redox_os]

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
