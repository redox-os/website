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

Anhad Singh successfully implemented the necessary fixes for compiling Cargo projects on Redox!

This is the third attempt to run the Rust compiler (`rustc`) and Cargo on Redox and the first focused on stable execution in single-core or multi-core CPUs. The [first attempt](https://www.redox-os.org/news/gsoc-self-hosting-final/) made significant progress but wasn't completed due to the amount of work remaining. The [second attempt](https://www.redox-os.org/news/focusing-on-rustc/) fixed `rustc` compilation but did not run on Redox yet.

He successfully built [relibc](https://gitlab.redox-os.org/redox-os/relibc), [ripgrep](https://github.com/BurntSushi/ripgrep), [cbindgen](https://github.com/mozilla/cbindgen), and [acid](https://gitlab.redox-os.org/redox-os/acid) on Redox.

- `ripgrep` compilation on Redox

<img src="/img/screenshot/cargo-ripgrep.png" class="img-responsive"/>

## First Contribution From Redox!

Using the [COSMIC Edit](https://github.com/pop-os/cosmic-edit) text editor, Anhad Singh wrote, tested, and pushed the [first relibc contribution](https://gitlab.redox-os.org/redox-os/relibc/-/merge_requests/891) entirely on Redox running in QEMU!

- Development on Redox

<img src="/img/screenshot/dev-on-redox.png" class="img-responsive"/>

## Capabilities on Redox!

Ibuki Omatsu successfully implemented the initial capability-based security infrastructure which allows our permission and sandbox system to be much more granular and secure.

The capability-based system has been implemented for scheme visibility which is configurable per-user, through the concept of Namespaces. There is work to do as many system services and drivers uses effective UID and GID as the only mechanism for security. Migration into Capability-based security will be gradually implemented to more system services in upcoming months.

## Proper SSH Support!

Anhad Singh fixed (and Wildan Mubarok confirmed) the OpenSSH session exit which allow exit in remote control without manual intervention to workaround a bug where SSH sessions weren't exitting.

Now we can remotely control Redox in QEMU or real hardware without manual intervention!

## Massive USB Input Latency Reduction

Wildan Mubarok reduced the USB input latency by removing heap allocation in the `rehid` library.

In a QEMU benchmark without KVM acceleration he reported an input latency reduction of 100ms to 30ms, a 70% latency reduction.

QEMU with KVM acceleration or real hardware has much lower input latency thus their reduction is much higher.

## Redox on VPS!

Wildan Mubarok successfully [hosted a Redox VM](https://gist.github.com/willnode/468f961602d96bef507e9f672250c7cc) in the [Vultr](https://www.vultr.com/) VPS with some tweaks.

- Redox running in a Vultr VM

<img src="/img/screenshot/vultr.png" class="img-responsive"/>

## Redox on Web Browser!

Our [v86 web demo](https://static.redox-os.org/online-demo/) finally reached acceptable performance in terminal mode!

Wildan Mubarok also improved it to increase performance and improved UI.

(Keep in mind that the QEMU KVM or real hardware performance is much better)

<img src="/img/screenshot/online-demo.png" class="img-responsive"/>

## Proper Keyboard Layout (Map) Management

Wildan Mubarok moved the keyboard layout handling from the PS/2 driver to the `inputd` daemon to share code with the USB HID driver and allow rootless usage.

The `/scheme/ps2` scheme-based configuration was replaced by the `inputd -K <name>` command, where `<name>` is the keyboard layout code. The keyboard layout names can be seen by running the `inputd --keymaps` command.

## Bootloader Environment Editor

Wildan Mubarok implemented a boot environment text editor in the bootloader to insert environment variables and options to change the boot environment.

- Bootloader environment editor with debug environment variables

<img src="/img/screenshot/bootloader-editor.png" class="img-responsive"/>

## More Boot Debugging Information and Handling

Wildan Mubarok implemented the `BOOTSTRAP_LOG_LEVEL` (bootstrap and process manager logging verbosity), `INIT_LOG_LEVEL` (init logging verbosity), `DRIVER_LOG_LEVEL` (driver logging verbosity), `DRIVER_*_LOG_LEVEL` (driver-specific logging verbosity), and `RELIBC_LOG_LEVEL` (relibc logging verbosity, require a debug build) bootloader environment variables to easily show more information in boot problems like hangs or errors, he implemented these log levels using the [log](https://docs.rs/log/latest/log/enum.LevelFilter.html) library:

- `ERROR` value: Known event that is a fatal error but recoverable.
- `WARN` value: Unexpected event coming from unexpected condition.
- `INFO` value: Significant event mostly useful for developer.
- `DEBUG` value: Detailed event monitoring to show how the service is being used.
- `TRACE` value: Very verbose information which is only useful when debugging.

You can see an example output below:

```
2026-01-12T22-27-51.758Z [@ps2d::controller:468 WARN] ps2d: post-test unexpected value: 9C
2026-01-12T22-27-51.760Z [@ps2d::controller:337 ERROR] ps2d: keyboard failed to reset: 55
```

He also implemented the `INIT_SKIP` environment variable to skip process hangs, the syntax is: `INIT_SKIP=executable-name` (commas are supported for multiple executable processes)

## Login Manager Options

Wildan Mubarok implemented a power menu (reboot/shutdown options) and a keyboard layout menu in the Orbital login manager (orblogin).

- Orbital login manager keyboard layout menu

<img src="/img/screenshot/orblogin-keymap-menu.png" class="img-responsive"/>

## Cargo Workspace Unification

Jeremy Soller added all system components and drivers to a Cargo workspace to unify the version management of libraries in one place, which allow faster development and less breakage.

## Redox Capabilities in FOSDEM 2026

Ibuki Omatsu [presented the Capability-based security project](https://fosdem.org/2026/schedule/event/KSK9RB-capability-based-redox-os/) at FOSDEM, thanks a lot for your help and dedication Ibuki!

## os-test in FOSDEM 2026

Jonas Sortie [presented the `os-test` test suite](https://fosdem.org/2026/schedule/event/CMCWY9-os-test_measuring_posix_compliance_on_every_single_os/) at FOSDEM and mentioned Redox, this test suite allowed us to find and fix many bugs (from easy to hard).

## Kernel Improvements

- (kernel) Jeremy Soller reduced the context switch cost by only reading the system time once
- (kernel) Jeremy Soller fixed a potential preemption guard deadlock
- (kernel) Jeremy Soller improved the error handling to disable event queue recursive registering in the same queue to fix X11 and D-Bus bugs
- (kernel) Jeremy Soller removed the legacy scheme path warning
- (kernel) Anhad Singh fixed a context switch deadlock
- (kernel) Anhad Singh fixed the `mremap` system call mapping size behavior causing a panic when running Cargo
- (kernel) Anhad Singh fixed the `futex` syscall behaviour where spurious wake-ups were incorrectly treated as timeout expirations
- (kernel) Pascal Reich improved and fixed typos in the documentation

## Driver Improvements

- (drivers) Jeremy Soller implemented the support for more PS/2 devices
- (drivers) Jeremy Soller implemented initial PS/2 touchpad support
- (drivers) Jeremy Soller reduced the USB HID input latency by temporarily using spinloops instead of sleep until sleep accuracy is better
- (drivers) Jeremy Soller enabled interrupt-driven initialization in the PS/2 driver to improve reliability and not delay keyboard handling
- (drivers) Jeremy Soller updated the USB HID driver to use the `anyhow` library for better error handling
- (drivers) Jeremy Soller fixed a xHCI error message typo in USB drivers
- (drivers) Jeremy Soller reduced unnecessary logging in xHCI driver by default
- (drivers) Wildan Mubarok exposed error reasons in the PS/2 driver initialization logging to improve debugging and save time
- (drivers) Wildan Mubarok fixed a mouse pointer warping bug when using the QEMU GTK frontend with USB relative mouse
- (drivers) bjorn3 unified the common PCI-based device drivers initialization code into the PCI driver

## System Improvements

- (sys) 4lDO2 replaced [our `kill` implementation](https://gitlab.redox-os.org/redox-os/coreutils/-/merge_requests/221) with the [`uutils` implementation](https://github.com/uutils/coreutils), which has the GNU/Linux command syntax and avoid confusion with a different syntax
- (sys) bjorn3 implemented dynamic linking support on `initfs`
- (sys) Wildan Mubarok enabled the `nproc` tool from `uutils` implementation
- (sys) Wildan Mubarok fixed `fbcond` error handling by not panicking when a display is not used
- (sys) Wildan Mubarok added a temporary workaround to fix `EBADF` in the `setsockopt()` function
- (sys) Wildan Mubarok fixed `uutils` localization init for ARM64
- (sys) Wildan Mubarok fixed a problem in `rustysd` where it was only been able to spawn one program, and updating `server-demo` variant to spawn NGINX, OpenSSH and PHP built-in server from `rustysd` service files.

## Relibc Improvements

- (libc) Jeremy Soller implemented signal mask handling in the `epoll_pwait()` function
- (libc) 4lDO2 fixed some POSIX signals bugs
- (libc) Anhad Singh improved POSIX threads destructor compliance
- (libc) Anhad Singh fixed an allocator difference between relibc and the dynamic linker which caused undefined behavior
- (libc) Anhad Singh implemented handling of undefined symbol index in the `TPOFF` relocation to fix random `rustc` errors/page faults
- (libc) Anhad Singh fixed a thread creation race condition which caused a panic in programs
- (libc) Anhad Singh fixed some missing `unsafe` declarations
- (libc) Anhad Singh fixed `memcmp()` to use `read_unaligned` where alignment is not guaranteed
- (libc) Anhad Singh fixed the `make all` command not triggering a rebuild when the dynamic linker, `redox-rt`, and `redox-ioctl` sources changed
- (libc) Anhad Singh fixed build log message colours
- (libc) Anhad Singh did a cleanup in POSIX threads mutex code
- (libc) Wildan Mubarok implemented the `malloc_usable_size()` function to allow efficient pointer memory allocation and improve `malloc` leaks debugging
- (libc) Wildan Mubarok improved the inet `setsockopt()` function performance using `SYS_CALL`
- (libc) Wildan Mubarok fixed the `pthread_cond_timedwait()` function futex behavior
- (libc) Wildan Mubarok fixed a hang in the UDS `connect()` function
- (libc) Wildan Mubarok fixed an CPU endianness hang in the UDP `accept()` function
- (libc) Wildan Mubarok fixed the UDP `accept()` function behavior in the `recvfrom()` function
- (libc) Wildan Mubarok fixed the `getpeername()`, `putc_unlocked()`, `pthread_cond_clockwait()`, and `pthread_mutex_timedlock()` functions
- (libc) Wildan Mubarok fixed the pthread `thread_fork` test
- (libc) Wildan Mubarok added tests for the `sys_socket()` and `putc_unlocked()` functions
- (libc) Wildan Mubarok improved single test execution
- (libc) Wildan Mubarok documented the `check.sh` script usage in the README
- (libc) Josh Megnauth added more tests for the `open()` function
- (libc) Landon Propes implemented the `mkfifoat()`, `mkdirat()`, `posix_close()`, `strxfrm_l()`, `strcoll_l()`, and `strerror_l()` functions
- (libc) Landon Propes implemented all locale-based versions of the `ctype` functions
- (libc) Landon Propes improved the `psiginfo()` function performance by removing memory allocations
- (libc) Landon Propes fixed some namespace pollution
- (libc) Pascal Reich implemented mathematical constants
- (libc) sourceturner migrated the code of many functions to use the new unsafe Rust syntax which allow safe Rust syntax usage, which help to prevent more bugs and ease bug hunt due to less places to suspect
- (libc) Akshit Gaur fixed the `%g` number modifier in the `printf()` function
- (libc) Mustafa Oz fixed an error when the `ppoll` timeout number overflow
- (libc) auronandace fixed some regressions in tests
- (libc) auronandace did some header cleanups

## Networking Improvements

- (net) Akshit Gaur implemented socket shutdown
- (net) Akshit Gaur implemented UDP Packet Filtering
- (net) Akshit Gaur implemented inet `getsockopt()` function via `SYS_CALL`
- (net) Wildan Mubarok fixed UDP `localhost` connection resolving

## RedoxFS Improvements

- (redoxfs) Jeremy Soller delayed the deletion of an unlinked file until all open file descriptors are closed to improve POSIX anonymous file compatibility
- (redoxfs) Jeremy Soller added a workaround to partially fix memory leaks

## Orbital Improvements

- (gui) Wildan Mubarok exposed numpad, arrow and media keyboard keys to `orbclient` library
- (gui) Wildan Mubarok implemented scrolling and numpad lock keys handling in `orbclient` library
- (gui) Wildan Mubarok improved the wallpaper processing performance 4 times (400%) by caching the first image decoding to a BMP file for fastest CPU performance, in a QEMU benchmark without KVM acceleration he reported the processing time being reduced from almost 10 seconds (in a cold cache) to around ~350ms (in a hot cache)
- (gui) bjorn3 did some code cleanups in the `orbclient` library
- (gui) bjorn3 moved the Orbital data to the `/usr/share/ui` directory to comply with Linux FHS
- (gui) bjorn3 simplified Orbital utilities recipe source fetch which reduced their build time

## Packaging Improvements

- (pkg) Mustafa Oz expanded the package manager library and tool error handling

## Programs

- (app) Jeremy Soller fixed the `mdp`, Gigalomania and `vvvvvv` compilation
- (app) Jeremy Soller moved all recipe fonts and icons to `/usr/share` to comply with Linux FHS
- (app) Anhad Singh fixed the [GNU Awk](https://www.gnu.org/software/gawk/) compilation
- (app) Wildan Mubarok enabled wide character support in the `libstdc++` library to help Firefox porting
- (app) Wildan Mubarok removed the `epoch-update` branch pin from COSMIC programs to quickly get improvements and fixes
- (app) Bendeguz Pisch confirmed that [file](https://www.darwinsys.com/file/) and [jq](https://jqlang.org/) are working
- (app) Bendeguz Pisch ported [espeak-ng](https://github.com/espeak-ng/espeak-ng)
- (app) Petr Hrdina confirmed that [hf](https://github.com/sorairolake/hf) is working
- (app) Benton60 confirmed that [pls](https://github.com/pls-rs/pls) is working
- (app) Akshit Gaur ported [iPerf](https://iperf.fr/)

## Ion Improvements

- (ion) David Campbell fixed some code warnings

## Testing Improvements

- (tests) Josh Williams finished our [POSIX signals test suite](https://gitlab.redox-os.org/redox-os/redox-posix-tests) and fixed some tests
- (tests) Wildan Mubarok updated the `acid` test suite to allow the usage of `cargo test` to run all correctness tests and `cargo bench` to run all stress tests.

## Build System Improvements

- (build) Jeremy Soller implemented the `make setenv` command to allow scripts to read the `ARCH`, `BOARD`, and `CONFIG_NAME` environment variables
- (build) Jeremy Soller added the [network-boot.sh](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/scripts/network-boot.sh) script to ease and automate network booting
- (build) Wildan Mubarok added a feature flag in the installer to disable FUSE for systems with problems
- (build) Wildan Mubarok implemented the `COOKBOOK_CLEAN_BUILD` (clean previous recipe binaries before compilation) and `COOKBOOK_CLEAN_TARGET` (clean previous recipe binaries after compilation) boolean environment variables
- (build) Wildan Mubarok implemented the `make cook.clean_target` recipe target to clean previous binaries before compilation
- (build) Wildan Mubarok improved Redoxer to support [compilation with `musl` and compiler customization](https://gitlab.redox-os.org/redox-os/redoxer#host-specific-customizations)
- (build) Wildan Mubarok added CPU-specific filesystem configurations for Redoxer to allow its image to be updated from the build system
- (build) Wildan Mubarok improved the recipe push reliability
- (build) Wildan Mubarok simplified and reduced the filesystem tooling setup time by not compiling Cookbook twice to download their sources
- (build) Wildan Mubarok reduced the `make rebuild` command processing time
- (build) Wildan Mubarok enabled `sccache` build status log to say if compilation is using outdated cached library objects and improve debugging
- (build) Wildan Mubarok moved the `prefix_clean` target relibc logic to the `static_clean` target to avoid confusion between `prefix` and relibc/statically linked recipes cleanup
- (build) Wildan Mubarok fixed unnecessary compilation in `recipe = "binary"` when the `dev-dependencies` data type was used
- (build) Wildan Mubarok fixed the `make r.recipe-dependency` command not ignoring when used in recipe dependencies when `recipe = "binary"` was used
- (build) Wildan Mubarok fixing `recipe "ignore"` and `recipe = "local"` also applying to their recipe dependencies
- (build) Wildan Mubarok fixed `recipe = "ignore"` when used for recipes from meta-packages
- (build) Ojus Chugh fixed the source dependency propagation in the `REPO_BINARY` environment variable
- (build) Ribbon fixed the QEMU RISC-V firmware location in Fedora

## Documentation Improvements

- (doc) Ribbon documented the [CPU requirements](https://doc.redox-os.org/book/hardware-support.html#cpu-requirements) to allow Redox to work
- (doc) Ribbon documented how to find and open the GUI system installer in the [Installing Redox in a Drive](https://doc.redox-os.org/book/installing.html) page
- (doc) Ribbon did some improvements and fixes to the [Hardware Compatibility document](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md)
- (doc) Ribbon added [quick notes](https://doc.redox-os.org/book/troubleshooting.html#notes) to help with troubleshooting and save time
- (doc) Ribbon documented the [hardware and software requirements](https://doc.redox-os.org/book/developer-faq.html#what-is-the-software-and-hardware-requirements-for-development) for Redox development in the Developer FAQ
- (doc) Ribbon moved the development tips from the book to the [CONTRIBUTING.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md#development-recommendations-and-tips) document to be more easy to find
- (doc) Ribbon added questions about how to [update initfs](https://doc.redox-os.org/book/developer-faq.html#how-to-update-initfs) and [disable the automatic recipe source update](https://doc.redox-os.org/book/developer-faq.html#how-to-disable-the-automatic-recipe-source-update)
- (doc) Ribbon enabled dynamic linking in all Cargo example commands in the porting documentation
- (doc) Ribbon added more data types to speedup the Quick Recipe Template usage
- (doc) Ribbon documented the `build.dev-dependencies` recipe data type
- (doc) Ribbon added the [POSIX errors](https://en.wikipedia.org/wiki/Errno.h#POSIX_errors) and [Linux FHS Directory Structure](https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard#Directory_structure) references in the References book page
- (doc) Ribbon improved the book summary order to better separate pages for end-users and testers/developers
- (doc) Ribbon fixed a regression in the QEMU commands to load x86-64 images
- (doc) Ribbon did some improvements in command examples and removed deprecated information
- (doc) Ribbon documented that [kibi](https://github.com/ilai-deutel/kibi) is the new default terminal text editor
- (doc) Wildan Mubarok did many improvements and fixes (such as documentation of [new build system filesystem tooling options](https://doc.redox-os.org/book/configuration-settings.html#environment-variables), minimum host system tools and toolchain prefix behavior/new configuration) to the Advanced Native Build, Advanced Podman Build, Native Build and Configuration Settings pages
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
