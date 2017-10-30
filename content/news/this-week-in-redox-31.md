+++
title = "This Week in Redox 31"
author = "goyox86"
date = "2017-10-30 19:58:39 +0000"
+++

This is the 31st post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by [@goyox86](https://github.com/goyox86))*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

Don't forget that if you would like to see any package ported to Redox or are working porting one, please jump on the chat and we are there to help you! Also, suggestions on packages you would like to see to ported are more than welcome!

# What's new in Redox?

## TL;DR

Hello and welcome to another issue of This Week in Redox! 

The Last two weeks we have been busy working on some cool and exciting stuff! 

Let's start with the no-so-exciting things. That is: **bootloader** and **drivers** got their LICENSE file. 

Moving on to the super exciting territory we have [@jackpot51](https://github.com/jackpot51) (who else!?), who has been pretty busy standing on [@ids1024](https://github.com/ids1024)'s shoulders and his GSoC work on self hosting. He has been implementing the remaining tasks and fixing the outstanding issues preventing us to run `rustc` and `cargo` inside Redox. This is a big deal! As is the crucial step on making Redox OS self hosted.

**kernel**wise [@jackpot51](https://github.com/jackpot51) implemented interrupting on signals on pipes. He also made a hack to allow `rustc` to wait on non-child processes and incorporated a new `sys:syscall` scheme with the objective of seeing active system calls. He also migrated the **kernel** from the `collections` library and shipped many fixes to `waitpid`.

On the **Ion** side of things (and pretty much as always) we have a ton of stuff! But without a doubt, the highlights are for [@chrisvittal](https://github.com/chrisvittal)'s implementation of multiple redirection, enabling us to do things like: `cmd <file1 <file2 ^>> err-log > output | cmd2`. For more details on why this is such a big deal you might want to go the [PR](https://github.com/redox-os/ion/pull/553) link. Also, [@Shiwin](https://github.com/Shiwin) implemented `$regex_replace` while [@mmstick](https://github.com/mmstick) implemented `!!`, `!$` `!0`, `!^` and `!*`.

There was lots of activity on the **cookbook** too: The addition of man pages by [@jackpot51](https://github.com/jackpot51), [@NilSet](https://github.com/NilSet) adding a recipe for `PrBoom` (Yes! we *almost* run doom!). Mr [@goyox86](https://github.com/goyox86) adding support for the recently released `fd`, [@sajattack](https://github.com/sajattack) porting `termplay` finishing up with [@xTibor](https://github.com/xTibor) who added a `vttest` recipe.

**Orbterm** saw [@jackpot51](https://github.com/jackpot51) updating `ransid` which improved significantly ANSI compliance. Versions `0.2.0`, `0.2.1` and `0.2.2` were also released while [@xTibor](https://github.com/xTibor) made some updates to use the new `ransid` color handling. 

As mentioned before, **ransid**, our backend for terminal emulators got some love. It's ANSI compliance was improved significantly. Notably, versions `0.3.1`, `0.3.2`, `0.3.3` and `0.3.4` shipped improvements to unknown escapes parsing, corrections on csi handling of missing escapes and fixes for cursor movement csis.

Stopping on the utilities station we have: **userutils**, **coreutils** and **extrautils** getting `man` pages and **netutils**'s `dhcpd` gaining the ability to broadcast packets.

And last but never least [@sajattack](https://github.com/sajattack) added some networking headers to our fork of the **newlib** C standard library (Which we implement in Rust :).

Looking forward to a next issue potentially talking about `rustc` and `cargo` running on Redox <3.

See you soon!

## Bootloader

Redox OS Bootloader.

- [@jackpot51](https://github.com/jackpot51) Created the LICENSE file. Details [here](https://github.com/redox-os/bootloader/commit/b44740f1d965e638f37f28a08009b991457e7ad6).

## Kernel

The Redox microkernel.

- [@jackpot51](https://github.com/jackpot51) Cleaned up warnings and implemented interrupt on signal in pipe. Details [here](https://github.com/redox-os/kernel/commit/51339cb8c94529127151a541e47ebd77eef30f85).
- [@jackpot51](https://github.com/jackpot51) Uncommented AML value variant. Details [here](https://github.com/redox-os/kernel/commit/ef70cd257c1150fbcbb476c6c9fc4ea82e23dfac).
- [@jackpot51](https://github.com/jackpot51) Made a hack to allow `rustc` to wait on non-child process. He also added the `sys:syscall` scheme for seeing active system calls. Details [here](https://github.com/redox-os/kernel/commit/8ec5d4726b49b4ce4e76308ffe40cd6f5aaa61f5).
- [@xTibor](https://github.com/xTibor) Migrated from `collections`. Details [here](https://github.com/redox-os/kernel/pull/59).
- [@jackpot51](https://github.com/jackpot51) Made the `debug` function never return error. Details [here](https://github.com/redox-os/kernel/commit/1f99d038c45cd9f2e72821a9601087bbf0e912ef).
- [@jackpot51](https://github.com/jackpot51) Fixed returning too many errors from `waitpid`. Details [here](https://github.com/redox-os/kernel/commit/eebf12bec5c0999adf9d898a7a78b9fc3d2367ca).
- [@jackpot51](https://github.com/jackpot51) Fixed some errors from `waitpid`. Details [here](https://github.com/redox-os/kernel/commit/1e553b744c908daac2afe544db38210546c47bc0).

## Ion

The Ion Shell. Compatible with Redox and Linux.

- [@chrisvittal](https://github.com/chrisvittal) Implemented multiple redirection.. Details [here](https://github.com/redox-os/ion/pull/553).
- [@Shiwin](https://github.com/Shiwin) Implement `$regex_replace`. Details [here](https://github.com/redox-os/ion/pull/555).
- [@mmstick](https://github.com/mmstick) Fixed #554, Closing #554. Details [here](https://github.com/redox-os/ion/commit/4928e8a886ac0de0d459242bde50d31c7bfdbb06).
- [@mmstick](https://github.com/mmstick) Fixed #557, Closing #557. Details [here](https://github.com/redox-os/ion/commit/5e2b08abafbb2732a5f6f7ae63497d319336127b).
- [@mmstick](https://github.com/mmstick) Made a change to use the `integer_atomics` feature. Instead of using `AtomicUsize` and `AtomicBool` fields within `ForegroundSignals` they were switched to `AtomicU32` and `AtomicU8`. Details [here](https://github.com/redox-os/ion/commit/e5d307401e65a08507fbf23b3124265c21fd9d38).
- [@mmstick](https://github.com/mmstick) Ran `rustfmt` again. Details [here](https://github.com/redox-os/ion/commit/44ccc4f04b94db338cbaecbae3bc6de661afaf53).
- [@mmstick](https://github.com/mmstick) Removed the dependency on the `nix` crate. Closes #547. Details [here](https://github.com/redox-os/ion/commit/9e5b39c0791ac8955a9461a7760dccb28046dfac).
- [@mmstick](https://github.com/mmstick) Fixed #558, Closing #558. Details [here](https://github.com/redox-os/ion/commit/6880e6ebf2fcd4d9486ada407f10d838d015614d).
- [@mmstick](https://github.com/mmstick) Simplified and improved stream dup/redirection logic. Details [here](https://github.com/redox-os/ion/commit/5514bef912dcbf35b0cfc75d88d7422617110aa2).
- [@mmstick](https://github.com/mmstick) Re-applied `rustfmt`. Details [here](https://github.com/redox-os/ion/commit/de27cd076e4f04dac255c1744a0f0282d4a89c82).
- [@mmstick](https://github.com/mmstick) Made the builtin map is now a static struct of arrays. Details [here](https://github.com/redox-os/ion/commit/279dfa8006f4da7668886dff7fa4cdfd3613c3a1).
- [@mmstick](https://github.com/mmstick) Implemented better builtin map macro syntax. Details [here](https://github.com/redox-os/ion/commit/fd3bef2f42304c625e19a63e9dbe9e815e9e9507).
- [@mmstick](https://github.com/mmstick) Made a change to only check for signals that we are listening to. Details [here](https://github.com/redox-os/ion/commit/809324ff0ca88a1c9443e503b7f99f6ac4039c6d).
- [@mmstick](https://github.com/mmstick) Worked on further signal handling optimizations. Details [here](https://github.com/redox-os/ion/commit/693d2a60524dac3f168aa300be035834a4a18d56).
- [@mmstick](https://github.com/mmstick) Refactored the assignments module. Severely trimming down LOC for performing assignments. Details [here](https://github.com/redox-os/ion/commit/c6d76f81ea71ecf7948a5e404283e7116d4c9ad3).
- [@mmstick](https://github.com/mmstick) Implemented an `ArgumentSplitter` optimization. Details [here](https://github.com/redox-os/ion/commit/f6077ce4a8f93396fa5dd6e7ee9691b4594f8353).
- [@mmstick](https://github.com/mmstick) Optimized & enhanced assignment parsing. Details [here](https://github.com/redox-os/ion/commit/1055e456b259c3a58f9b7ba4555ed67f8055c6aa).
- [@mmstick](https://github.com/mmstick) Fixed unit tests. Details [here](https://github.com/redox-os/ion/commit/fd9ce76e1e1e71cd451f3131ebd7c56968338183).
- [@mmstick](https://github.com/mmstick) Optimized statement splitter. Details [here](https://github.com/redox-os/ion/commit/dfc587b61fc6b5783fd0986ad089ef44accc8506).
- [@mmstick](https://github.com/mmstick) Implemented `!!` and `!$` expansions. Details [here](https://github.com/redox-os/ion/commit/3dfd46c2a6a4a67dd96fe412ed67b57585e26de3).
- [@ids1024](https://github.com/ids1024) Added the `which` builtin. Details [here](https://github.com/redox-os/ion/pull/561).
- [@mmstick](https://github.com/mmstick) Made more process expansion improvements. Details [here](https://github.com/redox-os/ion/commit/1147ac5785c7170ab241c14df34988fd797f860d).
- [@mmstick](https://github.com/mmstick) Implemented `!0`, `!^`, and `!*`. Details [here](https://github.com/redox-os/ion/commit/4d971dd41547c28e25b6e4fc5fc9ba340bbf67b7).
- [@mmstick](https://github.com/mmstick) Removed the `EXPAND_PROCESSES` flag. Details [here](https://github.com/redox-os/ion/commit/741baf2602c65b4a3e71f65510fc160e08ebf5e8).

## drivers

Redox OS Drivers.

- [@jackpot51](https://github.com/jackpot51) Created the LICENSE file. Details [here](https://github.com/redox-os/drivers/commit/bd102d7f0d80e354bface3cfab79fc5b5fc1119e).

## cookbook

A collection of package recipes for Redox.

- [@jackpot51](https://github.com/jackpot51) Added man pages. Details [here](https://github.com/redox-os/cookbook/pull/84).
- [@NilSet](https://github.com/NilSet) Added recipe for  `PrBoom`. It almost runs doom!. Details [here](https://github.com/redox-os/cookbook/pull/85).
- [@jackpot51](https://github.com/jackpot51) Added LLVM LTO linkages. Details [here](https://github.com/redox-os/cookbook/commit/5e621772cff283ee9b05e9daba59e236745dc847).
- [@goyox86](https://github.com/goyox86) Added a recipe for `fd`. Details [here](https://github.com/redox-os/cookbook/pull/86).
- [@jackpot51](https://github.com/jackpot51) Updated `rust` recipe. Details [here](https://github.com/redox-os/cookbook/commit/21559d4c99e4dbe310d570b2843f488da78d10a1).
- [@jackpot51](https://github.com/jackpot51) Used `nproc` for rust LLVM. Details [here](https://github.com/redox-os/cookbook/commit/2bb4b066432a38539fa2f3e30d8279882f0b2224).
- [@jackpot51](https://github.com/jackpot51) Updated `cargo` path. Details [here](https://github.com/redox-os/cookbook/commit/dc61f23565c9da2e6017d2998a95bf3dca327569).
- [@ids1024](https://github.com/ids1024) Made `repo.sh` to accept `--debug` and pass it to `cook.sh`. Details [here](https://github.com/redox-os/cookbook/pull/87).
- [@jackpot51](https://github.com/jackpot51) Updated `pkgutils`. Details [here](https://github.com/redox-os/cookbook/commit/7e314025bde2a6a5711c055fc41ff972d76f9e3f).
- [@jackpot51](https://github.com/jackpot51) Fixed repo script. Details [here](https://github.com/redox-os/cookbook/commit/ff5df44151eb2501ba708e1a6b54b24aa57d84de).
- [@sajattack](https://github.com/sajattack) Added recipe for `termplay`. Details [here](https://github.com/redox-os/cookbook/pull/89).
- [@sajattack](https://github.com/sajattack) Add instructions for Arch and other distributions. Details [here](https://github.com/redox-os/cookbook/pull/90).
- [@xTibor](https://github.com/xTibor) Added `vttest` recipe. Details [here](https://github.com/redox-os/cookbook/pull/91).

## Orbterm

Orbital Terminal, compatible with Redox and Linux.

- [@jackpot51](https://github.com/jackpot51) Updated `ransid`, improving ANSI compliance significantly. Details [here](https://github.com/redox-os/orbterm/commit/2131525a953473a83846b959c3b642abc732f627).
- [@jackpot51](https://github.com/jackpot51) Fixed unused variable warning. Details [here](https://github.com/redox-os/orbterm/commit/ea00d067b5b4eccbe4dacd29ae62bc526bfefc92).
- [@jackpot51](https://github.com/jackpot51) Released version `0.2.0`. Details [here](https://github.com/redox-os/orbterm/commit/1213489b4eda73fdad032b9a886c11aa08afe9da).
- [@xTibor](https://github.com/xTibor) Updated to new `ransid` color handling. Details [here](https://github.com/redox-os/orbterm/pull/4).
- [@jackpot51](https://github.com/jackpot51) Updated dependencies. Details [here](https://github.com/redox-os/orbterm/commit/e4e538e978e047433fe232782bb860c1abb7f695).
- [@jackpot51](https://github.com/jackpot51) Released `0.2.1`. Details [here](https://github.com/redox-os/orbterm/commit/b2953da6f0e626c29f8b6db805225e12dee68e05).
- [@jackpot51](https://github.com/jackpot51) Fixed reverse scrolling. Details [here](https://github.com/redox-os/orbterm/commit/600cf033e4f34327d5432ed8bd1be6568812146f).
- [@jackpot51](https://github.com/jackpot51) Released `0.2.2`. Details [here](https://github.com/redox-os/orbterm/commit/363ffa8ec679f56636d46f27a1f4939973536082).

## ransid

Rust ANSI Driver - a backend for terminal emulators in Rust.

- [@jackpot51](https://github.com/jackpot51) Improved significantly ANSI compliance. Details [here](https://github.com/redox-os/ransid/commit/396270866ebcab3c948b153ea0d1431dcb66df02).
- [@xTibor](https://github.com/xTibor) Converted `Color` into an enum. Details [here](https://github.com/redox-os/ransid/pull/4).
- [@jackpot51](https://github.com/jackpot51) Released 0.3.1. Details [here](https://github.com/redox-os/ransid/commit/c165d62d5f9fea54f1167c90a27aee8b184e7e81).
- [@jackpot51](https://github.com/jackpot51) Improved unknown escapes parsing. Details [here](https://github.com/redox-os/ransid/commit/47352087390247063e0aa8062ee761924009b07d).
- [@jackpot51](https://github.com/jackpot51) Released 0.3.2. Details [here](https://github.com/redox-os/ransid/commit/c2b1c46cd0715d3c834b91bfd5ce6eb42b552bb4).
- [@jackpot51](https://github.com/jackpot51) Released 0.3.3 - Correct csi handling of missing escapes. Details [here](https://github.com/redox-os/ransid/commit/c031a65fa5029f4074126391a72f33427bbf0e44).
- [@jackpot51](https://github.com/jackpot51) Released 0.3.4 - Fixing cursor movement csis. Details [here](https://github.com/redox-os/ransid/commit/3574eaa7945e3c924567447b573e4fa08d9006c5).

## Userutils

User and group management utilities.

- [@jackpot51](https://github.com/jackpot51) Fixed man pages. Details [here](https://github.com/redox-os/userutils/commit/28d097dbf37ac0dec44d9f103eab8de79374cb58).

## Coreutils

The Redox coreutils.

- [@jackpot51](https://github.com/jackpot51) Fixed man page names. Details [here](https://github.com/redox-os/coreutils/commit/fc4dec225093f1e9bc79566b192e615c8b2ccf5a).

## Extrautils

Extra utilities for Redox (and Unix systems).

- [@jackpot51](https://github.com/jackpot51) Fixed man page names. Details [here](https://github.com/redox-os/extrautils/commit/35ab8d587fbc6cd14cb99fe5c71b46bb4ce1fa85).

## Netutils

Network Utilities for Redox.

- [@jackpot51](https://github.com/jackpot51) Made a change to allow broadcast packets in `dhcpd`. Details [here](https://github.com/redox-os/netutils/commit/a719fa50b065840ffacc81d989e47f258b3e5170).

## Newlib

A fork of newlib from git://sourceware.org/git/newlib-cygwin.git with Redox support.

- [@sajattack](https://github.com/sajattack) Added some networking headers. Details [here](https://github.com/redox-os/newlib/pull/65).

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

- [@sajattack](https://github.com/sajattack) 🎂
- [@Shiwin](https://github.com/Shiwin) 🎂

If I missed something, feel free to contact me [@goyox86](https://github.com/goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
