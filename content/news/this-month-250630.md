+++
title = "This Month in Redox - June 2025"
author = "Ribbon and Ron Williams"
date = "2025-06-30"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. June was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Kernel Improvements

- (kernel) 

## System Call Improvements

- (syscall) Ron Williams fixed a regression with the file type information which broke recursive search of directories, pattern matching and some other problems

## Driver Improvements

- (drivers) 

## System Improvements

- (system) bjorn3 implemented network boot (PXE) support for UEFI in the bootloader
- (system) bjorn3 fixed a conflict with the `du` and `touch` tools between Rust Coreutils and uutils

## Relibc Improvements

- (relibc) James Matlik fixed a bug with the rename to relative destination

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) 

## Packaging Improvements

- (pkg) Wildan Mubarok fixed the package update logic
- (pkg) Wildan Mubarok improved the package update performance
- (pkg) Wildan Mubarok added a workaround to fix a symbolic link bug in pkgar
- (pkg) Wildan Mubarok added tests for package installation
- (pkg) Wildan Mubarok implemented support for a custom paclage repository
- (pkg) Wildan Mubarok implemented the support for symbolic link overwrite

## Terminal Improvements

- (term) Petr Hrdina fixed the Ion shell prompt user type symbol
- (term) David da Silva implemented the built-in `mapfile` command on the Ion shell, it's using the GNU Bash behavior without callbacks and file descriptors

## Programs

- (programs) Jeremy Soller fixed COSMIC Files, COSMIC Store and FreeCiv
- (programs) Jeremy Soller enabled dynamic linking on the libxkbcommon, OpenJK and Gigalomania recipes
- (programs) Jeremy Soller converted the mgba and Neverball recipes to TOML
- (programs) Jeremy Soller updated mgba to the 0.10.5 version
- (programs) Jeremy Soller replaced the libjpeg library by libjpeg-turbo
- (programs) Wildan Mubarok fixed the source download of the libgmp recipe on GitHub CI (due to blocked Microsoft IPs) by using the GNU FTP mirror
- (programs) Ron Williams fixed GNU sed
- (programs) Oleg Pittman converted the recipes to TOML
- (programs) Josh Megnauth converted the powerline-rs shell to TOML
- (programs) Ribbon fixed and packaged many tools and demos written in Rust

## Build System Improvements

- (build-system) Jeremy Soller improved the recipe scanning performance massively
- (build-system) bjorn3 implemented a way to install the bootloader in a custom location
- (build-system) Wildan Mubarok reduced the Git fetch time of our libtool fork
- (build-system) Wildan Mubarok fixed the fetch of our libtool fork in older Git versions
- (build-system) Josh Megnauth fixed the `make virtualbox` command with recent VirtualBox versions
- (build-system) Ribbon improved the script of the `myfiles` recipe to avoid problems with bad characters on paths
- (build-system) Wildan Mubarok updated the GitLab CI to Ubuntu 24.04 to fix the Redox toolchain

## Documentation Improvements

- (doc) Ribbon did many improvements, fixes and cleanup in the [Developer FAQ](https://doc.redox-os.org/book/developer-faq.html) page
- (doc) Ribbon improved the GDB documentation on the book thanks to bjorn3
- (doc) Ribbon added a reference for debugging techniques on the debug methods list on the book
- (doc) Ribbon improved the Podman documentation of the `make env` and `make container_shell` commands
- (doc) Ribbon added a section for feature flags of C/C++ programs and libraries on the porting documentation
- (doc) Ribbon added a benefit about the kernel simplicity on the microkernel architecture
- (doc) Ribbon documented the Podman update process
- (doc) Ribbon documented the practice where Rust programs use Cargo packages for examples instead of Cargo examples in the porting documentation
- (doc) James Matlik fixed the kernel recipe source location in the "System Call Tracing" page
- (doc) Wildan Mubarok added questions for the `REPO_BINARY` environment variable on the Developer FAQ

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

(Use the `server` variant for a terminal interface and the `desktop` variant for a graphical interface, if the `desktop` variant doesn't work use the `server` variant)

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
