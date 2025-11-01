+++
title = "This Month in Redox - October 2025"
author = "Ribbon and Ron Williams"
date = "2025-10-31"
+++

- Servo on Redox

<img src="/img/screenshot/servo.png" class="img-responsive"/>

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. October was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Flexible Device Detection

Jeremy Soller was improving the upcoming `hwd` daemon to make it usable and finally enabled it to detect and configure ACPI or DeviceTree computers.

This daemon fixed our problems with DeviceTree computers and improved the ARM64 hardware support.

## Servo on Redox!

Wildan Mubarok successfully ported Servo after some effort to fix bugs and missing functionality, unfortunately it crashes if another website is loaded and don't respond to keyboard input (these bugs will be fixed soon)

Thanks for all contributors that made it possible.

## htop on Redox!

Wildan Mubarok successfully ported htop with help from Jeremy Soller to improve the port, it's the first advanced system monitor to work on Redox.

(CPU graphs are incorrect in the moment)

<img src="/img/screenshot/htop.png" class="img-responsive"/>

- htop and ffplay

<img src="/img/screenshot/htop-ffplay.jpg" class="img-responsive"/>

## bottom on Redox!

Jeremy Soller ported the [bottom](https://github.com/ClementTsang/bottom) system monitor.

<img src="/img/screenshot/bottom.jpg" class="img-responsive"/>

## Upgrade to Rust 1.90.x

Jeremy Soller updated our Rust nightly fork to the 03/10/2025 date equivalent to 1.90.x version, this fixed some programs and crates.

## Initial Keyboard Layout Configuration

Wildan Mubarok implemented a scheme in the PS/2 driver to allow the PS/2 keyboard layout to be easily changed (it was hardcoded before), the following keyboard layouts are supported for a long time but were hardcoded:

- dvorak
- us
- gb
- azerty
- bepo
- it

The keyboard layout resources are available at `/scheme/ps2`, see the example usage below:

```
user:~$ ls -1 /scheme/ps2
keymap
keymap_list
user:~$ cat /scheme/ps2/keymap
us
user:~$ cat /scheme/ps2/keymap_list
dvorak
us
gb
azerty
bepo
it
user:~$ sudo echo "azerty" > /scheme/ps2/keymap
2025-10-20T16-38-39.045Z [@ps2d:154 INFO] ps2d: updating to new keymap '"azerty"'
user:~$
```

## Partial systemd Service Configuration Compatibility

Wildan Mubarok successfully ported the [rustysd](https://github.com/KillingSpark/rustysd) portable systemd service manager written in Rust and started nginx at boot using a systemd service.

## GoAccess on Redox

The rsm92 (Rafael) contributor ported [GoAccess](https://goaccess.io/), it's the first web analytics program to work on Redox.

<img src="/img/screenshot/goaccess.jpg" class="img-responsive"/>

## Cookbook in Rust

Wildan Mubarok reimplemented the Cookbook scripts in Rust with better performance and more features, he implemented the following items:

- A TUI to monitor and manage the build process
- Options to skip, retry or cancel the build process when an error happens
- Parallel recipe source fetch
- Log scrolling with arrow keys
- Unique screen for fetch and compilation logs (use the "1" and "2" keys to switch)
- Option to disable recipe logs
- Option to do an operation in a recipe category (free space by cleaning all recipe sources/binaries of a WIP category, for example)

<img src="/img/screenshot/cookbook-tui.png" class="img-responsive"/>

## Kernel Improvements

- (kernel) Speedy_Lex fixed many code warnings
- (kernel) bjorn3 reduced unsafe code in naked functions
- (kernel) bjorn3 unified the generic IRQ handling code between x86_64 and i686
- (kernel) bjorn3 did some code cleanups
- (kernel) bjorn3 fixed some code warnings

## Driver Improvements

- (drivers) bjorn3 fixed a boot hang by removing an useless loop in the `driver-block` library
- (drivers) Wildan Mubarok updated the example driver to use the `redox-scheme`, `redox-daemon` and `redox-event` libraries (up-to-date driver)
- (drivers) Jeremy Soller implemented timeouts in the AHCI driver to ignore infinite loop bugs and allow boot to continue
- (drivers) Jeremy Soller implemented an unique log file per-driver
- (drivers) AArch Angel implemented AML evaluation exposure in the ACPI scheme to allow drivers to use AML functions

## System Improvements

- (sys) Wildan Mubarok bumped uutils to 0.3 version
- (sys) Wildan Mubarok fixed shared memory read/write operation
- (sys) Wildan Mubarok fixed an Unix Domain Sockets race condition
- (sys) Wildan Mubarok implemented scrolling in the boot log using Shift+Up/Down keys (it has a limit of 1000 lines)

## Relibc Improvements

- (libc) bjorn3 fixed ARM64 compilation
- (libc) Wildan Mubarok implemented POSIX timer functions
- (libc) Wildan Mubarok fixed ARM64 and RISC-V compilation
- (libc) Wildan Mubarok fixed a panic in the `strlen()` function due to an uninitialized string
- (libc) Wildan Mubarok fixed a dynamic linker bug where multiple objects were loading the same object
- (libc) Wildan Mubarok exposed memory information for programs
- (libc) Wildan Mubarok exposed PIE information to ease dynamic linker debugging
- (libc) Josh Megnauth implemented the `renameat()` and `renameat2()` functions
- (libc) 4lDO2 implemented Rust newtype wrappers to allow nul-terminated strings to be handled in safer code
- (libc) 4lDO2 implemented a Rust newtype wrapper to improve the C FFI safety with input and output data distinction
- (libc) 4lDO2 mostly unified the `printf()` and `wprintf()` functions code
- (libc) Jeremy Soller implemented the `NAME_MAX` limit
- (libc) auronandace did small code cleanups
- (libc) auronandace improved code documentation

## Networking Improvements

- (net) Wildan Mubarok updated the configuration to support IPv4 loopback address and allow `localhost` usage
- (net) Jeremy Soller updated the configuration to use [Quad9](https://quad9.net/) DNS

## RedoxFS Improvements

- (redoxfs) Jeremy Soller implemented partition resizing support

## Terminal Improvements

- (term) Stephen Seo implemented the support for temporary environment variables (`ENVIVAR=some-value` command) in the Ion shell

## Programs

- (programs) Wildan Mubarok ported [GitUI](https://github.com/gitui-org/gitui)
- (programs) Wildan Mubarok fixed NodeJS 21.x compilation
- (programs) Jeremy Soller fixed Love2D compilation

## Build System Improvements

- (build) Wildan Mubarok installed C++ headers in the toolchain to fix C++ programs and libraries
- (build) Wildan Mubarok implemented the `make push` command to install recipe packages with new changes in an existing Redox image for faster testing
- (build) Wildan Mubarok implemented the `remote` Cookbook template to allow recipes to use pre-compiled library objects downloaded from Redox package server
- (build) Wildan Mubarok implemented a way to disable the recipe source update from filesystem configuration (`recipe-name = "local"`) to easily avoid upstream breaking changes in local development
- (build) Wildan Mubarok implemented automatic tarball update when BLAKE3 hashes change
- (build) Wildan Mubarok implemented offline mode in the installer when remote packages aren't used
- (build) Wildan Mubarok implemented a filesystem configuration recipe and recipe dependency tree to help the investigation of problems and bugs (`make tree` command)
- (build) Wildan Mubarok implemented tarball mirror configuration in Cookbook
- (build) Jeremy Soller implemented the `make mount_live` command to mount the ISO file (live disk)
- (build) Timmy Douglas updated the Podman container image reference to use a fully qualified domain name and improve compatibility
- (build) Ribbon added a [filesystem configuration for testing](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/config/tests.toml)
- (build) Zhiwei Liang fixed the Podman Build in Fedora

## Testing Improvements

- (tests) Joshua Williams added more POSIX signals tests

## Documentation Improvements

- (doc) Ribbon [documented the method](https://doc.redox-os.org/book/troubleshooting.html#debug-methods) to verify if Orbital or system hangs with a bug
- (doc) Ribbon added the [Harvard CS50](https://www.youtube.com/watch?v=8mAITcNt710) 24-hour course from freeCodeCamp in the "References" page, thanks to Ron Williams
- (doc) Ribbon explained [why C/C++ programs and libraries can be hard and time consuming to port](https://doc.redox-os.org/book/developer-faq.html#why-cc-programs-and-libraries-are-hard-and-time-consuming-to-port) in the Developer FAQ
- (doc) Ribbon did many improvements, fixes and cleanup in the porting documentation

## Website Improvements

- (web) Wildan Mubarok fixed the YouTube embedded player width on mobile devices
- (web) Ribbon added more screenshots and hardware photos in the [Redox in Action](https://www.redox-os.org/screens/) page
- (web) The deck1 contributor fixed a broken link in the Plan 9's influence section of General FAQ
- (web) Angel Cervera fixed a hyperlink in the homepage roadmap

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

The following template is for screenshots or photos

<a href="/img/screenshot/image-name.png"><img class="img-responsive" alt="Description" src="/img/screenshot/image-name.png"/></a>

-->

<!--

The following template is for YouTube videos

## Title

<iframe width="800" height="640" src="insert-the-video-embed-link-here" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

-->
