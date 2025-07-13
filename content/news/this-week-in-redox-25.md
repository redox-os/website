+++
title = "This Week in Redox 25"
author = "goyox86"
date = "2017-07-14T18:00:00+00:00"
+++

This is the 25th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# What's new in Redox?

## TL;DR

Big news this week: We released **0.3.0**.It is a big release including many improvements notably the Cookbook based build system and a new ACPI stack. Go read the [announcement](https://github.com/redox-os/redox/releases/tag/0.3.0)!

Now to this weeks summary: We shipped a couple of changes to the bootstrap script and the cookbook that should make the on-boarding on macOS smooth again. Go ahead try and give us feedback <3.

The **kernel** was very active this week, particularly with the landing of the initial support for signals by [@jackpot51](https://github.com/jackpot51)! Also, a new API for specifying custom memory allocators and changes in the `alloc` crate API landed in nightly so the kernel had to be updated. Mr [@CWood1](https://github.com/CWood1) added an HPET (High Precision Event Time) driver to the kernel and also moved the PIT (Programmable Interval Timer) driver from the bootloader to the kernel as part of his ongoing work on ACPI. [@ids1024](https://github.com/ids1024) shipped some fixes to kernel's `dup2()` and `exec()` too.

**Ion** impressive streak continues mainly propelled (but no limited to) by  [@mmstick](https://github.com/mmstick) and [@huntergoldstein](https://github.com/huntergoldstein). **Ion**'s biggest highlight this week? The completion of job control and addition of the `fg` builtin command! Also asynchronous history writing, the addition of an `array!` macro to ease the creation of  inline `Array`s in Ion's codebase, initial support for herestrings, the extraction of `calc` to it's own crate, refactoring to signal handling, forking, the reimplementation of `pipelines::collect` into a recursive descendent parser, `set -x`'s implementation and many fixes. You should try it , works in Linux too ;).

**Drivers** had to also be updated to the new `alloc` API (mainly `vesad`). **Coreutils** now have a `base64` command by  [@goyox86](https://github.com/goyox86), a new shiny `dirname` command along with recent support for `rm` for the `-f` flag thanks to [@ids1024](https://github.com/ids1024).

Other important highlight is the addition of initial `mtime/ctime` support and the implementation of `futimens` in **Redoxfs**.

Last but not least the **cookbook** saw a lot of activity with a new system for compile-time dependencies by [@ids1024](https://github.com/ids1024) and package recipes for `git`, `gawk`, `findutils`, GNU `sed`, `pastel`, `nasm`, `rustual-boy`.

## Kernel

- [CWood1](https://github.com/CWood1) Added an HPET (High Precision Event Time) driver to the kernel and also moved the PIT (Programmable interval timer) driver from the bootloader to the kernel.
- [@ids1024](https://github.com/ids1024) Made `dup2()` work even if second file descriptor doesn't exist. Details [here](https://github.com/redox-os/kernel/pull/34).
- [@ids1024](https://github.com/ids1024) Made a fix for `process::exec()` by stripping whitespaces after shebangs. Details [here](https://github.com/redox-os/kernel/pull/32).
- [@ids1024](https://github.com/ids1024) Made a fix for `process::exec()` and now it passes the relative, not canonicalised, path to scripts. Details [here](https://github.com/redox-os/kernel/pull/33).
- [@ids1024](https://github.com/ids1024) Made `pipe::read()` return when write end is closed (but it was afterwards reverted). Details [here](https://github.com/redox-os/kernel/pull/29).
- [@jackpot51](https://github.com/jackpot51) Updated the kernel to the new Rust allocator API. Details [here](https://github.com/redox-os/kernel/commit/3f40af0687086a52f21587730ac87a87d7956a7e).
- [@jackpot51](https://github.com/jackpot51) Implemented passthrough of futimens . Details [here](https://github.com/redox-os/kernel/commit/7e52541f39be01a011a9cc470d01c35f318fc78c).
- [@jackpot51](https://github.com/jackpot51) Added the initial implementation of signal handling. Details [here](https://github.com/redox-os/kernel/commit/b5ff0aabd561c1befcc583aa0d7139fddabda27b).
- [@jackpot51](https://github.com/jackpot51) Allowed simple signal delivery to PID 1 (the kernel idle process). Details [here](https://github.com/redox-os/kernel/commit/a3493d16fdd26b7422282b7b07b30db74089cb56).

## Ion

[Ion](https://github.com/redox-os/ion) is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

- [@mmstick](https://github.com/mmstick) Ensured the termination of pipes and jobs. Details [here](https://github.com/redox-os/ion/commit/4035d7d59a2ed774c748f3a144b9c9778c4c059d).
- [@z3ntu](https://github.com/z3ntu) Updated `version_check` to 0.1.3. Details [here](https://github.com/redox-os/ion/pull/394).
- [@huntergoldstein](https://github.com/huntergoldstein) Made `Test` able to interpret the empty string along with a big refactor. Details [here](https://github.com/redox-os/ion/pull/396).
- [@mmstick](https://github.com/mmstick) Implemented async history writing with his `liner` until the async work gets mainstreamed to `liner`. Details [here](https://github.com/redox-os/ion/commit/1afe9620a1db6e5dd0092c0033e694e4e0e2a4ba).
- [@huntergoldstein](https://github.com/huntergoldstein) Made tilde now properly expand inside a normal word. Details [here](https://github.com/redox-os/ion/pull/398).
- [@huntergoldstein](https://github.com/huntergoldstein) Added support for resolved quotes not being an escaped character. Details [here](https://github.com/redox-os/ion/pull/399).
- [@mmstick](https://github.com/mmstick) Documented `Shell` structure. Details [here](https://github.com/redox-os/ion/commit/ea4b98c94f218c72921f398d614b674c58cc94c4).
- [@clippix](https://github.com/clippix) Fixed the build by changing the type of a field in `Shell` to `Option`. Details [here](https://github.com/redox-os/ion/pull/403).
- [@huntergoldstein](https://github.com/huntergoldstein) Added an `array!` macro for creating inline `Array`s. Details [here](https://github.com/redox-os/ion/pull/404).
- [@huntergoldstein](https://github.com/huntergoldstein) Made tildes now part of normal tokens. Details [here](https://github.com/redox-os/ion/pull/407).
- [@huntergoldstein](https://github.com/huntergoldstein) Support for herestrings and heredocs is now completed. Details [here](https://github.com/redox-os/ion/pull/405).
- [@jackpot51](https://github.com/jackpot51) Made a small fix to `shell::pipe()`. Details [here](https://github.com/redox-os/ion/commit/a5d579bbffe1dd4cc6751825d3468f4bb556ca7c).
- [@huntergoldstein](https://github.com/huntergoldstein) Fixed autocompletion for partially escaped filenames. Details [here](https://github.com/redox-os/ion/pull/373).
- [@huntergoldstein](https://github.com/huntergoldstein) Updated example in README to reflect tilde expansion rules. Details [here](https://github.com/redox-os/ion/pull/377).
- [@huntergoldstein](https://github.com/huntergoldstein) Added a warning when a script completes with a statement in memory. Details [here](https://github.com/redox-os/ion/pull/376).
- [@mmstick](https://github.com/mmstick) Completed Job Control: `fg` works now! Details [here](https://github.com/redox-os/ion/commit/8fc7729400b7ba8b2bad8e5248be61b9a39472eb).
- [@mmstick](https://github.com/mmstick) Refactored signals code. Details [here](https://github.com/redox-os/ion/commit/5f0ed860d8c52032b889b811dfb3989732349ed1), [here](https://github.com/redox-os/ion/commit/f45b5f232a2b6a767e384c88e99700b782818dc4) and [here](https://github.com/redox-os/ion/commit/bea32bbff29f376c90e72ab5b6a56eea3e078353).
- [@mmstick](https://github.com/mmstick) Refactored forking code. Details [here](https://github.com/redox-os/ion/commit/b1cac10aa5b12a6fb36d01c9fe64d6b84706e78b).
- [@mmstick](https://github.com/mmstick) Fixed signal ignoring with`cat /dev/urandom | head`. Details [here](https://github.com/redox-os/ion/commit/48f48af901e09c59a104dacb1a3d1bf74f56df85).
- [@huntergoldstein](https://github.com/huntergoldstein) Rewrote `pipelines::collect` to be a recursive descent parser. Details [here](https://github.com/redox-os/ion/pull/382).
- [@mmstick](https://github.com/mmstick) Made background jobs display command arguments. Details [here](https://github.com/redox-os/ion/commit/c6f90de62a54868cbb2ec34b060cb5af6e499716).
- [@mmstick](https://github.com/mmstick) Implement `set -x`. Details [here](https://github.com/redox-os/ion/commit/8f3df249de8b7c410c83e1574f6e1de7756212f2).
- [@mmstick](https://github.com/mmstick) Re-enabled ability to break control flow when signalled. Details [here](https://github.com/redox-os/ion/commit/e3a519b3bcec4cf20bd247837eb46493b0133bf6).
- [@mgmoens](https://github.com/mgmoens) Extracted `calc` to it's own crate. Details [here](https://github.com/redox-os/ion/pull/372).

## Drivers

- [@jackpot51](https://github.com/jackpot51) Updated `vesad` to the new `alloc` API and added a `gitignore`. Details [here](https://github.com/redox-os/drivers/commit/cd782acf77d7d7fd00e843282b1f765ce6c13ab7).

## Redoxfs

- [@jackpot51](https://github.com/jackpot51) Removed unnecessary feature gate for associated constants. Details [here](https://github.com/redox-os/redoxfs/commit/dcce0d9e6e0519c486e1210ba792a9af13601c91).
- [@jackpot51](https://github.com/jackpot51) Added initial `mtime/ctime` support. Details [here](https://github.com/redox-os/redoxfs/commit/9471a2e4109d57c833aafc22536c0efd020021ff).
- [@jackpot51](https://github.com/jackpot51) Add times to stat. Details [here](https://github.com/redox-os/redoxfs/commit/1f97d8220cd48cd3ddcb917d23337f15104234cf).
- [@jackpot51](https://github.com/jackpot51) Implemented `futimens`. Details [here](https://github.com/redox-os/redoxfs/commit/8d66d9ce54490cf92b69aef12e2409dec448bf40).
- [@ids1024](https://github.com/ids1024) Made a fix for `fcntl` preventing it from clobbering access mode. Details [here](https://github.com/redox-os/redoxfs/pull/24).

## TFS

[TFS](https://github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

- [@ticki](https://github.com/ticki) Made an update to `parking_lot` and `owning_ref` in `chasmap` and a added some docs to `sync::Treiber`. Details [here](https://github.com/redox-os/tfs/commit/b09a9a07b53364b8ce9139d3c645223cf67308e3).
- [@ticki](https://github.com/ticki) Added a debug assertion against faulty hazards. Details [here](https://github.com/redox-os/tfs/commit/24f8064e3e0a0d38fe03fdf960a99086ca8ed0f4).

## Coreutils

- [@jackpot51](https://github.com/jackpot51) Fixed the formatting of symlink in long mode in `ls`. Details [here](https://github.com/redox-os/coreutils/commit/562223b7e030e57718b5e8884c5db9689380f9ba).
- [@ids1024](https://github.com/ids1024) Made a fix to `stat` in order to format time properly and display user and group name. Details [here](https://github.com/redox-os/coreutils/pull/161).
- [@ids1024](https://github.com/ids1024) Made `touch` to use the `filetime` crate. Details [here](https://github.com/redox-os/coreutils/pull/162).
- [@goyox86](https://github.com/goyox86) Corrected the `filetime` dependency so it points to the mainstream repo. Details [here](https://github.com/redox-os/coreutils/pull/163).
- [@ids1024](https://github.com/ids1024) Added the `-f` argument to `rm`. Details [here](https://github.com/redox-os/coreutils/pull/162).
- [@goyox86](https://github.com/goyox86) Removed some unneeded  code in `uptime`. Details [here](https://github.com/redox-os/coreutils/pull/165).
- [@ids1024](https://github.com/ids1024) Added the `dirname` command. Details [here](https://github.com/redox-os/coreutils/pull/166).
- [@goyox86](https://github.com/goyox86) Added the `base64` command. Details [here](https://github.com/redox-os/coreutils/pull/166).

## Cookbook

The [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes of Redox.

- [@ids1024](https://github.com/ids1024) Added a system for compile-time dependencies; (used in `openssl`). Details [here](https://github.com/redox-os/cookbook/pull/39).
- [@ids1024](https://github.com/ids1024) Added a `git` recipe. Details [here](https://github.com/redox-os/cookbook/pull/40).
- [@xTibor](https://github.com/xTibor) Added `rustual-boy` package recipe. Details [here](https://github.com/redox-os/cookbook/pull/44).
- [@ids1024](https://github.com/ids1024) Fixed `repo.sh` call for build dependencies. Details [here](https://github.com/redox-os/cookbook/pull/43).
- [@ids1024](https://github.com/ids1024) Remove some unneeded code in the python recipe. Details [here](https://github.com/redox-os/cookbook/pull/45).
- [@ids1024](https://github.com/ids1024) Added a recipe for `gawk`. Details [here](https://github.com/redox-os/cookbook/pull/46).
- [@goyox86](https://github.com/goyox86) Added some code in the cookbook system to determine tools at runtime and fix macOS build. Details [here](https://github.com/redox-os/cookbook/pull/47).
- [@ids1024](https://github.com/ids1024) Added a recipe for GNU `sed`. Details [here](https://github.com/redox-os/cookbook/pull/48).
- [@ids1024](https://github.com/ids1024) Added a recipe for uutils `findutils`. Details [here](https://github.com/redox-os/cookbook/pull/49).
- [@jackpot51](https://github.com/jackpot51) Add a recipe for `pastel`. Details [here](https://github.com/redox-os/cookbook/commit/5b78bf1d6c134cd6a2f23ed4fbd935ea9610c26a).
- [@7h0ma5](https://github.com/7h0ma5)  Added a recipe for `nasm`. Details [here](https://github.com/redox-os/cookbook/pull/42).

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

- Luca Weiss 🎂
- Thomas Gatzweiler 🎂

If I missed something, feel free to contact me (goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
