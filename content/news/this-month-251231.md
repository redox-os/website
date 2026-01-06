+++
title = "This Month in Redox - December 2025"
author = "Ribbon and Ron Williams"
date = "2025-12-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. December was a very exciting month for Redox! Here's all the latest news.

## Looking back on 2025

It was an wonderful year for Redox, as the project marked its 10th anniversary since the first commit. First, we want to send a huge thanks to our community! With more than 1,000 members in our Matrix Chat, we are one very large happy family.

If you have not already watched it, check out Jeremy Soller's [presentation at RustConf](https://www.youtube.com/watch?v=xlccq9EbXGA) in September, on the history and future of Redox.

This year saw more than 40 significant contributors to the Redox code base, and many smaller contributions as well. Redox continues to make major strides towards several of our goals. Check out our [development priorities](/news/development-priorities-2025-09/), published in September, to see some of the things we are working on. This year saw some big steps toward Wayland support and baby steps toward hardware-accelerated graphics. And [a first attempt at running Redox on a smartphone](https://blog.paulsajna.com/redox-in-your-pocket/)!

We have been placing more emphasis on compliance testing, and in particular the [os-test suite](https://sortix.org/os-test/#results) being developed by Jonas "Sortie" Termansen, funded in part by NLnet and NGI Zero Commons. Using a sort of "[test-driven development](https://en.wikipedia.org/wiki/Test-driven_development)" approach has helped Redox identify several non-conformances, some of which were easily fixed, and some of which required some thinking. Using a compliance test suite has also made it easier to port programs to Redox. And compiling the os-test suite on Redox has been an excellent stress test, identifying a few bugs and race conditions to be addressed, and helping us on our way to the self-hosting goal.

We have done reasonably well with funding our team, but we hope to do even better in 2026. We raised $17,000 in donations from our community, and $20,000 from Jeremy Soller that he had received prior to forming the Redox OS Nonprofit. These donations have been used to fund our Redox Summer of Code projects for students, our part-time build engineer, our community manager, and to keep the lights on.

Also, a tremendous thanks goes out to the generous support of [NLnet](https://nlnet.nl/) and the [NGI Zero Commons](https://nlnet.nl/commonsfund/) and [NGI Zero Core](https://nlnet.nl/core/) funds, and the European Commission's [Next Generation Internet initiative](https://ngi.eu/). We have three NGI Zero funded projects under way, covering 2 of our key contributors over the course of the summer and school year.
- [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/) (almost finished)
- [Capability-based Security for Redox](https://nlnet.nl/project/Capability-based-RedoxOS/) (started this summer)
- [io_uring-like IO for Redox](https://nlnet.nl/project/RedoxOS-ringbuffer/) (started this fall)

These projects are helping to greatly improve the system stability, security and performance.

We really appreciate all our donors, and all donations, large or small, that help us keep Redox moving forward. As we get closer to having Redox ready for specific use cases, we are looking for larger donations, especially from foundations and corporate partners, to help support full-time developers. If you have any ideas for funding opportunities, please contact us at donate@redox-os.org.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Board of Directors

Each year, Redox OS elects its board of directors. The current board consists of the following team:

- Ron Williams, Nonprofit president and board chair
- Jeremy Soller, treasurer (as well as Redox architect/lead maintainer)
- Alberto Souza, secretary
- Mathew John Roberts, director

The new board is elected by the previous board to ensure continuity.
However, anyone can be nominated or volunteer to stand for election.
If you are a Redox contributor and would like to volunteer, please let us know.
We are particularly looking for someone with good technical understanding of Redox, and its goals,
to join as a fifth board member.
All director positions are unpaid,
but being a director does not prevent someone from obtaining funding for their technical work.

## Trademark Policy

Redox OS has adopted a [trademark policy](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/TRADEMARK.md).
It is inspired by the COSMIC Desktop trademark policy.

The main purpose of the policy is to protect the use of the Redox OS name from abuse and misrepresentation.
Note that Redox OS is the trademark, so you can say "the Redox OS operating system" or just "Redox OS" to refer to the project,
but "the Redox operating system" is not a trademark, as there are many other products and projects that use the "Redox" name.

## First GPU Driver!

Jeremy Soller created an initial GPU driver for Intel Tiger Lake and Kaby Lake integrated GPUs, after reading many pages of documentation.
Currently the driver only supports [mode setting](https://en.wikipedia.org/wiki/Mode_setting).
Jeremy Soller and bjorn3 have begun creating `ioctl` support for hardware-accelerated rendering,
but no graphics acceleration is supported yet.

(This shouldn't be confused with video drivers for BIOS VESA and UEFI GOP, which we use to show video after bootloader kernel bootstraping, and has been used as the back-end for the Redox desktop for several years.)

- Intel GPU driver running in a System76 Galago Pro with an external monitor

<img src="/img/hardware/intel-graphics.jpg" class="img-responsive"/>

## First steps for Linux DRM support

Jeremy Soller and bjorn3 implemented some basic read-only APIs from Linux DRM, to simplify graphics drivers usage and porting of Linux software.

## Dynamic Linking On ARM64!

Anhad Singh and Wildan Mubarok implemented ARM64 support in the dynamic linker and Cookbook.
This reduces memory and storage space requirements, allows ARM64 packages to not require recompilation when changes are made to `relibc`, and simplifies recipes by not requiring static linking configuration.

## Completion Of Scheme Packet Protocol Migration

bjorn3 and Ibuki Omatsu finished the system components and drivers migration to the new `scheme` packet protocol.
This is the interface between system services, including drivers, and the kernel.
This change will allow us to move more quickly as we continue to expand and mature the Redox system call API.

## Optional Package Features

Wildan Mubarok implemented the support for optional package variants which allows the same package configuration to be customized and built into multiple compilation options.

The compilation syntax is `make r.recipe.variant`.
The `recipe.toml` syntax is the following:

```toml
[[optional-packages]]
name = "cxx"
dependencies = []
files = [
    # ...files in glob pattern...
]
```

For example: the `gcc13` recipe configuration has the `cxx` optional feature which can be compiled with the `make r.gcc13.cxx` command.
It will create the `gcc13.cxx` package, which depends on the `gcc13` primary package.
This allows users and developers to only install the features that they need, saving storage space and Internet usage.

In this example the primary `gcc13` package was reduced from 892MB to 597MB.

When including the optional feature packages in the Redox image during build,
use quotation marks around the extended package name, to comply with TOML syntax.
For example: `"gcc13.cxx" = {}`

## Many Correctness Improvements and More POSIX Conformance

Multiple contributors helped to fix the `os-test` results, including `relibc` and system bugs.
This helped Redox pass several more tests,
and improved the Redox OS score in the [os-test list](https://sortix.org/os-test/#results).
These improvements have helped increase Redox correctness, and simplify porting of Linux programs.

## Linux Binaries On Cookbook!

Wildan Mubarok implemented the `make r.host:recipe-name` command to build recipes for Linux,
to quickly test relibc and the package's cross-compilation configuration.
This is also part of our strategy to mirror our build system on both Redox and Linux,
allowing us to easily move our build tools between Linux+relibc, cross-compiled for Redox, and natively compiled on Redox.

## Many CI Fixes

Wildan Mubarok and Anhad Singh fixed several things which improved the reliability of the GitLab CI jobs,
reducing CI hangs and false errors.

Wildan Mubarok expanded the `redoxer` command to support more testing,
including enabling ARM64 and RISC-V CI testing.

## Autonomous Build Server Compilation

Wildan Mubarok improved the CI package build and enabled the `REPO_NONSTOP` environment variable,
which allows the package compilation to continue after errors.
It keeps the pre-compiled packages and images up-to-date with much less effort,
while identifying which packages have failed to build and need to be fixed.
Building a recipe now results in an individual log file, to identify the cause of the error.
And Wildan has created a dashboard to help maintainers identify which packages and images are out of date.

## Kernel Improvements

- (kernel) Ibuki Omatsu implemented the `syscall6` system call to support system calls with up to 6 arguments, as part of the Capability-based Security work but with more use cases.
- (kernel) bjorn3 enabled the compiler builtins for the `memcpy` functions to improve performance
- (kernel) bjorn3 fixed `MAP_FIXED` behavior
- (kernel) Anhad Singh fixed a process hanging race condition when a context switch would happen between a thread marking itself blocked and registering for wake-up
- (kernel) AArch Angel enabled RISC-V MMU marker flags to ease booting on real hardware

## Driver Improvements

- (drivers) Jeremy Soller disabled the USB SCSI driver until it's more reliable
- (drivers) AArch Angel implemented initial ACPI embedded controller support
- (drivers) bjorn3 did some refactoring of the graphics infrastructure, and reduced duplication
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
- (sys) Ibuki Omatsu changed the `unlink` and `rmdir` functions to use `unlinkat` as their implementation
- (sys) bjorn3 and Ibuki Omatsu updated all remaining system components and drivers to use the `redox-scheme` library,
which makes the whole system up-to-date with latest scheme API improvements and fixes

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
- (libc) Wildan Mubarok improved the test runner to be almost hang-proof and report hanging tests
- (libc) Wildan Mubarok fixed the `fstatat` function tests
- (libc) Wildan Mubarok fixed tests hanging the x86_64 CI jobs by using a timeout
- (libc) Anhad Singh implemented error handling for missing libraries on dynamic linker to fix a page fault
- (libc) Anhad Singh fixed a register corruption in POSIX signals
- (libc) Anhad Singh fixed the futex wake interruption error handling
- (libc) Anhad Singh fixed `futex_wait` by adding a restart on `EINTR` instead of treating it as a hard error
- (libc) Anhad Singh fixed TLS (Thread Local Storage) overallocation
- (libc) Anhad Singh fixed a bug where the dynamic linker could fail to allocate non-PIE objects at their desired memory locations
- (libc) Anahd Singh fixed a hang in the process group killing
- (libc) Anhad Singh fixed the `fstatat` function
- (libc) Anhad Singh fixed ARM64 compilation for Linux
- (libc) Bendeguz Pisch fixed the `getopt_long` function
- (libc) bjorn3 did some code simplification and cleanup on `redox-rt`
- (libc) Landon Propes implemented precision modifiers and negative value precision handling
- (libc) auronandace fixed the `memccpy`, `strlcpy`, `strlcat` and `dlfcn` functions to be POSIX-compliant
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
- (test) Wildan Mubarok added an option to overwrite multiple directory locations in the Redoxer filesystem with new local changes (quickly update a system component or relibc, for example)
- (test) Wildan Mubarok created the [os-test-result](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/recipes/tests/os-test-result/recipe.toml) recipe to run the `os-test` tests on Linux using relibc (`make r.host:os-test-result` command) and Redox using Redoxer (`make r.os-test-result` command) to quickly get the results
- (test) Wildan Mubarok implemented a quick way to run each test from [`os-test`](https://gitlab.redox-os.org/redox-os/redox/-/merge_requests/1775) and [relibc](https://gitlab.redox-os.org/redox-os/relibc/-/merge_requests/841) on Redoxer
- (test) Josh Williams added more POSIX signals tests

## Build System Improvements

- (build) Wildan Mubarok added an option to install [upstream Rust binaries](https://rustup.rs/) to the `prefix` directory, rather than Redox's fork of Rust, using the `PREFIX_USE_UPSTREAM_RUST_COMPILER` environment variable
- (build) Wildan Mubarok changed the Redox's fork of GCC configuration to be built from the Cookbook recipe and installed to the `prefix` directory, simplifying configuration and updates to new GCC versions
- (build) Wildan Mubarok migrated the statically linked relibc compilation to the Cookbook recipe, avoiding conflicts and simplifyng configuration
- (build) Wildan Mubarok updated the Podman configuration to preserve the `sccache` objects in container rebuilds
- (build) Wildan Mubarok added tags to `sysroot` to make the recipe dependencies reliable and avoid unnecessary recipe recompilation (`make cr.recipe`) to update dependencies
- (build) Wildan Mubarok updated the `make c.relibc` and `make r.relibc` commands to also clean the relibc static objects and rebuild them to fix breaking changes on statically linked recipes
- (build) Wildan Mubarok implemented the `make repo_clean` (clean all recipe binaries) and `make fetch_clean` (clean all recipe binaries and sources) commands as an alternative to `make c.--all` and `make u.--all`
- (build) Wildan Mubarok implemented filesystem support for pre-compiled packages on meta-packages
- (build) Wildan Mubarok improved the FreeBSD and MacOS build support
- (build) Wildan Mubarok added an option to customize the GCC path used to build the prefix toolchain
- (build) Wildan Mubarok added an option to not compile FUSE in the build system installer
- (build) Wildan Mubarok removed `cargo-binstall` in favor of manual downloads for simplicity and avoid possible missing binaries
- (build) Wildan Mubarok fixed the Cookbook TUI not updating after recipe changes when retrying compilation
- (build) Wildan Mubarok fixed the `recipe = "binary"` configuration being ignored in the Cookbook TUI
- (build) Wildan Mubarok fixed a bug where the Cookbook TUI compilation couldn't be stopped due to keyboard key clobbering
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
