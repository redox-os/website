+++
title = "This Week in Redox 26"
author = "goyox86"
date = "2017-07-21T18:00:00+00:00"
+++

This is the 26th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# What's new in Redox?

## TL;DR

Hello again! Buckle up because this is gonna be a long one.  That said, we better go start!

On the **kernel** a reset facility has been added by [@jackpot51](https://github.com/jackpot51), along with the addition of `uname` support by  [@ids1024](https://github.com/ids1024). There were also some fixes for pipes and the addition of `iopl`.  

**Ion** continues it's steady progress, I mean it continues of fire! This week we have a new contributor [@drosseau](https://github.com/drosseau) who shipped a ton of fixes, features and refactoring, fixing `echo`, some bugs on `||` and `&&` and some bugs in ranges syntax. [@drosseau](https://github.com/drosseau). All of that along with new features such as the `not` builtin and some general refactoring. Impressive right? As usual [@mmstick](https://github.com/mmstick) has been very busy, one of the highlights being the landing of the initial work on the new user manual based on *mdBook* How cool is that? He also continued his work on job control and did many bug fixes and refactoring. [@huntergoldstein](https://github.com/huntergoldstein) working hard too! Adding support for inline expressions in methods,  making case statements implicitly ended and some other goodies!

On the **drivers** side of the world there was not much activity besides some improvements to the network drivers configuration and the splitting of  `pcid` config into `initfs` and `fs` by [@jackpot51](https://github.com/jackpot51). 

As part of his GSoC  [@ids1024](https://github.com/ids1024)  did some work on **Redoxfs** notably preventing the failure due to file permissions on creation and a fix to require the same `uid` as owner to `unlink` and  not write permissions.

What about **TFS** ? Well [@ticki](https://github.com/ticki) was on fire this week! Mostly hardening and extending the test suite for the various concurrent data structure libraries he is creating as the base for **TFS**, AKA `conc`. He even found a segfault in safe code in `conc::hazard::Hazard`. See [here](https://github.com/redox-os/tfs/commit/b7e7983542bd7e830d46ee3535c4324b056c4270) for details. But to be honest I don't think I'm honouring all the work I saw while looking at the commit history. So go there yourself ;)

**Coreutils** progressed too with the addition of a reset flag to `shutdown` by [@jackpot51](https://github.com/jackpot51) exposing the rest work done in the **kernel**.  [@goyox86](https://github.com/goyox86) extracted the `ArgParser` to it's own library and migrated `coreutils` to it. [@ids1024](https://github.com/ids1024) Added the `uname` utility and fixed `rm` and `which`. Related to this is the work done in **userutils** where [@goyox86](https://github.com/goyox86) reimplemented `whoami` and `id` again on top of system calls, adding docs for all of the utilities and applied all `coreutils` conventions there too.

On the **netstack** - [@jackpot51](https://github.com/jackpot51) trimmed the network configuration while [@ids1024](https://github.com/ids1024) corrected `fpath()` for `tcpd`and fixed a bug in `tcpd`s partial reads that was breaking https in `curl`.

The **cookbook** was not as active in past weeks with some fixes to `pastel` by  [@jackpot51](https://github.com/jackpot51) and the hard work of [@ids1024](https://github.com/ids1024) on the `git` support.

Last but not least **Orbital** the composition and windowing manager received some love from [@jackpot51](https://github.com/jackpot51) highlighting the addition of left side and bottom left corner resizing and the landing of the initial work on a new event based method. 

Phew, that was a lot, and is just the "summary" xD Sorry by that! <3
 
## Kernel

- [@jackpot51](https://github.com/jackpot51) Added reset code. Details [here](https://github.com/redox-os/kernel/commit/b4d502c7639f54be0c4c27e7c86c6396dc617c5d).
- [@jackpot51](https://github.com/jackpot51) Reduced the scope of context blocks. Details [here](https://github.com/redox-os/kernel/commit/f7b961ddff32ac7d75d81624331cfbce91839089).
- [@jackpot51](https://github.com/jackpot51) Implemented `iopl`. Details [here](https://github.com/redox-os/kernel/commit/4ae6ed9d4c341b7102fd2480c61c9eac48511a46).
- [@ids1024](https://github.com/ids1024) Updated pipes to return `ESPIPE` when you try to `seek` on them. Details [here](https://github.com/redox-os/kernel/pull/34).
- [@ids1024](https://github.com/ids1024) Implemented `sys:uname`. Details [here](https://github.com/redox-os/kernel/pull/39/files#diff-d5d699e718c3d8c27fd660c998f8ee1c).

## Ion

[Ion](https://github.com/redox-os/ion) is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

- [@mmstick](https://github.com/mmstick) Converted `children: Vec<Option<Child>>` to `Vec<u32>` on pipes. Details [here](https://github.com/redox-os/ion/commit/a2e5875d37a9c8cb5a988c6a48d7b10f6c6a1c89).
- [@mmstick](https://github.com/mmstick) Resolved some `SIGPIPE` issues in job control. Details [here](https://github.com/redox-os/ion/commit/caf8b2f7b7ca6318833cb1475665c86aa6733eb6).
- [@mmstick](https://github.com/mmstick) Made a fix on shell expansion: if it's not a glob then the original word is kept. Details [here](https://github.com/redox-os/ion/commit/d28f8a760cf8b85a93628c465a4f94608b47e569).
- [@mmstick](https://github.com/mmstick) Added support to remember last background job ID. Now when the fg and bg commands are executed without arguments, the last background job ID will be used as the argument. Details [here](https://github.com/redox-os/ion/commit/1c45eef9c29c248a2cf91019baf5db2430ed3b33).
- [@chenl](https://github.com/chenl) Fixed a typo in the README. Details [here](github.com/redox-os/ion/pull/422).
- [@mmstick](https://github.com/mmstick) Made some work to only enable context with interactive sessions. This speeds up script executions. Details [here](https://github.com/redox-os/ion/commit/37dd8c8bec9dc420f298426b1bc2e506996b129e).
- [@mmstick](https://github.com/mmstick) Extracted binary logic from the shell module. Details [here](https://github.com/redox-os/ion/commit/64dbb1119346529cebecde1ffaa02f0f7964731e).
- [@mmstick](https://github.com/mmstick) Migrated readln prompt Into binary logic. Details [here](https://github.com/redox-os/ion/commit/f065a071f32f6189fd36a06f4799f97b72b90272).
- [@drosseau](https://github.com/drosseau) Fixed a bug in which `echo` was treating anything preceded by `-` as an option flag. Details [here](https://github.com/redox-os/ion/pull/427).
- [@drosseau](https://github.com/drosseau) Made an improvement and now jobs no longer use a separate list of builtins to determine the command type. Details [here](https://github.com/redox-os/ion/pull/428).
- [@drosseau](https://github.com/drosseau) Made an fix for `||` and `&&` which were not working as expected. Details [here](https://github.com/redox-os/ion/pull/429).
- [@drosseau](https://github.com/drosseau) Added the `not` builtin. Details [here](https://github.com/redox-os/ion/pull/431).
- [@drosseau](https://github.com/drosseau) Made a fix for `echo`. Details [here](https://github.com/redox-os/ion/pull/432).
- [@jackpot51](https://github.com/jackpot51) Fixed an issue with the `bytecount` crate when using Rust nightly. Details [here](https://github.com/redox-os/ion/commit/f81ae9bdff05e34bfef2dae46af53a676384361c).
- [@clippix](https://github.com/clippix) Added support to only read init file when using interactive shell. Details [here](https://github.com/redox-os/ion/pull/430).
- [@huntergoldstein](https://github.com/huntergoldstein) Added support for inline expressions in methods. Details [here](https://github.com/redox-os/ion/pull/433).
- [@huntergoldstein](https://github.com/huntergoldstein) Did some misc improvements on the code of shell words expansion. Details [here](https://github.com/redox-os/ion/pull/435).
- [@huntergoldstein](https://github.com/huntergoldstein) Added a change for case statements which makes them implicitly ended now. Details [here](https://github.com/redox-os/ion/pull/438).
- [@drosseau](https://github.com/drosseau) Made the builtins a little neater (Closures weren't very friendly for debuggers/backtrace). Details [here](https://github.com/redox-os/ion/pull/440).
- [@drosseau](https://github.com/drosseau) Added more consistency to builtins. Details [here](https://github.com/redox-os/ion/pull/442).
- [@richiejp](https://github.com/richiejp) Improved error handling during process spawning. Details [here](https://github.com/redox-os/ion/pull/443).
- [@drosseau](https://github.com/drosseau) Added the `matches` builtin and fixed a grammar issue. Details [here](https://github.com/redox-os/ion/pull/444).
- [@drosseau](https://github.com/drosseau) Fixed some range syntax bugs. Details [here](https://github.com/redox-os/ion/pull/427).
- [@mmstick](https://github.com/mmstick) Started an mdbook based user manual for Ion! Details [here](https://github.com/redox-os/ion/commit/f87d8ec7a23885fae76fb1913cc06436a249b0fd).

## Drivers

- [@jackpot51](https://github.com/jackpot51) Added newlines to the config of the network drivers. Details [here](https://github.com/redox-os/drivers/commit/c54aa03e54c10fdf1494891efb70b3ab90e85c32).
- [@jackpot51](https://github.com/jackpot51) Divided `pcid` config into `initfs` and `fs`. Details [here](https://github.com/redox-os/drivers/commit/15f3f0ad0f3ad303207bb8809f380e68123851fb).
- [@jackpot51](https://github.com/jackpot51) Made a change to use dashes for mac addresses on the network drivers. Details [here](https://github.com/redox-os/drivers/commit/c54aa03e54c10fdf1494891efb70b3ab90e85c32).

## Redoxfs

- [@ids1024](https://github.com/ids1024) Added a change to prevent the failure due to file permissions on creation. Details [here](https://github.com/redox-os/redoxfs/pull/25).
- [@ids1024](https://github.com/ids1024) Made a fix to require same `uid` as owner to `unlink`, not write permission. Details [here](https://github.com/redox-os/redoxfs/pull/26).

## TFS

[TFS](https://github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

- [@ticki](https://github.com/ticki) Changed the trap values of `conc::hazard::Hazard`, so it can safely store null and 0x1 pointers. Details [here](https://github.com/redox-os/tfs/commit/ce10d585dab1ac26bc377c0cfbe37fedecaac189).
- [@ticki](https://github.com/ticki) Added tests to `conc::hazard::Hazard`, revealing a segfault in safe code. Details [here](https://github.com/redox-os/tfs/commit/b7e7983542bd7e830d46ee3535c4324b056c4270).
- [@ticki](https://github.com/ticki) Fixed `conc::hazard::tests::hazard_set_get()` test, as suggested by Reddit user **sebzim4500**. Details [here](https://github.com/redox-os/tfs/commit/5fbbb50b2af1eabc412808d6dff24418ad682a2a).
- [@ticki](https://github.com/ticki) Removed a broken double-panicking test in `conc::hazard`. Details [here](https://github.com/redox-os/tfs/commit/b3f2fb43032a54af3331fbe2b3f10bd2651d572e).
- [@ticki](https://github.com/ticki) Fixed `conc` tests failing because the `RefCell` in the local state TLS variable is not mutually exclusive. Details [here](https://github.com/redox-os/tfs/commit/fad5e15c1c90a9006569288c8d073aee0e00f74e).
- [@ticki](https://github.com/ticki) Added a change to not expect `T: ?Sized` for `conc::Guard<T>`. Details [here](https://github.com/redox-os/tfs/commit/e40f41363f1774a70db99bf715b7d5630d6da659).
- [@ticki](https://github.com/ticki) Added support for catching endless looping caused by `conc::Guard::try_new` (and friends) calling garbage collecting functions. Details [here](https://github.com/redox-os/tfs/commit/2d303f326c8107669c35727e15e81f61016219ce).
- [@ticki](https://github.com/ticki) Added support for counting the number of read spins of `conc::hazard::Hazard` enabling the detection of infinite loops in debug mode. Details [here](https://github.com/redox-os/tfs/commit/df777d1ba8e50157af05acc481b16988ebaa62fb).
- [@ticki](https://github.com/ticki) Removed some hardcoded constants in `conc::hazard`. Details [here](https://github.com/redox-os/tfs/commit/b650935d9c69f850104b33e2bbbab39691fdef1f).
- [@ticki](https://github.com/ticki) Added a check against freeing blocked hazards through `local::free_hazard()` in `conc`.Details [here](https://github.com/redox-os/tfs/commit/d76d4892e8f20f2227b0655d9871fc88a0421867).
- [@ticki](https://github.com/ticki) Added a test for debug assertions in `conc`. Details [here](https://github.com/redox-os/tfs/commit/b39d66790019bf1b1a7d95e266b77e835bb32c73).
- [@ticki](https://github.com/ticki) Documented how `conc::Atomic` is represented. Details [here](https://github.com/redox-os/tfs/commit/50841d456956c362169fdc3db6b4ed56a1fe0e6b).
- [@ticki](https://github.com/ticki) Added `conc::sync::Treiber::top()` for getting the top item of the stack w/o popping. Details [here](https://github.com/redox-os/tfs/commit/58fe7ee6c9c00650c5991482409ad607637f37c7).
- [@ticki](https://github.com/ticki) After reverted `conc::sync::Treiber::top()` as it was unsound as it could cause double drop.  Details [here](https://github.com/redox-os/tfs/commit/9b40d809054b8f0df90c125afc5974933e2f372f). 
- [@ticki](https://github.com/ticki) Set a spin limit for `conc::hazard::Hazard` up to avoid spurious panics in debug mode.  Details [here](https://github.com/redox-os/tfs/commit/95088d84a0f654fb41b210df1c3e688b393e2aec).
- [@ticki](https://github.com/ticki) Added a test for panicking in destructor of `conc::sync::Treiber`.  Details [here](https://github.com/redox-os/tfs/commit/01f913be8f444a44ebfaf63754865af7a8c0c6a5). 
- [@ticki](https://github.com/ticki) Added a test to make sure that the destructor actually runs in `conc::local`. Details [here](https://github.com/redox-os/tfs/commit/3fd52777c9cd770e99b3acff0141bfa4d11b8af4).
- [@ticki](https://github.com/ticki) Added a test to make sure that the destructor actually runs in `conc::global`. Details [here](https://github.com/redox-os/tfs/commit/d2efa7285756dd0d3060e57dbd4ae7c78644026a).
- [@ticki](https://github.com/ticki) Added support for handling unwinding destructors in `conc::Garbage` by crashing when they panic. Details [here](https://github.com/redox-os/tfs/commit/e1a5f921e6351ab8750756b2d23ee1048b219288).
- [@ticki](https://github.com/ticki) Allowed destructors in `conc` to unwind. Details [here](https://github.com/redox-os/tfs/commit/35a58077c39ad195fb606b54eeb2f6c89aaf5083).
- [@ticki](https://github.com/ticki) Added `conc` tests for sending hazards cross threads. Details [here](https://github.com/redox-os/tfs/commit/ed0e4d0cfe39925a5358e883743ebe9a496aefd1).
- [@ticki](https://github.com/ticki) Switched to spin locks in `conc` due to an issue with `parking_lot`. Details [here](https://github.com/redox-os/tfs/commit/8149eb53ae6c1b0f2d76dd6a288bdf2d0d8de3c7).

## Coreutils

- [@jackpot51](https://github.com/jackpot51) Added a reset flag to `shutdown`. Details [here](https://github.com/redox-os/coreutils/commit/16c18e27e253ccaf3daa8ba252e9ec0b242938d8).
- [@goyox86](https://github.com/goyox86) Extracted the `ArgParser` to it's own library and migrated `coreutils` to it. Details [here](https://github.com/redox-os/coreutils/pull/168).
- [@ids1024](https://github.com/ids1024) Fixed directory support in `rm`. Details [here](https://github.com/redox-os/coreutils/pull/170).
- [@ids1024](https://github.com/ids1024) Made `which` work with multiple directories in `PATH`. Details [here](https://github.com/redox-os/coreutils/pull/171).
- [@ids1024](https://github.com/ids1024) Added a `uname` utility. Details [here](https://github.com/redox-os/coreutils/pull/172).

## Userutils

- [@goyox86](https://github.com/goyox86) Reimplemented `whoami` again on top of system calls (previously was based on env vars). Details [here](https://github.com/redox-os/userutils/pull/6).
- [@goyox86](https://github.com/goyox86) Reimplemented `id` again on top of system calls along with refactoring of the crate and added documentation to all utilities. Details [here](https://github.com/redox-os/userutils/pull/7).
- [@goyox86](https://github.com/goyox86) Made tweaks to `id` docs and copy-paste typos. Details [here](https://github.com/redox-os/userutils/pull/7).
-  [@goyox86](https://github.com/goyox86) Made a revision of `getty` improving error-handling, migrated to `ArgParser` and improved docs. Details [here](https://github.com/redox-os/userutils/pull/9).

## Netstack

- [@jackpot51](https://github.com/jackpot51) Trimmed the network configuration. Details [here](https://github.com/redox-os/netstack/commit/133d38ba7e41a1b61c3d95d492b9f3dd31d02d93). 
- [@ids1024](https://github.com/ids1024) Corrected `fpath()` for `tcpd`. Details [here](github.com/redox-os/netstack/pull/2).
- [@ids1024](https://github.com/ids1024) Fixed a bug in `tcpd`s partial reads that was breaking https in `curl`. Details [here](https://github.com/redox-os/netstack/pull/3).

## Netutils

- [@jackpot51](https://github.com/jackpot51) Add newlines to network config. Details [here](https://github.com/redox-os/netutils/commit/638578afc2a5647a419b99b659aa0f877f0f143b).
- [@jackpot51](https://github.com/jackpot51) Fixed trim usage in `dhcpd`. Details [here](https://github.com/redox-os/netutils/commit/9d3b8daeb9240fd8b761b8435cbb404bb2c1232b). 

## Orbital

Orbital is the windowing system and compositor for Redox.

- [@jackpot51](https://github.com/jackpot51) Made a fix to close display and socket before launching `orblogin`. Details [here](https://github.com/redox-os/orbital/commit/19e475b0fac8f197fb779f87c5b14f4d48b04829). 
- [@jackpot51](https://github.com/jackpot51) Started the work on moving to an event based method. Details [here](https://github.com/redox-os/orbital/commit/b82b7e74ad66a7281401b638ceeb24558d13c12b). 
- [@jackpot51](https://github.com/jackpot51) Removed a lot of debugging. Details [here](https://github.com/redox-os/orbital/commit/e8a73040268708a5f8bde3e9d703f6cbbab2b85f).
- [@jackpot51](https://github.com/jackpot51) Added support for left side and bottom left corner resizing. Details [here](https://github.com/redox-os/orbital/commit/65cde145f09f310425c5309b6f32abc9473c90f6).
-  [@jackpot51](https://github.com/jackpot51) Made a change to add `/ui/bin` to `PATH` when launching the first orbital application.

## Cookbook

The [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes of Redox.

- [@jackpot51](https://github.com/jackpot51) Made an update to the `drivers` recipe. Details [here](https://github.com/redox-os/cookbook/commit/5b78bf1d6c134cd6a2f23ed4fbd935ea9610c26a). 
- [@jackpot51](https://github.com/jackpot51) Added file types to `pastel`. Details [here](https://github.com/redox-os/cookbook/commit/3d2010b26a2b9cd966cb7982b7e50b150a5f530b). 
- [@jackpot51](https://github.com/jackpot51) Added a manifest for Pastel, placing it in /ui/bin. Details [here](https://github.com/redox-os/cookbook/commit/7d6529d6c0341d2a8e5a92bc0866671f23cb5264). 
- [@ids1024](https://github.com/ids1024) Updated the `git` recipe to override `git`s SHA1 implementation. Details [here](https://github.com/redox-os/cookbook/pull/39).

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

- Chen Rotem Levy 🎂
- Cooper Paul EdenDay 🎂
- Danny 🎂
- Danny Rosseau 🎂
- Jean-Loup 'clippix' Bogalho 🎂
- m4b 🎂
- Richard Palethorpe 🎂
 
If I missed something, feel free to contact me (goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
