+++
title = "This Week in Redox 22"
author = "goyox86"
date = "2017-06-15T13:00:00+00:00"
+++

This is the 22nd post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA
If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# TL;DR

We are adding this section just in case you want to have quick overview of what happened during the week without going into the glorious details.

So let's get started!

In **kernel** land initial support for symbol lookup and symbol name demangling were added both of which should make the traces more readable and kernel debugging a bit easier. **Ion** got a better implementation of globs parsing. Also in **Ion** indexing arrays with negative indices is now supported. The `ping` utility was added to netutils and the network stack supports ICMP. Work on **TFS** continues and support for ATA trimming was recently added! But without a doubt the star of this week is the addition of a **Rust** package into the cookbook. Yes! you can do a `pkg install rust` from the console within Redox! The new rust package aims to simplify the development experience and also paves the way for make Redox self-hosting!

# What's new in Redox?

## Kernel

- [@jackpot51](https://github.com/jackpot51) Improved the messages on failures when unpaging memory. Details [here](https://github.com/redox-os/kernel/commit/e3020db04f239ed6c01ab127d9319120f9802c72).
- [@jackpot51](https://github.com/jackpot51) Refactored the kernel mapping so that symbol table is mapped. Details [here](https://github.com/redox-os/kernel/commit/d6354aeb5644bc2ecefa295a8690bc10b4a21144).
- [@jackpot51](https://github.com/jackpot51) Added initial support for symbol lookup. Details [here](https://github.com/redox-os/kernel/commit/acab23d1e1fc1779b40caff0e710b352857ca7e8).
- [@jackpot51](https://github.com/jackpot51) Continuing the work on symbols added support for demangled symbol paths. Details [here](https://github.com/redox-os/kernel/commit/c9cbdab9f1e2019a2461ef97136cd7224c16433e).
- [@jackpot51](https://github.com/jackpot51) Fixed a overallocation bug on the recycling memory allocator. Details [here](https://github.com/redox-os/kernel/commit/85c02365c96e9f2b551edeb8f7c4b306ea4feb04).

## Ion

[Ion](https://github.com/redox-os/ion) is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

- [@mgmoens](https://github.com/mgmoens) Implemented proper glob parsing. Details [here](https://github.com/redox-os/ion/pull/295).
- [@mmstick](https://github.com/mmstick) Refactored glob checking. Details [here](https://github.com/redox-os/ion/commit/556260e43122ece41145ee25a0382a9271bba767).
- [@huntergoldstein](https://github.com/huntergoldstein) Implemented reverse indexing with negative values. Details [here](https://github.com/redox-os/ion/pull/297).

## TFS

[TFS](https://github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

- [@ticki](https://github.com/ticki) Added ATA trim support. Details [here](https://github.com/redox-os/tfs/commit/bce6ea1e608094197ee8a41004d358d26bf92004).
- [@ticki](https://github.com/ticki) Add destructor to `conc::sync::Treiber` that runs dtor on every item. Details [here](https://github.com/redox-os/tfs/commit/943aa06463dc81294f33d807cc1eb5c2bac5ca88).
- [@ticki](https://github.com/ticki) Removed unsound `conc::Atomic::get_mut` and replace it by `conc::Atomic::get_inner[_mut]`. Details [here](https://github.com/redox-os/tfs/commit/1f5c889ad6d095dd47bdd264b1048f621735f80f).
- [@ticki](https://github.com/ticki) Added tests for the destructor of `conc::Atomic`. Details [here](https://github.com/redox-os/tfs/commit/9d42c865f4b5e1c0edb65704041cdbcd4f0bceb0).
- [@ticki](https://github.com/ticki) Added `get_mut()` to `conc::Atomic`. Details [here](https://github.com/redox-os/tfs/commit/0b12dded07ba3e4fa2abefcc183c8b0e499a159b).
- [@ticki](https://github.com/ticki) Fixed the destructors in `conc::Atomic`. Details [here](https://github.com/redox-os/tfs/commit/d88fe2367d807ac0be54ac447b3848484d588a4b).
- [@ticki](https://github.com/ticki) Added more tests to  the destructors in `conc::sync::Treiber`. See [here](https://github.com/redox-os/tfs/commit/75466b3722f5442e26f73b597c2c037d897216be), [here](https://github.com/redox-os/tfs/commit/c7c79f8ff635211e4d3b2eac6a9d08a6e3604752) and [here](https://github.com/redox-os/tfs/commit/51bab5cf9bc6ac200c64ef6c9cbe871d405a32a8) for details.
- [@ticki](https://github.com/ticki) Extended the `conc::sync::Treiber` docs. See [here](https://github.com/redox-os/tfs/commit/6fdacfdc8908f37376039c32558e3a02cbf0c147) and [here](https://github.com/redox-os/tfs/commit/1bef4d3cb365f98f188a3c1ae50b4266b99e0d87).

## Netutils & Netstack

- [@batonius](https://github.com/batonius) Added support for ICMP to the network stack. Details [here](https://github.com/redox-os/netstack/pull/1).
- [@batonius](https://github.com/batonius) Added the `ping` utility. See [here](https://github.com/redox-os/netutils/pull/21).

## Package Management

Work on this topic continues specially on the [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes of Redox. With special highlight that thanks to the hard work of [@ids1024](https://github.com/ids1024) We have a `rustc` and now you can do `pkg install rust`! This will simplify the development experience significantly and also paves the way for make Redox self-hosting!

- [@ids1024](https://github.com/ids1024) Added a cookbook recipe for Rust!. Details [here](https://github.com/redox-os/cookbook/pull/26).
- [@ids1024](https://github.com/ids1024) Stripped the gcc and gnu-binutils packages binaries allowing much smaller file sizes. Details [here](https://github.com/redox-os/cookbook/pull/21).

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

- Egor Karavaev 🎂
- mgmoens 🎂
- baton 🎂

If I missed something, feel free to contact me (goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
