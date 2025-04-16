+++
title = "This Month in Redox - April 2025"
author = "Ribbon and Ron Williams"
date = "2025-04-30"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. April was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Improvements

- (kernel) 4lDO2 fixed the cancellation of the network stack schemes
- (kernel) 4lDO2 removed the `ITimer` scheme
- (kernel) bjorn3 fixed the saving and restoring of float registers on ARM64
- (drivers) bjorn3 updated the VESA driver (vesad) to disable the kernel graphical debugging as late as possible
- (drivers) bjorn3 fixed the ARM64 support on the PCI driver
- (system) Jeremy Soller updated uutils to the latest commit
- (system) Darley Barreto implemented the openat() POSIX function which allows file locations to be isolated from the program. It will replace the "named dup" calls, which are non-standard (not POSIX or Linux) so you can access a specific resource or get/set values of a certain category for a resource 
- (system) 4lDO2 migrated more system components and libraries to the userspace-based process manager
- (system) 4lDO2 updated `escalated` to use the `redox-scheme` library and `SYS_CALL` system call
- (system) 4lDO2 implemented cancellation on the Orbital scheme
- (system) 4lDO2 implemented cancellation on the `audiod` scheme
- (system) 4lDO2 updated the `audiod` daemon to use the `redox-scheme` library
- (system) bjorn3 fixed the ARM64 support on the `bootstrap` program
- (system) bjorn3 changed the boot order to start the `logd` daemon before the `fbbootlogd` daemon
- (system) bjorn3 implemented the support for new sink sources on the `logd` daemon
- (system) bjorn3 restored the relibc static linking on the Ion shell to improve the relibc and dynamic linker debugging
- (system) bjorn3 did a code cleanup on `userutils`
- (system) bjorn3 fixed warnings in some system components
- (relibc) bjorn3 added a workaround to fix an undefined behavior on ARM64
- (relibc) Josh Megnauth fixed a clobbering on the strptime() function following the musl and glibc behavior
- (net) 4lDO2 updated the DNS daemon (dnsd) to use the `redox-scheme` library
- (redoxfs) bjorn3 fixed the RedoxFS tests
- (redoxfs) bjorn3 did a code cleanup in RedoxFS
- (orbital) 4lDO2 updated Orbital to use the `redox-scheme` library
- (orbital) Dimitar Gjorgievski implemented GPU-based mouse cursor rendering in Orbital, improving VirtIO-GPU support
- (orbital) bjorn3 fixed a correctness bug in Orbital
- (orbital) bjorn3 improved the VirtIO-GPU support in Orbital
- (orbital) bjorn3 simplified the Orbital code
- (orbital) bjorn3 did a code cleanup on Orbital
- (pkg) Josh Megnauth replaced the unmaintained `plain`, `error-chain` and `user_error` libraries with the `bytemuck`, `anyhow` and `thiserror` libraries on `pkgar` for better error reporting
- (programs) Jeremy Soller fixed DevilutionX, FreeCiv, libicu and fontconfig recipes
- (programs) Jeremy Soller updated GStreamer, HarfBuzz, QEMU, GLib and libffi to the latest version
- (programs) Jeremy Soller enabled dynamic linking on the SDL2-image, SDL2-ttf, Cairo, liborbital, COSMIC Player, GStreamer, HarfBuzz, FreeType, pkg-config, Boxedwine, QEMU, GLib and libffi recipes
- (programs) Jeremy Soller enabled the POSIX thread semaphores on SDL1
- (programs) Jeremy Soller restored the PrBoom music (this bug was hard to fix...)
- (programs) Jeremy Soller converted the FreeCiv, SDL2-ttf and ncursesw recipes to TOML
- (build-system) Jeremy Soller implemented automatic shared dependency (dynamically-linked libraries) detection on Cookbook
- (hardware) Ralen Oreti documented the status of the Samsung Series 3 and ASUS Vivobook 15 OLED laptops
- (hardware) Collin M documented the status of the HP EliteBook Folio 9480m laptop
- (doc) Ribbon added [advanced instructions](https://doc.redox-os.org/book/troubleshooting.html#fix-breaking-changes) to fix common types of breaking changes in the book
- (doc) Miles Ramage did formatting improvements on the Chapter 4 of the book
- (doc) Miles Ramage and Ribbon improved and fixed the Chapter 2 of the book

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

- [Fosstodon @redox]()
- [Fosstodon @soller]()
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
