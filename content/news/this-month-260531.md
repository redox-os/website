+++
title = "This Month in Redox - May 2026"
author = "Ribbon and Ron Williams"
date = "2026-05-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. May was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Redox Summer of Code

We would like to officially announce our two Redox Summer of Code (RSoC) projects for 2026, supporting student developers.

1. Akshit Gaur is implementing a new scheduler for Redox. He has already implemented the [Deficit Weighted Round Robin (DWRR)](https://en.wikipedia.org/wiki/Deficit_round_robin) algorithm, which has been in use in Redox for the past month. His work on implementing [Earliest Eligible Virtual Deadline First (EEVDF)](https://en.wikipedia.org/wiki/Earliest_eligible_virtual_deadline_first_scheduling) has just been merged, and he is about to begin work on optimizing system performance using the new algorithm. More details below.
2. Landon Propes will be improving various aspects of system compatibility, correctness and performance, including improvements to our pseudo-terminal driver, our math library (libm), partial support for "rlimits", and other improvements to our C standard library, relibc. Landon has been contributing to relibc for several months, and has already significantly improved our compliance with [the POSIX standard](https://pubs.opengroup.org/onlinepubs/9799919799/).

Each Summer of Code project this year is providing our students with more than $5,000 in funding. In addition to these projects, Redox is also providing a small amount of funding for 3 other non-student contributors on an ongoing basis. Our current spending is exceeding our monthly donations by quite a bit, and we are relying on donations received in previous years to support RSoC. If you can afford it, we would greatly appreciate a monthly or one-time donation, through [Donorbox](https://donorbox.org/redox-os), [Patreon](https://www.patreon.com/redox_os), Bitcoin or Ethereum wallets available in the [Donate](https://www.redox-os.org/donate/) page.

## EEVDF Scheduler on Redox!

Akshit Gaur successfully implemented the EEVDF scheduler to follow his earlier implementation of the DWRR scheduler.
It features more dynamic calculations than the simple DWRR, which should ensure tasks are given enough CPU time, even when doing many system calls or given lower process priority.
The new scheduler is more consistent than the old one and boasts ~200 FPS gain in Pixelcannon.
Do note that the implementation for EEVDF has not yet gone through optimization phase.
Expect the system to be more consistent and fair now!

Read [the EEVDF progress report](./eevdf.md) to see the benchmark comparison.

## Massive Performance Improvement On I/O Event Wait

Wildan Mubarok improved the performance of the `poll` and `epoll` by 4x times in a non-KVM QEMU benchmark! Timeout accuracy on both function is also massively improved. Improvement seen on QEMU KVM and real hardware can be much higher.

This improved X11 performance a lot, other applications need to be measured to know other possible gains.

## Massive RedoxFS Inode Performance Improvement

Wildan Mubarok implemented inode caching which reduced the compilation time in a simple GCC compilation in non-KVM QEMU from around 2.411s to 670ms! QEMU KVM and real hardware improvement can be much higher.

Cold cache:

```
user:~$ time gcc test.c -o t
CHECK: /usr/libexec/gcc/x86_64-unknown-redox/13.2.0/cc1
SEARCH: 3ms
READ: 1178ms
DSO: 4ms
LOAD: 1ms
...
cc1: fatal error: test.c: No such file or directory
compilation terminated.
real    2.411483288s
```

Hot cache:

```
user:~$ time gcc test.c -o t
...
CHECK: /usr/libexec/gcc/x86_64-unknown-redox/13.2.0/cc1
SEARCH: 2ms
READ: 5ms
DSO: 2ms
LOAD: 1ms
...
cc1: fatal error: test.c: No such file or directory
compilation terminated.
real    0.670010746s
```

## Incremental Compilation In Pre-built Packages

For a long time we had a problem where the package server was unnecessarily doing full package cleanup when the package update job was triggered, not allowing incremental compilation. This was preventing us to provide bigger packages.

We finally fixed it, now packages are updated in minutes instead of hours!

## XFCE on Redox!

Wildan Mubarok successfully ported the XFCE desktop environment after some effort for a better X11 experience, currently this port is more stable than MATE due to crashes with Caja. Many bugs need to be fixed to consider it usable.

<img src="/img/screenshot/xfce.png" class="img-responsive"/>

## COSMIC Monitor on Redox!

Jeremy Soller ported the recent COSMIC Monitor application, giving Redox its first graphical system monitor!

<img src="/img/screenshot/cosmic-monitor.png" class="img-responsive"/>

## Rust Compiler Update

Jeremy Soller successfully updated our Rust fork version to 1.98 nightly (2026-05-24), which fixed crates needing a newer Rust version.

## Package Web File Browser

Wildan Mubarok implemented a file browser and symbolic link visualization in the package web UI, you can use it by clicking on [this](https://static.redox-os.org/web/x86_64-unknown-redox/files.html) link.

<img src="/img/screenshot/cook-web-file-browser.png" class="img-responsive"/>

## Terminal Font Customization

Migue Magic implemented font customization in the Redox terminal! (not COSMIC Terminal)

<img src="/img/screenshot/custom-fbcond-font.png" class="img-responsive"/>

## Cookbook Recipe Rules and Rollback

Wildan Mubarok implemented the "recipe rule" mechanism to quickly change the recipe type without filesystem configuration modification, easing the development workflow. It has the following commands:

- `make lc.recipe-name` : Enable local recipe source mode in one recipe to prevent the loss of uncommited source changes and active branch change
- `make nc.recipe-name` : Ignore the installation of one recipe and clean recipe binaries
- `make bc.recipe-name` : Enable binary mode (download pre-built package) to disable compilation and clean recipe binaries
- `make sc.recipe-name` : Re-enable source compilation and clean recipe binaries
- `make cc.recipe-name` : Restore the default recipe rule (source) and clean the recipe

He also implemented recipe commit rollback to improve debugging with smaller bug reproduction cases:

(Run the `make unfetch prefix_clean PREFIX_BINARY=0` command before)

- `make repo-rollback.<COMMIT_HASH>` : Rollback to the specified build system commit
- `make repo-lock` : Pin the current build system commit and disable the recipe `fetch` step
- `make repo-unlock` : Unpin the current build system commit and enable the recipe `fetch` step
- `make distclean all` : Clean all recipe sources, build system binaries and rebuild the Redox image with the latest recipe commits

## Boot Improvements

- (boot) Wildan Mubarok fixed the boot being stuck by PCI driver spawn in ARM64

## Kernel Improvements

- (kernel) 4lDO2 fixed and simplified the performance profiling
- (kernel) Wildan Mubarok improved `futex` performance
- (kernel) Wildan Mubarok improved I/O event debugging
- (kernel) Wildan Mubarok fixed a bug where `epoll` had outdated data, which caused a X11 crash
- (kernel) Wildan Mubarok did a potential fix to a `EBADF` race condition
- (kernel) Wildan Mubarok simplified context switch error handling
- (kernel) Wildan Mubarok did some code cleanups
- (kernel) Wildan Mubarok fixed some code warnings
- (kernel) Aadarsh implemented a interface to improve the file table modification flexibility
- (kernel) Speedy_Lex added ACPI RSDP validation
- (kernel) Speedy_Lex fixed some code warnings

## Driver Improvements

- (driver) bjorn3 implemented page flipping on Intel graphics driver
- (driver) bjorn3 implemented PCI BAR mapping in `pcid` for unprivileged usage to improve security
- (driver) bjorn3 did some code cleanups
- (driver) Alexander Usenko and bjorn3 implemented planes (compositing offload) in the DRM API
- (driver) Antoine Reversat simplified the xHCI code

## System Improvements

- (sys) Jeremy Soller fixed a deadlock in `audiod`
- (sys) Wildan Mubarok ported the [uutils procps implementation](https://github.com/uutils/procps) (except the `free`, `top`, and `w` tools, WIP) and replaced the basic Redox `watch` implementation
- (sys) Wildan Mubarok implemented I/O event timeout
- (sys) Wildan Mubarok improved `nproc` performance by removing a dynamic memory allocation
- (sys) Wildan Mubarok moved more recipe binaries, configuration, and data to `/usr` directory
- (sys) Frank Li fixed a `df` tool regression
- (sys) Frank Li fixed the `uutils` UTF-8 locale handling (missing default locale (set to UTF-8 as fallback) and filename escaping), which allowed acute accent characters to be correctly shown, for example
- (sys) Akshit Gaur enabled the `nice` tool from `uutils` and ported `renice`
- (sys) Ibuki Omatsu added multiple `fds` variant for `call` and `std_fs_call` 
- (sys) bjorn3 fixed some code warnings

## Relibc Improvements

- (libc) Wildan Mubarok implemented the `static_assert`, `pselect`, and `qsort_r` functions
- (libc) Wildan Mubarok implemented `%x` support in `strftime` function
- (libc) Wildan Mubarok improved POSIX conformance
- (libc) Wildan Mubarok enabled SMP in tests
- (libc) Wildan Mubarok fixed the `sys/resource.h`, `sys/ipc.h`, `sys/shm.h`, `setjmp.h`, and `elf.h` headers
- (libc) Wildan Mubarok fixed the `sigjmp_buf` function and added tests
- (libc) Wildan Mubarok fixed `EINVAL` in `pthread_key_delete` function
- (libc) Wildan Mubarok fixed a possible POSIX signals race condition in tests
- (libc) Wildan Mubarok fixed undefined behavior in `utimes` function
- (libc) Wildan Mubarok fixed `libm` on Linux
- (libc) Wildan Mubarok fixed the `alarm` test
- (libc) Wildan Mubarok added tests for the `nice`, `pselect`, and `utimes` functions
- (libc) Wildan Mubarok reduced code duplication
- (libc) Wildan Mubarok simplified test data
- (libc) Wildan Mubarok documented all `pthread` functions
- (libc) Landon Propes and Wildan Mubarok implemented the `utimensat` function
- (libc) Landon Propes implemented the `threads.h` header
- (libc) Landon Propes migrated more functions to use their `*at` variants
- (libc) Landon Propes reduced code duplication
- (libc) Landon Propes fixed `EINVAL` in `openat2` function
- (libc) Landon Propes fixed some code warnings
- (libc) sourceturner fixed POSIX timers on Linux and added tests
- (libc) David Finder fixed the `alarm` function
- (libc) Mustafa Oz implemented the `fmtmsg` function
- (libc) plimkilde reduced code duplication
- (libc) auronandace continued improving POSIX compliance
- (libc) auronandace split `sys/types.h` definition to reduce namespace pollution
- (libc) auronandace eliminated more C header file fragments by including definitions in the `cbindgen` configuration file
- (libc) auronandace moved many definitions written in C to Rust via cbindgen 
- (libc) auronandace added documentation to many functions and definitions
- (libc) auronandace cleaned up lots of headers and code
- (libc) auronandace fixed some code warnings
- (libc) Speedy_Lex fixed many code warnings
- (libc) Vera Delfavero did small grammar fixes in the README

## Networking Improvements

- (net) Frank Li fixed the `ifconfig` tool device listing when executed without arguments
- (net) Frank Li fixed a bug where `nc -l` exit when the listener is running in background

## Terminal Improvements

- (term) Migue Magic removed `fbcond` from `initfs` to allow Redox terminal font customization
- (term) Migue Magic did a small improvement in terminal drawing performance

## Security Improvements

- (safe) Ibuki Omatsu implemented the `relpathat` function for `ramfs`

## Desktop Improvements

- (desk) Wildan Mubarok fixed programs using `no_std` feature in orbclient
- (desk) Ribbon configured `c`, `cpp`, `css`, `java`, `js`, and `py` to be opened in COSMIC Editor
- (desk) Ribbon configured `webp` and `gif` files to be opened in the Orbital Image viewer
- (desk) Ribbon configured `epub` and `cbz` files to be opened in COSMIC Reader

## Applications

- (app) Jeremy Soller enabled dynamic linking in sdl1-ttf, sdl1-image, and sdl1-mixer
- (app) Jeremy Soller added GNU AWK to the x86-64 `demo` Redox variant
- (app) bjorn3 finished the `libdrm` port
- (app) Wildan Mubarok ported CPython 3.15 and GObject Introspection
- (app) Wildan Mubarok fixed cURL by switching from POSIX Alarm to Threads to improve safety and workaround a bug
- (app) Wildan Mubarok enabled dynamic linking in Timidity, patch, LuaRocks, SDL 1.2, sdl-gfx, Sopwith, vttest
- (app) Wildan Mubarok fixed CMake, GNU M4, and `groff` compilation
- (app) Wildan Mubarok improved many recipes to be stored in the `/usr` directory
- (app) Ribbon created the `autotools` meta-package for faster GNU Autotools installation
- (app) Ribbon added `uutils-procps` to the `minimal` Redox variant
- (app) Ribbon added `file` to the `desktop` Redox variant
- (app) Ribbon added `wget` and COSMIC Reader to the x86-64 `demo` Redox variant

## Build System Improvements

- (build) Wildan Mubarok implemented the inspection mode in the Cookbook TUI where you can scroll the log in case of error by pressing the "Inspect" button, for quick investigation and preserve the log formatting
- (build) Wildan Mubarok implemented the `linux-relibc` target for better relibc testing on Linux
- (build) Wildan Mubarok implemented the `python` Cookbook template to ease Python packaging
- (build) Wildan Mubarok updated `REPO_BINARY` and `binary` recipe type to fallback to `source` if the pre-built package is not available
- (build) Wildan Mubarok updated the `make qemu` command to automatically unmount the Redox filesystem to prevent accidental data corruption
- (build) Wildan Mubarok updated the `make prefix_clean` command to clean all Rust and GCC dependencies
- (build) Wildan Mubarok fixed the extraction and push when the recipe package was partially downloaded in `REPO_BINARY` and `binary` recipe type
- (build) Wildan Mubarok fixed meta-package push
- (build) Wildan Mubarok fixed the `make fetch` command not working if `make prefix` was not executed before
- (build) Wildan Mubarok fixed a bug where `make push` was ignoring recipe dependencies in some cases, when an ignored recipe used the same dependencies
- (build) Wildan Mubarok fixed `pkg install` and `pkg update` not working after recipe push
- (build) Wildan Mubarok fixed a possible Cookbook startup slowdown
- (build) Wildan Mubarok fixed the QEMU RISC-V emulator installation in old Debian and Ubuntu versions
- (build) Wildan Mubarok fixed the bootstrap script if the `apt` package manager is used in Fedora
- (build) Frank Li implemented file append in filesystem configuration to prevent declared file (`[[files]]` section) overwrite when a new Redox image is created
- (build) Frank Li added the build system commit in `/etc/os-release` to improve debugging
- (build) Ribbon fixed and simplified the `auto-test.toml` filesystem configuration
- (build) Ribbon fixed the QEMU GUI not working in Arch Linux

## Documentation Improvements

- (doc) Hamish McIntyre-Bhatty added compatiblity reports for Dell Latitude D600 (status: Broken), Lenovo Thinkbook 14 Gen 2 ARE (AMD Ryzen Edition) (status: Booting), Apple Mac Mini (2012) (status: Broken), VIA C3 (unbranded) (status: Broken), and custom ASRock X570 Phantom Gaming 4 (Ryzen 3600) (status: Broken)
- (doc) Hamish McIntyre-Bhatty fixed some grammar in `HARDWARE.md`
- (doc) Migue Magic added a compatibility report for the Dell XPS L502X laptop (status: Booting)
- (doc) Ribbon documented the keyboard keys used to scroll the boot log (Shift+Up and Shift+Down) to help debugging
- (doc) Ribbon documented the `make rebuild-push` (update the system and applications in the existing QEMU image to preserve data) and `make fetch push` (update and install pre-built packages if `REPO_BINARY` is enabled) commands in the [Update Redox](https://doc.redox-os.org/book/build-system-reference.html#update-redox) section
- (doc) Ribbon added the `make lc.recipe` command for quick and flexible configuration of [Local Recipe Changes](https://doc.redox-os.org/book/configuration-settings.html#local-recipe-changes)
- (doc) Ribbon documented the [ignored recipe configuration](https://doc.redox-os.org/book/configuration-settings.html#ignored-recipes)
- (doc) Ribbon documented the `REPO_BINARY` compilation behavior where pre-built dependency packages are used in source-based recipes if available
- (doc) Ribbon fixed and updated the [kernel performance profiling documentation](https://doc.redox-os.org/book/performance.html#kernel)
- (doc) Ribbon documented the [CPU and userspace IPC benchmarks](https://doc.redox-os.org/book/performance.html#benchmarks)
- (doc) Ribbon documented all recipe targets
- (doc) Ribbon documented the [optional packages configuration](https://doc.redox-os.org/book/porting-applications.html#configuration-example)
- (doc) Ribbon documented a possible FreeBSD preference (Linuxlator usage) for the Linux codepath of some application or library, to reduce false-positives in application porting reference
- (doc) Ribbon added links for OpenBSD, NetBSD and Haiku packages for more portability references

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
