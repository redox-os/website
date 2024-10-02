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

## Release 0.9.0

For those of you that missed it, Redox 0.9.0 was released earlier this month!
With numerous improvements and important additions, it represents another huge step forward for Redox!
You can read all about it in the [Release notes](https://redox-os.org/news/release-0.9.0/)

## RustConf 2024 - by Ron Williams

I got a chance to attend RustConf in Montreal. Montreal is a beautiful city, and the conference was in an amazing location.
The St-James Theatre was built in the early 1900s to house the Montreal branch of a major bank.
The presentation theater was on the main floor, with another theater upstairs and space for the sponsors downstairs.
The Rust Lounge was located in a converted safe, which still had the huge steel door.
It seemed very apropos that the Rust Lounge should be in a safe.

I got a chance to meet up with many people from the Rust community, as well as many of the companies that sponsored the conference.
There was lots of interest and enthusiasm for Redox,
and it was awesome to meet so many people that saw Redox as an important and meaningful project.

Unfortunately, some of us got sick after the conference, so to those of you that were hit by the virus, I wish you a speedy recovery.

## Generalizing Directory Support for Schemes

4lDO2 added support for directories to the scheme interface.
Previously, it was up to each scheme to provide directories, and there was a "convention" on how directories should be managed,
but the implementation was left to each scheme to implement the details.

The new `getdents` call allows us to provide a consistent scheme interface for directories,
and future refactoring of schemes will reduce directory management code.

## Kernel Improvements

After completing the release, several pending and new kernel improvements were merged.

- Andrey Turkin improved the panic stack trace handling and fixed some bugs
- Andrey fixed the RISC-V memory paging code in the `rmm` crate
- Andrey reduced the size of some CPU-specific code, simplifying portability to new CPU types and reducing the maintenance cost
- The time precision and reliability of TSC was improved
- 4lDO2 reimplemented a scheme-related TLB optimization, that was temporarily removed as a result of [a fix](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/333) for a scheme bug prior to 0.9.0.
- 4lDO2's queued POSIX signals work was merged
- 4lDO2 fixed the bump allocator initialization
- Andrey Turkin updated the `fdt` library to the latest version
- A panic on `dirent` was fixed

## Driver Improvements

- Tim Finnegan fixed a kernel panic due to an unitialized PCI BAR
- Ivan Tan updated the SD card reader driver for Raspberry Pi boards to use the version 2 of the scheme protocol.

## USB Improvements

Tim Finnegan is continuing to work on USB xHCI, and trying to bring it into compliance with both the standard and the behavior of real hardware. 
He has also improved the documentation of the xHCI driver.

## Relibc Improvements

- 4lDO2 merged the support for real-time POSIX signals
- The `endian` function was implemented
- `poll`  was improved to follow the Linux system call behavior more accurately
- When translating paths that don't have an explicit scheme, the ability to choose the default scheme was added (usually "/scheme/file" or "/scheme/initfs")
- 4lDO2 changed the PAL (POSIX Abstraction Layer) component to use Rusty error handling. This means that the interface to both Redox and Linux stays in safe Rust as long as possible, pushing the C-style error handling into the interface layers.
- 4lDO2 moved `umask` to a regular global variable
- 4lDO2 added a test for the `sigaltstack` function
- A stub for `net/if.h` was added
- 4lDO2 added code to cope with legacy schemes until they are updated
- plimkilde implemented a way to use Rust iterators on C-style strings

## RISC-V Port

Andrey Turkin started the RISC-V port and sent improvements to our toolchain.

## QEMU Port

Jeremy updated the QEMU patches to the latest version and is working on the remaining bugs.

The hope is that QEMU will be ported soon.

## Programs

- The `dd` tool from uutils was fixed
- 4lDO2 fixed pipe event handling, which was causing issues in RustPython
- Bendeguz Pisch fixed the Perl 5 recipe
- Neovim is being ported
- Tim Finnegan started the [Dropbear SSH](https://matt.ucc.asn.au/dropbear/dropbear.html) porting

## Ion Improvements

- The `$HOME` to `~` replacement was fixed

## CI Improvements

4lDO2 added support for kernel unit tests in CI. For real QEMU-based CI testing, Redoxer will need to be fixed.

## Podman By Default

Now Podman is our default build method and was enabled in our build system, it allows us to have a reproducible environment for all developers.

The Podman container environment is using Debian 12 and prevents many bugs caused by build environment differences.

## Build System Improvements

- Podman was enabled by default
- The `path` data type was implemented on Cookbook to specify a local folder, it reduce the size of scripts
- Ribbon fixed FUSE on Podman
- The `libtool` dependency on the Podman container was fixed
- OpenSSH was installed on the Podman container for developers using SSH

## Documentation Improvements

- The boot process documentation was improved
- 4lDO2 clarified the [system call explanation](https://doc.redox-os.org/book/how-redox-compares.html#system-calls) to address the confusion with POSIX "system calls" and Linux system calls
- Ribbon updated the "Documentation" page of the website to add the `libredox` documentation and remove the `redox_syscall` documentation.
- Ribbon added the "Benchmarks" section on the "Performance" page of the book to explain how to do simple benchmarks on Redox, you can read the section on [this](https://doc.redox-os.org/book/performance.html#benchmarks) link
- Ribbon documented how to get the [CPU information](https://doc.redox-os.org/book/tasks.html#show-cpu-information) and [show the system log](https://doc.redox-os.org/book/tasks.html#show-the-system-log) in the [Tasks](https://doc.redox-os.org/book/tasks.html) page
- Ribbon removed the chapter numbers from the page names to remove the maintenance cost to move pages on the book summary.

## Organization Improvements

Ribbon removed the "Tracking Issues Index" in favor of GitLab label filters to track our development priorities, reducing the maintenance cost.

## Art

Ribbon packaged the Ubuntu wallpapers from most recent versions and PopOS wallpapers.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

## Discussion

Here are some links to discussion about this news post:

- [Fosstodon @redox](https://fosstodon.org/@redox/113238436856184947)
- [Fosstodon @soller](https://fosstodon.org/@soller/113238422123305113)
- [Patreon](https://www.patreon.com/posts/113225427)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/1fuid6p/this_month_in_redox_os_september_2024/)
- [Reddit /r/rust](https://www.reddit.com/r/rust/comments/1fuiddg/this_month_in_redox_os_september_2024/)
- [Twitter @redox_os](https://x.com/redox_os/status/1841494088912142356)
- [Twitter @jeremy_soller](https://x.com/jeremy_soller/status/1841494050462978477)
