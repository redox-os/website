+++
title = "This Month in Redox - September 2024"
author = "Ribbon and Ron Williams"
date = "2024-09-30"
+++

September was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Kernel Improvements

- Andrey Turkin fixed some bugs
- Andrey Turkin fixed the RISC-V memory paging code on RMM
- Andrey Turkin reduced CPU-specific code, improving the CPU portability and reducing the maintenance cost
- The time precision of TSC was improved
- 4lDO2 improved the memory performance
- 4lDO2 implemented queued POSIX signals
- 4lDO2 fixed the bump allocator initialization
- Andrey Turkin updated the `fdt` library to the latest version
- A panic on `dirent` was fixed

## Driver Improvements

- Timothy Finnegan fixed a kernel panic due to an unitialized PCI BAR
- Ivan Tan updated the SD card reader driver for Raspberry Pi boards to use the version 2 of the scheme protocol.

## Scheme Improvements

4lDO2 implemented the `getdents` system call to simplify the scheme interface, it will speedup the scheme development and ease the bug fixing.

## USB Improvements

- Tim Finnegan improved our xHCI driver to be compliant with the standard.
- Tim Finnegan improved the documentation of the xHCI driver

## Relibc Improvements

- 4lDO2 implemented real-time POSIX signals
- The `endian` function was implemented
- The `poll` system call was improved to follow more the Linux behavior
- A capability was implemented to make the `chroot` command work
- 4lDO2 updated the PAL (POSIX Abstraction Layer) component to use a Rust-written error handling
- 4lDO2 moved `umask` to a regular global variable
- 4lDO2 added a test for the `sigaltstack` function
- A stub for `net/if.h` was added
- 4lDO2 added a hack to cope with legacy schemes until they are updated
- plimkilde implemented a way to use Rust iterators on C-style strings

## RISC-V Port

Andrey Turkin started the RISC-V port and sent improvements to our toolchain.

## QEMU Port

Jeremy updated the QEMU patches to the latest version and is working on the remaining bugs.

QEMU can be ported soon.

## Programs

- The `dd` tool from uutils was fixed
- 4lDO2 fixed RustPython
- Bendeguz Pisch fixed the Perl 5 recipe
- Neovim is being ported
- Timothy Finnegan started the [Dropbear SSH](https://matt.ucc.asn.au/dropbear/dropbear.html) porting

## Ion Improvements

- The `$HOME` to `~` replacement was fixed

## CI Improvements

4lDO2 fixed the kernel CI and added unit tests, Redoxer will be improved to support more test cases.

## Podman By Default

Now Podman is our default build method and was enabled in our build system, it allow us to have a reproducible environment for all developers.

The Podman container environment is using Debian 12 and prevent many bugs caused by build environment differences (even kernel panics can be fixed!)

## Build System Improvements

- Podman was enabled by default
- The `path` data type was implemented on Cookbook to specify a local folder, it reduce the size of scripts
- Ribbon fixed FUSE on Podman
- The `libtool` dependency on the Podman container was fixed
- OpenSSH was installed on the Podman container for developers using SSH

## Documentation Improvements

- The boot process documentation was improved
- 4lDO2 fixed the [system call explanation](https://doc.redox-os.org/book/how-redox-compares.html#system-calls) to address the confusion with "POSIX system calls" and "Linux system calls"
- Ribbon updated the "Documentation" page of the website to add the `libredox` documentation and remove the `redox_syscall` documentation.
- Ribbon added the "Benchmarks" section on the "Performance" page of the book to explain how to do simple benchmarks on Redox, you can read the section on [this](https://doc.redox-os.org/book/ch09-10-performance.html#benchmarks) link
- Ribbon documented how to get the [CPU information](https://doc.redox-os.org/book/ch02-09-tasks.html#show-cpu-information) and [show the system log](https://doc.redox-os.org/book/ch02-09-tasks.html#show-the-system-log) in the [Tasks](https://doc.redox-os.org/book/ch02-09-tasks.html) page
- Ribbon removed the chapter numbers from the page names to remove the maintenance cost to mvoe pages on the book summary.

## Organization Improvements

Ribbon removed the "Tracking Issues Index" in favor of GitLab label filters to track our development priorities, reducing the maintenance cost.

## Art

Ribbon packaged the Ubuntu wallpapers from most recent versions and PopOS wallpapers.

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
- [Twitter @redox_os]()
- [Twitter @jeremy_soller]()
-->
