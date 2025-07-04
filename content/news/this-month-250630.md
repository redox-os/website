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

## NLnet/NGI Zero Grants!

Redox has been awarded two new grants by the [NGI Zero Commons fund](https://nlnet.nl/commonsfund/) and [NLnet Foundation](https://nlnet.nl/).

- [Capability-based security for Redox](https://nlnet.nl/project/Capability-based-RedoxOS/) is our first step to supporting [Capabilities](https://en.wikipedia.org/wiki/Capability-based_security) as the underlying mechanism for file descriptors.
- [io_uring-like IO for Redox](https://nlnet.nl/project/RedoxOS-ringbuffer/) is intended to improve the performance of Redox internal communication by using asynchronous queues inspired by [io_uring](https://en.wikipedia.org/wiki/Io_uring) rather than synchronous messaging, while also ensuring the safety of the requests.

The amounts of the grants is still to be determined, but each project should be about 2 to 4 months work.

## Redox is hiring a Build Engineer!

In addition to our development position announced in [last month's report](https://redox-os.org/news/this-month-250531/), Redox is looking for a part-time Build/CI Engineer. This is a remote position, and there are no geographical restrictions, other than you must be eligible to receive payment from a US-based non-profit. We have a budget of US$1,000 per month available for this position, so we are open to proposals with flexible work schedules, and are open to ideas about your responsibilities.

The primary responsibility is to monitor Redox's build and CI to identify the cause of failures and repair them, either by working with the developers, applying fixes or rolling back changes to the various Redox gitlab repos.

Other possible responsibilities and tasks include:
- Monitor Redox's GitLab, website and other communication tools for problems.
- Provide technical support to the Redox community.
- Contribute to Redox documentation, especially with respect to the build process.
- Improve Redox's build system, and help create a self-hosted build system, as time permits.
- Improve Redox's website design.

Qualifications include some or all of:
- Knowledge of various Linux build systems, including Cargo, GNU Make, CMake, GNU Autotools, Meson and others
- Knowledge of Git, GitLab, and CI configuration
- Experience programming in Rust, C, Shell scripts and GNU Bash
- Experience with Podman and/or Docker
- Past contributions to open source projects
- HTML and CSS knowledge
- Enthusiasm for Rust, Redox and learning in general
- Ability to communicate effectively in English
- Ability to provide positive and friendly support for community members of varying skills and backgrounds

Email president@redox-os.org, CC info@redox-os.org. Write a short proposal indicating how much time you would be available, given our budget constraints. Tell us about your build and GitLab expertise, some of the areas above where you would like to make a contribution, and the relevant skills and experience you have.

## Wayland and Unix Domain Sockets

As we continue to move forward with our plans for Wayland,
a key technology for Wayland support is the ability to send file descriptors over Unix Domain Sockets.
File descriptor sending is also an important part of many other OS features,
including Capability-based Security.

Our Redox Summer of Code project to implement that ability has been progressing very well.
Ibuki, a new member of the Redox team, has jumped right into the deep end,
and implemented the [`sendmg`](https://www.man7.org/linux/man-pages/man3/sendmsg.3p.html)
and [`recvmsg`](https://www.man7.org/linux/man-pages/man3/recvmsg.3p.html) functionality,
and continues to move forward with work on UDS.

Understanding how Redox enables sending file descriptors gives some key insights into how Redox services collaborate.
Read all about it in Ibuki's [RSoC news post](https://redox-os.org/news/rsoc-2025-uds/).

## Redox at RustConf

[RustConf 2025](https://rustconf.com/) is in Seattle, September 2-5. Jeremy Soller will be presenting "10 Years of Rust and Redox",
including our shared history with Rust, and our vision for the future of Redox.

We hope to see you there!
 
## COSMIC Desktop Presentation

Jeremy Soller, Redox founder and architect, and principal engineer at [System76](https://system76.com/),
along with System76 CEO Carl Richell, presented the [COSMIC Desktop Environment](https://system76.com/cosmic/) at the [Open Source Summit](https://ossna2025.sched.com/event/1zfnp/cosmic-de-the-first-modular-composable-desktop-environment-carl-richell-jeremy-soller-system76).

Redox has adopted some of the main applications from the COSMIC Desktop, and we plan to use the COSMIC Compositor as soon as we complete our Wayland support.

- [0:00](https://youtu.be/fBcfjlFX-xM?feature=shared) Motivation for COSMIC DE
- [7:48](https://youtu.be/fBcfjlFX-xM?feature=shared&t=468) COSMIC DE Overview
- [9:12](https://youtu.be/fBcfjlFX-xM?feature=shared&t=552) Live Demo
- [26:08](https://youtu.be/fBcfjlFX-xM?feature=shared&t=1568) Modularity and COSMIC Panel
- [28:02](https://youtu.be/fBcfjlFX-xM?feature=shared&t=1682) File-based Configuration
- [32:48](https://youtu.be/fBcfjlFX-xM?feature=shared&t=1968) Next Steps, Platforms, Availability

<iframe width="800" height="480" src="https://www.youtube.com/embed/fBcfjlFX-xM?si=I0Hv2yJo0Y0DuF59" title="COSMIC Desktop Environment" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Network Booting Support

bjorn3 implemented [network booting](https://en.wikipedia.org/wiki/Network_booting) (PXE) support allowing Redox to be booted from the local network or Internet.

Currently only UEFI is supported.

## Kernel Improvements

- (kernel) bjorn3 unified more x86-64 and i686 code
- (kernel) bjorn3 reduced boot verbosity
- (kernel) bjorn3 fixed some warnings

## System Call Improvements

- (syscall) Ron Williams fixed a regression with the file type information which broke recursive search of directories, pattern matching and some other problems

## Driver Improvements

- (drivers) bjorn3 did many code refactorings in the graphics API

## System Improvements

- (system) bjorn3 implemented an option in the bootloader to enable/disable live mode to fully load the system into RAM (if the storage drivers don't work on your computer) or load from the storage device
- (system) bjorn3 fixed a conflict with the `du` and `touch` tools between Redox coreutils and uutils
- (system) James Matlik did a small dependency cleanup in `userutils`

## RedoxFS Improvements

- (redoxfs) James Matlik did a massive performance improvement on file/directory creatioon and path-based lookups

## Relibc Improvements

- (relibc) James Matlik fixed a bug with the rename to relative destination

## Networking Improvements

- (net) voedipus fixed the `ping` tool by removing the legacy scheme path format code
- (net) bjorn3 did a code cleanup and removed dead code in the network stack and tools

## Testing Improvements

- (test) Ibuki Omatsu added Unix domain socket tests on `acid`
- (test) Darley Barreto added `openat` API tests on `acid`
- (test) Ron Williams packaged the Open POSIX Test Suite

## Packaging Improvements

- (pkg) Wildan Mubarok fixed the package update logic
- (pkg) Wildan Mubarok fixed a bug in the package manager which caused duplicated downloads
- (pkg) Wildan Mubarok improved the package update performance
- (pkg) Wildan Mubarok added a workaround to fix a symbolic link bug in pkgar
- (pkg) Wildan Mubarok added tests for package installation
- (pkg) Wildan Mubarok implemented support for a custom package repository
- (pkg) Wildan Mubarok improved the package manager search by reading the package server `repo.toml` database instead of HTML package list
- (pkg) Josh Megnauth added unit tests on the package manager

## Terminal Improvements

- (term) Petr Hrdina fixed the Ion shell prompt user type symbol
- (term) David da Silva implemented the built-in `mapfile` command on the Ion shell, it's using the GNU Bash behavior without callbacks and file descriptors

## Programs

- (programs) Jeremy Soller fixed COSMIC Files, COSMIC Store, and FreeCiv
- (programs) Jeremy Soller enabled dynamic linking on the libxkbcommon, OpenJK, and Gigalomania recipes
- (programs) Jeremy Soller converted the mgba and Neverball recipes to TOML
- (programs) Jeremy Soller updated mgba to the 0.10.5 version
- (programs) Jeremy Soller replaced the libjpeg library with libjpeg-turbo
- (programs) Wildan Mubarok fixed the source download of the libgmp recipe on GitHub CI (due to blocked Microsoft IPs) by using the GNU FTP mirror
- (programs) Ron Williams fixed GNU sed
- (programs) Oleg Pittman converted the cmatrix, dynamic-example, Pixelcannon, patch, rustual-boy, ScummVM, ttf-hack, Gigalomania, OpenTTD, Sopwith, Duktape, SDL_gfx, SDL_image, SDL_ttf, generaluser-rs, Timidity, vttest, GNU Grep, libc-bench, Periodictable, Schismtracker, and mdp recipes to TOML
- (programs) bjorn3 converted the osdemo, sdl2-gears, ncdu, and sdl-player recipes to TOML
- (programs) Wildan Mubarok enabled more recipes for ARM64
- (programs) Wildan Mubarok fixed GNU Nano by adding a missing dependency
- (programs) Wildan Mubarok disabled the OpenSSL man pages to speedup building a lot
- (programs) Josh Megnauth converted the powerline-rs shell to TOML
- (programs) Ribbon fixed and packaged many tools and demos written in Rust
- (programs) bjorn3 removed some recipes that aren't used anymore and use the deprecated `recipe.sh` format
- (programs) David Campbell added the `BROWSER` environment variable in the `desktop` variant configuration to fix programs that use the default web browser to do tasks
- (programs) David Campbell packaged the [Copenhagen Hnefatafl](https://github.com/dcampbell24/hnefatafl) client

## Build System Improvements

- (build-system) Jeremy Soller improved the recipe scanning performance massively
- (build-system) bjorn3 implemented a way to install the bootloader to a custom location
- (build-system) Wildan Mubarok reduced the Git fetch time of our libtool fork
- (build-system) Wildan Mubarok fixed the fetch of our libtool fork with older Git versions
- (build-system) Wildan Mubarok fixed the frequent libtool-build rebuild when using the Podman Build
- (build-system) Josh Megnauth fixed the `make virtualbox` command with recent VirtualBox versions
- (build-system) Ribbon improved the script of the `myfiles` recipe to avoid problems with bad characters on paths
- (build-system) Wildan Mubarok updated Cookbook to build the items of the `package.dependencies` data type before their recipe instead after all recipes
- (build-system) Wildan Mubarok fixed Redoxer on Linux and MacOS
- (build-system) Wildan Mubarok reduced the Redoxer Docker image size
- (build-system) Wildan Mubarok implemented dynamic search of the QEMU UEFI firmware for Linux distributions and MacOS Brew to fix a QEMU problem with different firmware locations on package systems
- (build-system) Wildan Mubarok improved the support for ARM64 host systems
- (build-system) Wildan Mubarok updated the GitLab CI to Ubuntu 24.04 to fix the Redox toolchain
- (build-system) auronandace added spaces in the Podman and Native build bootstrap scripts for consistant formatting
- (build-system) Petr Hrdina implemented support for multiple items on recipe target commands (`make r.recipe1,recipe2`) and fixed the slowness of the `scripts/category.sh` script in the Podman Build
- (build-system) Wildan Mubarok implemented the `recipe = "ignore"` option to allow the CPU-specific configurations to disable recipes when a recipe breaks for some CPU architecture (reducing configuration duplication and less error-prone).

Before that the i686, ARM64 and RISC-V configurations couldn't disable the broken recipes from the complete/CPU-agnostic root configurations

## Documentation Improvements

- (doc) Ribbon added a brief explanation of the Redox's [origin story](https://doc.redox-os.org/book/#origin-story)
- (doc) Ribbon improved the scheme documentation and fixed broken source code links of some schemes in the [scheme tables](https://doc.redox-os.org/book/schemes.html)
- (doc) Ribbon improved the [CONTRIBUTING.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md) document with more information for Matrix/Discord/GitLab, added missing important repositories and more tasks for contributors who don't know programming
- (doc) Ribbon did many improvements, fixes and cleanup in the [Developer FAQ](https://doc.redox-os.org/book/developer-faq.html) page
- (doc) Ribbon added the [Documentation Questions](https://doc.redox-os.org/book/developer-faq.html#documentation-questions) with answers for contributors who want to write documentation
- (doc) Ribbon improved the GDB documentation on the book thanks to bjorn3
- (doc) Ribbon added a reference for debugging techniques on the debug methods list in the book
- (doc) Ribbon improved the Podman documentation of the `make env` and `make container_shell` commands
- (doc) Ribbon added a section for feature flags of C/C++ programs and libraries in the porting documentation
- (doc) Ribbon added the "more stable long execution" and "kernel simplicity" [microkernel benefits](https://doc.redox-os.org/book/why-a-new-os.html#benefits-1) in the book
- (doc) Ribbon added missing important repositories in the [Ecosystem](https://gitlab.redox-os.org/redox-os/redox#ecosystem) table of the build system repository
- (doc) Ribbon documented the Podman update process
- (doc) Ribbon documented the practice where Rust programs use Cargo packages for examples instead of Cargo examples in the porting documentation
- (doc) Ribbon moved the hardware compatibility list to a [table](https://doc.redox-os.org/book/hardware-support.html#compatibility-table)
- (doc) James Matlik fixed the kernel recipe source location in the "System Call Tracing" page
- (doc) Wildan Mubarok added questions for the `REPO_BINARY` environment variable on the Developer FAQ
- (doc) Wildan Mubarok added a README in the bootloader repository
- (doc) Wildan Mubarok added the [lychee](https://lychee.cli.rs/) tool in the book CI to verify broken links
- (doc) auronandace added a reference for [Rust security](https://yevh.github.io/rust-security-handbook/) in the book
- (doc) Brooks McMillin fixed the Periodic Table executable location in the "Trying Out Redox" page

## Website Improvements

- (web) Wildan Mubarok fixed the repository CI

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
