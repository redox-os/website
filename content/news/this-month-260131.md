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

Anhad Singh wrote (using the [COSMIC Edit](https://github.com/pop-os/cosmic-edit) text editor) and pushed the first relibc contribution from the Redox QEMU VM!

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

## Bootloader Environment Editor

Wildan Mubarok implemented a boot environment text editor in the bootloader to insert environment variables and options to change the boot environment.

- Bootloader environment editor with debug environment variables

<img src="/img/screenshot/bootloader-editor.png" class="img-responsive"/>

## Login Manager Options

Wildan Mubarok implemented a power menu (reboot/shutdown) and a keyboard layout menu in the Orbital login manager (orblogin).

## Cargo Workspace Unification

Jeremy Soller added all system components and drivers to a Cargo workspace to unify the version management of libraries in one place, which allow faster development and less breakage.

## Kernel Improvements

- (kernel) Anhad Singh fixed the `mremap` mapping size behavior which was causing a panic when Cargo was running
- (kernel) Pascal Reich improved the code documentation

## Driver Improvements

- (drivers) Wildan Mubarok moved the keyboard layout handling from the PS/2 driver to the `inputd` daemon to share code with the USB HID driver
- (drivers) Wildan Mubarok improved the PS/2 driver init logging

## System Improvements

- (sys) Wildan Mubarok added a temporary workaround to fix `EBADF` in the `setsockopt()` function

## Relibc Improvements

- (libc) Jeremy Soller implemented signal mask handling in the `epoll_pwait()` function
- (libc) Anhad Singh fixed the `memcmp()` function alignment
- (libc) Wildan Mubarok implemented `malloc_usable_size()` function to allow efficient pointer memory allocation and improve `malloc` leaks debugging
- (libc) Wildan Mubarok added tests for the `sys_socket()` and `putc_unlocked()` functions
- (libc) Wildan Mubarok improved single test execution
- (libc) Wildan Mubarok documented the `check.sh` script usage in the README
- (libc) Josh Megnauth added more tests for the `open()` function
- (libc) Landon Propes implemented the `mkfifoat()`, `mkdirat()`, `posix_close()`, `strxfrm_l()`, `strcoll_l()`, and `strerror_l()` functions
- (libc) Landon Propes fixed some namespace pollution
- (libc) Pascal Reich implemented mathematical constants
- (libc) auronandace did some code cleanups

## Networking Improvements

- (net) Akshit Gaur implemented UDP Packet Filtering
- (net) Wildan Mubarok fixed UDP resolving connection

## RedoxFS Improvements

- (redoxfs) 

## Packaging Improvements

- (pkg) Mustafa Oz expanded the package manager library and tool error handling

## Programs

- (programs) Petr Hrdina confirmed that the [hf] recipe is working
- (programs) Benton60 confirmed that the [pls] recipe is working

## Ion Improvements

- (ion) David Campbell fixed code warnings

## Testing Improvements

- (tests) Josh Williams finished the [POSIX signals test suite](https://gitlab.redox-os.org/redox-os/redox-posix-tests) and fixed some tests

## Build System Improvements

- (build) Wildan Mubarok improved the recipe push reliability
- (build) Wildan Mubarok enabled `sccache` build status log to improve recipe debugging
- (build) Wildan Mubarok renamed the `prefix_clean` target to `static_clean` to avoid confusion

## Documentation Improvements

- (doc) Ribbon documented the [hardware and software requirements] for Redox development in the Developer FAQ
- (doc) Ribbon improved the book summary order to better separate pages for end-users and testers/developers
- (doc) Wildan Mubarok did many improvements and fixes to the Advanced Build, Advanced Podman Build, Native Build and Configuration Settings pages

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
