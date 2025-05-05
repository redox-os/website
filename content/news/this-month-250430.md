+++
title = "This Month in Redox - April 2025"
author = "Ribbon and Ron Williams"
date = "2025-04-30"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. April was a very exciting month for Redox! Here's all the latest news.

<a href="/img/screenshot/freeciv.png"><img class="img-responsive" alt="FreeCiv running on Redox" src="/img/screenshot/freeciv.png"/></a>

(FreeCiv running on Redox)

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Redox Summer of Code

It's that time of year again - Redox Summer of Code (RSoC) has engaged two students and one recent graduate for some exciting projects.
This year's projects are:
- Unix Domain Sockets - A warm welcome to Ibuki, who will be developing Unix Domain Sockets, including the ability to send file descriptors between processes. This is a key piece of functionality towards support for Wayland and D-Bus, which will eventually enable Linux desktop applications and many important accessibility features such as a screen reader.
- System Services Manager - Welcome back to Charlie, who was part of a Georgia Tech project to develop a System Health Monitor. Charlie will be continuing that work, and taking it to the next level, looking at our initialization, hardware platform services, PCI/PCIe driver initialization, and other aspects of how Redox services and drivers are started and managed.
- SpiderMonkey and Servo - And a warm welcome to Andrew, who will be porting SpiderMonkey and Servo to Redox. Redox's current browser is NetSurf, and it does not have full JavaScript support, so having support for SpiderMonkey and Servo will be a big step up for us.

Thank you to our generous donors, who help make Redox Summer of Code possible. Joshua "jduck" Drake of Magnetite Security, who is funding a full RSoC project, Nigel Stoppard, who has been giving generously every month to help us improve accessibility, and our many patrons on [Patreon](https://www.patreon.com/redox_os) and [Donorbox](https://donorbox.org/redox-os).

## Complete Userspace-based Process Manager

4lDO2 finished the userspace process manager, part of the NLnet/NGI Zero project [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/), fixing process and POSIX signals bugs in the process. The process manager is the backend for POSIX functions related to processes, process groups, sessions, threads, signals and similar.

In monolithic kernels this management is done in the kernel, resulting in necessary ambient authority, and possibly constrained interfaces if a stable ABI is to be guaranteed. With this userspace implementation, it will be easier to manage access rights using capabilities, reduce kernel bugs by keeping it simpler, and make changes where both sides of the interface can be updated simultaneously.

It also allowed the removal of 20 system calls from the kernel, and decreased the kernel binary size by 10%.

4lDO2's [FOSDEM talk on Redox Signals](https://fosdem.org/2025/schedule/event/fosdem-2025-5670-posix-signals-in-user-space-on-the-redox-microkernel/) is now online, although it is missing the first couple of minutes due to audio problems.
Check out his [FOSDEM overview of Redox](https://fosdem.org/2025/schedule/event/fosdem-2025-5973-redox-os-a-microkernel-based-unix-like-os/).

## Georgia Tech Service Monitor

This winter, a team of students from Georgia Tech has been developing a System Health Monitoring and Recovery daemon and user interface.
This software demonstrates how a microkernel OS can detect and restart services that crash or hang.
It also allows the configuration and disabling of system services,
gathering operational statistics, and other essential functionality.

A big thanks to Julianna, Devan, Donald, Matthew, Charlie and Thomas! Check out the video of their work.

<iframe width="800" height="450" src="https://www.youtube.com/embed/lzeUhNs34CU?si=Hitd2BpKpSzQU25e" title="Georgia Tech Service Monitor" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## All In One

Jeremy Soller enabled and fixed nightly builds on the build server for [packages](https://static.redox-os.org/pkg/) and [images](https://static.redox-os.org/img/) of the x86-64, i686, ARM64 and RISC-V architectures!!

Before it had bugs and flexibility problems that didn't allow it. Expect more build server package and image stability in the future.

## Minimality

Jeremy Soller enabled the `minimal` and `minimal-net` variants on the build server images, this allow testers and developers to easily test the smallest Redox variant for computers with a limited resources or to optimize Redox to use less resources.

## Better User Authentication Security

bjorn3 implemented the `sudo` daemon to replace the setuid bit and removed the `escalated` daemon to reduce the risk of privilege escalation vulnerabilities caused by bugs in setuid programs, quoting him:

"setuid is not a security issue in itself, but every setuid binary needs to be carefully written to avoid privilege escalation as it inherits an untrusted environment from the parent process. For example LD_PRELOAD needs to be ignored by the dynamic linker, PATH needs to be replaced with something trusted, and more. Containers also have bad interactions with setuid binaries. If you were to allow mount namespaces without any other isolation, you can easily trick a setuid binary into using a different config than it should. For example you could present a sudoers config to sudo that allows anyone to run any command as root without needing a password"

`sudo` and `su` now request the "sudo" daemon to elevate their privileges, after the daemon validates the user's credentials.
The `passwd` command delegates setting the user's password to the "sudo" daemon.
This eliminates all "setuid" programs from Redox.

## Bootloader Improvements

- (bootloader) Jeremy Soller fixed the RISC-V compilation
- (bootloader) Andrey Turkin fixed the RISC-V initialization

## Kernel Improvements

- (kernel) Jeremy Soller fixed the ARM64 and RISC-V support
- (kernel) 4lDO2 fixed a shared memory use-after-free fault, for userspace schemes both served and used in the same memory address space
- (kernel) 4lDO2 fixed the cancellation of the network stack schemes
- (kernel) 4lDO2 removed the `ITimer` scheme, which had always been merely a stub in the kernel
- (kernel) bjorn3 fixed the saving and restoring of float registers on ARM64
- (kernel) bjorn3 fixed a crash on GICv3 used for ARM64 serial debugging
- (kernel) bjorn3 improved the debugging by showing the PID of the process on unhandled exceptions

## Driver Improvements

- (drivers) Jeremy Soller implemented a timeout of 5 seconds on the NVMe driver initialization to restart the process when it fails, and to try to continue the boot process
- (drivers) Jeremy Soller did a cleanup of the memory read/write handler for the AML parser
- (drivers) bjorn3 updated the VESA driver (vesad) to disable the kernel graphical debugging as late as possible
- (drivers) bjorn3 partially fixed the ARM64 support on the PCI driver, interrupts still have issues
- (drivers) bjorn3 improved the error message when the hardware doesn't support ACPI

## System Improvements

- (system) 4lDO2 finished the userspace-based process manager and migrated necessary system components to use it
- (system) Jeremy Soller updated uutils to the latest commit
- (system) Darley Barreto started to implement the `openat()` POSIX function which allows file locations to be isolated from the program. It will replace the "named dup" calls, which are non-standard (not POSIX or Linux) so you can access a specific resource or get/set values of a certain category for a resource. Eventually, it will allow more secure filesystem operations.
- (system) 4lDO2 implemented a readiness-based I/O model wrapper for the completion-based I/O model to reduce boilerplate code in the `redox-scheme` library
- (system) 4lDO2 updated `escalated` to use the `redox-scheme` library and `SYS_CALL` system call, before the `sudo` daemon made it obsolete
- (system) 4lDO2 implemented cancellation for the Orbital scheme
- (system) 4lDO2 implemented cancellation for the `audiod` scheme
- (system) 4lDO2 updated the `audiod` daemon to use the `redox-scheme` library
- (system) bjorn3 fixed the ARM64 support on the `bootstrap` program
- (system) bjorn3 changed the boot order to start the `logd` daemon before the `fbbootlogd` daemon
- (system) bjorn3 implemented the support for new sink sources on the `logd` daemon
- (system) bjorn3 restored the relibc static linking on the Ion shell to improve the relibc and dynamic linker debugging
- (system) bjorn3 moved `bootstrap` and `initfs` to the `base` repository
- (system) bjorn3 did a code cleanup on `userutils`
- (system) bjorn3 fixed warnings in some system components

## Relibc Improvements

- (relibc) Jeremy Soller fixed the ARM64 and RISC-V support
- (relibc) Jeremy Soller fixed the dynamic linker support for multiple CPU architectures
- (relibc) Jeremy Soller added the libstdc++ library on the `base` configuration to fix the dynamic linker and simplify the dynamically linked recipes
- (relibc) Anhad Singh fixed the non-x86 CPU support on the [TCB](https://en.wikipedia.org/wiki/Thread_control_block) of the dynamic linker
- (relibc) bjorn3 did minor improvements to the efficiency and code quality of the `exec` implementation
- (relibc) Josh Megnauth removed an unnecessary data overwrite in the strptime() function, following the musl and glibc behavior, which also fixed a bug for compound date formats
- (relibc) Josh Megnauth implemented the [err.h](https://man.freebsd.org/cgi/man.cgi?err) BSD extension to simplify error messages (also supported by glibc and musl)
- (relibc) Josh Williams added partial POSIX signals tests

## Networking Improvements

- (net) 4lDO2 updated the DNS daemon (dnsd) to use the `redox-scheme` library

## RedoxFS Improvements

- (redoxfs) James Matlik fixed a regression where the filesystem couldn't write data after squashing the allocator log
- (redoxfs) bjorn3 fixed the RedoxFS tests
- (redoxfs) bjorn3 did a code cleanup in RedoxFS

## Orbital Improvements

- (orbital) Dimitar Gjorgievski implemented GPU-based mouse cursor rendering in Orbital, improving VirtIO-GPU support
- (orbital) bjorn3 updated Orbital to use the `redox-scheme` library
- (orbital) bjorn3 fixed a correctness bug in Orbital
- (orbital) bjorn3 fixed a bug where the cursor would be hidden behind OSDs when not using an hardware-accelerated mouse cursor
- (orbital) bjorn3 improved the VirtIO-GPU support in Orbital
- (orbital) bjorn3 simplified the code
- (orbital) bjorn3 did a code cleanup on Orbital

## Packaging Improvements

- (pkg) Josh Megnauth replaced the unmaintained `plain`, `error-chain` and `user_error` libraries with the `bytemuck`, `anyhow` and `thiserror` libraries on `pkgar` for better error reporting

## Programs

- (programs) Jeremy Soller fixed DevilutionX, FreeCiv, libicu and fontconfig recipes
- (programs) Jeremy Soller fixed GCC on RISC-V
- (programs) Jeremy Soller updated GStreamer, HarfBuzz, QEMU, GLib and libffi to the latest version
- (programs) Jeremy Soller enabled dynamic linking on the SDL2-image, SDL2-ttf, Cairo, liborbital, COSMIC Player, GStreamer, HarfBuzz, FreeType, pkg-config, Boxedwine, QEMU, GLib and libffi recipes
- (programs) Jeremy Soller enabled the POSIX thread semaphores on SDL1
- (programs) Jeremy Soller restored the PrBoom music (this bug was hard to fix...)
- (programs) Jeremy Soller converted the FreeCiv, SDL2-ttf and ncursesw recipes to TOML
- (programs) Jeremy Soller enabled the FreeCiv dedicated server
- (programs) Andrey Turkin fixed the ARM64 support from OpenSSL

## Build System Improvements

- (build-system) Jeremy Soller updated the Podman container configuration to use the Debian stable backports to update the build tool versions, fixing some programs
- (build-system) Jeremy Soller implemented automatic shared dependency (dynamically-linked libraries) detection on Cookbook and deprecated the `shared-deps` data type
- (build-system) Jeremy Soller deprecated the `COOKBOOK_PREFER_STATIC` environment variable in favor of `DYNAMIC_INIT`
- (build-system) Jeremy Soller updated the Redox build server to use Podman (using a Debian stable container with backports) instead of Ubuntu 22.04, fixing environment problems and outdated build tools
- (build-system) Jeremy Soller and Ron Williams improved the compilation and execution separation (host system vs. Podman container) of the build system tools in Podman Builds to fix bugs caused by potentially different software environments between the host system and Podman container
- (build-system) Jeremy Soller updated the `make clean` command to wipe the `prefix` folder, this allow breaking changes on the Redox toolchain to be easily fixed
- (build-system) bjorn3 did a cleanup

## Hardware Updates

- (hardware) Ralen Oreti documented the status of the Samsung Series 3 and ASUS Vivobook 15 OLED laptops
- (hardware) Collin M documented the status of the HP EliteBook Folio 9480m laptop

## Documentation Improvements

- (doc) Ribbon added [advanced instructions](https://doc.redox-os.org/book/troubleshooting.html#fix-breaking-changes) to fix common types of breaking changes in the book
- (doc) Ribbon added the RISC-V support on the website FAQ
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
