+++
title = "This Week in Redox 30"
author = "goyox86"
date = "2017-10-13 11:57:31 +0100"
+++

This is the 30th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by [@goyox86](https://github.com/goyox86))*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

## TL;DR

Hello there! And welcome to another edition of TWiR!

As usual, we have been busy making Redox better and we have a couple of exciting news to share. So, Let's get started!

First of all, [@andre](https://github.com/andre-richter) pointed out that the Docker experience has been improved. Among others, consecutive builds are now way faster because `cargo` downloads are cached with named volumes. Also, there's documentation for running the container interactively now. Please check it out [here](https://github.com/redox-os/redox/blob/master/docker/README.md)!

We are super excited about the work done by [@jackpot51](https://github.com/jackpot51) towards the installer support. For example, the **bootloader** now supports filesystem UUID detection and is able to send that information to the kernel at boot time. The **kernel** has notably gained the ability to receive environment variables at the main entry point (`kmain`) this is needed to being able to receive that `REDOXFS_UUID` environment with the filesystem UUID to be mounted. It's also worth mentioning that [@jackpot51](https://github.com/jackpot51) made some refactoring to the **kernel** arguments infrastructure.

The other very important change is related to schemes. Redox now supports hierarchical schemes enabling for example, more than one disk controller.

Other exciting news in the **kernel** is the work on capability based security. Basically, capability mode will make a process unable to open new file descriptors unless it has required access to it, improving security and allowing more reasoning about the system. The `sys:iostat` scheme for example, should tell you what any process is allowed to do, once it is in capability mode. You can read more about capability based security [here](https://en.wikipedia.org/wiki/Capability-based_security) and also check out [FreeBSD's implementation of this model](https://wiki.freebsd.org/Capsicum).

Along with this work is the support for disk hierarchies added to the AHCID **driver** and the support for capability mode added to all the **drivers** by using the `0` namespace (also known as null namespace). In addition to that, we have now a `vmmouse` driver which should improve significantly the mouse support in `QEMU`.

**Redoxfs** was cleaned to allow use of most functions when linking the library, including mounting and creating file systems. It was also extended to allow a bootloader to be written during `redoxfs-mkfs` but, without doubt, the most notable feature is the addition of `UUID` support, enabling file systems to be mounted by `UUID` (used by the installer).

Moving up to the userland we have **Ion** which experienced a lot of changes and improvements notably: The initial work on library support, the support for custom prompts via the `PROMPT` function, the implementation of `$find()` and `@split_at()`, support multi-line array assignments and lots of refactoring to the `words` module all by [@mmstick](https://github.com/mmstick).

The **cookbook** got some new packages (a lot of the related to games and emulators ;)): notably `2048`, `cleye`, `rust64` and `rs-nes` thanks to [@jackpot51](https://github.com/jackpot51).

The **coreutils** `yes` utility was improved by [@youknowone](https://github.com/youknowone) to show invalid parameter error rather than silencing 'y'.

On the GUI side of things **Orbital** was updated to use the `null` namespace and [@dummie999](https://github.com/dummie999) was busy with **Sodium** adding line numbers, wrapping long lines, fixing a bug that could cause panic when deleting lines, fixing a bug when entering invalid commands in prompt and making buffers behave more consistent.

*Bonus*: There is a new release in the works. It should be out in the next few days, make sure you give it a spin!

## Bootloader

Redox OS Bootloader

- [@jackpot51](https://github.com/jackpot51) Made a change to prepare `bootloader` for use in installer. Details [here](https://github.com/redox-os/bootloader/commit/cccb19d19ff27724e412cf3b21750f82ebbb20d1).
- [@jackpot51](https://github.com/jackpot51) Printed UUID, cleaned up print functions, and reformated kernel arguments. Details [here](https://github.com/redox-os/bootloader/commit/d48e8237f215ce9dbe0a6d2a1dde89047b69e6b6).
- [@jackpot51](https://github.com/jackpot51) Added support to send REDOXFS_UUID to kernel. Details [here](https://github.com/redox-os/bootloader/commit/3755c7cbdd64d5707608d6a499835ce46db1f08e).
- [@jackpot51](https://github.com/jackpot51) Fixed an off-by-one error when copying env. Details [here](https://github.com/redox-os/bootloader/commit/7c4ef88003726359a3b53140fc68c5fd723d135b).

## Kernel

The Redox microkernel

- [@jackpot51](https://github.com/jackpot51) Updated README.md. Details [here](https://github.com/redox-os/kernel/commit/55ed5f81c3ffed7042bdc47d10c68bdb984a9e6c) and [here](https://github.com/redox-os/kernel/commit/735802366fcfcf84ea36577061c273c34c6d3b0f).
- [@jackpot51](https://github.com/jackpot51) Created LICENSE. Details [here](https://github.com/redox-os/kernel/commit/23e30c14a89ec4c49e1c70a5fd4a2cc91fc67c31).
- [@jackpot51](https://github.com/jackpot51) Fixed the output of build script. Details [here](https://github.com/redox-os/kernel/commit/37c9250a527e025b2d33c58cbdcaec629806ba75).
- [@jackpot51](https://github.com/jackpot51) Updated dependencies. Details [here](https://github.com/redox-os/kernel/commit/9a9f5d17cb0ba93dd6d973423f33eaa320ab1b9c).
- [@jackpot51](https://github.com/jackpot51) Fixed more documentation. Details [here](https://github.com/redox-os/kernel/commit/bdff0dd004686effd8a1a1db256af178677df118).
- [@jackpot51](https://github.com/jackpot51) Updated features for latest nightly. Details [here](https://github.com/redox-os/kernel/commit/fcf8120eec53bcabfa6939c900f31c9d3bc91972).
- [@jackpot51](https://github.com/jackpot51) Chnaged hybrid -> micro. Details [here](https://github.com/redox-os/kernel/commit/01a881243b3c51939af29426cfd86ec3014967e4).
- [@jackpot51](https://github.com/jackpot51) Updated README.md. Details [here](https://github.com/redox-os/kernel/commit/aa3c1515a0b67dc0d56dc69a3a08110a202dbc81).
- [@jackpot51](https://github.com/jackpot51) Downgraded `goblin` crate. Details [here](https://github.com/redox-os/kernel/commit/49ef95a156b1d5524724a2bb2e8c92d29cb24a65).
- [@jackpot51](https://github.com/jackpot51) Allowed the listing of `root` scheme. Details [here](https://github.com/redox-os/kernel/commit/ce87b7fc6c7cf7085f5ba747ff887a5e715b1d14).
- [@jackpot51](https://github.com/jackpot51) Reformated kernel arguments. Details [here](https://github.com/redox-os/kernel/commit/41ee250eeab82ee7ae69f42e302b934a539122e5).
- [@jackpot51](https://github.com/jackpot51) Passed `env` to the first function. Details [here](https://github.com/redox-os/kernel/commit/0794926493a26a1384063e792e7df3de88faa373).
- [@jackpot51](https://github.com/jackpot51) Moved location of live disk. Details [here](https://github.com/redox-os/kernel/commit/808447cbfbd8d52d5383d22d25f806cefe3bed2a).
- [@jackpot51](https://github.com/jackpot51) Adedd `target-c-int-width` to `x86_64` target. Details [here](https://github.com/redox-os/kernel/commit/c417f0cf001edcda04c765f1ffedd8fc8736643f).
- [@jaje](https://github.com/jaje)  Deduplicated `memcpy`, `memmove`, `memset` and `memcmp` functions. Details [here](https://github.com/redox-os/kernel/pull/56).
- [@jackpot51](https://github.com/jackpot51) Added capability mode support using `null` namespace. Details [here](https://github.com/redox-os/kernel/pull/57).
- [@GabrielMajeri](https://github.com/GabrielMajeri) Updated to `bitflags` version 1.0. Details [here](https://github.com/redox-os/kernel/pull/58).

## Drivers

Redox OS Drivers

- [@jackpot51](https://github.com/jackpot51) Updated cargo.lock. Details [here](https://github.com/redox-os/drivers/commit/94b869cd61957e340c648788fd2de8bb87ed5150).
- [@jackpot51](https://github.com/jackpot51) Made a change to use disk hierarchy. Details [here](https://github.com/redox-os/drivers/commit/8e41cb9f032593c078f129aa740cc4c2a6124a4e).
- [@jackpot51](https://github.com/jackpot51) Added `vmmouse` support. Details [here](https://github.com/redox-os/drivers/commit/e4a297b725c0b3339920d00f826e8fa1cc43ecb9).
- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock. Details [here](https://github.com/redox-os/drivers/commit/e3a9314a5a2ba2fe5ae3f6653371b5b67e3c558b).
- [@jackpot51](https://github.com/jackpot51) Added support to use capability mode (`null` namespace) for drivers. Details [here](https://github.com/redox-os/drivers/pull/19).
- [@jackpot51](https://github.com/jackpot51) Update Cargo.lock. Details [here](https://github.com/redox-os/drivers/commit/12989384c050273002b11ce55406e9ffb334b89b).

## Ion

The Ion Shell. Compatible with Redox and Linux.

- [@mmstick](https://github.com/mmstick) Added initial library support. Details [here](https://github.com/redox-os/ion/commit/e9d865605f773e5e6183434185af8f46ec289ede).
- [@mmstick](https://github.com/mmstick) Made variables struct cloneable. Details [here](https://github.com/redox-os/ion/commit/3d4241776cc6d4e7b52a230ba62abbe0550511c4).
- [@mmstick](https://github.com/mmstick) disable `tcsetpgrp` when using Ion as a library. Details [here](https://github.com/redox-os/ion/commit/bfb7d6eb6f2f10d9163b2ed3acd0ccd1d7f40921).
- [@mmstick](https://github.com/mmstick) Implemented `PROMPT` function support, to use a function to generate a prompt, simply create a function whose name is `PROMPT`. Details [here](https://github.com/redox-os/ion/commit/cc5fba63c5ab4f422a54891d35890ee12d5e646c).
- [@mmstick](https://github.com/mmstick) Re-ran `cargo fmt`. Details [here](https://github.com/redox-os/ion/commit/3424e2ecaf09dca7512200cc9054f3795e31f682).
- [@mmstick](https://github.com/mmstick) Made `export VAR` exports local variables. Details [here](https://github.com/redox-os/ion/commit/863d77946da26e291d525677362477faa0b57a14).
- [@mmstick](https://github.com/mmstick) Added better error message for detected invalid implicit `cd` commands. Details [here](https://github.com/redox-os/ion/commit/7d06182abfc4cabf453e7cdd4368afdf01bb8619).
- [@mmstick](https://github.com/mmstick) Made a change so commands can be expanded now. Details [here](https://github.com/redox-os/ion/commit/a8c22d161eeb38f7234e1e3453d24ab5927c976f).
- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock. Details [here](https://github.com/redox-os/ion/commit/5926d679491b7b7e696659c7ad174e05477735e1).
- [@mmstick](https://github.com/mmstick) Applied fixed for #543, closes #543. Details [here](https://github.com/redox-os/ion/commit/939c9165dcd64abb4562043c227925836325182d).
- [@mmstick](https://github.com/mmstick) Applied fixes for #544, closes #544. Details [here](https://github.com/redox-os/ion/commit/5e39de0abbfbd3b1ef786b15cd1cbb7ff86e5fa5).
- [@mmstick](https://github.com/mmstick) Fixed the integration tests. Details [here](https://github.com/redox-os/ion/commit/edd4ff21ba87bcc748ae88ce97534d751dca1c51).
- [@mmstick](https://github.com/mmstick) Implemented the `-n` flag, closes #529. Details [here](https://github.com/redox-os/ion/commit/2e4bd3774904f11fa9c68b114210a5a46bec7890).
- [@mmstick](https://github.com/mmstick) Switched to `d128` fork of `calculate`, this addresses precision issues with floating point math by converting. Details [here](https://github.com/redox-os/ion/commit/59ee8e9ced649392e9b3ce80494556c50e46a4d8).
- [@mmstick](https://github.com/mmstick) Reverted to `master` branch of `calculate` crate. Details [here](https://github.com/redox-os/ion/commit/42b8e2715e7d5925b74cddd3c2763d289d6d31c8).
- [@mmstick](https://github.com/mmstick) Improved methods documentation. Details [here](https://github.com/redox-os/ion/commit/09cb2ba16c52ceee8dc75b5c578d02424db27514).
- [@mmstick](https://github.com/mmstick) Fixed #549, closed #549. Details [here](https://github.com/redox-os/ion/commit/4e77a83067b0526eab9629ad12b619d4b45545f7).
- [@Kvikal](https://github.com/Kvikal) Changed `is_array` to properly return `false` when multiple arrays are present. Details [here](https://github.com/redox-os/ion/pull/550).
- [@Kvikal](https://github.com/Kvikal) Fixed a `TODO` in `is_array` function: [1 2 3][0] is now treated as a string. Details [here](https://github.com/redox-os/ion/commit/b92afb4bd89e9317429e1fef13c31c2a317bc0fb).
- [@mmstick](https://github.com/mmstick) Refactored the `words` module. Details [here](https://github.com/redox-os/ion/commit/4a542c1fe72eefc26ecbfed5314b387df2368c83).
- [@mmstick](https://github.com/mmstick) String method args unescape `\n` and `\t` sequences. Details [here](https://github.com/redox-os/ion/commit/cf0c2c27537768a5cafc8df8e7d2f73dea36b4a1).
- [@mmstick](https://github.com/mmstick) Implemented `$find()` & `@split_at()`. Details [here](https://github.com/redox-os/ion/commit/13054955db8ca3ff46dbf0934a35fb2b7f3f0ee1).
- [@mmstick](https://github.com/mmstick) Improved method argument parsing. Details [here](https://github.com/redox-os/ion/commit/1fb9bf75c874f9de9c9e506126293b676ea14283).
- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock. Details [here](https://github.com/redox-os/ion/commit/95910578344377153baf4bd0a4700c2c61af156d).
- [@mmstick](https://github.com/mmstick) Improved string methods. A bit of refactoring to make handling method arguments simpler. Details [here](https://github.com/redox-os/ion/commit/9af5cd8d20c13580c266dac2d220300c98e1a2df).
- [@mmstick](https://github.com/mmstick) Applied a fix for #551. Updated variables for commands that start with `~` too. Closes #551. Details [here](https://github.com/redox-os/ion/commit/24a3e4fce5a5fb40dd764fc17d09dfe63b658456).
- [@mmstick](https://github.com/mmstick) Applied a fix for #532. Liner seems to be doing some very limited form of multi-line comment, support, itself. This change strips out the excess characters, that are returned by liner. Details [here](https://github.com/redox-os/ion/commit/189542337856fac66489e9f02c2ae1a160de68d8).
- [@mmstick](https://github.com/mmstick) Made a change to let builtin prints variables. After the refactoring of how `let` and other builtins were parsed we lost the ability to get a list of local variables just by supplying the `let` command without any arguments. This fix re-implements that. Details [here](https://github.com/redox-os/ion/commit/095b557a45dfc29015701b5bd9b0ba02b1f66c09).
- [@mmstick](https://github.com/mmstick) Made some work so `get_vars()` now returns an iterator. Details [here](https://github.com/redox-os/ion/commit/49d6133f22e295408f3dab7d482b74a2a6387b13).
- [@mmstick](https://github.com/mmstick) Made some refactoring to string method. Details [here](https://github.com/redox-os/ion/commit/69f55d82177f2eb2c41dab934c891598ee90ac72).
- [@mmstick](https://github.com/mmstick) Implemented multi-line array assignments. Details [here](https://github.com/redox-os/ion/commit/cdb6a6cda7964c6093e946037098be1aecf323e3).
- [@mmstick](https://github.com/mmstick) Made more refactoring on the `words` module. Details [here](https://github.com/redox-os/ion/commit/ace07de2126a56c37cb257cce6b756862f6dd658).

## Cookbook

A collection of package recipes for Redox.

- [@jackpot51](https://github.com/jackpot51) Added recipes for `2048`, `cleye`, and `rust64`. Details [here](https://github.com/redox-os/cookbook/commit/fa11383b38b69d64ec9733b5f27d011a4bcdbd9e).
- [@jackpot51](https://github.com/jackpot51) Added upstream URLs. Details [here](https://github.com/redox-os/cookbook/commit/c708430031b4b37e1db86a20e35dea5e61756bad).
- [@jackpot51](https://github.com/jackpot51) Updated the `rustual-boy` fork. Details [here](https://github.com/redox-os/cookbook/commit/1c3121d8f9ea4b0536a076284092a26a75e5a71f).
- [@jackpot51](https://github.com/jackpot51) Added `rs-nes`. Details [here](https://github.com/redox-os/cookbook/commit/211d5c2bdb20b217d8bca2a8c97939bf7ce05a15).
- [@jackpot51](https://github.com/jackpot51) Added upstream link if necessary. Details [here](https://github.com/redox-os/cookbook/commit/1f7128c43f30116d48dcceff630b5ac6728c272c).
- [@jackpot51](https://github.com/jackpot51) Update the `status` script. Details [here](https://github.com/redox-os/cookbook/commit/348dd4a8fe8bc92614a60a77d31b416029993d89).
- [@jackpot51](https://github.com/jackpot51) Added upstream status script. Details [here](https://github.com/redox-os/cookbook/commit/569bc08564824af906cf20b7311c3ff8dc6c6903).
- [@jackpot51](https://github.com/jackpot51) Added `diff` sub commands. Details [here](https://github.com/redox-os/cookbook/commit/1ff2f8f4588937a2b054f48ff1baf1f84db4a778).
- [@jackpot51](https://github.com/jackpot51) Used color and --stat for `status` command. Details [here](https://github.com/redox-os/cookbook/commit/d029991234516200a57de83370acad2333f2798b).
- [@jackpot51](https://github.com/jackpot51) Added `difftool` sub commands. Details [here](https://github.com/redox-os/cookbook/commit/5d1d2c58c167493cc9119de3ee37ab8d6d707cc9).

## Orbital

Redox Windowing and Compositing System

- [@jackpot51](https://github.com/jackpot51) Made a change to utilize the `null` namespace. Details [here](https://github.com/redox-os/orbital/commit/37451daae8712546c28478dcd4d1d8b9dd1346f6).
- [@pharaone](https://github.com/pharaone) Updated README.md. Details [here](https://github.com/redox-os/orbital/pull/18).

## Redoxfs

The Redox Filesystem

- [@jackpot51](https://github.com/jackpot51) Made a cleanup to allow use of most functions when linking the library, including mounting and creating filesystems. Details [here](https://github.com/redox-os/redoxfs/commit/070aeb54ef2039c5ce3a5b453ae332ba92f3ad58).
- [@jackpot51](https://github.com/jackpot51) Updated FUSE. Details [here](https://github.com/redox-os/redoxfs/commit/541a58181aadb1352dabe0687bf78e54ab8c50e5).
- [@jackpot51](https://github.com/jackpot51) Fixed `cargo doc`. Details [here](https://github.com/redox-os/redoxfs/commit/260bc1e1e81da4671f3ff2db1e4a37d6522080d5).
- [@jackpot51](https://github.com/jackpot51) Cleaned up FUSE backend, also, made a fix to send signal at correct time. Details [here](https://github.com/redox-os/redoxfs/commit/dfd2dd8ae12aa464fa8877925bdc4c850589022b).
- [@jackpot51](https://github.com/jackpot51) Fixed compilation on Redox. Details [here](https://github.com/redox-os/redoxfs/commit/dc0b0c5c2d5e50736dbe40b7dada4655fac17a85).
- [@jackpot51](https://github.com/jackpot51) Update `spin` crate. Details [here](https://github.com/redox-os/redoxfs/commit/ade6234f12c0ac22ab45c2ec7e6833ace8f1a342).
- [@jackpot51](https://github.com/jackpot51) Added `docs.rs` badge. Details [here](https://github.com/redox-os/redoxfs/commit/90dc177d758c501a60f66d836027f6331250d2e3).
- [@jackpot51](https://github.com/jackpot51) Allowed a bootloader to be written during redoxfs-mkfs. Details [here](https://github.com/redox-os/redoxfs/commit/cbdfba7b94e4138a6848665a5e741e46cb38a719).
- [@jackpot51](https://github.com/jackpot51) Fixed offset calculations. Details [here](https://github.com/redox-os/redoxfs/commit/6d62d22262b9308a8151b512a7b27a91e2ce446d).
- [@jackpot51](https://github.com/jackpot51) Implemented `UUID`. Details [here](https://github.com/redox-os/redoxfs/commit/db2293736195a8fc6f64ecc9eab8a4d3efa44994).
- [@jackpot51](https://github.com/jackpot51) Added `UUID` matching. Details [here](https://github.com/redox-os/redoxfs/commit/e74975d2f9365c7dc179f4180aa3fbc8ffa8277f).
- [@jackpot51](https://github.com/jackpot51) Fixed the `disk` scheme path. Details [here](https://github.com/redox-os/redoxfs/commit/d4ea343a3930bdb76ac5412f0f113a84c9328e3c).

## Sodium

Sodium: The Text Editor

- [@dummie999](https://github.com/dummie999) Added line numbers and wrapped lines that are too long. Details [here](https://github.com/redox-os/sodium/pull/78).
- [@dummie999](https://github.com/dummie999) Fixed a bug that could cause panic when deleting lines. Details [here](https://github.com/redox-os/sodium/pull/79).
- [@dummie999](https://github.com/dummie999) Fixed a bug when entering invalid command in prompt. Details [here](https://github.com/redox-os/sodium/pull/80).
- [@dummie999](https://github.com/dummie999) Made buffers behave more consistent. Details [here](https://github.com/redox-os/sodium/pull/81).

## Coreutils

The Redox coreutils.

- [@youknowone](https://github.com/youknowone) Improved 'yes' to show an invalid parameter error rather than silencing 'y'. Details [here](https://github.com/redox-os/coreutils/pull/182).

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

- [@tjrana](https://github.com/tjrana) 🎂
- [@GabrielMajeri](https://github.com/GabrielMajeri) 🎂
- [@Kvikal](https://github.com/Kvikal) 🎂

If I missed something, feel free to contact me [@goyox86](https://github.com/goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
