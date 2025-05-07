+++
title = "Redox OS 0.10.0"
author = "Ron Williams, Ribbon and Jeremy Soller"
date = "2025-03-01"
+++

Redox OS is an Unix-like general-purpose microkernel-based operating system written in Rust.

<!--
Image HTML Code

<a href="/img/screenshot/image-name.png"><img class="img-responsive" alt="Description" src="/img/screenshot/image-name.png"/></a>

-->

## Overview

The version 0.10.0 is packed with new features, improvements, bug fixes and cleanup. 

We would like to thank all maintainers and contributors whose hard work has made this release possible.

Here are just a few of the highlights!

- Complete dynamic linking support and process manager
- Better performance and stability
- Better hardware compatibility
- Better software compatibility
- More ported programs

## Donations and Funding

We are seeking community donations to support more full-time developers, we need the help of generous donors like you!

If you want to help support Redox development, you can make a donation to our [Patreon](https://www.patreon.com/redox_os), [Donorbox](https://donorbox.org/redox-os), or choose one of the other methods in our [Donate](https://redox-os.org/donate/) page.

You can also buy Redox merch (T-shirts, hoodies and mugs!) at our [Redox store](https://redox-os.creator-spring.com/).

If you know an organization or foundation that may be interested in supporting Redox, please contact us on Matrix or the email: donate@redox-os.org

## Fixed USB Input Support

Jeremy Soller has made substantial improvements to our USB xHCI driver, USB 3.x support and completed a USB hub driver. Our USB HID implementation has had some issues, and was not working in the 0.9.0 version. It is much better now, and can support more real-world hardware.

We would love your help testing external USB mouse and keyboards, as well as the keyboard and touchpad on your laptop, especially if they use USB internally instead of PS/2.
You can do this by [following the instructions below](#how-to-test-the-changes) to download the daily images.
Please be aware that we are bumping into a few other issues, so if the daily images don't boot for you today,
they may work better in the next few days.

Send a message in the [Support](https://matrix.to/#/#redox-support:matrix.org) room to let us know if it worked.
If you have problems, please provide the brand and model code, for both the computer and the device (mouse or keyboard).
Please join our [GitLab](https://doc.redox-os.org/book/signing-in-to-gitlab.html) and add your computer to our [Hardware Compatibility](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md?ref_type=heads) list, if you have the time.

## Fixed VirtualBox Support

The execution in a VirtualBox VM was fixed on this release, please test it and report any bugs that you find in the support room of our chat.

## NLnet Project - Process Manager

Redox was awarded a grant from [NLnet/NGI Zero](https://nlnet.nl/NGI0/) for our project [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/). The work has been conceived and implemented by 4lDO2, with backup from the Redox team.

The NGI grant is divided into (1) a signal handling part and (2) a process management part. The signal handling was largely completed last summer.
As part of the work on process management, 4lDO2 has recently made great progress towards re-implementing the Redox kernel/userspace runtime layer, _where the system can now start almost all daemons, and properly boot to prompt (both dynamically linked ion and static bash)_.
This means the concept of Process IDs is now entirely a userspace thing.

As well, the _process and signal services formerly accessible as specialized system calls, are now accessed via file descriptors_, using the thread and process fds which are now present in (virtually) every file table. This has allowed the removal of **close to 20** system calls from the Redox kernel, replacing them with messages to/from the process manager and other fd-based services.

Although there are some other performance bottlenecks related to process management, it is obviously preferable if this new set of changes does not significantly affect the performance of the full system. So far, no significant performance issues have been observed, but we will be doing benchmarking when the process management work is closer to completion. Eventually Redox may benefit from L4-like [synchronous IPC](https://microkerneldude.org/2019/03/07/how-to-and-how-not-to-use-sel4-ipc/), given the synchronous nature of POSIX functions in the proc category, but this is a bit farther in the future.

## Complete Userspace-based Process Manager

4lDO2 finished the userspace process manager, part of the NLnet/NGI Zero project [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/), fixing process and POSIX signals bugs in the process. The process manager is the backend for POSIX functions related to processes, process groups, sessions, threads, signals and similar.

In monolithic kernels this management is done in the kernel, resulting in necessary ambient authority, and possibly constrained interfaces if a stable ABI is to be guaranteed. With this userspace implementation, it will be easier to manage access rights using capabilities, reduce kernel bugs by keeping it simpler, and make changes where both sides of the interface can be updated simultaneously.

It also allowed the removal of 20 system calls from the kernel, and decreased the kernel binary size by 10%.

4lDO2's [FOSDEM talk on Redox Signals](https://fosdem.org/2025/schedule/event/fosdem-2025-5670-posix-signals-in-user-space-on-the-redox-microkernel/) is now online, although it is missing the first couple of minutes due to audio problems.
Check out his [FOSDEM overview of Redox](https://fosdem.org/2025/schedule/event/fosdem-2025-5973-redox-os-a-microkernel-based-unix-like-os/).

## Redox On RISC-V

RISC-V is now a supported target for Redox!

Andrey Turkin has done extensive work on RISC-V support in the kernel, toolchain and elsewhere.
Thanks very much Andrey for the excellent work!

Jeremy Soller has incorporated RISC-V support into the toolchain, build process and has begun some refactoring of the kernel and device drivers to better handle all the supported architectures, and has gotten the Orbital Desktop working when running in QEMU.

<a href="/img/screenshot/orbital-riscv64gc.png"><img class="img-responsive" alt="Orbital on RISC-V" src="/img/screenshot/orbital-riscv64gc.png"/></a>

<a href="/img/screenshot/riscv-terminal.png"><img class="img-responsive" alt="Terminal on RISC-V" src="/img/screenshot/riscv-terminal.png"/></a>

## Raspberry Pi 4 Is Booting

Jeremy Soller got the Raspberry Pi 4 board to show the Orbital login screen.
We still need to work on USB support to make it fully usable.

## Georgia Tech Service Monitor

This winter, a team of students from Georgia Tech has been developing a System Health Monitoring and Recovery daemon and user interface.
This software demonstrates how a microkernel OS can detect and restart services that crash or hang.
It also allows the configuration and disabling of system services,
gathering operational statistics, and other essential functionality.

A big thanks to Julianna, Devan, Donald, Matthew, Charlie and Thomas! Check out the video of their work.

<iframe width="800" height="450" src="https://www.youtube.com/embed/lzeUhNs34CU?si=Hitd2BpKpSzQU25e" title="Georgia Tech Service Monitor" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Better User Authentication Security

bjorn3 implemented the `sudo` daemon to replace the setuid bit and removed the `escalated` daemon to reduce the risk of privilege escalation vulnerabilities caused by bugs in setuid programs, quoting him:

"setuid is not a security issue in itself, but every setuid binary needs to be carefully written to avoid privilege escalation as it inherits an untrusted environment from the parent process. For example LD_PRELOAD needs to be ignored by the dynamic linker, PATH needs to be replaced with something trusted, and more. Containers also have bad interactions with setuid binaries. If you were to allow mount namespaces without any other isolation, you can easily trick a setuid binary into using a different config than it should. For example you could present a sudoers config to sudo that allows anyone to run any command as root without needing a password"

`sudo` and `su` now request the "sudo" daemon to elevate their privileges, after the daemon validates the user's credentials.
The `passwd` command delegates setting the user's password to the "sudo" daemon.
This eliminates all "setuid" programs from Redox.

## Redox On Redox

Andrey Turkin executed the RISC-V version of Redox Server from the [RVVM](https://github.com/LekKit/RVVM) RISC-V emulator running on the x86-64 version of Redox Desktop!!

Thanks again to LekKit for the awesome emulator!

<a href="/img/screenshot/redox-on-redox.png"><img class="img-responsive" alt="Redox On Redox" src="/img/screenshot/redox-on-redox.png"/></a>

## Dynamic Linking for Redox

Dynamic linking is an key part of our Stable ABI strategy, and will help us in our work towards self-hosted development. It will also result in faster compilation time and more space efficient userspace programs.
Read his [report on the work so far](/news/01_rsoc2024_dynamic_linker).

## Dynamic Linking

Thanks to Anhad Singh for his amazing work on Dynamic Linking!
In this southern-hemisphere-Redox-Summer-of-Code project,
Anhad has implemented dynamic linking as the default build method for many recipes,
and all new porting can use dynamic linking with relatively little effort.

This is a huge step forward for Redox,
because relibc can now become a stable ABI.
And having a stable ABI is one of the prerequisites for Redox to reach "Release 1.0".

Congratulations and many thanks Anhad!

## Toolchain Upgrade

The Rust compiler version was updated from 1.80 to 1.86 to fix many programs and libraries.

## Pkgar By Default

We finally enabled the `pkgar` package format by default and dropped the `tar.gz` packages, you can see all features and benefits of the `pkgar` package format below:

- Atomic - Updates are done atomically if possible
- Economical - Transfer of data must only occur when hashes change, allowing for
  network and data usage to be minimized
- Fast - Encryption and hashing algorithms are chosen for performance, and
  packages can potentially be extracted in parallel
- Minimal - Unlike other formats such as `tar`, the metadata included in a
  `pkgar` file is only what is required to extract the package
- Relocatable - Packages can be installed to any directory, by any user,
  provided the user can verify the package signature and has access to that
  directory.
- Secure - Packages are always cryptographically secure, and verification of all
  contents must occur before installation of a package completes.

## Podman By Default

Now Podman is our default build method in the Redox build system, it allows us to have a reproducible environment for all developers.

The Podman container is using Debian stable and prevents many bugs caused by build environment differences.

## COSMIC Alpha 7

COSMIC Desktop has just released [Alpha 7](https://blog.system76.com/post/cosmic-alpha-7)!
Redox includes COSMIC Editor, Files, Terminal and Store,
and the Redox daily build has all the latest improvements.

## COSMIC Store

The COSMIC Store was ported!

We updated our configuration files to be compliant with the FreeDesktop standards, this allowed the COSMIC Store to show and install our packages.

<a href="/img/screenshot/cosmic-store.png"><img class="img-responsive" alt="COSMIC Store running on Redox" src="/img/screenshot/cosmic-store.png"/></a>

## LOVE on Redox

Jeremy Soller ported the [LOVE](https://www.love2d.org/) game engine to Redox, to achieve this he did the following tasks:

- Ported the libmodplug, libtheora, and openal-soft libraries
- Fixed bugs and implemented some functions in relibc

You can see the [Balatro game](https://www.playbalatro.com/) running on Redox below:

<a href="/img/screenshot/balatro-redox.png"><img class="img-responsive" alt="Balatro on Redox" src="/img/screenshot/balatro-redox.png"/></a>

<a href="/img/screenshot/balatro-gameplay.png"><img class="img-responsive" alt="Balatro Gameplay" src="/img/screenshot/balatro-gameplay.png"/></a>

## All In One

Jeremy Soller enabled and fixed nightly builds on the build server for [packages](https://static.redox-os.org/pkg/) and [images](https://static.redox-os.org/img/) of the x86-64, i686, ARM64 and RISC-V architectures!!

Before it had bugs and flexibility problems that didn't allow it. Expect more build server package and image stability in the future.

## Minimality

Jeremy Soller enabled the `minimal` and `minimal-net` variants on the build server images, this allow testers and developers to easily test the smallest Redox variant for computers with a limited resources or to optimize Redox to use less resources.

## From Nothing To Hello World

Ribbon wrote a page to explain the most quick way to test Redox and run a "Hello World" program, have a look at [From Nothing To Hello World](https://doc.redox-os.org/book/nothing-to-hello-world.html) in the Redox Book.

## Overview Video

If you want to avoid the setup work of running Redox on real hardware or in a virtual machine, have a look at our [Software Showcase X]() where we show off programs running on Redox.

## Running Redox

It is recommended to try Redox OS in a virtual machine before trying on real hardware. See
the [supported hardware](https://www.redox-os.org/faq/#which-devices-does-redox-support) section for details on what
hardware to select for the best experience.

- Read [this](https://doc.redox-os.org/book/running-vm.html) page to learn how to run the Redox images in a virtual machine
- Read [this](https://doc.redox-os.org/book/real-hardware.html) page to learn how to run the Redox images on real hardware
- Read [this](https://doc.redox-os.org/book/installing.html) page to learn how to install Redox

### Demo

A 1536 MiB image containing the Orbital desktop environment as well as pre-installed demonstration programs.

- [Real Hardware Image](https://static.redox-os.org/releases/x.y.z/x86_64/redox_demo_x86_64_*_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/x.y.z/x86_64/redox_demo_x86_64_*_harddrive.img.zst)

The demo image includes these additional packages:

- [DOSBox](https://www.dosbox.com/) - A DOS emulator
- Games using PrBoom:
    - DOOM (Shareware)
    - [FreeDOOM](https://freedoom.github.io/)
- [Neverball and Neverputt](https://neverball.org/) - OpenGL games using LLVMPipe (performance may vary!)
- [orbclient](https://gitlab.redox-os.org/redox-os/orbclient) - An Orbital client demo
- [Periodic Table](https://gitlab.redox-os.org/redox-os/periodictable) - A program for viewing information about chemical elements
- [Terminal games](https://gitlab.redox-os.org/redox-os/games) - Command-line games
- [rodioplay](https://gitlab.redox-os.org/redox-os/rodioplay) - A FLAC/WAV music player
- [Sodium](https://gitlab.redox-os.org/redox-os/sodium): A vi-like text editor
- [sopwith](http://www.sopwith.org/): A classic PC air combat game
- syobonaction - A freeware platforming game

### Desktop

A 512 MiB image containing the Orbital desktop environment and some programs for common tasks. Use this if you want to download a smaller image.

- [Real Hardware](https://static.redox-os.org/releases/x.y.z/x86_64/redox_desktop_x86_64_*_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/x.y.z/x86_64/redox_desktop_x86_64_*_harddrive.img.zst)

### Server

A 512 MiB image containing only the command-line environment. Use this if the desktop image is not working well for you.

- [Real Hardware](https://static.redox-os.org/releases/x.y.z/x86_64/redox_server_x86_64_*_livedisk.iso.zst)
- [Virtual Machine Image](https://static.redox-os.org/releases/x.y.z/x86_64/redox_server_x86_64_*_harddrive.img.zst)

## This Month in Redox

The monthly reports offer more details about the changes present on this release post.

You can read them on the following links:

- [This Month in Redox - (Month) (Year)]()

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

## Changes

There have been quite a lot of changes since x.y.z. We have manually enumerated
what we think is important in this list. Links to exhaustive source-level change
details can be found in the [Changelog](#changelog) section.

## In Depth

The most important changes are shown below.

## Bootloader Improvements

- Jeremy Soller fixed the RISC-V compilation
- Andrey Turkin fixed the RISC-V initialization

## Kernel

- The time precision and reliability of TSC was improved
- A panic on `dirent` was fixed
- Andrey Turkin improved the panic stack trace handling and fixed some bugs
- Andrey Turkin fixed the RISC-V memory paging code in the `rmm` crate
- Andrey Turkin reduced the size of some CPU-specific code, simplifying portability to new CPU types and reducing the maintenance cost
- Andrey Turkin updated the `fdt` library to the latest version
- Andrey Turkin fixed a regression in the Raspberry Pi 3B support
- 4lDO2 reimplemented a scheme-related TLB optimization, that was temporarily removed as a result of [a fix](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/333) for a scheme bug prior to 0.9.0.
- 4lDO2 finished the queued POSIX signals implementation
- 4lDO2 fixed the bump allocator initialization
- 4lDO2 fixed the profiler
- 4lDO2 implemented the `SYS_CALL` system call to unify several different means of setting or getting parameters or invoking actions on a resource. It allows bidirectional read/write buffers, simplifying scheme logic for providing RPC-like interfaces, as well as replacing the dup+read/write+close pattern, and technically all scheme calls that don't send or receive file descriptors
- 4lDO2 fixed a shared memory use-after-free fault, for userspace schemes both served and used in the same memory address space
- 4lDO2 fixed the cancellation of the network stack schemes
- 4lDO2 removed the `ITimer` scheme, which had always been merely a stub in the kernel
- Ron Williams fixed a regression in the serial console login
- Ron Williams improved the `nanosleep()` system call to return the time remaining after a software interrupt
- James Francis added a small optimization to how the vector containing open files is resized
- Jeremy Soller fixed a bug on MSI that allowed Meteor Lake CPUs to boot with USB keyboard support
- Arthur Paulino refactored the `switch` function for extra clarity
- Zhouqi Jiang improved the [OpenSBI](https://github.com/riscv-software-src/opensbi) support for RISC-V
- Matej Bozic improved the consistency in memory page representation
- bjorn3 restored the legacy scheme path format deprecation warnings
- bjorn3 reduced the verbosity of debug logs on boot
- bjorn3 fixed the saving and restoring of float registers on ARM64
- bjorn3 fixed a crash on GICv3 used for ARM64 serial debugging
- bjorn3 improved the debugging by showing the PID of the process on unhandled exceptions
- Anhad Singh fixed the chunk size of the `ITimer` scheme
- Jeremy Soller fixed the ARM64 and RISC-V support

## ARM64

- Jeremy Soller enabled the ARM64 [packages](https://static.redox-os.org/pkg/aarch64-unknown-redox/) on the build server

## RISC-V

- Andrey Turkin sent the first batch of patches to implement the `riscv64gc-unknown-redox` triple on the Rust compiler fork of Redox
- Andrey Turkin implemented the RISC-V target on the build system
- Andrey Turkin added RISC-V code on most user-space components
- Jeremy Soller enabled the RISC-V [toolchain](https://static.redox-os.org/toolchain/riscv64gc-unknown-redox/) and [packages](https://static.redox-os.org/pkg/riscv64gc-unknown-redox/) on the build server

## Drivers

- Tim Finnegan fixed a kernel panic due to an unitialized PCI BAR
- Tim Finnegan fixed a deadlock on the USB device initialization
- Ivan Tan updated the SD card reader driver for Raspberry Pi boards to use the version 2 of the scheme protocol.
- Andrey Turkin sent initial code for RISC-V support on drivers
- Andrey Turkin fixed the BCM2835 driver (Raspberry Pi 3 B+)
- Kamil Koczurek updated the ACPI driver to serialize symbols to RON
- Kamil Koczurek updated the ACPI driver to use the new `redox_scheme` library
- bjorn3 did many improvements and cleanup on video drivers
- bjorn3 did many refactorings on the graphics and input subsystems
- bjorn3 migrated all video drivers to the `redox-scheme` library
- bjorn3 created the `driver-graphics` and `graphics-ipc` libraries to unify code
- bjorn3 reduced the `fbcond` daemon and created the `fbbootlogd` daemon to fix boot deadlocks
- bjorn3 removed blocking on any graphics driver
- bjorn3 updated the `redox-scheme` library version
- bjorn3 fixed some warnings
- bjorn3 simplified the `fbbootlogd` daemon code
- bjorn3 fixed the standalone compilation of the `driver-network` library
- bjorn3 fixed the PCI/PCIe device function scanning
- bjorn3 fixed potential misbehavior in future versions of the Rust compiler
- bjorn3 removed unnecessary feature gates
- bjorn3 did some code refactorings
- bjorn3 reduced code duplication
- bjorn3 updated the USB xHCI drivers to use the `redox-scheme` library
- bjorn3 updated the `inputd` daemon to use the `redox-scheme` library
- bjorn3 updated all drivers and daemons to the 0.4 version of the `redox-scheme` library
- bjorn3 moved the PCI driver spawning to the pci-spawner daemon
- bjorn3 fixed the `fbbootlogd` daemon crash which was causing occasional system components and drivers to crash, and it allows you to login on a serial console
- bjorn3 fixed a random crash on the VirtIO-GPU driver
- bjorn3 fixed the damage calculation on the display drawing
- bjorn3 improved the virtual terminal creation and fixed a bug where consumers couldn't get a virtual terminal because it was not available
- bjorn3 improved the handling when the boot framebuffer is missing
- bjorn3 did lots of general code cleanup
- bjorn3 did some refactorings and cleanup on the `inputd` daemon
- bjorn3 did a code cleanup on the `fbbootlogd` and `fbcond` daemons
- bjorn3 implemented a global graphics driver to replace the graphics driver on each virtual terminal on the `inputd` daemon
- bjorn3 did a cleanup of the MBR/GPT library
- bjorn3 reduced the code duplication on storage drivers
- bjorn3 improved the graphics subsystem API
- bjorn3 unified most of the scheme code on storage drivers
- bjorn3 moved the aborts of drivers to the `pcid` daemon, simplifying the drivers
- bjorn3 removed the archaic IBM PC speaker driver
- bjorn3 reduced the verbosity of debug logs on boot
- bjorn3 updated the VESA driver (vesad) to disable the kernel graphical debugging as late as possible
- bjorn3 partially fixed the ARM64 support on the PCI driver, interrupts still have issues
- bjorn3 improved the error message when the hardware doesn't support ACPI
- bjorn3 improved the `fmt.sh` script to apply code formatting in all drivers and libraries with Cargo
- 4lDO2 added the x86 real-time clock (RTC) driver in userspace, moving it out of the kernel. ARM and RISC-V RTC still need to be moved.
- 4lDO2 started to implement asynchronous support for the NVMe driver which improved performance by about 13-14%
- Alice Shelton fixed the Intel HD Audio driver initialization
- Alice Shelton fixed the PS/2 touchpad support on some laptops
- Jeremy Soller implemented a timeout of 5 seconds on the NVMe driver initialization to restart the process when it fails, and to try to continue the boot process
- Jeremy Soller did a cleanup of the memory read/write handler for the AML parser

## VirtIO

bjorn3 has been working on improvements to the VirtIO-GPU driver.

- bjorn3 improved the VirtIO-GPU driver to allow Redox guest video size to follow the QEMU window size on the host system, currently it only use the window size before boot, post-boot window resizing will be implemented soon
- bjorn3 fixed a crash on the driver when multiple displays are attached
- bjorn3 fixed a memory bug and improved the driver performance

## USB

- Tim Finnegan improved the xHCI driver behavior to be more compliant with the USB standard
- Tim Finnegan improved the xHCI driver documentation
- Jeremy Soller fixed the USB hub driver
- Jeremy Soller fixed the xHCI driver
- Jeremy Soller fixed the USB 3.x support for input devices
- bjorn3 fixed the USB 3.x support for storage devices (currently only tested on QEMU)

## System

- The contributor rm-dr did a cleanup on RedoxFS
- bjorn3 implemented `sendfd` handling on the `redox-scheme` library
- bjorn3 fixed a deadlock on the `logd` daemon
- bjorn3 updated Orbital and the audio daemon (audiod) to use the new scheme path format
- bjorn3 unified the architecture-specific commands for the init configuration
- bjorn3 removed the pollution of the system environment by an unused environment variable in the boot loader
- bjorn3 removed some obsolete code in the `ptyd`, `logd`, `ramfs` and, `zerod` daemons
- bjorn3 fixed the ARM64 support on the `bootstrap` program
- bjorn3 changed the boot order to start the `logd` daemon before the `fbbootlogd` daemon
- bjorn3 implemented the support for new sink sources on the `logd` daemon
- bjorn3 restored the relibc static linking on the Ion shell to improve the relibc and dynamic linker debugging
- bjorn3 moved `bootstrap` and `initfs` to the `base` repository
- bjorn3 did a code cleanup on `userutils`
- bjorn3 fixed warnings in some system components
- bjorn3 improved error messages for the `init` command shell
- Tim Crawford updated the `redox_hwio` library to the Rust 2021 edition
- Tim Crawford removed the support for non-x86 architectures on PIO from the `redox_hwio` library
- Anhad Singh implemented dynamic linking support on the `liborbital` library
- Ron Williams updated the `bootstrap` program to use the 0.2.3 version of the `redox-scheme` library and other new library versions
- Ron Williams updated the libraries of the `escalated` daemon to fix bugs
- Ron Williams updated the `ptyd` daemon to use the latest version of the `redox-scheme` library
- 4lDO2 improved the logic of the `shutdown` tool
- 4lDO2 implemented a way to install Redox in a partition instead of the entire storage device in the installer
- 4lDO2 finished the userspace-based process manager and migrated necessary system components to use it
- 4lDO2 implemented a readiness-based I/O model wrapper for the completion-based I/O model to reduce boilerplate code in the `redox-scheme` library
- 4lDO2 updated `escalated` to use the `redox-scheme` library and `SYS_CALL` system call, before the `sudo` daemon made it obsolete
- 4lDO2 implemented cancellation for the Orbital scheme
- 4lDO2 implemented cancellation for the `audiod` scheme
- 4lDO2 updated the `audiod` daemon to use the `redox-scheme` library
- Jeremy Soller updated uutils to the latest commit
- Darley Barreto started to implement the `openat()` POSIX function which allows file locations to be isolated from the program. It will replace the "named dup" calls, which are non-standard (not POSIX or Linux) so you can access a specific resource or get/set values of a certain category for a resource. Eventually, it will allow more secure filesystem operations.

## Relibc

- The `endian` function was implemented
- The `poll` system call was improved to follow the Linux behavior more accurately
- A stub for `net/if.h` was added
- The ability to choose the default scheme was implemented (when translating paths that don't have an explicit scheme, usually "/scheme/file" or "/scheme/initfs")
- 4lDO2 merged the support for real-time POSIX signals
- 4lDO2 changed the PAL (POSIX Abstraction Layer) component to use Rusty error handling. This means that the interface to both Redox and Linux stays in safe Rust as long as possible, pushing the C-style error handling into the interface layers.
- 4lDO2 moved `umask` to a regular global variable
- 4lDO2 added a test for the `sigaltstack` function
- 4lDO2 added code to cope with legacy schemes until they are updated
- plimkilde implemented a way to use Rust iterators on C-style strings
- plimkilde refactored the `strcasecmp` and `strncasecmp` functions with iterators
- plimkilde documented more functions
- plimkilde implemented the `memmem()` and `pvalloc()` functions
- plimkilde implemented the `iso686` function group and its tests
- plimkilde added a test for errno constant macros
- plimkilde allowed `ENOTSUP` to be available for Rust programs
- plimkilde added stubs for all missing functions from POSIX 2024
- plimkilde removed an unnecessary intrinsic in calloc
- plimkilde documented the `stdlib.h`, `crypt.h`, `elf.h`, `inttypes.h`, `pty.h`, `utmp.h`, `string.h`, `pwd.h`, `sys/random.h`, `sys/auxv.h`, `sys/file.h`, `dirent.h`, `arpa/inet.h`, `unistd.h`, `netinet/in.h`, `netinet/ip.h` and `netinet/tcp.h` function groups
- plimkilde reimplemented the `memcpy()` function using slices instead of raw pointers, fixed unaligned read/write and added a test
- plimkilde added TODOs for the remaining POSIX functions
- plimkilde implemented a way to test deprecated functions
- plimkilde added documentation and deprecations for the sys/time.h function group
- plimkilde added documentation, deprecations and missing functions for the strings.h function group
- plimkilde fixed the type of the clock_id parameter on the clock_getcpuclockid() function
- Ron Williams fixed detection of errors during the `cbindgen` header building
- Ron Williams improved the tests to make them easier to run on Redox
- Ron Williams fixed the `popen()` function and fixed/improved its tests
- Ron Williams fixed the sigqueue() function test
- Ron Williams fixed the interrupt handling of the `nanosleep` and `sleep` functions
- Ron Williams fixed the `alarm` function to match the POSIX specification
- Josh Megnauth fixed a panic with programs or games using deprecated POSIX functions
- Josh Megnauth fixed a multiplication overflow on the `setsockopt` function
- Josh Megnauth fixed a buffer overrun when parsing DNS
- Josh Megnauth removed unnecessary memory over-allocations and reallocations
- Josh Megnauth improved the generated C code for the return value of the `exit` functions
- Josh Megnauth allowed `cbindgen` to emit C attributes
- Josh Megnauth fixed a memory overflow
- Josh Megnauth fixed the shebang implementation
- Josh Megnauth implemented missing structs on `netinet.h` function group
- Josh Megnauth implemented the `stdnoreturn.h` function group
- Josh Megnauth removed an obsolete workaround for `varargs`
- Josh Megnauth fixed the wrong signature of the vsscanf() function emitted by cbindgen
- Josh Megnauth implemented the support for arguments on shebangs
- Josh Megnauth implemented support for "ISO-8601 leap weeks" in the strftime() function
- Josh Megnauth implemented the `%T` format and did cleanups in the strptime() function
- Josh Megnauth removed an unnecessary data overwrite in the strptime() function, following the musl and glibc behavior, which also fixed a bug for compound date formats
- Josh Megnauth implemented the [err.h](https://man.freebsd.org/cgi/man.cgi?err) BSD extension to simplify error messages (also supported by glibc and musl)
- Josh Megnauth updated the code to use C string literals
- Josh Megnauth added tests for the strptime() function
- Josh Megnauth deprecated `c_str!`
- Anhad Singh fixed the dynamic linker
- Anhad Singh implemented lazy binding and scopes on the dynamic linker
- Anhad Singh implemented dynamic linker configuration through environment variables
- Anhad Singh fixed a delay on the Makefile
- Anhad Singh improved the debugging
- Anhad Singh improved the dynamic linker performance up to 1000%
- Anhad Singh fixed undefined behavior on the error handling
- Anhad Singh fixed the dynamic linker's copy relocations
- Anhad Singh implemented `DT_RELR` on the dynamic linker
- Anhad Singh fixed the dynamic linker multi-threading
- Guillaume Gielly implemented the `tar.h` and `monetary.h` function groups
- Guillaume Gielly implemented the `strfmon()` function
- Darley Barreto implemented missing functions on the `string.h` function group
- Darley Barreto implemented the `tzset` function
- Darley Barreto implemented timezone awareness
- Darley Barreto implemented the `z` and `Z` timezone formats and fixed how day of the year is shown for the `j` format (which is 1 based) on the strftime() function
- Darley Barreto improved the time.h function group
- Guillaume Gielly implemented the `langinfo.h` function group
- Guillaume Gielly refactored the `strftime()` function to use the `langinfo` constants
- Nicolás Antinori implemented the wscanf(), swscanf(), vswscanf() and vwscanf() functions
- Nicolás Antinori updated the `posix-regex` library to fix a bug
- bjorn3 fixed the ARM64 and RISC-V compilation
- bjorn3 improved the correctness of a function
- bjorn3 did minor improvements to the efficiency and code quality of the `exec` implementation
- bjorn3 fixed some warnings
- Satoru Shimizu implemented the `%b` and `%B` formats in the printf() function
- Satoru Shimizu documented the format of the printf() function
- bitstr0m implemented the `cpio.h` and `glob.h` function groups
- Bendeguz Pisch implemented the `sigsetjmp` and `siglongjmp` functions
- Jeremy Soller implemented the `setlinebuf()` function
- Jeremy Soller fixed the ARM64 and RISC-V support
- Jeremy Soller fixed the dynamic linker support for multiple CPU architectures
- Jeremy Soller added the libstdc++ library on the `base` configuration to fix the dynamic linker and simplify the dynamically linked recipes
- Anhad Singh fixed the non-x86 CPU support on the [TCB](https://en.wikipedia.org/wiki/Thread_control_block) of the dynamic linker
- Josh Williams added partial POSIX signals tests

## RedoxFS

- Andrey Turkin fixed a troublesome bug on the FUSE backend, which was causing issues with both the build and CI
- James Matlik fixed a tree node leak on file deletion
- James Matlik implemented a garbage collector for the allocation log to prevent it from growing excessively
- James Matlik fixed a regression where the filesystem couldn't write data after squashing the allocator log
- bjorn3 fixed the RedoxFS tests
- bjorn3 did a code cleanup in RedoxFS

## Schemes

- 4lDO2 replaced the close() scheme call by a one-way message
- 4lDO2 implemented the `/sys/fdstat` scheme resource to know the percentage of file descriptors shared between multiple processes
- Vincent Berthier implemented the `/sys/stat` scheme resource (`/proc/stat` equivalent)
- bjorn3 implemented the `/pci/` scheme, partially based on an earlier attempt by 4lDO2. Quoting bjorn3 from GitLab:

"This allows a single PCI daemon to run on the whole system, prevents multiple drivers from claiming the same PCI device and makes it possible for userspace to enumerate all available PCI devices. In the future this will enable an `lspci` tool, possibly PCIe hot plugging and more"

## Networking

- Steffen Butzer fixed some bugs in the implementation of the Address Resolution Protocol
- Guillaume Gielly implemented the `ifconfig` tool for network management on the Redox network stack
- Guillaume Gielly improved the `ping` tool
- Guillaume Gielly did a code cleanup and fixed compilation warnings
- Guillaume Gielly fixed the DHCP server identifier
- Guillaume Gielly fixed the time calculation of the `ping` tool
- bjorn3 enabled the CUBIC congestion control which improved network performance by up to 35%
- bjorn3 did a code cleanup and fixed many warnings
- Josh Megnauth fixed an overflow on `MAX_DURATION`
- 4lDO2 updated the DNS daemon (dnsd) to use the `redox-scheme` library

## Packaging Improvements

- Josh Megnauth updated the `pkgar` library to Rust 2021 and fixed most compilation warnings
- Josh Megnauth replaced the unmaintained `plain`, `error-chain` and `user_error` libraries with the `bytemuck`, `anyhow` and `thiserror` libraries on `pkgar` for better error reporting
- Marika added an explicit error message when some package manager command is executed with insufficient permissions

## Orbital Improvements

- Dimitar Gjorgievski implemented GPU-based mouse cursor rendering, improving VirtIO-GPU support
- bjorn3 updated Orbital to use the `redox-scheme` library
- bjorn3 fixed a correctness bug
- bjorn3 fixed a bug where the cursor would be hidden behind OSDs when not using an hardware-accelerated mouse cursor
- bjorn3 improved the VirtIO-GPU support
- bjorn3 simplified the code
- bjorn3 did a code cleanup

## Tests

- Ron Williams created the [Benchmarks](https://gitlab.redox-os.org/redox-os/benchmarks) repository and recipe to measure and record our performance data history

## Programs

- The `dd` tool from uutils was fixed
- 4lDO2 fixed pipe event handling, which was causing issues in RustPython
- Bendeguz Pisch fixed the Perl 5 recipe
- Tim Finnegan started the [Dropbear SSH](https://matt.ucc.asn.au/dropbear/dropbear.html) porting
- LekKit ported the [RVVM](https://github.com/LekKit/RVVM) RISC-V emulator to Redox. Thanks LekKit!
- bitstr0m ported LuaJIT
- bitstr0m fixed the libevent compilation
- Josh Megnauth ported the [QuakeSpasm](https://github.com/sezero/quakespasm) engine
- Josh Megnauth ported the [OpenTyrian](https://github.com/opentyrian/opentyrian) game
- Josh Megnauth ported the GLEW library
- Josh Megnauth updated OpenJazz to the latest version and converted the recipe configuration to TOML
- Josh Megnauth fixed and updated Lua
- Josh Megnauth ported the LZ4 compressor
- Josh Megnauth fixed GLib
- Josh Megnauth added a demo for OpenJazz
- Josh Megnauth improved the portability of GNU programs
- Josh Megnauth simplified the GNU Make recipe configuration
- Josh Megnauth partially ported the Boost library
- Josh Megnauth updated the libpng, bzip2 and DevilutionX recipes to support dynamic linking
- Josh Megnauth fixed the Vim compilation, fixed the download link, updated to the version 8.2 and converted the recipe to TOML
- Josh Megnauth fixed and updated the MPFR library to the 4.2.2 version
- Josh Megnauth fixed the `libuv` library
- Josh Megnauth simplified the OpenTyrian recipe configuration
- Ribbon successsfully compiled more Rust programs and demos
- Amir Ghazanfari improved the Sodium file selection
- Amir Ghazanfari improved the process to quit the Sodium text editor
- Ron Williams fixed a GNU Bash glob regression
- Ron Williams fixed the Git recipe
- Ron Williams fixed the dynamic linking of the curl recipe
- Jeremy Soller ported the LOVE game engine
- Jeremy Soller ported the libmodplug, libtheora and openal-soft libraries
- Jeremy Soller converted the Git recipe to TOML
- Jeremy Soller fixed our `sudo` implementation, where the "setuid" bit was lost during package installation
- Jeremy Soller fixed DevilutionX, FreeCiv, libicu and fontconfig recipes
- Jeremy Soller fixed GCC on RISC-V
- Jeremy Soller updated GStreamer, HarfBuzz, QEMU, GLib and libffi to the latest version
- Jeremy Soller enabled dynamic linking on the SDL2-image, SDL2-ttf, Cairo, liborbital, COSMIC Player, GStreamer, HarfBuzz, FreeType, pkg-config, Boxedwine, QEMU, GLib and libffi recipes
- Jeremy Soller enabled the POSIX thread semaphores on SDL1
- Jeremy Soller restored the PrBoom music (this bug was hard to fix...)
- Jeremy Soller converted the FreeCiv, SDL2-ttf and ncursesw recipes to TOML
- Jeremy Soller enabled the FreeCiv dedicated server
- Anhad Singh ported the [patchelf](https://github.com/NixOS/patchelf) tool
- Anhad Singh updated more recipes to support dynamic linking
- Anhad Singh converted the PrBoom and terminfo recipes to TOML
- Anhad Singh updated the Cargo, LLVM, Rust, libssh2, OpenSSL, zlib, COSMIC Terminal and NetSurf recipes to support dynamic linking
- Anhad Singh updated the Rust and OpenSSL forks to allow dynamic linking
- Leny implemented dynamic linking support on the LuaJIT recipe
- bjorn3 did a code cleanup in our `sudo` implementation
- bjorn3 updated our OpenSSL, libsodium forks and the Orbital utilities to use the new scheme path format
- Andrey Turkin fixed the ARM64 support from OpenSSL

## Terminal

- Orhun Parmaksiz implemented the [NO_COLOR](https://no-color.org/) environment variable on the termion library
- Vlad implemented a way to get the terminal size from an alternative file descriptor

## Ion

- The `$HOME` to `~` replacement was fixed

## Build System

- Podman was enabled by default
- The `path` data type was implemented on Cookbook to specify a local folder, it reduce the size of scripts
- The `libtool` dependency on the Podman container was fixed
- OpenSSH was installed on the Podman container for developers using SSH
- Ribbon fixed FUSE on Podman
- Ribbon fixed the Debian/Ubuntu target on the `native_bootstrap.sh` script
- Ribbon enabled the installation of GNU Debugger by default on the Podman and Native builds, with support for multiple CPU architectures in some Linux distributions and Unix-like systems
- 4lDO2 modernized the installer code and implemented support for local binary packages
- 4lDO2 added support for kernel unit tests in CI. For real QEMU-based CI testing, Redoxer will need to be fixed
- Jeremy Soller fixed the pre-built packages installation not working after the pkgar transition
- Jeremy Soller updated the Podman container configuration to use the Debian stable backports to update the build tool versions, fixing some programs
- Jeremy Soller implemented automatic shared dependency (dynamically-linked libraries) detection on Cookbook and deprecated the `shared-deps` data type
- Jeremy Soller deprecated the `COOKBOOK_PREFER_STATIC` environment variable in favor of `DYNAMIC_INIT`
- Jeremy Soller updated the Redox build server to use Podman (using a Debian stable container with backports) instead of Ubuntu 22.04, fixing environment problems and outdated build tools
- Jeremy Soller and Ron Williams improved the compilation and execution separation (host system vs. Podman container) of the build system tools in Podman Builds to fix bugs caused by potentially different software environments between the host system and Podman container
- Jeremy Soller updated the `make clean` command to wipe the `prefix` folder, this allow breaking changes on the Redox toolchain to be easily fixed
- Andrey Turkin packaged all toolchains on the Docker image
- Andrey Turkin fixed some linker warnings on the GCC fork
- Andrey Turkin fixed the recipe operations on the installer after `pkgutils` removal
- Andrey Turkin fixed the configuration for Raspberry Pi 3B emulation on QEMU
- Ron Williams allowed the installer error handling to show the package name when a pre-built package can't be found on the Redox build server
- Ron Williams added some recipes on the build server configuration to allow the `desktop` variant image to be created with downloaded pre-built packages
- Ron Williams implemented the `"source"` value as an alternative for `"recipe"` in the filesystem config files when the `REPO_BINARY` environment variable is enabled, to reduce confusion
- Ron Williams improved the error messages from the installer
- Ron Williams fixed a toolchain desynchronization
- Ron Williams updated the Cookbook dependencies to the latest version
- Anhad Singh implemented dynamic linking functions on Cookbook
- Anhad Singh implement a way to install the runtime dependencies of recipes using the installer
- Anhad Singh implemented the support for dynamic linking on Cookbook
- Anhad Singh implemented a switch to enable/disable static linking
- Anhad Singh implemented a recipe data type (`shared-deps`) for dynamically linked libraries
- Anhad Singh updated the Redoxer version
- Anhad Singh fixed the Cookbook runtime dependencies support
- Anhad Singh fixed the build server (CI) Makefile to support dynamic linking
- Anhad Singh added the "patchelf" tool on the Podman container
- bjorn3 started a build system unification for system components to allow faster contributions and more configuration flexibility
- bjorn3 fixed the QEMU configuration for when multiple displays are attached to the GPU
- bjorn3 continued the migration of drivers into a unified `base` package, including the network stack (netstack) and the audio daemon (audiod). This substantially simplifies driver development and common-code improvements.
- bjorn3 fixed the leaking of environment variables from a recipe into the overall build scope
- bjorn3 did a cleanup
- Vincent Berthier implemented a [Nix flake](https://nixos.wiki/wiki/flakes) for the Podman build
- Leny implemented the GNU patch support for recipes using Git repositories
- Josh Megnauth replaced the SHA256 hash by a BLAKE3 hash on the Cookbook unit tests
- Daniel Axtens fixed the bootstrapping on Ubuntu 24.04
- Leandro Santiago allowed the Podman build to be used when SELinux is disabled

## Hardware Updates

- Ralen Oreti documented the status of the Samsung Series 3 and ASUS Vivobook 15 OLED laptops
- Collin M documented the status of the HP EliteBook Folio 9480m laptop

## Documentation

- The boot process documentation was improved
- 4lDO2 clarified the [system call explanation](https://doc.redox-os.org/book/how-redox-compares.html#system-calls) to address the confusion with POSIX "system calls" and Linux system calls
- Ribbon updated the "Documentation" page of the website to add the `libredox` documentation and remove the `redox_syscall` documentation.
- Ribbon added the "Benchmarks" section on the "Performance" page of the book to explain how to do simple benchmarks on Redox, you can read the section on [this](https://doc.redox-os.org/book/performance.html#benchmarks) link
- Ribbon documented how to get the [CPU information](https://doc.redox-os.org/book/tasks.html#show-cpu-information) and [show the system log](https://doc.redox-os.org/book/tasks.html#show-the-system-log) in the [Tasks](https://doc.redox-os.org/book/tasks.html) page
- Ribbon removed the chapter numbers from the page names to remove the maintenance cost to move pages on the book summary.
- Ribbon moved the items of the [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) document to status tables that are much more easy to maintain (thanks for the suggestion contributor J. Craft)
- Ribbon [explained](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md#why-hardware-reports-are-needed) why we need hardware reports
- Ribbon explained the design and benefits of the Redox package management on the [Package Management](https://doc.redox-os.org/book/package-management.html) page
- Ribbon fixed problems on the tutorial from the [From Nothing to Hello World](https://doc.redox-os.org/book/nothing-to-hello-world.html) page, please read the page again
- Ribbon improved the [Security](https://doc.redox-os.org/book/security.html) page with more information
- Ribbon improved the documentation for accessibility
- Ribbon documented how to [download the relibc sources](https://gitlab.redox-os.org/redox-os/relibc#download-the-sources) and [build it](https://gitlab.redox-os.org/redox-os/relibc#build-instructions)
- Ribbon documented [how to mount a RedoxFS partition](https://gitlab.redox-os.org/redox-os/redoxfs#how-to-mount-a-partition)
- Ribbon improved the README of most system components to include guidance on how to contribute and do Redox development,
to encourage people to read and follow the method in the [Redox book](https://doc.redox-os.org/book/)
- Ribbon documented the [system communication with programs](https://doc.redox-os.org/book/communication.html)
- Ribbon made a correction on the "Configuration Settings" page
- Ribbon added [advanced instructions](https://doc.redox-os.org/book/troubleshooting.html#fix-breaking-changes) to fix common types of breaking changes in the book
- Ribbon added the RISC-V support on the website FAQ
- Jeffrey Carter fixed the Raspberry Pi build instructions
- Brandon Konkle removed all outdated references for the `vga=no` option
- David Pfeiffer added a hardware report for the Lenovo Yoga S730-13IWL computer
- Matthew Croughan added a hardware report for the HP Compaq NC6120 computer
- The contributor rm-dr improved the RedoxFS code documentation
- Jack Lin fixed broken links on the Cookbook README
- Ron Williams implemented a test for unused pages on the Redox book
- Ron Williams improved the chat documentation
- Ron Williams documented [how to do system call tracing on Redox](https://doc.redox-os.org/book/syscall-debug.html)
- Ron Williams and Ribbon updated the [Redox Summer Of Code project suggestions](https://www.redox-os.org/rsoc-project-suggestions)
- Anhad Singh documented the [recipe dynamic linking configuration](https://doc.redox-os.org/book/porting-applications.html#dynamically-linked-programs)
- Andrew Lygin fixed typos on the book
- Ronald Weber removed a leftover from the redox repository README
- Jesper Moller fixed a broken link on the drivers repository README
- Hubert Kwitowski replaced the PeaZip recommendation by 7-Zip to extract the Redox images on Windows
- Hubert Kwitowski documented the SHA256 checksum hashes of the Redox daily images
- Vadim Vodopolov fixed a wrong link in the "Introduction" page of the book
- Vincent Berthier documented the process to use the Podman build on NixOS
- Artur Assis improved the diagram on the [Stitching it all together](https://doc.redox-os.org/book/stitching-it-all-together.html) page
- Miles Ramage improved and did a cleanup on the "Configuration Settings" page
- Miles Ramage did formatting improvements on the Chapter 4 of the book
- Miles Ramage and Ribbon improved and fixed the Chapter 2 of the book

## Art

Ribbon packaged the Ubuntu wallpapers from most recent versions and PopOS wallpapers.

## Changelog

As many changes happened it's not possible to write everything on this post, this section contains all commits since the 0.8.0 version generated by the [changelog](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/changelog.sh) script:

- [redox](https://gitlab.redox-os.org/redox-os/redox/-/compare/first-8-values-current-commit-hash...f2fc8e6)
- [cookbook](https://gitlab.redox-os.org/redox-os/cookbook/-/compare/first-8-values-current-commit-hash...29bf5784)
- [audiod](https://gitlab.redox-os.org/redox-os/audiod/-/compare/first-8-values-current-commit-hash...f7c2426)
- [bootloader](https://gitlab.redox-os.org/redox-os/bootloader/-/compare/first-8-values-current-commit-hash...c7588a1)
- [bootstrap](https://gitlab.redox-os.org/redox-os/bootstrap/-/compare/first-8-values-current-commit-hash...94ac220)
- [ca-certificates](https://gitlab.redox-os.org/redox-os/ca-certificates/-/compare/first-8-values-current-commit-hash...4df67f2)
- [contain](https://gitlab.redox-os.org/redox-os/contain/-/compare/first-8-values-current-commit-hash...e6b8856)
- [coreutils](https://gitlab.redox-os.org/redox-os/coreutils/-/compare/first-8-values-current-commit-hash...b52a1b2)
- [cosmic-edit](https://github.com/pop-os/cosmic-edit)
- [cosmic-files](https://github.com/pop-os/cosmic-files)
- [cosmic-icons](https://github.com/pop-os/cosmic-icons)
- [cosmic-term](https://github.com/pop-os/cosmic-term)
- [curl](https://gitlab.redox-os.org/redox-os/curl/-/compare/first-8-values-current-commit-hash...f50c28394)
- [drivers](https://gitlab.redox-os.org/redox-os/drivers/-/compare/first-8-values-current-commit-hash...897866d)
- [escalated](https://gitlab.redox-os.org/redox-os/escalated/-/compare/first-8-values-current-commit-hash...06fe299)
- [extrautils](https://gitlab.redox-os.org/redox-os/extrautils/-/compare/first-8-values-current-commit-hash...2218a14)
- [findutils](https://gitlab.redox-os.org/redox-os/findutils/-/compare/first-8-values-current-commit-hash...116c044)
- [initfs](https://gitlab.redox-os.org/redox-os/redox-initfs/-/compare/first-8-values-current-commit-hash...7dd9b2e)
- [installer](https://gitlab.redox-os.org/redox-os/installer/-/compare/first-8-values-current-commit-hash...087810a)
- [installer-gui](https://gitlab.redox-os.org/redox-os/installer-gui)
- [ion](https://gitlab.redox-os.org/redox-os/ion/-/compare/first-8-values-current-commit-hash...b1b9475f)
- [ipcd](https://gitlab.redox-os.org/redox-os/ipcd/-/compare/first-8-values-current-commit-hash...db2322c)
- [kernel](https://gitlab.redox-os.org/redox-os/kernel/-/compare/first-8-values-current-commit-hash...0c99e1b)
- [netstack](https://gitlab.redox-os.org/redox-os/netstack/-/compare/first-8-values-current-commit-hash...640e548)
- [netutils](https://gitlab.redox-os.org/redox-os/netutils/-/compare/first-8-values-current-commit-hash...c78b13c)
- [orbdata](https://gitlab.redox-os.org/redox-os/orbdata/-/compare/first-8-values-current-commit-hash...3ca60ee)
- [orbital](https://gitlab.redox-os.org/redox-os/orbital/-/compare/first-8-values-current-commit-hash...8b5497a)
- [orbutils](https://gitlab.redox-os.org/redox-os/orbutils/-/compare/first-8-values-current-commit-hash...4878e07)
- [pkgutils](https://gitlab.redox-os.org/redox-os/pkgutils/-/compare/first-8-values-current-commit-hash...87e2dc8)
- [pop-icon-theme](https://github.com/pop-os/icon-theme/-/compare/first-8-values-current-commit-hash...3126c6a3f6)
- [ptyd](https://gitlab.redox-os.org/redox-os/ptyd/-/compare/first-8-values-current-commit-hash...ab26604)
- [redoxfs](https://gitlab.redox-os.org/redox-os/redoxfs/-/compare/first-8-values-current-commit-hash...5c8f22b)
- [relibc](https://gitlab.redox-os.org/redox-os/relibc/-/compare/first-8-values-current-commit-hash...7a86d101)
- [resist](https://gitlab.redox-os.org/redox-os/resist/-/compare/first-8-values-current-commit-hash...1a09fad)
- [userutils](https://gitlab.redox-os.org/redox-os/userutils/-/compare/first-8-values-current-commit-hash...7a96dab)
- [init](https://gitlab.redox-os.org/redox-os/init/-/compare/first-8-values-current-commit-hash...f5aaf7f)
- [logd](https://gitlab.redox-os.org/redox-os/logd/-/compare/first-8-values-current-commit-hash...e0f930a)
- [ramfs](https://gitlab.redox-os.org/redox-os/ramfs/-/compare/first-8-values-current-commit-hash...f404d64)
- [randd](https://gitlab.redox-os.org/redox-os/randd/-/compare/first-8-values-current-commit-hash...1c88eea)
- [zerod](https://gitlab.redox-os.org/redox-os/zerod/-/compare/first-8-values-current-commit-hash...286bd4a)
