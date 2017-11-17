+++
title = "This Week in Redox 32"
author = "goyox86"
date = "2017-11-16 11:39:07 +0000"
+++

This is the 32nd post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by [@goyox86](https://github.com/goyox86))*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

## TL;DR

Hello there! Welcome to another issue of TWiR!

This week [@jackpot51](https://github.com/jackpot51) surprised us by sharing this on the Mattermost channel:

![cargo on Redox](https://chat.redox-os.org/files/qnmgh4pcefdg5xs1uda9ekby7a/public?h=O9WYJaxO_3GjDPRTDIhAUdK5KPH8UWRFOwo7TOnHNvs)

Yes! it's `cargo` running on Redox! This milestone represents a significant step forward on our path to self-hosting. Kudos to [@ids1024](https://github.com/ids1024) who worked really hard on self-hosting during the GSoC.

It's worth mentioning that `cargo` and `rustc` have been [@jackpot51](https://github.com/jackpot51)'s focus these last two weeks and many changes are directly related (but not limited) to this effort.

So, without further ado, let's give you an overview of what happened this week in the Redox universe!

I'm gonna start with the [**book**](https://github.com/redox-os/book/) where [@sajattack](https://github.com/sajattack) made some updates on installation and build instructions.

Moving to the [**kernel**](https://github.com/redox-os/kernel/), [@jackpot51](https://github.com/jackpot51) was focused on implementing the remaining `cargo` and `rustc` missing pieces, specifically: timeouts for futexes and improving interruption detection. Also in the kernel, [@pzmarzly](https://github.com/pzmarzly) made a fix on `elf.rs` to prevent the inlining of some constants from `goblin`.

As always the [**Ion**](https://github.com/redox-os/ion) shell saw a lot of work. Including the introduction of a new fork abstraction, which will hopefully help to eliminate some redundancy caused by the manual handling of forking logic in command expansions and function prompts. There were also `readln` and quote termination refactorings as well as the elimination of heap allocations with `!*` designator. All of that thanks to [@mmstick](https://github.com/mmstick). [@ids1024](https://github.com/ids1024) also worked on in **Ion**, adding the `set_var()` and `get_var()` methods to `IonLibrary` while [@KaKnife](https://github.com/KaKnife) was busy implementing the `random` builtin in addition to [@AgustinCB](https://github.com/AgustinCB) implementing `escape` and `unescape` as well as a major optimization to perform builtin Lookup when parsing now the builtin lookup once when parsing the statement, rather than performing a lookup for a given builtin command for each statement repeatedly.

This week, I saw a new contributor super active in the chat, asking many questions, and trying to port stuff to Redox. The result: the addition of recipes for `vim`, `jansson` and `openssh` to the [**cookbook**](https://github.com/redox-os/cookbook). Give it up for [@sajattack](https://github.com/sajattack)!

Continuing with the [**cookbook**](https://github.com/redox-os/cookbook): [@xTibor](https://github.com/xTibor) added recipe version to `vttest` in addtion to a new `periodictable` recipe, along with lots of activity from [@jackpot51](https://github.com/jackpot51) who cleaned up LLVM the build and improved build speed of the `rust` recipe, fixed `llvm-config`'s path. Meanwhile [@AgustinCB](https://github.com/AgustinCB) focused efforts on fixing the `xz` recipe.

On the [**Orbtk**](https://github.com/redox-os/orbtk) side of things, [@BojanKogoj](https://github.com/BojanKogoj) added `clear()` to `Grid` plus some examples. Continuing on the GUI work, the [**Orbterm**](https://github.com/redox-os/orbterm) emulator saw a bunch of updates, mostly related to bumping [**ransid**](https://github.com/redox-os/ransid) who experienced a bunch of improvements: fixes to overflow, improvements on the `vt100` compliance, better `vttest` performance and few enhancements to the parsing of nested control characters.

Moving onto [**pkgutils**](https://github.com/redox-os/pkgutils), few issues related to dependency resolution were addressed, and now we are retrieving the dependency list from repo.

A quick glimpse to the utilities land reveals a new small new crate: [**redox_users**](https://github.com/redox-os/users). Basically, we moved all of the users and groups functionality there (along with few new goodies and documentation improvements), functionality that was previously embedded on [userutils](https://github.com/redox-os/userutils) which was not optimal. This was done by [@goyox86](https://github.com/goyox86) as part of his ongoing work on porting the [exa](https://github.com/ogham/exa) to Redox.

The [**userutils**](https://github.com/redox-os/userutils) [**coreutils**](https://github.com/redox-os/coreutils/) packages were updated to [**redox_users**](https://github.com/redox-os/users) in addition to some general refactoring and cleanup.

Another package updated to **redox_users** was [**Orbutils**](https://github.com/redox-os/coreutils/). The migration was done by [@chebykinn](https://github.com/chebykinn) and [@AleVul](https://github.com/AleVul).

And last but not least, [**newlib**](https://github.com/redox-os/newlib) our C library got some attention from [@sajattack](https://github.com/sajattack) who removed include of nonexistent `endian.h` file, added all the headers necessary for `openssh` to compile, replaced `glibc` headers with newlib ones where possible as well as implemented `scandir()` and `alphasort()`.

Now I leave you with the details. See you next time, hopefully with `rustc` compiling some interesting crates ;)!

## Book

The Redox book.

- [@sajattack](https://github.com/sajattack) Made a change to highlight the fact that we need `cargo install xargo`. Details [here](https://github.com/redox-os/book/commit/12e3c55d8536b13445da0688f607f366b75c41e5).
- [@sajattack](https://github.com/sajattack) Updated the build preparation intructions. Details [here](https://github.com/redox-os/book/commit/040ff9ca62a9c7c79b1a7768f34b7a222a4006e3).
- [@sajattack](https://github.com/sajattack) Updated the toolchain installation instructions. Details [here](https://github.com/redox-os/book/commit/e387551b36000acb22ca31a9be8f7f2d9d154475).

## Kernel

The Redox microkernel.

- [@sajattack](https://github.com/sajattack) Added a LOC badge. Details [here](https://github.com/redox-os/kernel/pull/61).
- [@jackpot51](https://github.com/jackpot51) Implemented futex timeouts. Details [here](https://github.com/redox-os/kernel/commit/9e9f80ef13bfa4aa03c29db35cc67de97bd1f5e7).
- [@pzmarzly](https://github.com/pzmarzly) Made a fix on `elf.rs` to not inline constant from goblin library. Details [here](https://github.com/redox-os/kernel/pull/63).
- [@jackpot51](https://github.com/jackpot51) Removed `SwitchResult`, used out of band data to detect interruption and updated debugging code. Details [here](https://github.com/redox-os/kernel/commit/ed055640119d7078d9b9ec1aea6ebc99dd1c6a43).

## Ion

The Ion Shell. Compatible with Redox and Linux.

- [@Eijebong](https://github.com/Eijebong) Bumped `bitflags` to 1.0. Details [here](https://github.com/redox-os/ion/pull/568).
- [@mmstick](https://github.com/mmstick) Made process expansions to allow access to stdin. Builtin commands like read aren't working yet. Details [here](https://github.com/redox-os/ion/commit/becfbfb83499b32beb1ff0e9bfb23f243938cb03).
- [@mmstick](https://github.com/mmstick) Created fork abstraction with cmd expansions and fn prompts. Details [here](https://github.com/redox-os/ion/commit/2529362cf2e0210984b430c0683cdb08a5d7e2a6).
- [@mmstick](https://github.com/mmstick) Refactored `readln` logic into it's own module. Details [here](https://github.com/redox-os/ion/commit/9f8e9e539fb62f7513f33ff110d1a3253bad2c3c).
- [@mmstick](https://github.com/mmstick) Refactored quote termination logic. Details [here](https://github.com/redox-os/ion/commit/a09aa7d6fb1c0e607be15fd4eb05faa8e0859fcc).
- [@mmstick](https://github.com/mmstick) Made a change when expanding arguments: if an argument evaluates to an empty argument, simply ignore the argument as if it didn't exist. Details [here](https://github.com/redox-os/ion/commit/2d49c5932b8885a74fb3f3344e49626f82d2da21).
- [@mmstick](https://github.com/mmstick) Implemented superior word designator support. Details [here](https://github.com/redox-os/ion/commit/dff4a0bf024b87a2fcb57730c70230965ed94cf3).
- [@mmstick](https://github.com/mmstick) Sorted the builtins and used binary search with lookups. Details [here](https://github.com/redox-os/ion/commit/98bfa8976f023888586ade9d51548b8fb10aa15f).
- [@mmstick](https://github.com/mmstick) Improved public API with `fork` method. Details [here](https://github.com/redox-os/ion/commit/89c1de8e70baf38c7cdf27e6ec504a8db80b611f).
- [@mmstick](https://github.com/mmstick) Made further public API improvements. Details [here](https://github.com/redox-os/ion/commit/6d1e42289b98a0a1e696c0372ec7612ada5f161e).
- [@ids1024](https://github.com/ids1024) Made `IonError` derive debug. Details [here](https://github.com/redox-os/ion/pull/571).
- [@ids1024](https://github.com/ids1024) Added `set_var()` and `get_var()` methods to `IonLibrary`. Details [here](https://github.com/redox-os/ion/pull/572).
- [@mmstick](https://github.com/mmstick) Further public API Improvements. The `IonLibrary` interface was removed, and integrated directly, within the shell's main module. Details [here](https://github.com/redox-os/ion/commit/fffdddcd64b15f6edb2c92b2a4638044ac51544a).
- [@xTibor](https://github.com/xTibor) Fixed string comparisons in documentation. Details [here](https://github.com/redox-os/ion/pull/575).
- [@mmstick](https://github.com/mmstick) Implemented the `execute_function()` method for public API. Details [here](https://github.com/redox-os/ion/commit/7a7c796df33818220ee706fceafbd1f20a9b5757).
- [@ids1024](https://github.com/ids1024) Added a `get_array()` method to the public API. Details [here](https://github.com/redox-os/ion/pull/576).
- [@mmstick](https://github.com/mmstick) Replace `sys::getpid()` with `process::id()`. Details [here](https://github.com/redox-os/ion/commit/e9dd8f1a9bf41104e21236b996aa6e12d683bf58).
- [@mmstick](https://github.com/mmstick) Handled signals with forks, closing #577. Details [here](https://github.com/redox-os/ion/commit/079a2367641ad0bc60b673e2e55cb29914fce09b).
- [@mmstick](https://github.com/mmstick) Eliminated Heap allocation with `!*` designator. Details [here](https://github.com/redox-os/ion/commit/576182b49181cdf4a3196f0134d3294202b40e12).
- [@mmstick](https://github.com/mmstick) Refactored the `binary` module. Details [here](https://github.com/redox-os/ion/commit/2200d4a0d93a4b29c9eecd8f41428070f6e23de4).
- [@mmstick](https://github.com/mmstick) Made some assignment optimizations. Details [here](https://github.com/redox-os/ion/commit/b4e426f3e525841dea2507b4ae7a3a3b88543c2a).
- [@AgustinCB](https://github.com/AgustinCB) Escaped unescape. Details [here](https://github.com/redox-os/ion/pull/579).
- [@KaKnife](https://github.com/KaKnife) Added `--help` argument and the `random` builtin. Partial fix for issue #528. Details [here](https://github.com/redox-os/ion/pull/580).
- [@mmstick](https://github.com/mmstick) Enhanced the fork API & simplified the public API. Details [here](https://github.com/redox-os/ion/commit/4dd8e58c5b55b273c213ab4bd37924eb5356b8ca).
- [@KaKnife](https://github.com/KaKnife) Documented builtins. Details [here](https://github.com/redox-os/ion/pull/583).
- [@mmstick](https://github.com/mmstick) Fixed builtin documentation style. Details [here](https://github.com/redox-os/ion/commit/7bfa1789267176e515cd157f4504c15cdd29d91c).
- [@AgustinCB](https://github.com/AgustinCB) Implemented `escape` & `unescape` Methods (#579). Details [here](https://github.com/redox-os/ion/commit/2f176ebe1010b4ebd9e2a9031ad354e598cdee9c).
- [@AgustinCB](https://github.com/AgustinCB) Made a major optimization: Perform Builtin Lookup when parsing (#587). Rather than performing a lookup for a given builtin command for each statement repeatedly, we now perform the builtin lookup once when parsing the statement. Details [here](https://github.com/redox-os/ion/pull/587).
- [@AgustinCB](https://github.com/AgustinCB) Made `./examples/run_examples.sh` loudly fail. Details [here](https://github.com/redox-os/ion/commit/649fc1f7e62da0e5fbb471cd625d29e6a1bba336).
- [@AgustinCB](https://github.com/AgustinCB) Fixed a test with negative numbers. Details [here](https://github.com/redox-os/ion/pull/590).

## Cookbook

A collection of package recipes for Redox.

- [@dlrobertson](https://github.com/dlrobertson) Added documentation for Gentoo Linux. Details [here](https://github.com/redox-os/cookbook/pull/92).
- [@sajattack](https://github.com/sajattack) Added recipes for `vim`, `jansson` and `ssh`. Details [here](https://github.com/redox-os/cookbook/pull/93).
- [@sajattack](https://github.com/sajattack) Made a quick fix to the `ssh` recipe. Details [here](https://github.com/redox-os/cookbook/pull/94).
- [@xTibor](https://github.com/xTibor) Added recipe version to `vttest` recipe. Details [here](https://github.com/redox-os/cookbook/pull/95).
- [@sajattack](https://github.com/sajattack) Fixed `vim.patch`. Details [here](https://github.com/redox-os/cookbook/pull/96).
- [@sajattack](https://github.com/sajattack) Change `ssh` recipe to use custom branch of `newlib`. Details [here](https://github.com/redox-os/cookbook/pull/97).
- [@jackpot51](https://github.com/jackpot51) Updated `pkgutils`. Details [here](https://github.com/redox-os/cookbook/commit/6b6568f7941f27e8431d8bbe72565fc7faf281be).
- [@jackpot51](https://github.com/jackpot51) Fixed `prboom` recipe. Details [here](https://github.com/redox-os/cookbook/commit/b913b258f7c6cad0329ecf752983907e3ed900c0).
- [@sajattack](https://github.com/sajattack) Created `jansson.patch` in the `jansson`. Details [here](https://github.com/redox-os/cookbook/pull/98).
- [@xTibor](https://github.com/xTibor) Added `periodictable` recipe. Details [here](https://github.com/redox-os/cookbook/pull/99).
- [@jackpot51](https://github.com/jackpot51) Cleaned up LLVM build in Rust recipe. Details [here](https://github.com/redox-os/cookbook/commit/ceb3eb73df4a316be126b96689e23bba4497ef33).
- [@jackpot51](https://github.com/jackpot51) Improved build speed of Rust recipe. Details [here](https://github.com/redox-os/cookbook/commit/58ff0bf93602d47d106d6c79366b6cbcb3ad7344).
- [@jackpot51](https://github.com/jackpot51) Fixed `llvm-config` path. Details [here](https://github.com/redox-os/cookbook/commit/8de4e0f20e9b93cc3daf129f6b8153cf760c0a07).
- [@AgustinCB](https://github.com/AgustinCB) Fixed `xz` recipe. Details [here](https://github.com/redox-os/cookbook/pull/100).
- [@jackpot51](https://github.com/jackpot51) Cleaned up compilation of Rust. Details [here](https://github.com/redox-os/cookbook/commit/22c98abf7939aa3dff85b59b4e608bf902c6ecbc).
- [@jackpot51](https://github.com/jackpot51) Added version for `ca-certificates`. Details [here](https://github.com/redox-os/cookbook/commit/d14d183a1de4e9b87730ae27700fbcaed04ded99).
- [@jackpot51](https://github.com/jackpot51) Disabled LLVM ninja build, Enable compilation of codegen tests. Details [here](https://github.com/redox-os/cookbook/commit/25803c9a506f80dfe985c1f39d30ffcc7f2cc06c).

## Orbtk

The Orbital Widget Toolkit. Compatible with Redox and SDL2.

- [@BojanKogoj](https://github.com/BojanKogoj) Added `clear()` to Grid and example. Details [here](https://github.com/redox-os/orbtk/pull/56).

## pkgutils

Redox Packaging Utilities.

- [@jackpot51](https://github.com/jackpot51) Removed dependency resolution in `tar.gz` package case. Details [here](https://github.com/redox-os/pkgutils/commit/7c9f14af4391aed4fb8ab09bc2320ec962aba9fe).
- [@jackpot51](https://github.com/jackpot51) Made a change to retrieve dependency list from repo. Details [here](https://github.com/redox-os/pkgutils/commit/767c4d24e3358e778819e0059c15cd0ba2358cbc).
- [@jackpot51](https://github.com/jackpot51) Retrieve dependency list from repo. Details [here](https://github.com/redox-os/pkgutils/commit/767c4d24e3358e778819e0059c15cd0ba2358cbc).

## Orbterm

Orbital Terminal, compatible with Redox and Linux.

- [@jackpot51](https://github.com/jackpot51) Fixed an issue when resizing smaller than cursor. Details [here](https://github.com/redox-os/orbterm/commit/57a282351e0ff3b3488b66a2844df23862f178cb).
- [@jackpot51](https://github.com/jackpot51) Updated `ransid`. Details [here](https://github.com/redox-os/orbterm/commit/4295247ae0d1772911ae373bed6c8c5c43d685f9).
- [@jackpot51](https://github.com/jackpot51) Fixed enter character, update `ransid`. Details [here](https://github.com/redox-os/orbterm/commit/e645866574112117e2c7962253a3501a32619a1d).
- [@jackpot51](https://github.com/jackpot51) Updated `ransid`. Details [here](https://github.com/redox-os/orbterm/commit/b12b1ed4ff65b0aa959c390b6580b557f92ca9eb).
- [@jackpot51](https://github.com/jackpot51) Updated to git `ransid`. Details [here](https://github.com/redox-os/orbterm/commit/e5ca808d0d99df57c1c4918c1ab1e394b441a50e).
- [@jackpot51](https://github.com/jackpot51) Updated to git `ransid`. Details [here](https://github.com/redox-os/orbterm/commit/d385d34e77e942b1ef58585cda55f92117e66d60).
- [@jackpot51](https://github.com/jackpot51) Added resize event. Details [here](https://github.com/redox-os/orbterm/commit/f762ad4a50728fb2476e1a1ba6241e85229e8295).
- [@jackpot51](https://github.com/jackpot51) Released version`0.3.0`. Details [here](https://github.com/redox-os/orbterm/commit/da3090e5a664948d446bfe181dc9cb2fde520091).

## Orbutils

The Orbital Utilities. Compatible with Redox and SDL2.

- [@chebykinn](https://github.com/chebykinn) Migrated to `redox_users` in `orblogin`. Details [here](https://github.com/redox-os/orbutils/pull/31).
- [@AleVul](https://github.com/AleVul) replace userutils with redox_users in `orblogin`. Details [here](https://github.com/redox-os/orbutils/pull/32).

## ransid

Rust ANSI Driver - a backend for terminal emulators in Rust.

- [@jackpot51](https://github.com/jackpot51) Fixed overflow. Details [here](https://github.com/redox-os/ransid/commit/c2c8bdc639424e9c28c94ff437bdfdf6d9abd4c3).
- [@jackpot51](https://github.com/jackpot51) Improved `vt100` compliance. Details [here](https://github.com/redox-os/ransid/commit/7e4106ea221adc217fcd8aea2276f9a3ca510a9f).
- [@jackpot51](https://github.com/jackpot51) Improved `vttest` performance. Details [here](https://github.com/redox-os/ransid/commit/1694719624567d3ee2517fbfc1fff129140515b9).
- [@jackpot51](https://github.com/jackpot51) Released `0.3.7`. Details [here](https://github.com/redox-os/ransid/commit/728c1e1e05b50d6994bcd1dbd722e87a1bdf6214).
- [@jackpot51](https://github.com/jackpot51) Improved parsing of nested control characters. Details [here](https://github.com/redox-os/ransid/commit/2e4846b4aedcf750bd5e87818ef613ce3ae599cf).
- [@jackpot51](https://github.com/jackpot51) Used VTE for lower level state machine. Details [here](https://github.com/redox-os/ransid/commit/39579630a023e914957e7e8d32ca61e2d134f1ca).
- [@jackpot51](https://github.com/jackpot51) Added `test` pattern. Details [here](https://github.com/redox-os/ransid/commit/41396f208f932b9349af00b1b982342d51efc265).
- [@jackpot51](https://github.com/jackpot51) Handled parameters. Details [here](https://github.com/redox-os/ransid/commit/f25f9a24fad345e7b4e8c2af0a893330b77a5777).
- [@jackpot51](https://github.com/jackpot51) Fixed `ESC D` and `ESC E` behavior. Details [here](https://github.com/redox-os/ransid/commit/c0dd20c31266199882b06851c4f658181b9089d8).
- [@jackpot51](https://github.com/jackpot51) Fixed some wrapping behaviors. Details [here](https://github.com/redox-os/ransid/commit/8b24ae5cd4e334afa277fc7075f8ea5672d7f71e).
- [@jackpot51](https://github.com/jackpot51) Fixe CSI `m`. Details [here](https://github.com/redox-os/ransid/commit/687cc864911eed89a68d819fbf1c95cc34426bfb).
- [@jackpot51](https://github.com/jackpot51) Implemented titlebar. Details [here](https://github.com/redox-os/ransid/commit/9478c7e02c2d5e43ef78a7931b8fb2b176c16aa8).
- [@jackpot51](https://github.com/jackpot51) Released `0.4.0`. Details [here](https://github.com/redox-os/ransid/commit/73c74d90c5514bc3eb36ec1e6009140be1e40f7f).
- [@jackpot51](https://github.com/jackpot51) Disabled `xenl`. Details [here](https://github.com/redox-os/ransid/commit/c94322362a4c7fbb6e37fe6e087c4ccd174ec624).
- [@jackpot51](https://github.com/jackpot51) Released 0.4.1. Details [here](https://github.com/redox-os/ransid/commit/a74e5c0b7097cb985505c3a26721e677645c7048).
- [@jackpot51](https://github.com/jackpot51) Released 0.4.2 - Which fixes cursor before printing char. Details [here](https://github.com/redox-os/ransid/commit/6ac43395a59e600e1649d2b007d85e878546278d).
- [@jackpot51](https://github.com/jackpot51) Released 0.4.3 - Fixing `pb`. Details [here](https://github.com/redox-os/ransid/commit/5958b37254a9d7ae58af2adc7d0b90a97355edf7).

## Users

Redox OS APIs for accessing users and groups information.

- [@goyox86](https://github.com/goyox86) Initial commit. Details [here](https://github.com/redox-os/users/commit/a22b3d5eda8d4996b2f00d870bc7a332046514db).
- [@goyox86](https://github.com/goyox86) Added LICENSE and README. Details [here](https://github.com/redox-os/users/commit/53682918af8a71825eb05414793d5de04381e350).
- [@goyox86](https://github.com/goyox86) Tweaked comments. Details [here](https://github.com/redox-os/users/commit/a4b16feb95fc0dea3ec8f03f3608e2bd3dd76456).
- [@goyox86](https://github.com/goyox86) Tweaks README. Details [here](https://github.com/redox-os/users/commit/d959e4d30b45aaacc6093ad57eec1d1061eea248).
- [@goyox86](https://github.com/goyox86) Updated README. Details [here](https://github.com/redox-os/users/commit/e9cdeaea8342e0d120345241041473c317e351c0).
- [@goyox86](https://github.com/goyox86) Updated Cargo.toml. Details [here](https://github.com/redox-os/users/commit/5cda74ef5c50a2ea5557d02770302c0c744e90cb).
- [@goyox86](https://github.com/goyox86) Made some renaming and improved docs. Details [here](https://github.com/redox-os/users/pull/1).
- [@goyox86](https://github.com/goyox86) Moved `Group` `users` field to be a vector of `String`s. Details [here](https://github.com/redox-os/users/pull/2).
- [@goyox86](https://github.com/goyox86) Implemened `AllUsers` iterator. Details [here](https://github.com/redox-os/users/pull/3).

## Userutils

User and group management utilities.

- [@goyox86](https://github.com/goyox86) Migrated to the new `redox_users` crate, some refactoring and docs. Details [here](https://github.com/redox-os/userutils/pull/14).
- [@goyox86](https://github.com/goyox86) Updated README and some more documentation tweaks. Details [here](https://github.com/redox-os/userutils/pull/15).

## Coreutils

The Redox coreutils.

- [@goyox86](https://github.com/goyox86) Migrated to the new `redox_users` crate. Details [here](https://github.com/redox-os/coreutils/pull/184).

## Newlib

A fork of newlib from git://sourceware.org/git/newlib-cygwin.git with Redox support

- [@sajattack](https://github.com/sajattack) Removed include of nonexistent endian.h file. Details [here](https://github.com/redox-os/newlib/pull/67).
- [@sajattack](https://github.com/sajattack) Added all the headers necessary for `openssh` to compile. Details [here](https://github.com/redox-os/newlib/pull/68).
- [@sajattack](https://github.com/sajattack) Replaced `glibc` headers with newlib ones where possible. Details [here](https://github.com/redox-os/newlib/pull/69).
- [@sajattack](https://github.com/sajattack) Removed `ioctl.h` and revert netdb.h for breaking ncurses and bash. Details [here](https://github.com/redox-os/newlib/pull/70).
- [@sajattack](https://github.com/sajattack) Removed `un.h` for breaking openssl. Details [here](https://github.com/redox-os/newlib/pull/71).
- [@sajattack](https://github.com/sajattack) Added `ssh` dependencies. Details [here](https://github.com/redox-os/newlib/pull/72).
- [@sajattack](https://github.com/sajattack) Implemented `scandir()` and `alphasort()`. Details [here](https://github.com/redox-os/newlib/pull/73).

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

Sorted in alphabetical order:

- [@AgustinCB](https://github.com/AgustinCB) 🎂
- [@AleVul](https://github.com/AleVul) 🎂
- [@BojanKogoj](https://github.com/BojanKogoj) 🎂
- [@dlrobertson](https://github.com/dlrobertson) 🎂
- [@Eijebong](https://github.com/Eijebong) 🎂
- [@gbutler69](https://github.com/gbutler69) 🎂
- [@pzmarzly](https://github.com/pzmarzly) 🎂

If I missed something, feel free to contact me [@goyox86](https://github.com/goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
