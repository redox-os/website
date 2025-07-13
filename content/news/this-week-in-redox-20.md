+++
title = "This Week in Redox 20"
author = "goyox86"
date = "2017-05-19T13:16:00+00:00"
+++

This is the 20th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

With this post we restart the tradition of the weekly report and this one in particular is a catchup and it's a big one! So bear with us please! ;)

*(edited by goyox86)*

# PSA
If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# What's new in Redox?

## Kernel

- [@jackpot51](https://github.com/jackpot51) implemented timeouts.
- [@jackpot51](https://github.com/jackpot51) implemented an memory allocator that recycles frames when possible using an inner bump allocator if it cannot recycle. This new recycling allocator also allows the allocation of larger frames.
- [@jackpot51](https://github.com/jackpot51) added the `sys:iostat` scheme.
- [@jackpot51](https://github.com/jackpot51) implemented Implement CLOEXEC for root scheme and initfs.
- [@jackpot51](https://github.com/jackpot51) Other things include increasing the kernel heap size, fixed some bugs in the interrupts mechanism on serial devices, fixed `memmove()`, fixed some deallocation issues, cleaned the debug scheme and added xargo support.
- [@jackpot51](https://github.com/jackpot51) added support to pass a live filesystem in the `FILESYSTEM` environment var to the live scheme.

- [@pi-pi3](https://github.com/pi-pi3) has improved the performance of `memcpy()` family of functions.

- [@CWood1](https://github.com/CWood1) has been working on adding AML support for the ACPI subsystem.

- [@InsidiousMind](https://github.com/InsidiousMind) did some work on the PIT (Programmable interval timer). Now the PIT interrupt properly context switches fixing crashes in the kernel.

- [@bjorn3](https://github.com/bjorn3) added support for listing all schemes using the `:` scheme.

# Ion

There has been so much work [ion shell](https://github.com/redox-os/ion) that we have it's own section for this issue. Ion is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

- [@ids1024](https://github.com/ids1024) has been working on Redox's Newlib's [fork](https://github.com/redox-os/newlib). Adding support for getuid(), getgid(), getcwd(), fixed execve() and many others.

- [@jFransham](https://github.com/jFransham) landed a patch enabling LTO which yields a ~15% speedup. Details [here](https://github.com/redox-os/ion/pull/278).

- [@jFransham](https://github.com/jFransham) reduced the number of allocations. Details [here](https://github.com/redox-os/ion/pull/271).

- [@Maaarcocr](https://github.com/Maaarcocr) added descriptions to functions.  Details [here](https://github.com/redox-os/ion/pull/268).

- [@paezao](https://github.com/paezao) added the `echo` builtin .  Details [here](https://github.com/redox-os/ion/pull/268).

- [@amw-zero](https://github.com/amw-zero) added s small change so whenever you type `fn` it will give you the set of currently defined functions. Details [here](https://github.com/redox-os/ion/pull/256).

- [@mmstick](https://github.com/mmstick) added support for user's home directories in non-redox systems. Details [here](https://github.com/redox-os/ion/pull/253).

- [@mmstick](https://github.com/mmstick) rewrote the control flow mechanism! Details [here](https://github.com/redox-os/ion/pull/239).

- [@mmstick](https://github.com/mmstick) implemented basic arithmetic for let/export in. Details [here](https://github.com/redox-os/ion/pull/237).

- [@mmstick](https://github.com/mmstick) reworked the while loops and they now work as they do in other shells . Details [here](https://github.com/redox-os/ion/pull/235).

- [@mmstick](https://github.com/mmstick) implemented the `&&` and `||`  operators. Details [here](https://github.com/redox-os/ion/pull/227).

- [@mmstick](https://github.com/mmstick) implement aliasing support. Details [here](https://github.com/redox-os/ion/pull/222).

- [@mmstick](https://github.com/mmstick) added the ability to pass variables into subshells by expanding inner variables before performing process expansion. Details [here](https://github.com/redox-os/ion/pull/221).

- [@mmstick](https://github.com/mmstick) refactored the parser and also added process recursion. Details [here](https://github.com/redox-os/ion/pull/219).

- [@mmstick](https://github.com/mmstick) added the ability to split statements in a single line). Details [here](https://github.com/redox-os/ion/pull/218).

- ... and many small things!

## Drivers

- [@jackpot51](https://github.com/jackpot51) added support for the VirtualBox guest driver and implemented resizing on it.
- [@jackpot51](https://github.com/jackpot51) added initial support for the Atheros ALX ethernet driver.
- [@jackpot51](https://github.com/jackpot51) added initial support for the BGA mode setting.
- [@jackpot51](https://github.com/jackpot51) added scroll events to orbclient.
- [@jackpot51](https://github.com/jackpot51) added support for absolute mouse events in the VESA driver.
- [@jackpot51](https://github.com/jackpot51) done some fixes to the PS/2 driver related to interrupts.
- [@jackpot51](https://github.com/jackpot51) added support for retrying commands to ps2d.
- [@jackpot51](https://github.com/jackpot51) implemented `path` for the e1000d and ahcid drivers.
- [@kaedroho](https://github.com/kaedroho) migrated pcid from rustc-serialize to serde. He also added a few new keymaps to ps2d.

## Coreutils

- [@Mojo4242](https://github.com/Mojo4242) added  support for stdin and stdout to `dd`. Details [here](https://github.com/redox-os/coreutils/pull/134)
- [@DaanHoogland](https://github.com/DaanHoogland) added recursion support to `mv`. Details [here](https://github.com/redox-os/coreutils/pull/135)
- [@n0npax](https://github.com/n0npax) added basic support for symbolic links to `ls`. Details [here](https://github.com/redox-os/coreutils/pull/136)
- [@n0npax](https://github.com/n0npax) extended `ls` with new options for showing dates. Details [here](https://github.com/redox-os/coreutils/pull/138)
- [@n0npax](https://github.com/n0npax) added the `ln` utility. Details [here](https://github.com/redox-os/coreutils/pull/139).
- [@n0npax](https://github.com/n0npax) refactored the `format_date` function. Details [here](https://github.com/redox-os/coreutils/pull/151)
- [@bertinatto](https://github.com/bertinatto) added the `--unique` option to `sort`. Details [here](https://github.com/redox-os/coreutils/pull/142)
- [@bertinatto](https://github.com/bertinatto) added the `unique` command. Details [here](https://github.com/redox-os/coreutils/pull/143)
- [@simondesloges](https://github.com/simondesloges) added the `-f` and `-F` options to `tail`. Details [here](https://github.com/redox-os/coreutils/pull/144)
- [@simondesloges](https://github.com/simondesloges) changed `ls` to use `BufWriter`. Details [here](https://github.com/redox-os/coreutils/pull/147)
- [@vladimiroff](https://github.com/vladimiroff) made `wc` consider Unicode spaces when counting words. Details [here](https://github.com/redox-os/coreutils/pull/150)
- [@jackpot51](https://github.com/jackpot51) reimplemented `shutdown` on top of the `kill` system call.

# TFS

[TFS](https://github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

There has been enough work done in TFS that we added this section in this edition so you can have an idea about how the progress is going there.

First of all: Great news! [@ticki](https://github.com/ticki) has been working on many aspects of TFS and he considers that it is pretty near to functional. One of the great things is that as a product of this work several crates with interesting data structures and algorithms were created:

- [chashmap](https://github.com/redox-os/tfs/tree/master/chashmap) - Concurrent hashmaps.
- [cbloom](https://github.com/redox-os/tfs/tree/master/cbloom) - Concurrent bloom filters.
- [lz4](https://github.com/redox-os/tfs/tree/master/lz4) - An implementation of lz4.
- [speck](https://github.com/redox-os/tfs/tree/master/speck) - An implementation of SPECK cipher.
- [tm](https://github.com/redox-os/tfs/tree/master/tm) - transactional memory.
- [atomic-hashmap](https://github.com/redox-os/tfs/tree/master/atomic-hashmap) - Atomic hashmaps (you can read the [blog post](https://ticki.github.io/blog/an-atomic-hash-table/)).
- [mlcr](https://github.com/redox-os/tfs/tree/master/mlcr) - A machine-learning based cache replacement strategy.
- [seahash](https://github.com/redox-os/tfs/tree/master/seahash) - A hash function.
- [concurrent](https://github.com/redox-os/tfs/tree/master/concurrent) - Hazard pointers implementation.
- TFS has a logo.
- There is a specification document.
- A bunch of blog posts on design: https://github.com/redox-os/tfs#resources-on-design.

And according [@ticki](https://github.com/ticki) there's a ton of interesting things to write about, and eventually he will be doing an in-depth blog post about them.

## Package Management

There has been a ton of work on this topic specially on the [pkgutils](https://github.com/redox-os/pkgutils). Redox OS packaging utilities and in the [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes.

- [@ids1024](https://github.com/ids1024) migrated `pkg` to Hyper. Details [here](https://github.com/redox-os/pkgutils/pull/1).
- [@ids1024](https://github.com/ids1024) made `pkg` able to install packages from a given path. Details [here](https://github.com/redox-os/pkgutils/pull/3).
- [@ids1024](https://github.com/ids1024) made possible to use the pkgutils library on Linux and install to custom destination. Details [here](https://github.com/redox-os/pkgutils/pull/5).
- [@ids1024](https://github.com/ids1024) pkgutils now use the tar-rs library instead of the `tar` binary. Details [here](https://github.com/redox-os/pkgutils/pull/6).
- [@ids1024](https://github.com/ids1024) added support for package metadata. Details [here](https://github.com/redox-os/pkgutils/pull/8).
- [@ids1024](https://github.com/ids1024) added a `Package` struct. Details [here](https://github.com/redox-os/pkgutils/pull/9).
- [@jackpot51](https://github.com/jackpot51) added a method for configuring repos to `pkg`.
- [@jackpot51](https://github.com/jackpot51) started the work on upgrading logic in `pkg`.
- [@jackpot51](https://github.com/jackpot51) worked on package signature verification so we determine the need for re-downloading packages.

# Handy links

1. [The Glorious Book](https://doc.redox-os.org/book/)
2. [The Holiest Forum](https://discourse.redox-os.org/)
3. [The Shiny ISOs](https://github.com/redox-os/redox/releases)
4. [Redocs](https://www.redox-os.org/docs/)
5. [Fancy GitHub organization](https://github.com/redox-os)
6. [Our Holy Grail of a Website](https://www.redox-os.org/)
7. [The Extreme Screenshots](https://www.redox-os.org/screens/)

# New contributors

Since the list of contributors are growing too fast, we'll now only list the new contributors. This might change in the future.

Sorted in alphabetical order.

- Abdel-Rahman 🎂
- Adrian Neumann 🎂
- Aurélien DESBRIÈRES 🎂
- Clint Byrum 🎂
- Ian Douglas Scott 🎂
- Konrad Lipner 🎂
- Michael Köppl 🎂
- Niklas Claesson 🎂
- Petr 🎂
- Richard Dodd 🎂
- bjorn3 🎂
- equal-l2 🎂
- n0npax 🎂

If I missed something, feel free to contact me (Ticki) or send a PR to [Redox website](https://github.com/redox-os/website).
