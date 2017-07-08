+++
title = "This Week in Redox 24"
author = "goyox86"
date = "2017-07-06T22:00:00+00:00"
+++

This is the 24th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA
If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# TL;DR

Welcome to another edition of "This Week in Redox"! Without further preamble let's dive in!

Starting with the **kernel** land [@jackpot51](https://github.com/jackpot51) started work on signals as this is needed for one of `cargo`'s dependencies. Also  [@ids1024](https://github.com/ids1024) Implemented the `getppid` system call. There was not much activity on the **drivers** side of things, only a fix for seek flags handling on the Intel HDA audio driver by [@xTibor](https://github.com/xTibor).

The folks of **Ion** specially [@huntergoldstein](https://github.com/huntergoldstein) have been on fire! Shipping a ton of stuff: adding sub-expressions, convenience methods `@graphemes(..)`, `@bytes(..)` and `@chars(..)` supporting different ways of iterating strings. Also, the addition of a really nice match-case construct to the grammar. [@mmstick](https://github.com/mmstick) along with [@myfreeweb](https://github.com/myfreeweb) have been working on **Ion**'s job control facility on things like adding support for process groups, handling of `SIGTERM` and `SIGTSTP` and the addition of `bg`, `wait` and `jobs` builtin commands.

On **TFS**  [@ticki](https://github.com/ticki) reenabled jemalloc as it was not the cause of this [bug](https://github.com/redox-os/tfs/issues/53). Something worth to mention is that we are currently having a sneaky segfault in one of the `conc::sync::treiber` tests, maybe *you* reading this have the fix and we don't now it!? ;) Jump in!

What about **coreutils**? Well, the `uptime` and `readlink` commands were added as well as a bunch of fixes and improvements for `stat`. **netutils**'s `httpd` was switched to the [Hyper](https://github.com/hyperium/hyper) crate and the **cookbook** has seen the birth of a Python language recipe by [@ids1024](https://github.com/ids1024). In **pkgutils** the `pkg` continues to evolve steadily. Where you wondering what [@jackpot51](https://github.com/jackpot51) has been doing? The answer is: starting the work on UEFI support! You can take a look [here](https://github.com/redox-os/uefi) and [here](https://github.com/redox-os/uefi_alloc). Rust `libstd` support for UEFI? Yes [that too!](https://github.com/system76/rust/tree/efi) (WIP though). And last but not least [@ids1024](https://github.com/ids1024) continues his work on GSoC trying to make Redox self-hosting! Notably his work on adding symlinks support to **redoxfs**.

# What's new in Redox?

## Kernel

- [@jackpot51](https://github.com/jackpot51) Started the work on signals. Details [here](https://github.com/redox-os/kernel/commit/0e8e1b5c4ef9d174458dd9a0d3d27cd113d10c4a).
- [@bjorn3](https://github.com/bjorn3) Fixed a lot of lint warnings. Details [here](https://github.com/redox-os/kernel/pull/19).
- [@ids1024](https://github.com/ids1024) Implemented the `getppid` system call. Details [here](https://github.com/redox-os/kernel/pull/26).
- [@ids1024](https://github.com/ids1024) Fixed a bug in the `clone` system call. Details [here](https://github.com/redox-os/kernel/pull/27).

## Ion

[Ion](https://github.com/redox-os/ion) is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

- [@huntergoldstein](https://github.com/huntergoldstein) Added arithmetic sub-expressions to Ion's syntax. Details [here](https://github.com/redox-os/ion/pull/327).
- [@mmstick](https://github.com/mmstick) Converted `@[]` to `@()`. Details [here](https://github.com/redox-os/ion/commit/94e5e8e9236e2aadb4f8065ccec4f84ef1d7bce2).
- [@huntergoldstein](https://github.com/huntergoldstein) Removed an extra read increment in glob branch. Details [here](https://github.com/redox-os/ion/pull/334).
- [@huntergoldstein](https://github.com/huntergoldstein) Empty argument slice now results in empty command. Details [here](https://github.com/redox-os/ion/pull/335).
- [@huntergoldstein](https://github.com/huntergoldstein) Added `@graphemes(..)`, `@bytes(..)` and `@chars(..)` for improved string iteration. Details [here](https://github.com/redox-os/ion/pull/338).
- [@jdanford](https://github.com/jdanford) Fixed some grammar issues on the README. Details [here](https://github.com/redox-os/ion/pull/340)
- [@huntergoldstein](https://github.com/huntergoldstein) Refactored `array_expand` (and squashed bug). Details [here](https://github.com/redox-os/ion/pull/341).
- [@huntergoldstein](https://github.com/huntergoldstein) Made `Shell::readln` to complete to a file name if the last word is a file. Details [here](https://github.com/redox-os/ion/pull/342).
- [@mmstick](https://github.com/mmstick) Added documentation to `shell::completer`. Details [here](https://github.com/redox-os/ion/commit/fa37ae6e2ec7fc6038d12068461101b3025c3590).
- [@mmstick](https://github.com/mmstick) Implemented explicit array assignments. Details [here](https://github.com/redox-os/ion/commit/b7a931173c91cd13909592d1c9a701d77d24da9c).
- [@mmstick](https://github.com/mmstick) Updated the README to display explicit array syntax. Details [here](https://github.com/redox-os/ion/commit/f51448bb96b8aedc70564d472f8f09b24452d4d3).
- [@huntergoldstein](https://github.com/huntergoldstein) Made possible to pass an empty string to commands, functions, etc. Details [here](https://github.com/redox-os/ion/pull/346).
- [@MovingtoMars](https://github.com/MovingtoMars) Updated `liner` and `peg` dependencies. Details [here](https://github.com/redox-os/ion/pull/349).
- [@huntergoldstein](https://github.com/huntergoldstein) Introduced a match-case construct to Ion's grammar. Details [here](https://github.com/redox-os/ion/pull/351).
- [@huntergoldstein](https://github.com/huntergoldstein) Fixed executables completion. Details [here](https://github.com/redox-os/ion/pull/353).
- [@MovingtoMars](https://github.com/MovingtoMars) Updated dependencies to fix a bug with `liner` in vi mode. Details [here](https://github.com/redox-os/ion/pull/355).
- [@mmstick](https://github.com/mmstick) Implemented SIGTERM handling. Details [here](https://github.com/redox-os/ion/commit/c32cd6d7f7a1f679d43a7d7277a5b20265ca7d96).
- [@huntergoldstein](https://github.com/huntergoldstein) Forced `run_examples.sh` to use project root as working directory. Details [here](https://github.com/redox-os/ion/pull/357).
- [@jwbowen](https://github.com/jwbowen) Updated the minimum `rustc` version requirement. Details [here](https://github.com/redox-os/ion/pull/360).
- [@mmstick](https://github.com/mmstick) Implemented SIGTSTP (Ctrl+Z) handling and wait/jobs/bg builtins. Details [here](https://github.com/redox-os/ion/commit/d9506aa6c8a7851981547736161a168ccf0ad69b).
- [@mmstick](https://github.com/mmstick) Started the work on `fg`. Details [here](https://github.com/redox-os/ion/commit/c38bf3598e8037e8268024d36c049433ce47886a).
- [@myfreeweb](https://github.com/myfreeweb) Added more work on job control and fixed a pid bug. Details [here](https://github.com/redox-os/ion/pull/362).
- [@mmstick](https://github.com/mmstick) Added support for monitoring child with `waitpid` and forking shell with with background jobs. Details [here](https://github.com/redox-os/ion/commit/4bae77d2df58dbf58cbedc9b33f5197851635bcb).
- [@mmstick](https://github.com/mmstick) Did some work on storing configurations in the correct XDG app dir. Details [here](https://github.com/redox-os/ion/pull/362).
- [@huntergoldstein](https://github.com/huntergoldstein) Fixed a broken Redox build. Details [here](https://github.com/redox-os/ion/pull/365).
- [@mmstick](https://github.com/mmstick) Added support for creating initrc and history files if they don't exist. Details [here](https://github.com/redox-os/ion/commit/8e0b1e37a585168b04bfae29bdecfd8e95e1db16).

## Drivers

- [@xTibor](https://github.com/xTibor) Fixed seek flags in the Intel HDA Audio driver. Details [here](https://github.com/redox-os/drivers/pull/17).

## Redoxfs

- [@ids1024](https://github.com/ids1024) Implemented symbolic links. Details [here](https://github.com/redox-os/redoxfs/pull/18), [here](https://github.com/redox-os/redoxfs/pull/19), [here](https://github.com/redox-os/redoxfs/pull/20), [here](https://github.com/redox-os/redoxfs/pull/21) and [here](https://github.com/redox-os/redoxfs/pull/22).

## TFS

[TFS](https://github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

- [@ticki](https://github.com/ticki) Brought back jemalloc into `conc` (turns out it was not a bug in jemalloc). Details [here](https://github.com/redox-os/tfs/commit/c78bceef2b7f3223a4cab1fa63c797bd0ec6b4eb).
- [@ticki](https://github.com/ticki) Fixed the `conc::sync::treiber::tests::increment` test, which previously was looping infinitely. Details [here](https://github.com/redox-os/tfs/commit/473e4ab2c607a1340769fa35777f05cb0dd23c38).
- [@ticki](https://github.com/ticki) Added a test for nested `conc::Atomic`. Details [here](https://github.com/redox-os/tfs/commit/cb4518cdff948c22163b9e1bfdf72c4be66cd2e4).
- [@ticki](https://github.com/ticki) Introduced `conc::Atomic::destroy_no_guard()` for no-overhead destruction of the atomic. Details [here](https://github.com/redox-os/tfs/commit/65c120216c155808962a0336ac75671663d66269).
- [@ticki](https://github.com/ticki) Fixed the destructor of `conc::sync::treiber`, which previously was double dropping. Details [here](https://github.com/redox-os/tfs/commit/921303f83451dca1954447dcdf50f6aff81e812b).
- [@ticki](https://github.com/ticki) Made a fix to prevent calling destructors on null pointers in `conc::sync::treiber`. Details [here](https://github.com/redox-os/tfs/commit/6bd5bd5614effaa4016394d24ad2881aab8d4e51).
- [@ticki](https://github.com/ticki) Made a change to ensure that `conc::Treiber::drop` doesn't cause double-drop of the inner. Details [here](https://github.com/redox-os/tfs/commit/0b15e8bdfcda359501763d77eb0eb76d32f30a3b).
- [@ticki](https://github.com/ticki) Added a test for `conc::Atomic<()>`. Details [here](https://github.com/redox-os/tfs/commit/cc587063ee5fbcd67f42996da026a1f373ccd0ff).
- [@ticki](https://github.com/ticki) Provide a message on why `conc::Guard` is `must_use`. Details [here](https://github.com/redox-os/tfs/commit/18b5179a537d6215a26312547d3e9594fb114c8e).
- [@ticki](https://github.com/ticki) Removed some warnings in `conc`. Details [here](https://github.com/redox-os/tfs/commit/077911f12e1141ef5b80fb502258a90e89ac2c42).
- [@ticki](https://github.com/ticki) Updated `parking_lot` and `owning_ref` in `chasmap`. Details [here](https://github.com/redox-os/tfs/commit/b09a9a07b53364b8ce9139d3c645223cf67308e3).

## Coreutils

- [@goyox86](https://github.com/goyox86) Added the `uptime` command. Details [here](https://github.com/redox-os/coreutils/pull/155).
- [@ids1024](https://github.com/ids1024) Added the `readlink` command. Details [here](https://github.com/redox-os/coreutils/pull/156).
- [@ids1024](https://github.com/ids1024) Improved the `stat` command. Details [here](https://github.com/redox-os/coreutils/pull/157).
- [@ids1024](https://github.com/ids1024) Made `stat` use `O_NOFOLLOW`. Details [here](https://github.com/redox-os/coreutils/pull/158).
- [@sebastianpfluegelmeier](https://github.com/sebastianpfluegelmeier) Added support for `ls` columned output. Details [here](https://github.com/redox-os/coreutils/pull/159).
- [@ids1024](https://github.com/ids1024) Made `stat` use `libstd` instead of system calls. Details [here](https://github.com/redox-os/coreutils/pull/160).

## Netutils

- [@ids1024](https://github.com/ids1024) Switched `httpd` to use the Hyper crate. Details
[here](https://github.com/redox-os/netutils/pull/23).

## Cookbook

The [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes of Redox. The effort on self-hosting continues! And [@ids1024](https://github.com/ids1024) is working hard on a `cargo` recipe. How cool is that?

- [@ids1024](https://github.com/ids1024) Added a system for compile-time dependencies (needed for openssl). Details [here](https://github.com/redox-os/cookbook/pull/39).
- [@ids1024](https://github.com/ids1024) Updated `gcc` and `dash` recipes to create symlinks. Details [here](https://github.com/redox-os/cookbook/pull/36).
- [@ids1024](https://github.com/ids1024) Added a recipe for Python. Details [here](https://github.com/redox-os/cookbook/pull/37).
- [@ids1024](https://github.com/ids1024) Made a change to forward the target to `pkg`. Details [here](https://github.com/redox-os/cookbook/pull/35).

## Pkgutils

The [pkgutils](https://github.com/redox-os/cookbook) are a set of utilities for package management on Redox.

- [@ids1024](https://github.com/ids1024) Added support for determining the default target based on LLVM triple at build. Details [here](https://github.com/redox-os/pkgutils/pull/15).
- [@ids1024](https://github.com/ids1024) Prevented the following of symbolic links when creating packages. Details [here](https://github.com/redox-os/pkgutils/pull/16).
- [@ids1024](https://github.com/ids1024) Improved the error handling in `pkg`. Details [here](https://github.com/redox-os/pkgutils/pull/17).
- [@ids1024](https://github.com/ids1024) Added a `--root` argument to `pkg` also now the help message is printed when no subcommand. Details [here](https://github.com/redox-os/pkgutils/pull/18).

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

-  clippix 🎂
- goyox86 🎂
- myfreeweb 🎂

If I missed something, feel free to contact me (goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
