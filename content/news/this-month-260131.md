+++
title = "This Month in Redox - January 2026"
author = "Ribbon and Ron Williams"
date = "2026-01-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. January was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Cargo Project Compilation in Redox!

Anhad Singh successfully applied enough fixes to allow the Cargo project compilation in Redox to work!

This is the third attempt to run the Rust compiler (rustc) and Cargo on Redox, the [first attempt](https://www.redox-os.org/news/gsoc-self-hosting-final/) did many progress but didn't finished due to many work still needed and the [second attempt](https://www.redox-os.org/news/focusing-on-rustc/) fixed the `rustc` compilation but didn't work in Redox yet.

He successfully built GNU nano, [ripgrep](https://github.com/BurntSushi/ripgrep), [cbindgen](https://github.com/mozilla/cbindgen) and [acid](https://gitlab.redox-os.org/redox-os/acid)

- ripgrep compilation in Redox

<img src="/img/screenshot/cargo-ripgrep.png" class="img-responsive"/>

## First Contribution From Redox!

Anhad Singh wrote (using the [COSMIC Edit](https://github.com/pop-os/cosmic-edit) text editor), tested and pushed the [first relibc contribution] from the Redox QEMU VM!

- Development in Redox

<img src="/img/screenshot/dev-on-redox.png" class="img-responsive"/>

## Capabilties on Redox!

Ibuki Omatsu successfully implemented the initial capability-based security infrastructure which allows our permission and sandbox system to be much more granular and secure.

It will be extended to other system interfaces in next months.

## Redox on VPS!

Wildan Mubarok successfully [hosted a Redox VM](https://gist.github.com/willnode/468f961602d96bef507e9f672250c7cc) in the [Vultr](https://www.vultr.com/) VPS with some tweaks.

- Redox running in a Vultr VM

<img src="/img/screenshot/vultr.png" class="img-responsive"/>

## Redox on Web Browser!

Our [v86 web demo] finally reached acceptable performance in terminal mode!

Wildan Mubarok also improved it to increase performance and UI.

<img src="/img/screenshot/online-demo.png" class="img-responsive"/>

## Proper Keyboard Layout (Map) Management

Wildan Mubarok moved the keyboard layout handling from the PS/2 driver to the `inputd` daemon to share code with the USB HID driver and allow rootless usage.

The `/scheme/ps2` scheme-based configuration was replaced by the `inputd -K <name>` command, where `<name>` is the keyboard layout code.

## Bootloader Environment Editor

Wildan Mubarok implemented a boot environment text editor in the bootloader to insert environment variables and options to change the boot environment.

- Bootloader environment editor with debug environment variables

<img src="/img/screenshot/bootloader-editor.png" class="img-responsive"/>

## More Bootloader Debugging Information

Wildan Mubarok implemented the `BOOTSTRAP_LOG_LEVEL` (bootstrap and process manager logging verbosity), `INIT_LOG_LEVEL` (init logging verbosity), `DRIVER_LOG_LEVEL` (driver logging verbosity), `DRIVER_*_LOG_LEVEL` (driver-specific logging verbosity), and `RELIBC_LOG_LEVEL` (relibc logging verbosity) bootloader environment variables to easily show more information in boot problems like hangs or errors, he implemented the following options:

- `WARN` value: TODO
- `ERROR` value: TODO
- `DEBUG` value: TODO
- `TRACE` value: TODO

You can see an example output below:

```
2026-01-12T22-27-51.758Z [@ps2d::controller:468 WARN] ps2d: post-test unexpected value: 9C
2026-01-12T22-27-51.760Z [@ps2d::controller:337 ERROR] ps2d: keyboard failed to reset: 55
```

## Login Manager Options

Wildan Mubarok implemented a power menu (reboot/shutdown) and a keyboard layout menu in the Orbital login manager (orblogin).

## Cargo Workspace Unification

Jeremy Soller added all system components and drivers to a Cargo workspace to unify the version management of libraries in one place, which allow faster development and less breakage.

## Redox Capabilities in FOSDEM 2026

Ibuki Omatsu [presented the Capability-based security project](https://fosdem.org/2026/schedule/event/KSK9RB-capability-based-redox-os/) at FOSDEM, thanks a lot for your help and dedication Ibuki!

## os-test in FOSDEM 2026

Jonas Sortie [presented the `os-test` test suite](https://fosdem.org/2026/schedule/event/CMCWY9-os-test_measuring_posix_compliance_on_every_single_os/) at FOSDEM and mentioned Redox, this test suite allowed us to find and fix many bugs (from easy to hard).

## Kernel Improvements

- (kernel) Anhad Singh fixed the `mremap` mapping size behavior which was causing a panic when Cargo was running
- (kernel) Anhad Singh fixed futex timeout behavior
- (kernel) Pascal Reich improved the code documentation

## Driver Improvements

- (drivers) Wildan Mubarok exposed error reasons in the PS/2 driver initialization logging to improve debugging and save time

## System Improvements

- (sys) bjorn3 implemented dynamic linking support on `initfs`
- (sys) Wildan Mubarok added a temporary workaround to fix `EBADF` in the `setsockopt()` function

## Relibc Improvements

- (libc) Jeremy Soller implemented signal mask handling in the `epoll_pwait()` function
- (libc) Anhad Singh fixed undefinied symbol index in `TPOFF` which fixed random errors/page faults in `rustc`
- (libc) Anhad Singh fixed the `memcmp()` function alignment
- (libc) Anhad Singh fixed the `make all` command not triggering a rebuild when the dynamic linker, `redoxt-rt` and `redox-ioctl` sources changed
- (libc) Anhad Singh fixed log message colours
- (libc) Wildan Mubarok implemented `malloc_usable_size()` function to allow efficient pointer memory allocation and improve `malloc` leaks debugging
- (libc) Wildan Mubarok improved `inet` socket performance using `SYS_CALL`
- (libc) Wildan Mubarok fixed the `pthread_cond_timedwait()` function futex behavior
- (libc) Wildan Mubarok fixed an endianess hang in the UDP `accept()` function
- (libc) Wildan Mubarok fixed the UDP `accept()` function behavior in the `recvfrom()` function
- (libc) Wildan Mubarok fixed the `putc_unlocked()`,`pthread_cond_clockwait()` , and `pthread_mutex_timedlock()` functions
- (libc) Wildan Mubarok added tests for the `sys_socket()` and `putc_unlocked()` functions
- (libc) Wildan Mubarok improved single test execution
- (libc) Wildan Mubarok documented the `check.sh` script usage in the README
- (libc) Josh Megnauth added more tests for the `open()` function
- (libc) Landon Propes implemented the `mkfifoat()`, `mkdirat()`, `posix_close()`, `strxfrm_l()`, `strcoll_l()`, and `strerror_l()` functions
- (libc) Landon Propes fixed some namespace pollution
- (libc) Pascal Reich implemented mathematical constants
- (libc) Akshit Gaur fixed the `printf()` function floating number format handling
- (libc) auronandace fixed some tests
- (libc) auronandace did some code cleanups

## Networking Improvements

- (net) Akshit Gaur implemented UDP Packet Filtering
- (net) Akshit Gaur implemented `GetSockOpt`
- (net) Wildan Mubarok fixed UDP `localhost` connection resolving

## RedoxFS Improvements

- (redoxfs) Jeremy Soller delayed the deletion of an unlinked file until all open file descriptors are closed to improve POSIX anonymous file compatibility

## Orbital Improvements

- (gui) Wildan Mubarok exposed numbad, arrow and media keyboard keys to `orbclient` library
- (gui) Wildan Mubarok implemented scrolling and numpad lock keys handling in `orbclient` library
- (gui) Wildan Mubarok improved the wallpaper processing performance 4 times (400%) by caching the first image decoding to a BMP file for fastest CPU performance, in a QEMU benchmark without KVM acceleration he reported the processing time being reduced from almost 10 seconds to around ~350ms (in a hot cache)
- (gui) bjorn3 did some code cleanups in the `orbclient` library
- (gui) bjorn3 moved the Orbital data to the `/usr/share/ui` directory
- (gui) bjorn3 simplified Orbital utilities recipe source fetch

## Packaging Improvements

- (pkg) Mustafa Oz expanded the package manager library and tool error handling

## Programs

- (app) Wildan Mubarok fixed the OpenSSH session exit
- (app) Bendeguz Pusch confirmed that [file](https://www.darwinsys.com/file/) and [jq](https://jqlang.org/) are working
- (app) Petr Hrdina confirmed that the [hf](https://github.com/sorairolake/hf) recipe is working
- (app) Benton60 confirmed that the [pls](https://github.com/pls-rs/pls) recipe is working

## Ion Improvements

- (ion) David Campbell fixed some code warnings

## Testing Improvements

- (tests) Josh Williams finished the [POSIX signals test suite](https://gitlab.redox-os.org/redox-os/redox-posix-tests) and fixed some tests
- (tests) Wildan Mubarok updated the `acid` test suite to allow the usage of `cargo test` to run all correctness tests and `cargo bench` to run all stress tests.

## Build System Improvements

- (build) Wildan Mubarok added a feature flag in the installer to disable FUSE
- (build) Wildan Mubarok implemented the `COOKBOOK_CLEAN_BUILD` (clean previous recipe binaries before compilation) and `COOKBOOK_CLEAN_TARGET` (clean previous recipe binaries after compilation) boolean environment variables
- (build) Wildan Mubarok implemented the `make cook.clean_target` recipe target to clean previous binaries before compilation
- (build) Wildan Mubarok improved Redoxer to support [compilation with `musl` and compiler customization](https://gitlab.redox-os.org/redox-os/redoxer#host-specific-customizations)
- (build) Wildan Mubarok added CPU-specific filesystem configurations for Redoxer to allow its image to be updated from the build system
- (build) Wildan Mubarok improved the recipe push reliability
- (build) Wildan Mubarok simplified and reduced the filesystem tooling setup time by not compiling Cookbook twice to download their sources
- (build) Wildan Mubarok reduced the `make rebuild` command processing time
- (build) Wildan Mubarok enabled `sccache` build status log to say if compilation is using outdated cached library objects and improve debugging
- (build) Wildan Mubarok moved the `prefix_clean` target relibc logic to the `static_clean` target to avoid confusion between `prefix` and relibc/statically linked recipes cleanup
- (build) Ojus Chugh the source dependency propagation in the `REPO_BINARY` environment variable

## Documentation Improvements

- (doc) Ribbon documented the [hardware and software requirements](https://doc.redox-os.org/book/developer-faq.html#what-is-the-software-and-hardware-requirements-for-development) for Redox development in the Developer FAQ
- (doc) Ribbon improved the book summary order to better separate pages for end-users and testers/developers
- (doc) Wildan Mubarok did many improvements and fixes (such as documentation of [new build system filesystem tooling options](https://doc.redox-os.org/book/configuration-settings.html#environment-variables), minimum host system tools and toolchain prefix behavior/new configuration) to the Advanced Build, Advanced Podman Build, Native Build and Configuration Settings pages
- (doc) Wildan Mubarok documented [how to use the Podman Build without FUSE](https://doc.redox-os.org/book/advanced-podman-build.html#installing-without-fuse) to fix problems
- (doc) Wildan Mubarok documented [how to customize the C/C++ compiler](https://doc.redox-os.org/book/advanced-build.html#customizing-c-compiler) used in recipes
- (doc) Wildan Mubarok documented [how to use the upstream Rust binaries](https://doc.redox-os.org/book/advanced-build.html#prefix-rust) to build Redox (experimental)

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
