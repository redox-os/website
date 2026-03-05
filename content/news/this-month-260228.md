+++
title = "This Month in Redox - February 2026"
author = "Ribbon and Ron Williams"
date = "2026-02-28"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. February was a very exciting month for Redox! Here's all the latest news.

<img src="/img/screenshot/qemu-sdl-virtio.png" class="img-responsive"/>

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## NGI Zero and NLnet Projects

We want to thank the European Commission's [Next Generation Internet](https://ngi.eu/) program, [NGI Zero](https://nlnet.nl/NGI0/)
and the [NLnet foundation](https://nlnet.nl/) for their generous and ongoing support.

This month, we concluded our work on the [Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/) project.
We also made significant progress on our [Capability-based Security](https://nlnet.nl/project/Capability-based-RedoxOS/) project, in several areas you will see below.
Our [io_uring-like I/O](https://nlnet.nl/project/RedoxOS-ringbuffer/) project is also well underway.

The funding provided by NLnet and NGI Zero has been a tremendous benefit to Redox, and to our student developers in particular.

## Redox Summer of Code

Our Redox Summer of Code (RSoC) program has been operating on an unusual schedule this year.

One of our RSoC contributors, [Anhad Singh](https://andypy.dev/), is based in the southern hemisphere,
so he has been working on an RSoC project since November, and has just wrapped up his work.
Anhad worked across the full breadth of Redox, fixing kernel bugs, memory management issues, signals-related issues, dynamic linking problems,
and variety of other things, with the primary objective of getting Rust and Cargo running consistently on Redox.
Anhad has done a great job, and we want to thank him for his tremendous contributions.

We have a second contributor, Akshit Gaur, who has gotten an early start on his RSoC project.
Akshit is working on improving Redox performance, with a focus on the scheduler, and on performance benchmarks.
He has already ported several benchmark programs (see some examples below), and has made substantial progress on a priority-based scheduler.
The big goal for this summer is to implement [EEVDF scheduling](https://en.wikipedia.org/wiki/Earliest_eligible_virtual_deadline_first_scheduling),
and to work on tuning the scheduler to suit Redox's services-in-userspace microkernel architecture.
Welcome Akshit!

Redox Summer of Code is intended for students and new graduates who are already contributing to open source projects and programming in Rust.
We haven't updated our [RSoC](https://redox-os.org/rsoc/) page yet for this year,
but if you are a skilled Rust programmer that fits the above description,
feel free to contact us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).
Some of our priorities for this year can be found in [this news post](https://redox-os.org/news/development-priorities-2025-09/),
but we would love to hear your ideas as well.

If you would like to help fund our student developers, we would greatly appreciate the financial support.
Whether a monthly donation through Donorbox, Patreon, one-time cash, Bitcoin or Ethereum contribution, 
any amount helps.
Check out our [Donate](https://redox-os.org/donate/) page for more information.

## Redox Community

The Redox OS Community continues to grow, and we want to welcome all our new members and contributors.
Over the past few months, we have had many people join the Redox team,
and you will see several new names in the list of contributors below.
Thanks very much and welcome!

## COSMIC Compositor On Redox!

Jeremy Soller was able to run the [COSMIC compositor](https://github.com/pop-os/cosmic-comp) as a [winit](https://github.com/rust-windowing/winit) window on Redox,
as a proof of concept. Input processing is not working yet, and we hope to be able to manage the full desktop with `cosmic-comp` in the near future.

<img src="/img/screenshot/cosmic-comp1.png" class="img-responsive"/>

<img src="/img/screenshot/cosmic-comp2.png" class="img-responsive"/>

## COSMIC Settings On Redox!

Wildan Mubarok got [COSMIC Settings](https://github.com/pop-os/cosmic-settings) running on Redox.
We have a fairly small collection of settings available right now, but this provides a good UI for adding more settings.

<img src="/img/screenshot/cosmic-settings.png" class="img-responsive"/>

## Vulkan On Redox!

Jeremy Soller enabled Lavapipe in Mesa3D. Lavapipe provides Vulkan-compatible software rendering, and allows us to run Vulkan-based software for the first time.

## Redox On Lenovo IdeaPad 710S-13IKB laptop

After recent boot hang fixes and workarounds, John Coonrod successfully booted his Lenovo IdeaPad 710S-13IKB into Orbital!
John has been incredibly patient with us while we worked to improve our boot and driver debugging processes.
Thanks John!

<img src="/img/hardware/lenovo-ideapad-710s-13ikb.jpg" class="img-responsive"/>

## More Boot Fixes

Wildan Mubarok fixed a PS/2 driver crash in case of a non-fatal keyboard scan initialization error that would hang the boot in some computers.

If you have a PS/2 keyboard and had a boot hang, please test again.

## Better Bootloader Errors

Wildan Mubarok improved the information of errors and warnings to clearly say their reason, for example:

- Insufficient RAM memory to load the Redox image into RAM (live mode)

```
live: 0/647 MiBSETUP PANIC: panicked at src/os/uefi/mod.rs:56:10:
called `Result::unwrap()` on an `Err` value: Status(0x8000000000000009) "out of resources"
```

- The display don't provide EDID information (non-fatal)

```
WARN - Failed to get EFI EDID from handle Handle(503078296): Status(0x8000000000000003) "unsupported"
```

## NodeJS On Redox!

After many fixes Anhad Singh and Wildan Mubarok successfully executed NodeJS (version 21.7.3). Fixing NodeJS revealed problems hiding in many areas including the kernel memory remapping, relibc dynamic linker, and shebang code.

- NodeJS CLI

<img src="/img/screenshot/nodejs.png" class="img-responsive"/>

- NodeJS running a Hello World program

<img src="/img/screenshot/nodejs-hello.png" class="img-responsive"/>

- npm running a "Hello World" project

<img src="/img/screenshot/npm-hello.png" class="img-responsive"/>

- npm [Vite](https://vite.dev/) project creation

<img src="/img/screenshot/npm-vite.png" class="img-responsive"/>

## Fixed Nushell

Wildan Mubarok fixed Nushell which was not working for some time.
He also dropped our fork and switched to latest upstream code.

<img src="/img/screenshot/nushell2.png" class="img-responsive"/>

<img src="/img/screenshot/nushell3.png" class="img-responsive"/>

## Fixed Helix Editor

Sergey Reshetnikov fixed and updated the Helix editor which was not working for some time.

<img src="/img/screenshot/helix2.png" class="img-responsive"/>

## Better Package Manager

Wildan Mubarok improved several parts of the package manager, you can see them below:

- Preview dependencies to install or uninstall
- See download and storage size before package operations
- Detailed progress bar with percentages on each step
- Less chance to have broken installation when I/O errors happen

You can see it in action on [this link](https://asciinema.org/a/tdZJqARsQra66lLe)

## Filesystem System Call Unification

Jeremy Soller implemented the `stdfscall` protocol and `std_fs_call` userspace function to [unify filesystem operations](https://gitlab.redox-os.org/redox-os/rfcs/-/blob/master/text/0029-fscall.md) under the `SYS_CALL` system call.
This allows several system calls, and the supporting kernel code, to be eliminated,
and makes it easier to add or improve the available operations in future.

Ibuki Omatsu updated some system components and drivers to use the `std_fs_call` function including RedoxFS, `ramfs`, `initfs`, `acpid` and `xhcid`.

Ibuki Omatsu also unified the `fstat*()`, `fchmod()`, `getdents()`, `ftruncate()`, and `futimens()` functions into the `std_fs_call` function.

## Multi-threading Reliability Improvements

Wildan Mubarok successfully executed the `os-test` test suite on multiple QEMU CPU cores without hangs!
Previously, when running multi-core, `os-test` had been triggering some kernel bugs and other hangs,
which we have been working hard to fix.

<img src="/img/screenshot/os-test-multicore.png" class="img-responsive"/>

## Orbital On-Screen Display Performance Monitor

Wildan Mubarok implemented an OSD performance monitor to measure the CPU rendering cost of Orbital frames

<img src="/img/screenshot/orbital-perf-osd.png" class="img-responsive"/>

<img src="/img/screenshot/orbital-perf-osd2.png" class="img-responsive"/>

## Rust In Cookbook!

Wildan Mubarok successfully updated the Rust compiler bootstrapping to be done from Cookbook recipes.
It allows `sccache` usage and is being built against shared LLVM libraries to reduce the Redox toolchain compilation time.

Wildan Mubarok also enabled `rustdoc` for Rust in both Linux and Redox, and enabled `rust-lld` in Redox.

## Kernel Improvements

- (kernel) Anhad Singh fixed memory corruption of The Zeroed Frame when remapping anonymous memory regions with the `PROT_WRITE` flag. `Grant::remap` no longer directly marks entries as writable without Copy-On-Write handling for `MAP_PRIVATE` memory.
- (kernel) Anhad Singh fixed the usage of `Grant::remove` in `move`, as it may fail when adjacent memory regions are merged, changing the grant’s base address
- (kernel) Wildan Mubarok added more Ordered Locks for some mutexes and resource drop functions to prevent and fix deadlocks
- (kernel) Marsman fixed an arithmetic overflow bug in `nanosleep` system call
- (kernel) bjorn3 did some code cleanups
- (kernel) auronandace added some Clippy lints

## Driver Improvements

- (drivers) Wildan Mubarok fixed a crash in the VirtIO GPU driver when the EDID descriptor is not available
- (drivers) bjorn3 did some code cleanups in the Intel GPU driver

## System Improvements

- (sys) Jeremy Soller bumped dependencies
- (sys) 4lDO2 fixed a bug where real-time POSIX signals couldn't wakeup a thread
- (sys) 4lDO2 fixed the `sigqueue()` function limit not being respected
- (sys) Wildan Mubarok implemented the support for non-contiguous shared memory allocation
- (sys) Wildan Mubarok fixed POSIX signal issues in the Ion shell, and in our patched version of GNU Bash
- (sys) Ibuki Omatsu changed the implementation of CWD and `chdir()` to use a capability descriptor, for improved security and future filesystem sandbox support. The previous implementation used a path maintained in userspace by relibc.
- (sys) Ibuki Omatsu moved the definitions for the communication between relibc and the schemes into `libredox`, to eliminate a dependency on a library that was not intended to be shared
- (sys) Mustafa Oz fixed a panic in `inputd` when the `-K` option is not correctly used
- (sys) bjorn3 increased the `FdGuard` type usage for more I/O safety in userspace bootstrapping
- (sys) bjorn3 did some code cleanup

## Relibc Improvements

- (libc) 4lDO2 fixed the `pthread_sigmask()` function not blocking real-time POSIX signals
- (libc) 4lDO2 fixed the `sigtimedwait()` and `sigwaitinfo()` functions to return the signal number
- (libc) bjorn3 improved the `redox-rt` library memory read safety
- (libc) Ron Williams fixed non-realtime POSIX signals by using the `posix_kill()` function instead of `posix_sigqueue()`
- (libc) Ron Williams fixed a bug where the `sigismember()` function was not counting real-time POSIX signals as a valid part of the signal set
- (libc) Ron Williams fixed a dependency loop by moving `timeval` to `sys_select`
- (libc) Ron Williams corrected some inconsistent declarations in the POSIX signals code
- (libc) Anhad Singh implemented the byte-range locking in `fcntl()` function
- (libc) Anhad Singh updated the dynamic linker to be position independent in memory
- (libc) Anhad Singh fixed bugs by not zeroing memory that's already zeroed by `mmap` with the `MAP_ANONYMOUS` flag
- (libc) Anhad Singh fixed shebang parsing
- (libc) Ibuki Omatsu reimplemented the `recvmsg()` and `sendmsg()` functions using bulk file descriptor passing which reduced the socket IPC latency, cost and context switches
- (libc) Ibuki Omatsu implemented `MSG_CMSG_CLOEXEC` handling in the `recvmsg()` function
- (libc) Ibuki Omatsu fixed an undefined behavior by passing raw pointers to the `syscall5` system call
- (libc) Wildan Mubarok completed the implementation of the `utimens()` function with directory handling, which allow the timestamp of directories to be changed with the `touch` command
- (libc) Wildan Mubarok updated the file descriptor and data tracing logging to append the program name to ease the communication debugging of multiple programs
- (libc) Wildan Mubarok added tests for the `epollet()` and `fmap()` functions
- (libc) Wildan Mubarok added a UDS write test
- (libc) Wildan Mubarok fixed `int32_t` to use `int` instead of `long int` in i586
- (libc) Wildan Mubarok fixed `blkcnt_t` type
- (libc) Wildan Mubarok fixed hosted C++ headers for i586 and RISC-V
- (libc) Akshit Gaur implemented the `pause()` function using existing POSIX signals functionality
- (libc) Marsman implemented character boundary handling in `parse_weekday()` and `parse_month()` functions to fix a panic in `parse_month()` when parsing month names with multi-byte characters
- (libc) Marsman implemented negative offset handling in `seekdir` to fix a panic
- (libc) Marsman updated the `argv` memory allocation to include a null terminator to fix an out of bounds index bug in `with_argv` when calling `execl`
- (libc) Marsman updated `__assert_fail` to use `to_string_lossy` for safer string conversion which fixed a panic
- (libc) Marsman improved the error handling for invalid `prot` in `mprotect`
- (libc) Marsman improved the error handling when `alignment` of `aligned_alloc` is zero
- (libc) Marsman improved the error handling of some functions
- (libc) Marsman fixed a DSO panic
- (libc) Marsman fixed an error handling panic in `pthread_rwlockattr_setpshared` when an invalid `pshared` is given
- (libc) auronandace improved the type safety in some code
- (libc) auronandace added the `PTHREAD_STACK_MIN` limit
- (libc) auronandace fixed exporting `timespec` by including the `sys/types` header to import `time_t`
- (libc) auronandace fixed the memory layout of the `sched_param` struct
- (libc) auronandace reduced the compilation of unused CPU-specific code
- (libc) auronandace reduced code duplication in several areas
- (libc) auronandace verified if the header includes of some POSIX headers matches the specification
- (libc) auronandace updated several source files to be more idiomatic
- (libc) auronandace added Clippy lints and fixed warnings
- (libc) auronandace did a code cleanup of many headers
- (libc) auronandace improved code documentation

## RedoxFS Improvements

- (redoxfs) Ibuki Omatsu implemented relative path support

## Networking Improvements

- (net) Bendeguz Pisch improved UDP error handling when the `dup` system call is called with unspecified address

## Packaging Improvements

- (pkg) Wildan Mubarok implemented compression in the `pkgar` format
- (pkg) Mustafa Oz fixed a hang when the package manager CLI is used without arguments

## Programs

- (app) Jeremy Soller fixed GStreamer, `sm64ex`, and `eduke32` compilation
- (app) Jeremy Soller updated COSMIC Store to use OpenSSL 3.x
- (app) Anhad Singh fixed Neovim crashes
- (app) Wildan Mubarok ported [elfutils](https://sourceware.org/elfutils/)
- (app) Wildan Mubarok added the `llvm21-common` (to easily define or install the most common LLVM dependencies) and `mate-common` (to easily install the MATE Desktop) meta-packages
- (app) Wildan Mubarok started the migration from OpenSSL 1.x to OpenSSL 3.x
- (app) Wildan Mubarok updated `nginx`, Git, RustPython, `curl`, and NetSurf to use OpenSSL 3.x
- (app) Wildan Mubarok fixed `nginx` compilation and enabled the HTTP v3 module
- (app) Wildan Mubarok fixed Neovim hangs
- (app) Wildan Mubarok fixed a LLVM dependency conflict
- (app) Wildan Mubarok added a warning for when JIT is not available for Mesa3D software rendering, with a command to run the program with `softpipe`
- (app) Wildan Mubarok reduced the Clang compilation by reusing shared LLVM library
- (app) Wildan Mubarok reduced the LLVM linking time
- (app) Wildan Mubarok disabled the `libxcb` documentation to reduce build time
- (app) Mark Harris updated and promoted `libopus` and `opusfile`
- (app) Mark Harris fixed OpenSSL 3.x static linking and SSL directory path
- (app) Mark Harris fixed and updated `libflac`
- (app) auronandace confirmed that [zoxide](https://github.com/ajeetdsouza/zoxide) is working
- (app) Akshit Gaur ported [sysbench](https://github.com/akopytov/sysbench)
- (app) Akshit Gaur [reimplemented](https://gitlab.redox-os.org/akshitgaur2005/schedrs) [schbench](https://openbenchmarking.org/test/pts/schbench) in Rust for Redox usage
- (app) Ojus Chugh disabled the GCC test suite compilation to reduce the GCC compilation time

## Testing Improvements

- (test) Ribbon created the `auto-test` image (the system run the test suites and shutdown) and meta-package (it comes with the `auto-test` script to run test suites without a system shutdown) for automated test suite execution, it runs the `acid`, `relibc-tests` and `os-test` test suites
- (test) Ribbon added more recipes in the `redox-tests` meta-package
- (test) Ribbon enabled all `acid` tests in the `acid` filesystem configuration
- (test) Ribbon fixed source recipes being stored at `/usr/share` which doesn't have write permission for compilation

## Debugging Improvements

- (debug) Wildan Mubarok enabled frame pointers in x86-64, ARM64 and RISC-V Rust binaries to allow userspace stack trace displayed when crash occurred
- (debug) April Grimoire fixed an insufficient space issue in `initfs` debug mode by increasing it from 128MiB to 256MiB, with the help of Wildan Mubarok

## CI Improvements

- (ci) Wildan Mubarok added a GitLab CI job to verify if some recipe in the build server configuration is removed or invalid to reduce breakage

## Build System Improvements

- (build) Jeremy Soller cached the Podman container to reduce the setup time a lot
- (build) Wildan Mubarok improved the self-hosted mode of Cookbook to download the Redox toolchain for easier compilation and testing inside of Redox
- (build) Wildan Mubarok added Clang to the Redox toolchain for easier recipe compilation using it
- (build) Wildan Mubarok implemented the `make pp.recipe` (push recipes with package dependencies), `make repo-tree` (show recipe build tree), `make image-tree` (show recipe push tree), `make rt.recipe` (`make repo-tree` abbreviation), `make pt.recipe` (`make image-tree` abbreviation), and `make ppt.recipe` (show recipe push with package dependencies tree) commands
- (build) Wildan Mubarok implemented the support to change the recipe type (`recipe-name = "type"`) in meta-packages from the filesystem configuration
- (build) Wildan Mubarok improved Cookbook to update the `sysroot` directory when the recipe dependencies are reduced
- (build) Wildan Mubarok improved the Cookbook `auto_deps` cache debugging
- (build) Wildan Mubarok improved the logging for missing packages on image installation
- (build) Wildan Mubarok increased the Podman container PID limit to use all CPU cores in compilation and fix build failures in the build server
- (build) Wildan Mubarok added an option to launch the QEMU SDL frontend with VirtIO drivers for much better mouse support (`make qemu gpu=virtio-sdl` command)
- (build) Wildan Mubarok fixed `recipe = "binary"` and `REPO_BINARY` unnecessarily downloading the `dev-dependencies` recipes
- (build) Zhiwei Liang deduplicated dependencies in the Native Build bootstrap script

## Documentation Improvements

- (doc) Ribbon added a hardware complexity reasoning for microkernel usage in the [Microkernel Architecture](https://doc.redox-os.org/book/why-a-new-os.html#microkernel-architecture) section of the "Why A New OS?" page
- (doc) Ribbon updated the [unsafe Rust question](https://doc.redox-os.org/book/developer-faq.html#why-does-redox-have-unsafe-rust-code) to explain that some safe Rust syntax is allowed in unsafe Rust syntax
- (doc) Ribbon documented [how to use the bootloader environment variables](https://doc.redox-os.org/book/troubleshooting.html#boot)
- (doc) Ribbon documented [how to use the acid, relibc-tests and os-test test suites](https://doc.redox-os.org/book/testing-practices.html)
- (doc) Ribbon improved the [recipe data type references](https://doc.redox-os.org/book/porting-applications.html#recipe-configuration-example)
- (doc) Ribbon documented [when Git shallow clone is not recommended](https://doc.redox-os.org/book/porting-applications.html#git-repositories) and the command to disable it without recipe configuration change
- (doc) Ribbon documented that the `dev-dependencies` recipe data type replace the host system build tool packages
- (doc) Ribbon added the [Update Redox](https://doc.redox-os.org/book/build-system-reference.html#update-redox) section focused on how to only update Redox in the build system
- (doc) Ribbon documented the new name of the bootable live image in the build system (`redox-live.iso`)
- (doc) Ribbon documented the recipe build logs directory (`build/logs/$TARGET/`)
- (doc) Ribbon added the [Unix Manual Section reference](https://en.wikipedia.org/wiki/Man_page#Manual_sections) in the "References" page
- (doc) Ribbon improved the [MR review policy](https://doc.redox-os.org/book/developer-faq.html#how-to-properly-request-a-review-or-review-mrs) and [how to write book documentation properly](https://doc.redox-os.org/book/developer-faq.html#how-can-i-write-book-documentation-properly) questions
- (doc) Ribbon documented [how to change the current keyboard layout (map)](https://doc.redox-os.org/book/tasks.html#change-current-keyboard-layout-map)
- (doc) Ribbon [added `screenfetch`](https://doc.redox-os.org/book/tasks.html#show-system-information) in the "Tasks" book page
- (doc) April Grimoire improved the Podman Build documentation

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
