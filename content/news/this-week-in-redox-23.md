+++
title = "This Week in Redox 23"
author = "goyox86"
date = "2017-06-24T22:00:00+00:00"
+++

This is the 23rd post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA
If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# TL;DR

The way Redox is built has changed, mainly by two things. First, a new Docker based build process was added! You can try it following [these instructions](https://github.com/redox-os/redox/blob/master/docker/README.md). Big kudos to [@batonius](https://github.com/batonius) for his work on this! If you decide to use the usual build process you will need the cross-compiler and toolchain in order to build Redox. Ubuntu packages and Arch recipes are available. See instructions [here](https://github.com/redox-os/libc).

[@ids1024](https://github.com/ids1024) wrote the first GSoC [status report](https://redox-os.org/news/gsoc-self-hosting-1/) on the self-hosting effort. Feel free to take a look, exciting stuff!

We have a new [Mastodon account](https://icosahedron.website/@redox_os)!

This week we start the code tour by making a stop in the **bootloader** which can now read RedoxFS partitions meaning that the kernel can be now in the filesystem. In the **kernel** the big news is the addition of an AML tables parser written by [@CWood1](https://github.com/cwood1) who has been doing an amazing work on the ACPI support. The preemption was re-enabled in the kernel also. **Drivers** land got more work from [@TheSchemm](https://github.com/TheSchemm) and the Intel HDA audio driver was refactored and now supports QEMU. The **Ion** folks were pretty busy too! They added support to *emacs* and *vi* key bindings, optionally-typed function parameters, implicit `cd`, multiple assigments, `length` methods for strings. Also **Ion's** `calc` command now supports a bunch more bitwise operations. All of that without mentioning a ton of fixes and refactoring! On the **TFS** side of things [@ticki](https://github.com/ticki) had a fun week sponsored by silent type coercions and deadlocks in jemalloc, but despite those bugs (which are now fixed), work in garbage collection was done. The **Netstack**'s TCP daemon got few fixes that were affecting HTTPS in cURL. The **cookbook** saw the addition of a `ca-certificates` recipe and `tar.gz` is now used in all packages in both the **cookbook** and **pkgutils**. Something that is super exciting is the progress made by [@ids1024](https://github.com/ids1024) on the `cargo` recipe <3. Last but not least we have a new login screen background!

# What's new in Redox?

## Bootloader

- [@jackpot51](https://github.com/jackpot51) Added RedoxFS driver to the bootloader. Details [here](https://github.com/redox-os/bootloader/commit/7ba99fce952558b0934ec38c5ffd2b21741426d4).

## Kernel

- [@jackpot51](https://github.com/jackpot51) Reenabled preemption. Details [here](https://github.com/redox-os/kernel/commit/7ef2401db3f0b4ce38f87978daa8c35cc0bd82d4).
- [@jackpot51](https://github.com/jackpot51) Continued work on symbol names demangling. Details [here](https://github.com/redox-os/kernel/commit/c9cbdab9f1e2019a2461ef97136cd7224c16433e).
- [@CWood1](https://github.com/cwood1) Added an AML parser. Details [here](https://github.com/redox-os/kernel/commit/bbcd5197a456b198750e35b085189e3e4b800c57).
- [@jackpot51](https://github.com/jackpot51) Switched from `collections::boxed` to `alloc::boxed`. Details [here](https://github.com/redox-os/kernel/commit/cd67aabd5aa1a16f1468c1f97eaf776425deb60a).
- [@ids1024](https://github.com/ids1024) Made the `env` scheme return `ENOENT` on non-existent. Also added support for `unlink()`. Details
[here](https://github.com/redox-os/kernel/pull/25).

## Ion

[Ion](https://github.com/redox-os/ion) is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

- [@mgmoens](https://github.com/mgmoens) Added ² and ³ to `calc`. Details [here](https://github.com/redox-os/ion/commit/41813426ae34d030ce91ef8c1e77b2b4c35fa0c2).
- [@mmstick](https://github.com/mmstick) Fixed bug in `echo` when doing `foo >> bar`. Details [here](https://github.com/redox-os/ion/commit/bae8b7fae9b9e4364233f4174c48346bb3b63145).
- [@mmstick](https://github.com/mmstick) Enabled the handling of `Ctrl + C` with prompt. Details [here](https://github.com/redox-os/ion/commit/47aa80fd55ad76eac4f42b947ece021e6d26e2db).
- [@mmstick](https://github.com/mmstick) Added support for retaining quoted backslashes. Details [here](https://github.com/redox-os/ion/commit/9d8ba6824928408f5de3c516a3564ac909c25418).
- [@mgmoens](https://github.com/mgmoens) Added support for bitwise AND, OR, LSHIFT, RSHIFT, NOT and modulo to `calc`. Details [here](https://github.com/redox-os/ion/commit/5ad8694f1b29773f6ebb9e292eb74dd08a529619) and [here](https://github.com/redox-os/ion/commit/4ed3dbdf35880a632fe651f524e064bc907b6083).
- [@mgmoens](https://github.com/mgmoens) Implemented proper glob parsing. Details [here](https://github.com/redox-os/ion/commit/090d8d72af75dfa1f2d59df71eea68a036c9d16a).
- [@mmstick](https://github.com/mmstick) Made use of `Iterator` on `calc`'s `tokenize()`. Details [here](https://github.com/redox-os/ion/commit/0c66887e155a627d3e42a0d721e4ceefbb5aea16).
- [@mmstick](https://github.com/mmstick) Implemented the changing of key bindings with `set -o` adding support for vi and emacs key bindings. Details [here](https://github.com/redox-os/ion/commit/ce0a19672e7d76c4ff431bffa2731852a893157e).
- [@huntergoldstein](https://github.com/huntergoldstein) Refactored `Index`, etc. into `Select`, `Range`, and `Index`. Details [here](https://github.com/redox-os/ion/commit/bb47e31bb87916863ab13554fa4589583a862d87).
- [@jwbowen](https://github.com/jwbowen) Updated README.md to add vi/emacs keybindings as a feature. Details [here]( https://github.com/redox-os/ion/commit/0d1b8741fde03e20f59328018f14536beb364519).
- [@mmstick](https://github.com/mmstick) Implemented optionally-typed function parameters. Details [here](https://github.com/redox-os/ion/commit/338bd96718f0444201485a63d54b41e55603ae9e).
- [@huntergoldstein](https://github.com/huntergoldstein) Moved `export` into the grammar. Details [here](https://github.com/redox-os/ion/commit/2a5d914630d54d7aa454a8f6b18d3901bae61bf2).
- [@mmstick](https://github.com/mmstick) Implemented implicit `cd`. Details [here](https://github.com/redox-os/ion/commit/5d3ca8997365c1c0366cac8c69afa072b1b0cabb).
- [@mmstick](https://github.com/mmstick) Implemented multiple assigments. Details [here](https://github.com/redox-os/ion/commit/a6fd25147ac12685b3a650d8478724f7bff80fb1).
- [@mmstick](https://github.com/mmstick) Implemented tilde expansions in tab completions. Details [here](https://github.com/redox-os/ion/commit/dd42c629caf7e19f28cc80dc80c9b239ecd7612c).
- [@mmstick](https://github.com/mmstick) Implemented expansions in slice syntax. Details [here](https://github.com/redox-os/ion/commit/246fa1b2b8a8b668461b6d2f803eda3ee6fb52eb).
- [@mmstick](https://github.com/mmstick) Fixed the parsing of variables. Details [here](https://github.com/redox-os/ion/commit/2f12c1be06090adcbaec59dafed24e601da935c3).
- [@huntergoldstein](https://github.com/huntergoldstein) Added support for braced array variables. Details [here](https://github.com/redox-os/ion/commit/b002e7d6727b6fcf7a612d3fab935cb835745f24).
- [@mmstick](https://github.com/mmstick) Refactored script execution. Details [here](https://github.com/redox-os/ion/commit/0b26e1754e0d42e4451348dbbf48156f2d3cef01).
- [@mmstick](https://github.com/mmstick) Added initial `Ctrl+C` signal handling support. Details [here](https://github.com/redox-os/ion/commit/9e02244a959f94280400c164f97d8d3a4834bdd1).
- [@huntergoldstein](https://github.com/huntergoldstein) Replaced manual bit flags with auto-generated
bit flag construct. Details [here](https://github.com/redox-os/ion/commit/eea59ead2505d747f253918cdf54012da05b6e05).
- [@huntergoldstein](https://github.com/huntergoldstein) Put the Tokio crates behind a cfg crate for Redox. Details [here](https://github.com/redox-os/ion/commit/b1014bf92baef120bacc34ef8178123b3225caea).
- [@mmstick](https://github.com/mmstick) Replaced `eprintln!()` with `writeln!(stderr())`. Details [here](https://github.com/redox-os/ion/commit/63d49ee97f8a1e71b9f6cc183b34e193422452c3).
- [@mmstick](https://github.com/mmstick) Implemented `SIGINT` control flow logic abortion. Details [here](https://github.com/redox-os/ion/commit/3633bddbb2347b2e2a302944bea2ff7a6d032aa9).
- [@mmstick](https://github.com/mmstick) `Ctrl+C` now clears multi-line prompts. Details [here](https://github.com/redox-os/ion/commit/8f5a2ae073c118da4a6a7753af216f2f4d1281d0).
- [@mmstick](https://github.com/mmstick) Implemented length methods for strings. Details [here](https://github.com/redox-os/ion/commit/14d6b336ca342df7dc012f7168f6d731f301e956).

## Drivers

- [@TheSchemm](https://github.com/TheSchemm) Added `$DEVID` and `$VENID` as arguments to pass to driver in `pcid`. Details [here](https://github.com/redox-os/drivers/pull/15).
- [@TheSchemm](https://github.com/TheSchemm) Refactored `ihdad` and added QEMU support! Details [here](https://github.com/redox-os/drivers/pull/16).

## TFS

[TFS](https://github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

- [@ticki](https://github.com/ticki) Add notes on destruction of the `new` field in `conc::Atomic::*_raw` arguments.
Details [here](https://github.com/redox-os/tfs/commit/21b84f038796950f15bffc2ee28a91b6e40db87c).
- [@ticki](https://github.com/ticki) Fixed a segfault in `conc` caused by a silent type coercion.
Details [here](https://github.com/redox-os/tfs/commit/e261914466455162d4a803efa1b99d86fbe965cb).
- [@ticki](https://github.com/ticki) Renamed `conc::gc()` to `conc::try_gc()` and introduce `conc::gc()`
for forced, deterministic GCs. Details [here](https://github.com/redox-os/tfs/commit/73a4cec90db8dee6b6f3a23761182132a53b7781).
- [@ticki](https://github.com/ticki) If tick triggers GC, it should call `conc::try_gc()` not `conc::gc()`
because the other way is too slow. Details [here](https://github.com/redox-os/tfs/commit/73a4cec90db8dee6b6f3a23761182132a53b7781).
- [@ticki](https://github.com/ticki) Switched to the system memory allocator in order to fix an apparent deadlock in `conc`s deallocation when `jemalloc` is used. Details [here](https://github.com/redox-os/tfs/commit/9d79785ac2a6e3793dac6aedc4fc6b792cc20a31).

## Netstack

- [@ids1024](https://github.com/ids1024) Corrected `fpath()` for `tcpd`. Details
[here](https://github.com/redox-os/netstack/pull/2).
- [@ids1024](https://github.com/ids1024) Fixed a bug in `tcp`s partial reads that was breaking HTTPS in cURL. Details
[here](https://github.com/redox-os/netstack/pull/3).

## Cookbook

The [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes of Redox. The effort on self-hosting continues! And [@ids1024](https://github.com/ids1024) is working hard on a `cargo` recipe. How cool is that?

- [@ids1024](https://github.com/ids1024) Now `dash` and `recipes` use `/bin/sh` and `/bin/cc` ion scripts. Details [here](https://github.com/redox-os/cookbook/pull/27).
- [@ids1024](https://github.com/ids1024) Added initial recipe for `cargo`! Details [here](https://github.com/redox-os/cookbook/pull/30).
- [@ids1024](https://github.com/ids1024) Added the `ca-certificates` recipe. Details [here](https://github.com/redox-os/cookbook/pull/31).
- [@ids1024](https://github.com/ids1024) Added cURL recipe. Details [here](https://github.com/redox-os/cookbook/pull/32).
- [@jackpot51](https://github.com/jackpot51) Removed `libc-artifacts` and a cross compiler is required. Details [here](https://github.com/redox-os/cookbook/commit/e50070b3f34fc4d54bf4e6f24a791add1f2137d5).
- [@jackpot51](https://github.com/jackpot51) Set the format to `tar.gz` for all packages. Details [here](https://github.com/redox-os/cookbook/commit/20db74be75c121814528c597a57e72cd94904376).
- [@jackpot51](https://github.com/jackpot51) Now the unstripped binaries are being kept in the target directory.
Details [here](https://github.com/redox-os/cookbook/commit/18fec4b46a90a112fb6ba2d90c28c8a088a32467).
- [@jackpot51](https://github.com/jackpot51) Moved `xargo-home` to `xargo` and enabled cross compiler.
Details [here](https://github.com/redox-os/cookbook/commit/18fec4b46a90a112fb6ba2d90c28c8a088a32467).
- [@jackpot51](https://github.com/jackpot51) Moved `uutils` back to recipes.
Details [here](https://github.com/redox-os/cookbook/commit/2833d16c17d5dc57a6e263c0fa9e5e469c739744).

## Pkgutils

The [pkgutils](https://github.com/redox-os/cookbook) are a set of utilities for package management on Redox.

- [@jackpot51](https://github.com/jackpot51) Made an update to use gzip in all package files. Details [here](https://github.com/redox-os/pkgutils/commit/2cfc944c9e4d7a91aa8c8d7ece8c531568817d5c). Update to use gzip for all package files
- [@ids1024](https://github.com/ids1024) Switched progress bar based on the `pbr` crate. Details [here](https://github.com/redox-os/pkgutils/pull/11).
- [@ids1024](https://github.com/ids1024) Switched to `BufReader` in the gzip archives extraction. Details [here](https://github.com/redox-os/pkgutils/pull/11).
- [@AgostonSzepessy](https://github.com/AgostonSzepessy) Added a `TARGET` environment variable for TravisCI.
- [@ids1024](https://github.com/ids1024) Set `clap` for argument parsing and also added a `--target` argument to choose which target to download packages for to the `pkg` utility. Details [here](https://github.com/redox-os/pkgutils/pull/14)

## Look and Feel

 [@xTibor](https://github.com/xTibor) Added a new login screen background! Details [here](https://github.com/redox-os/backgrounds/pull/7)

# Handy links

1. [The Glorious Book](https://doc.redox-os.org/book/)
2. [The Holiest Forum](https://discourse.redox-os.org/)
3. [The Shiny ISOs](https://github.com/redox-os/redox/releases)
4. [Redocs](http://www.redox-os.org/docs/)
5. [Fancy GitHub organization](https://github.com/redox-os)
6. [Our Holy Grail of a Website](http://www.redox-os.org/)
7. [The Extreme Screenshots](http://www.redox-os.org/screens/)

# New contributors

Since the list of contributors are growing too fast, we'll now only list the new contributors. This might change in the future.

Sorted in alphabetical order.

- Agoston Szepessy 🎂
- Hunter Goldstein 🎂
- Jason Bowen 🎂
- Jordan Danford 🎂

If I missed something, feel free to contact me (goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
