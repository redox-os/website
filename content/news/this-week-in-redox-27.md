+++
title = "This Week in Redox 27"
author = "goyox86"
date = "2017-07-27T22:00:00+00:00"
+++

This is the 27th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

## TL;DR

Welcome to the 27th edition of "This Week in Redox"!

As always, we have a bunch of good news to share with you. So lets get the ball rolling!

This week, one of the biggest changes is that we started to track the `Cargo.lock` file of most of Redox crates in Git as an attempt to improve the reproducibility of builds.

[@jackpot51](https://github.com/jackpot51) did a bunch of work in the **kernel** in order to add support for process groups. Result: as of this week, you can send signals to process groups! 

There was a also a small change on the **kernel** making an error to pass an non-empty buffer to `dup` in schemes, basically, after this change you will get `EINVAL` if you do so. [@jackpot51](https://github.com/jackpot51) also prevented handling of nested signals.

The streak on **Ion** seems like a never ending one! They continue to ship new features and improvements at a steady (and rather fast!) pace. This week  [@jackpot51](https://github.com/jackpot51) simplified signal handling by adding an atomic bitmask of pending signals and removing the extra signal handling thread. Work by [@mmstick](https://github.com/mmstick) on the mdBook based user manual continues, [@huntergoldstein](https://github.com/huntergoldstein) added support to allow builtins to be executed as part of pipelines, and made the RawFDs now managed by forked process when possible, along some other bug-fixes. Also in **Ion**, [@bblancha](https://github.com/bblancha) implemented associative arrays, the `and` and `or` builtins and he added an option to the `drop` builtin for dropping arrays. Mr [@drosseau](https://github.com/drosseau) added support for stepped ranges while [@memoryleak47](https://github.com/memoryleak47) implemented command line options for `popd`.

There was work done on moving the OS related `#[cfg]` functions to `sys` by [@bb010g](https://github.com/bb010g) and [@pithonsmear](https://github.com/pithonsmear) who added `reverse`, `to_lowercase` and `to_uppercase` to **Ion**'s word expansion parser.

The XHCI **driver** got a lot of love by [@jackpot51](https://github.com/jackpot51) with a big general refactoring plus the addition of runtime registers, tests for the TLB, a revamp of the events mechanism, fixes of the mapping size and the addition of a lot of debugging. It looks very cool now!

**Redoxfs** saw the birth of directory symbolic links, a fix for `readdir` when directories don't fit in the buffer and a FUSE update allowing setting `mtime` to earlier times. All of those by [@ids1024](https://github.com/ids1024).

On the **TFS** department we have for the first time in a while new contributors! This work includes [@m4b](https://github.com/m4b)'s  usage of `debug_map` in `chashmap` enabling maps pretty printing, [@cedenday](https://github.com/cedenday)'s remotion of `speck`s dependency on `std` and the fix for an infinite loop in `chashmap`'s `scan()` by [@memoryleak47](https://github.com/memoryleak47). Well done people! 

[@ticki](https://github.com/ticki) continues improving **TFS**'s
test suite along with an interesting work in reserving reserved special pointers for `conc::hazard::State` to avoid overlapping with pointers used in `Protect`. Also, if you are an compression algorithm aficionado you might want to look at [@ticki](https://github.com/ticki)'s [notes](https://github.com/redox-os/tfs/commit/624dce5fc4e12063972bc4817edfacfaa558f333) on `zmicro`, as they were updated this week.

In **coreutils** land [@ids1024](https://github.com/ids1024) allowed directory as second argument to `ln` and implemented octal escapes in `tr`. 

Continuing his last week's work on **userutils** [@goyox86](https://github.com/goyox86) made revisions to `getty`, `passwd`, `login` and `su` in order to update them to `coreutils` conventions and new APIs while Mr [@jackpot51](https://github.com/jackpot51) made updates to `getty` in order to use `PTY` to provide line control for raw consoles and `vesad`.

We end this week's tour on the **cookbook**  which saw the addition of a `status.sh` script for checking git modifications, an `update.sh` one to, well, update everything and the corresponding updates to `cook.sh` caused by `Cargo.lock` being now tracked in version control. All of that by [@jackpot51](https://github.com/jackpot51). 

[@ids1024](https://github.com/ids1024) added recipes for GNU `grep`, `diffutils` and made a patch in the `git` recipe to use `;` as `PATH` separator.

Enjoy the rest, and see you next week!
 
## Kernel

- [@jackpot51](https://github.com/jackpot51) Made changes to make an error to supply a `dup` buffer to schemes that do not handle it. Details [here](https://github.com/redox-os/kernel/commit/fc914e0cae8c865ed260af7286314c7dc8e63f19) and [here](https://github.com/redox-os/kernel/commit/6a061665e47febfff53e356363cfb7c13873dbec).
- [@jackpot51](https://github.com/jackpot51) Added group id (`pgid`) to processed. Details [here](https://github.com/redox-os/kernel/commit/d6848a19951ef67f768f5f8f68aebcd3d42765e5).
- [@jackpot51](https://github.com/jackpot51)  Implemented sending signals to process groups and modified the maximum contexts number fit inside `isize`. Details [here](https://github.com/redox-os/kernel/commit/07262fd86652bd15724c335b4a9b9d85e3485b78).
- [@jackpot51](https://github.com/jackpot51) Prevented nested signals and fixed a check for `PID > 0`. Details [here](https://github.com/redox-os/kernel/commit/ef8c120533b941399c55f3ac5871a8324ed90897).
- [@ids1024](https://github.com/ids1024) Stripped extra slashes from the path in processes. Details [here](https://github.com/redox-os/kernel/pull/40).
- [@jackpot51](https://github.com/jackpot51) Checked `Cargo.lock` in into source control. Details [here](https://github.com/redox-os/kernel/commit/b474136af4cb617c47834d188983e7e1ff701da4).
- [@jackpot51](https://github.com/jackpot51) Updated the paging module to new Rust nightly API. Details [here](https://github.com/redox-os/kernel/commit/226145249294c1ff82629f4b8be4024e7e938cad).

## Ion

[Ion](https://github.com/redox-os/ion) is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

- [@pithonsmear](https://github.com/pithonsmear) Added `reverse`, `to_lowercase` and `to_uppercase`. Details [here](https://github.com/redox-os/ion/pull/458).
- [@jackpot51](https://github.com/jackpot51) Added support for `setpgid` and `tcsetpgrp` to Redox. Also, updated to use a customised `termion` to get correct sizes on Redox. Details [here](https://github.com/redox-os/ion/commit/1bd0c776c7394d27e6497d6832829fa75d70b4d1).
- [@bblancha](https://github.com/bblancha) Added an option to the `drop` builtin for dropping arrays. Details [here](https://github.com/redox-os/ion/pull/459).
- [@jackpot51](https://github.com/jackpot51) Simplified signal logic so that it is safe and single-threaded. Details [here](https://github.com/redox-os/ion/pull/460).
- [@mmstick](https://github.com/mmstick) Implemented a README for mdBook Manual. Details [here](https://github.com/redox-os/ion/commit/e9cc1a1eb713c6184a01a8b8bfa6b825811676ee).
- [@huntergoldstein](https://github.com/huntergoldstein) Made a fix to ignore `SIGTTOU` before setting process group. Details [here](https://github.com/redox-os/ion/pull/462).
- [@bb010g](https://github.com/bb010g) Moved OS #[cfg] functions to `sys`. Details [here](https://github.com/redox-os/ion/pull/464).
- [@bblancha](https://github.com/bblancha) Implemented a simple form of associative arrays. Details [here](https://github.com/redox-os/ion/pull/465).
- [@llambda](https://github.com/llambda) Made `Ion` compile on Darwin. Details [here](https://github.com/redox-os/ion/pull/466). 
- [@fengalin](https://github.com/fengalin) Fixed the compilation on Redox. Details [here](https://github.com/redox-os/ion/pull/467).
- [@nivkner](https://github.com/nivkner) Included whitespace in `alias` builtin arguments. Details [here](https://github.com/redox-os/ion/pull/468).
- [@memoryleak47](https://github.com/memoryleak47) Implemented `popd` command line options. Details [here](https://github.com/redox-os/ion/pull/473).
- [@huntergoldstein](https://github.com/huntergoldstein) Added support to allow builtins to be executed as part of pipelines. Details [here](https://github.com/redox-os/ion/pull/469).
- [@mmstick](https://github.com/mmstick) Fixed quote terminator. Details [here](https://github.com/redox-os/ion/commit/a17a1b14f1124b9167846c97a311328221198583).
- [@drosseau](https://github.com/drosseau) Added support for stepped ranges. Details [here](https://github.com/redox-os/ion/pull/475).
- [@jackpot51](https://github.com/jackpot51) Fixed the build on Redox. Details [here](https://github.com/redox-os/ion/commit/d7e1a44c1d26b6770a428d272357d47f6a6496cb).
- [@mmstick](https://github.com/mmstick) Added `rustfmt` config. Details [here](https://github.com/redox-os/ion/commit/16097c629760996f9ab13d80f888b812e22d2248).
- [@mmstick](https://github.com/mmstick) Create PID variable to store shell's PID. Details [here](https://github.com/redox-os/ion/commit/4cea5782acbedeebee768b6b4b3eafddb4f1ce7b).
- [@mmstick](https://github.com/mmstick) Did some updates to the manual. Details [here](https://github.com/redox-os/ion/commit/13e6828393737755ee93dde28739ba11c0f7bbe5) and [here](https://github.com/redox-os/ion/commit/3ae0040fb1117fd0baa707cba543137cdc65f24b).
- [@huntergoldstein](https://github.com/huntergoldstein) Made a change so RawFDs are now managed by forked process, not shell::pipe::builtin, when appropriate. Details [here](https://github.com/redox-os/ion/pull/479).
- [@drosseau](https://github.com/drosseau) Fixed some range syntax bugs. Details [here](https://github.com/redox-os/ion/pull/447).
- [@huntergoldstein](https://github.com/huntergoldstein) Made a fix so `expand_process` now does not strip newlines for quoted instances. Details [here](https://github.com/redox-os/ion/pull/449).
- [@bblancha](https://github.com/bblancha) Implemented the `and` and `or` builtins. Details [here](https://github.com/redox-os/ion/pull/459).
- [@jackpot51](https://github.com/jackpot51) Simplified cross platform functions. Details [here](https://github.com/redox-os/ion/pull/451).

## Drivers

- [@jackpot51](https://github.com/jackpot51) Added a change to return error when `dup` buffer is not empty. Details [here](https://github.com/redox-os/drivers/commit/473ac85faa32166697ea954c01e9227397c744b3) and [here](https://github.com/redox-os/drivers/commit/513ddd9eb5f3d1b32da1e795f97894a0666c4d12).
- [@jackpot51](https://github.com/jackpot51) Added runtime registers and  testing for TLB in the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/815b59b80bb74efb1ff93be02641c2e49cce3c8c).
- [@jackpot51](https://github.com/jackpot51) Fixed mapping size of XHCI, and added more debugging. Details [here](https://github.com/redox-os/drivers/commit/325b303c545d352f81c13a884dbf4e4595eb67aa) and [here](https://github.com/redox-os/drivers/commit/545ec4d21fa6b239cb7ee27f86a21baea9563f9b).
- [@jackpot51](https://github.com/jackpot51) Refactored events mechanism on the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/43c1d5b6b0ba6dfe0adc3237bfb679f98ecce116).
- [@jackpot51](https://github.com/jackpot51) Added Cargo.lock to version control. Details [here](https://github.com/redox-os/drivers/commit/fc1a21c8eec1a989c760ef2f69019e33511989e7).
- [@jackpot51](https://github.com/jackpot51) Did a big refactoring of the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/b4209a6a9ca0527f2a0981e1eb4c6d73d25b2e26) and [here](https://github.com/redox-os/drivers/commit/84a8a6c0640325b2c545bbdfbb47a82d4a4a9774).

## Redoxfs

- [@jackpot51](https://github.com/jackpot51) Added a change to return error when `dup` buffer is not empty. Details [here](https://github.com/redox-os/redoxfs/commit/f40f6921e87af58ed4d18f06bd3736b7db76bd20) and [here](https://github.com/redox-os/redoxfs/commit/e635648ed7e779f52c2af2365ce6f2269ccbdbc6).
- [@ids1024](https://github.com/ids1024) Made a fix for `readdir` when directory does not fit in buffer. Details [here](https://github.com/redox-os/redoxfs/pull/27).
- [@ids1024](https://github.com/ids1024) Made a change to FUSE in order to allow setting `mtime` to earlier time. Details [here](https://github.com/redox-os/redoxfs/pull/28).
- [@ids1024](https://github.com/ids1024) Implemented directory symlinks. Details [here](https://github.com/redox-os/redoxfs/pull/29).

## TFS

[TFS](https://github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

- [@ticki](https://github.com/ticki) Add a debug assertion against null pointers and one pointers in `conc::garbage::Garbage`. Details [here](https://github.com/redox-os/tfs/commit/f8dad19e65959e923297e0d58320f5945057cadd).
- [@m4b](https://github.com/m4b) Made a change in `chashmap` to use `debug_map` enabling pretty printing requests from user. Details [here](https://github.com/redox-os/tfs/pull/51).
- [@m4b](https://github.com/m4b) Fixed a stack overflow in debug prints for guards in `chashmap`. Details [here](https://github.com/redox-os/tfs/commit/0e5781023fa9b513278a582cb59e6b0d8f4f678f).
- [@ticki](https://github.com/ticki) Bumped `speck` to `1.1.0`. Details [here](https://github.com/redox-os/tfs/commit/c1225f2ed7b5e749f0c515b82730ad21c0e4aa61).
- [@ticki](https://github.com/ticki) Reserved special pointers for `conc::hazard::State` to avoid overlapping with pointers used in `Protect`. Details [here](https://github.com/redox-os/tfs/commit/47d2ee6ed14b081db8b1c9947189870779d72acf).
- [@ticki](https://github.com/ticki) Removed warnings from `conc` in release mode. Details [here](https://github.com/redox-os/tfs/commit/bc7183071aa07e9067c54fff7e05f2533e50e650).
- [@ticki](https://github.com/ticki) Added some notes on the ideas for the `zmicro` compression algorithm. Details [here](https://github.com/redox-os/tfs/commit/624dce5fc4e12063972bc4817edfacfaa558f333).
- [@ticki](https://github.com/ticki) Prevented certain tests in `conc` from messing with each other by having separated states. Details [here](https://github.com/redox-os/tfs/commit/dfc113e08a6daf0473ba55e6317a62b270c12970).
- [@ticki](https://github.com/ticki) Added tests on-exit garbage collection in `conc`. Details [here](https://github.com/redox-os/tfs/commit/ab3c74d0011d6bebe3e4d102aa2d051208798226).
- [@ticki](https://github.com/ticki) Set down `MAX_NON_FREE_HAZARDS` in `conc::local` to avoid unnecessarily high memory usage. Details [here](https://github.com/redox-os/tfs/commit/4b8217f67d11c6e62e78a85b52068977bab5dc85).
- [@ticki](https://github.com/ticki) Added new tests for drops in `conc::Atomic` with the overwrite drops. Details [here](https://github.com/redox-os/tfs/commit/3e4fbab846ec7503bf7bab67705e3b71049685fe).
- [@ticki](https://github.com/ticki) Added tests for `conc::local`'s hazard clearing behaviour. Details [here](https://github.com/redox-os/tfs/commit/36f867570b0f495048c300e4f85abcb66419dd6b).
- [@memoryleak47](https://github.com/memoryleak47) Fixed an infinite loop in `chashmap`'s `scan()`. Details [here](https://github.com/redox-os/tfs/pull/58).
- [@ticki](https://github.com/ticki) Fixed an unsoundness of the internal `conc` API. Details [here](https://github.com/redox-os/tfs/commit/ce4ac1c7da81b4ee8d68384c37248bc882d5a32c).
- [@cedenday](https://github.com/cedenday) Removed the dependency of `speck` on `std`. Details [here](https://github.com/redox-os/tfs/pull/55).

## Coreutils

-  [@jackpot51](https://github.com/jackpot51) Added Cargo.lock to version control. Details [here](https://github.com/redox-os/coreutils/commit/7d978b672183b04f5eb1c6f73fe5332fd1fe0535) and [here](https://github.com/redox-os/coreutils/commit/f933387ae8746486ac093fa942911faac49f5f8d).
- [@ids1024](https://github.com/ids1024) Allowed directory as second argument to `ln`. Details [here](https://github.com/redox-os/coreutils/pull/173).
- [@ids1024](https://github.com/ids1024) Implemented octal escapes in `tr`. Details [here](https://github.com/redox-os/coreutils/pull/174).

## Userutils

- [@goyox86](https://github.com/goyox86) Made some improvements to `getty`. Details [here](https://github.com/redox-os/userutils/pull/9).
- [@jackpot51](https://github.com/jackpot51) Fixed `getty` spawning code. Details [here](https://github.com/redox-os/userutils/commit/4e2561ed75a6283ca8e8c5e9fea313317db47207).
- [@jackpot51](https://github.com/jackpot51) Made updates to `getty`in order to use `PTY` to provide line control for raw consoles and vesad. Details [here](https://github.com/redox-os/userutils/commit/83d77f812438b78b0108d2d8e29ae8183eafcd3e).
-  [@jackpot51](https://github.com/jackpot51) Added Cargo.lock to version control. Details [here](https://github.com/redox-os/userutils/commit/1725b377cddb42af08209a652bc63008e2b59f1c) and [here](https://github.com/redox-os/userutils/commit/e35d0bc6cd03cf67b96b56e1e42450be0274b2c6).
- [@goyox86](https://github.com/goyox86) Revisiting `passwd` to update it to `coreutils` conventions and new APIs. Details [here](https://github.com/redox-os/userutils/pull/12).
- [@goyox86](https://github.com/goyox86) Revisiting `su` to update it to `coreutils` conventions and new APIs. Details [here](https://github.com/redox-os/userutils/pull/11).
- [@goyox86](https://github.com/goyox86) Revisiting `login` to update it to `coreutils` conventions and new APIs. Details [here](https://github.com/redox-os/userutils/pull/10).

## Netstack

- [@jackpot51](https://github.com/jackpot51) Added a change to return error when `dup` buffer is not empty. Details [here](https://github.com/redox-os/netstack/commit/7f1eddc84d835423406ebf082cbbbdf9fc4b5025).
- [@jackpot51](https://github.com/jackpot51) Added Cargo.lock to version control. Details [here](https://github.com/redox-os/netstack/commit/51abd85d7093f84ddb4fc7fb1b5d58a07d2a0782) and [here](https://github.com/redox-os/netstack/commit/b34622184095a9765a2064e1d72087980494c2df).

## Netutils

- [@jackpot51](https://github.com/jackpot51) Added Cargo.lock to version control. Details [here](https://github.com/redox-os/netutils/commit/f5ccf7232353107e46e3d9308a1631633ee0398a) and [here](https://github.com/redox-os/netutils/commit/293fc961f92ba08f462cf1cc28d50d999265689a).

## Orbital

- [@jackpot51](https://github.com/jackpot51) Added Cargo.lock to version control. Details [here](https://github.com/redox-os/orbital/commit/5d9d274068f06732b9805c048ae39be074846357) and [here](https://github.com/redox-os/orbital/commit/dc6a6c901126d60cf154baabc73ac2bf68ff3b79).

## Cookbook

The [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes of Redox.

- [@jackpot51](https://github.com/jackpot51) Added a `status.sh` script for checking git modifications. Details [here](https://github.com/redox-os/cookbook/commit/1df0bc544357bfadf66502d87ddff4a3bd709c25),[here](https://github.com/redox-os/cookbook/commit/eb0a4c73156c9038107bc4454b40637065e03f9e) and [here](https://github.com/redox-os/cookbook/commit/943fe8ae8c99250b2ee0ffe2f4dc9edfe782e328).
- [@jackpot51](https://github.com/jackpot51) Added a `update.sh` script. Details [here](https://github.com/redox-os/cookbook/commit/3863dc9b4243ecd7c80f1f6984bcb1083f37c359).
- [@jackpot51](https://github.com/jackpot51) Updated the `ion` recipe to use a custom branch with simpler signal handling and afterwards switched back to `master` as the simpler signals work was mainstreamed into `Ion`. Details [here](https://github.com/redox-os/cookbook/commit/6e4d16d5d3b3525f31f10bcb9f9c6681004e1136) and [here](https://github.com/redox-os/cookbook/commit/2067c8292e1f7e2af2f794ff7d445bd4772ff1c6) respectively.
- [@ids1024](https://github.com/ids1024) Added a recipe for GNU `grep`. Details [here](https://github.com/redox-os/cookbook/pull/52) and [here](https://github.com/redox-os/cookbook/pull/53).
- [@ids1024](https://github.com/ids1024) Made a patch in the `git` to use `;` as `PATH` separator. Details [here](https://github.com/redox-os/cookbook/pull/54).
- [@ids1024](https://github.com/ids1024) Added a recipe for `diffutils`. Details [here](https://github.com/redox-os/cookbook/pull/55).
- [@jackpot51](https://github.com/jackpot51) Made a change to `cook.sh` so it updates the `source` and not the `build` directory as Cargo.lock is now committed. Details [here](https://github.com/redox-os/cookbook/commit/7d06611aa92938727325dbda68ff3e0805a3ce13).
- [@jackpot51](https://github.com/jackpot51) Made a change to `update.sh` to check for `source` and not for `build` as Cargo.lock is now committed. Details [here](https://github.com/redox-os/cookbook/commit/7d06611aa92938727325dbda68ff3e0805a3ce13).

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
- Brayden Banks 🎂
- Bryan Blanchard 🎂
- Danny 🎂
- fengalin 🎂
- Fredrik 🎂
- friend 🎂
- garasubo 🎂
- Grant Miner 🎂
- m4b 🎂
- memoryleak47 🎂
- Michel Boaventura 🎂
- Niv 🎂
- Richard Palethorpe 🎂

If I missed something, feel free to contact me (goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
