+++
title = "This Week in Redox 29"
author = "goyox86"
date = "2017-09-25 22:55:55 +0100"
+++

This is the 29th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

## TL;DR

Hello again! Did you missed us?

We hope you did!

Anyways, I have good news for you: it was only me! Because the rest of the team was super busy making Redox even awesomer ;)

There is a lot of stuff packed on this one. So... Buckle up!

First things first: During my absence there were 3 new releases [0.3.1](https://github.com/redox-os/redox/releases/tag/0.3.1), [0.3.2](https://github.com/redox-os/redox/releases/tag/0.3.2) and [0.3.3](https://github.com/redox-os/redox/releases/tag/0.3.3) focused on better POSIX compatibility, improved ACPI support and lower memory usage respectively (Along many other things I'm gonna cover next).

We also have a new [login window and a file dialog](https://imgur.com/a/4E7sz) thanks to [@jackpot51](https://github.com/jackpot51). 

Other important news is that we took over the maintenance of the **RustType** crate, it now lives [here](https://github.com/redox-os/rusttype) under the redox-os Github organization.

Let's start the more detailed view with the **kernel** where we have the [huge ACPI revamp](https://github.com/redox-os/kernel/pull/48) done by [@CWood1](https://github.com/CWood1) which implements (among other things) a full fledged AML parser. Mr [@jackpot51](https://github.com/jackpot51) was busy improving the debugging code, implementing events on pipe (which in turn adds up to `mio`s crate support AKA: [this](https://gist.github.com/goyox86/5902f42988b91741bc12a42a6b5c78ed) small sample now works in Redox). He also fixed the mapping of TLS (which now page aligned) as well as improved error information and cleaned the interrupt macros.

On the **Ion** front [@glowing-chemist](https://github.com/glowing-chemist) added support for polish notation, also, and thanks to [@mmstick](https://github.com/mmstick) Ion now supports 8, 16, 24 and 256 colours. He also added support for the `$SWD` and `$MWD` environment variables. A new `exists` builtin was added by [@BafDyce](https://github.com/BafDyce) and [@nivkner](https://github.com/nivkner) made some refactoring on the `match` statements. But changes don't stop there, read the details and you will see that there is a lot of other interesting stuff ni there!

The **drivers** saw a bunch of updates and fixes mostly by [@jackpot51](https://github.com/jackpot51) who made some fixes to `pcid`, a change on `Intel8254x` network driver in order use a spin for reset instead of yielding along with the addition of a method for resizing display in `bgad`. He also disabled the `XHCI` driver due to lockups and removed some unused `extern crate`s statements.

The **RedoxFS** got some attention from [@ids1024](https://github.com/ids1024) who made it not an error to open a directory without `O_DIRECTORY` or `O_STAT`, and `futimens` not to require `O_RWONLY/O_RDWR`. Also, we are temporarily using a `nightly` friendly version of the `spin` crate.

**TFS** land was visited by [@ticki](https://github.com/ticki) and among the highlights are: the introduction of a new `control-flow` crate to control control-flow outside closures, a fix for several compile errors in `atomic-hashmap`, the addition of `conc::Guard::{try,maybe}_map` followed by the switch to `parking_lot` in `conc`.

The **cookbook** (our collection of packages) was also very active during this period! [@7h0ma5](https://github.com/7h0ma5) added recipes for `ncurses` and `readline` while [@ids1024](https://github.com/ids1024) added one for `perl` and [@xTibor](https://github.com/xTibor) added `ffmpeg`. `python` was updated to a new version and a new `--debug` argument was added to `cook.sh` (the package builder). Last but no least! [@AgostonSzepessy](https://github.com/AgostonSzepessy) added support for dependency info to packages. Nice! 

Also, there are big news in **coreutils**: We are now using [coreutils](https://github.com/uutils/coreutils) versions of the utilities where it makes sense. For example: [@ids1024](https://github.com/ids1024) removed our versions of `chmod`, `env`, and `ls` opening room for the better versions on `uutils` (our fork of `coreutils`). While all of that was being done, [@dabbydubby](https://github.com/dabbydubby) was improving `pwd`'s description, reformatting, restructuring and fixing few bugs in `mv` and afterwhile porting those changes over to `cp`.

Finally on the GUI side of things **Orbital** experienced bunch of unused code remotion and the start of the work on z-buffering (by [@jackpot51](https://github.com/jackpot51)) while **Orbtk** saw the birth of a new file dialog, got the ability to convert an `orbclient` window into an `orbtk` one, the addition of borders around menu entries and some fixes on textbox's scrolling.

*Bonus*: Few days ago we saw this message from [@jackpot51](https://github.com/jackpot51) on the Redox chat: "Gentlemen, I am going to port libservo". Yes! some `libservo` work is on the way <3

*Bonus 2*: I also woke up one day and saw this [MESA fork](https://github.com/redox-os/mesa). 

Exciting times! Aren't they? Stay tunned for more!

## Kernel

The Redox microkernel.

- [@ids1024](https://github.com/ids1024) Added support for arguments in `#!`. Details [here](https://github.com/redox-os/kernel/pull/47).
- [@jackpot51](https://github.com/jackpot51) Fixed the PIT. Details [here](https://github.com/redox-os/kernel/commit/9fcaf30513d8f58cc405f14b2263f499de8fa185).
- [@jackpot51](https://github.com/jackpot51) Made `syscall` a submodule. Details [here](https://github.com/redox-os/kernel/commit/d487e1d23f39a26ea927b39a80f20e064bcdafaf).
- [@CWood1](https://github.com/CWood1) Fully implemented AML parser, and did many improvements to the ACPI infrastructure. Details [here](https://github.com/redox-os/kernel/pull/48).
- [@jackpot51](https://github.com/jackpot51) Removed warnings, improved error information and cleaned up interrupt macros in ACPI. Details [here](https://github.com/redox-os/kernel/commit/a5f3e5057b72c1f920839a8ab46f3ee77d6a17ae).
- [@jackpot51](https://github.com/jackpot51) Fixed the mapping of TLS. It is now be page aligned. Details [here](https://github.com/redox-os/kernel/commit/917d30c193edd6a7c4bdbf89f78c59299f4b4f4d).
- [@jackpot51](https://github.com/jackpot51) Implemented events on pipe, added syscall name debugging and update debugging code. Details [here](https://github.com/redox-os/kernel/commit/6e8de21b7c3354e9a1eac3c0570d9c5065281dec).
- [@ids1024](https://github.com/ids1024) Commented out system call debug printing code. Details [here](https://github.com/redox-os/kernel/pull/51).
- [@jackpot51](https://github.com/jackpot51) Updated debugging code. Details [here](https://github.com/redox-os/kernel/commit/5839641b414452fe789d85a2ec2670ca6c050dd6).
- [@jackpot51](https://github.com/jackpot51) Changed `unreachable` to `enosys`. Details [here](https://github.com/redox-os/kernel/commit/bec961094700d6886bd7a2ceb26c9eadb3586073).
- [@ids1024](https://github.com/ids1024) Temporary overrode `spin-rs`. Details [here](https://github.com/redox-os/kernel/pull/52).
- [@jackpot51](https://github.com/jackpot51) Updated dependencies. Details [here](https://github.com/redox-os/kernel/commit/1f81866afafd5a3830c078c0ad8921b5316c0248).
- [@jackpot51](https://github.com/jackpot51) Implemented a more efficient live filesystem method, reduce kernel heap to 64 MB and fixed an issue in `build.rs`. Details [here](https://github.com/redox-os/kernel/commit/d6b9768dc3e9cd967df0acf3eafb10d02c9f0ba6).
- [@L3nn0x](https://github.com/L3nn0x) Correct small bug in memcpy 32bits implementation. Details [here](https://github.com/redox-os/kernel/pull/54).

## Ion

The Ion Shell. Compatible with Redox and Linux.

- [@glowing-chemist](https://github.com/glowing-chemist) Added support for polish notation. Details [here](https://github.com/redox-os/ion/pull/497).
- [@jwarner112](https://github.com/jwarner112) Reformatted the manual based on Rust book (2nd edition). Details [here](https://github.com/redox-os/ion/pull/499).
- [@BafDyce](https://github.com/BafDyce) Fixed broken & missing links in documentation. Details [here](https://github.com/redox-os/ion/pull/500).
- [@mmstick](https://github.com/mmstick) Implemented string method plugins support. Details [here](https://github.com/redox-os/ion/commit/15b8943381be21d941b0860ad0419a33a7669472).
- [@jackpot51](https://github.com/jackpot51) Fix Redox support. Details [here](https://github.com/redox-os/ion/commit/c6aabc1266f9a17ee4ac5482b248fc920f4f5c86).
- [@mmstick](https://github.com/mmstick) Added color namespace with 8/16-bit color support. Details [here](https://github.com/redox-os/ion/commit/c1fdd5e83a701621b99f75cd664aae28c6078ce1).
- [@BafDyce](https://github.com/BafDyce) Fixed syntax error in `src/shell/variables.rs`. Details [here](https://github.com/redox-os/ion/pull/501).
- [@BafDyce](https://github.com/BafDyce) Added the `exists` builtin. Details [here](https://github.com/redox-os/ion/pull/504).
- [@mmstick](https://github.com/mmstick) Enabled setting multiple color parameters. Details [here](https://github.com/redox-os/ion/commit/7709762ddd377a99829419e3ae771bb633b516d2).
- [@mmstick](https://github.com/mmstick) Implemented 256-bit colors support, colors are defined via hexadecimal values. IE: 4E or 4Ebg. Details [here](https://github.com/redox-os/ion/commit/3b511ecff7e055a0a35f0f76d8e2b3f0e423ce0e).
- [@mmstick](https://github.com/mmstick) Refactored, documented, and fixed a panic in colors. Details [here](https://github.com/redox-os/ion/commit/030edb7f6a2ff381d81b60230dc2ef6ecef26f44).
- [@chrisvittal](https://github.com/chrisvittal) Changed `time` from builtin to a shell keyword. Details [here](https://github.com/redox-os/ion/pull/505).
- [@mmstick](https://github.com/mmstick) Added colors tests & enable decimal notation. The 'c' namespace is now a shorthand for 'color'. Hexadecimal color notations now require to be prefixed with '0x'. Details [here](https://github.com/redox-os/ion/commit/5d35de2d42e19cecf41dd7823ee540aba3ff286e).
- [@BafDyce](https://github.com/BafDyce) Implemented `exists` builtin command (#504). Details [here](https://github.com/redox-os/ion/commit/abdb02af3c8a48143296d2b8cf093b29b36e57e4).
- [@mmstick](https://github.com/mmstick) Implemented 24-bit true color support. Details [here](https://github.com/redox-os/ion/commit/97586eca109134c1ffb1625c81f0012e5dd8e353).
- [@mmstick](https://github.com/mmstick) Updated prompt. Details [here](https://github.com/redox-os/ion/commit/3319ffb00e3ff54db1446302a7debd7e7f7ff893).
- [@mmstick](https://github.com/mmstick) Implemented `Ion` docs launch support. We now have a `setup.ion` script for performing more advanced setup/installations. If the documentation is installed, it is accessible via the ion-docs builtin. This requires that the user specifies a BROWSER variable. . Details [here](https://github.com/redox-os/ion/commit/ffd7efde78ef5e1444413672570dcd8bf27e5d68).
- [@mmstick](https://github.com/mmstick) Implement `$SWD` and `$MWD` variables. `SWD`: Simplified Working Directory -- the default that most prompts use and `MWD`: Minified Working Directory -- the default that `Fish` uses. Details [here](https://github.com/redox-os/ion/commit/84b54577cfa5c658a320d6a1f9b6ddcf1bc5cd9f).
- [@glowing-chemist](https://github.com/glowing-chemist) Added a fallback to polish notation in calc. If the supplied expression doesn't match standard notation, try Polish (prefix) notation. Details [here](https://github.com/redox-os/ion/commit/ce6625b2e9ffdc5726803280666fd95c761f21d7).
- [@BafDyce](https://github.com/BafDyce) Allowed user to prevent commands from being saved in history. Details [here](https://github.com/redox-os/ion/pull/512).
- [@BafDyce](https://github.com/BafDyce) Fixed a small error in readme. Details [here](https://github.com/redox-os/ion/pull/514).
- [@drosseau](https://github.com/drosseau) Added a --version flag. Details [here](https://github.com/redox-os/ion/pull/516).
- [@mmstick](https://github.com/mmstick) Enhanced Assignment Parsing. Details [here](https://github.com/redox-os/ion/commit/fab14ab90fc7c0be7c00c6ee556ec901c2f2608f).
- [@mmstick](https://github.com/mmstick) Completed assignment type checking. Details [here](https://github.com/redox-os/ion/commit/1eceb5e36002cfca610f18d78e2b99336c04fbe5).
- [@mmstick](https://github.com/mmstick) Added methods documentation. Details [here](https://github.com/redox-os/ion/commit/dc9e0f15037705fc137710f9c28d7dcbe9c081c0).
- [@mmstick](https://github.com/mmstick) Documented the new assignment logic. Details [here](https://github.com/redox-os/ion/commit/65947555b0cee94ee1e9f3e2c52015c56bfcf0d0).
- [@mmstick](https://github.com/mmstick) Completely revamped function & assignment parsing. Function assignments now work the same as assignments in general. Assignments now instead take the expanded value into consideration when comparing types and the pre-expanded value determines arrayness. Details [here](https://github.com/redox-os/ion/commit/6308880f6af776164e4e16daa5ffb00f555ad366).
- [@mmstick](https://github.com/mmstick) Fixed a test. Details [here](https://github.com/redox-os/ion/commit/d7f1789377bb90226ab22c5bf97d9a8815476e20).
- [@mmstick](https://github.com/mmstick) Add more unit tests to functions. Details [here](https://github.com/redox-os/ion/commit/d98caf35e33f5de2fa1f2d4a62a7c4edebd4845a).
- [@mmstick](https://github.com/mmstick) Implemented case bindings support. Details [here](https://github.com/redox-os/ion/commit/2000f2400a4248489c22fae6365fef02351af0bb).
- [@mmstick](https://github.com/mmstick) Fixed array checks. Details [here](https://github.com/redox-os/ion/commit/94c8e60aeb063840376ba06fb278e510826d218b).
- [@mmstick](https://github.com/mmstick) Implemented conditional support with match cases. Details [here](https://github.com/redox-os/ion/commit/a247adb7326865b713d14610c1338fc1b5034921).
- [@mmstick](https://github.com/mmstick) Refactored some work. Details [here](https://github.com/redox-os/ion/commit/9906d32f04174357afcd950787ce40cd780df763).
- [@bb010g](https://github.com/bb010g) Set rust-toolchain for latest nightly. Details [here](https://github.com/redox-os/ion/pull/520).
- [@nivkner](https://github.com/nivkner) Refactored `match` statements. Details [here](https://github.com/redox-os/ion/pull/522).
- [@nivkner](https://github.com/nivkner) Made a change to distinguish between environment and local variables. Details [here](https://github.com/redox-os/ion/pull/523).
- [@nivkner](https://github.com/nivkner) Re-enabled ignoring commands in history. Details [here](https://github.com/redox-os/ion/pull/524).
- [@chrisvittal](https://github.com/chrisvittal) Changed time from builtin to shell keyword. Details [here](https://github.com/redox-os/ion/commit/d05cebd707818ec9b3eca94b1a70eb81d34860d3).
- [@jackpot51](https://github.com/jackpot51) Used fork of app-dirs-rs with support for Redox. Details [here](https://github.com/redox-os/ion/pull/527).
- [@mmstick](https://github.com/mmstick) Protected vars & improved assignment errors. Details [here](https://github.com/redox-os/ion/commit/bad04dfd6d0acd533e0d169f50114c78e2a75d67).
- [@mmstick](https://github.com/mmstick) Addressed compiler warnings. Details [here](https://github.com/redox-os/ion/commit/964aee5b73a4e104813de222aa00f559ec531542).
- [@mmstick](https://github.com/mmstick) Disabled namespace plugins by default. Details [here](https://github.com/redox-os/ion/commit/758aba5fbc6eb7c3f6ff3744d4f729c6d5e58aed).
- [@mmstick](https://github.com/mmstick) Disabled plugins for root. Details [here](https://github.com/redox-os/ion/commit/e5c32769443ce86568e4cfd0843743b43163ab56).
- [@aeosynth](https://github.com/aeosynth) Updated `README.md`. Details [here](https://github.com/redox-os/ion/pull/533).
- [@aeosynth](https://github.com/aeosynth) Updated `README.md` as nightly is required for compiling. Details [here](https://github.com/redox-os/ion/commit/9e1221f5ad651ceb956fc7aca88cfbe9809b9a89).
- [@KaKnife](https://github.com/KaKnife) Updated build.rs (#553) \n Nightly is required for compiling. Details [here](https://github.com/redox-os/ion/pull/534).
- [@jackpot51](https://github.com/jackpot51) Updated Redox support. Details [here](https://github.com/redox-os/ion/commit/1ac33a9bc288e78df4126fd0a41d3a9c9529192b).
- [@jackpot51](https://github.com/jackpot51) Fixed Redox `watch_foreground`. Details [here](https://github.com/redox-os/ion/pull/536).
- [@mmstick](https://github.com/mmstick) Applied `rustfmt-nightly` across the entire project. Details [here](https://github.com/redox-os/ion/commit/4b90fbc039ae67955fd1272bdd7d539f53097e1a).
- [@mmstick](https://github.com/mmstick) Applied more further `rustfmt` improvements. Details [here](https://github.com/redox-os/ion/commit/a61f0ec9bfc4e9d3a6900b6fc363a431edca1816).
- [@mmstick](https://github.com/mmstick) Made a change so public items now have crate-level visibility. Details [here](https://github.com/redox-os/ion/commit/41ff9ecb9acf56b05dedf5e156fb106db36e4e14).
- [@nivkner](https://github.com/nivkner) use `c_char` for plugin arguments instead of `i8`. Details [here](https://github.com/redox-os/ion/pull/537).

## Drivers

Redox OS Drivers

- [@jackpot51](https://github.com/jackpot51) Updated `mut` usage in `vesad`. Details [here](https://github.com/redox-os/drivers/commit/18f28d46b459368412e9943b6d05ba26c5362597).
- [@jackpot51](https://github.com/jackpot51) Updated `config.rs` in `pcid`. Details [here](https://github.com/redox-os/drivers/commit/1e7240eda6563019d9fc85552ae7dafb1287d0da).
- [@jackpot51](https://github.com/jackpot51) Updated `main.rs` in `pcid`. Details [here](https://github.com/redox-os/drivers/commit/1d7e51b42323bba3621983c2c2516557ff2c5ce0).
- [@jackpot51](https://github.com/jackpot51) Used a spin for reset, do not yield in the `Intel8254x`. Details [here](https://github.com/redox-os/drivers/commit/ee58fcaa6176c26d13a5a1433e2eb85b860c3a0c).
- [@jackpot51](https://github.com/jackpot51) Added the ability to query `BGA`. Details [here](https://github.com/redox-os/drivers/commit/770a23ef942e5614952b5117659f4fc805721420).
- [@jackpot51](https://github.com/jackpot51) Added method for resizing display in `bgad`. Details [here](https://github.com/redox-os/drivers/commit/4e40c1c8afb64c714fdfc80704038cc69b176e69).
- [@jackpot51](https://github.com/jackpot51) Disabled the `XHCI` driver due to lockups. Details [here](https://github.com/redox-os/drivers/commit/bc186fbb0d1a648d5985c02eceb07a75586189d6).
- [@jackpot51](https://github.com/jackpot51) Removed unused `extern crate`. Details [here](https://github.com/redox-os/drivers/commit/053524acacb197156f119e8033425818cc6be41c).
- [@jackpot51](https://github.com/jackpot51) Removed unnecessary `extern crate`. Details [here](https://github.com/redox-os/drivers/commit/17b592b0642b0e4a96b46d9785ada9b57b3dac8c).
- [@jackpot51](https://github.com/jackpot51) Fixed static on the Intel HDA driver. Details [here](https://github.com/redox-os/drivers/commit/46c84616ec12e157765e11b7e69b3408db8b8013).

## Redoxfs

The Redox Filesystem

- [@ids1024](https://github.com/ids1024) Made it not an error to open a directory without `O_DIRECTORY` or `O_STAT`. Details [here](https://github.com/redox-os/redoxfs/pull/32).
- [@ids1024](https://github.com/ids1024) `futimens`: do not require `O_RWONLY/O_RDWR`. Details [here](https://github.com/redox-os/redoxfs/pull/33).
- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock. Details [here](https://github.com/redox-os/redoxfs/commit/8f41e5a7773e6dc7c48f6890b38532e9019cca5a).
- [@ids1024](https://github.com/ids1024) Removed unused import causing lint. Details [here](https://github.com/redox-os/redoxfs/pull/34).
- [@jackpot51](https://github.com/jackpot51) Used `nightly` friendly spin. Details [here](https://github.com/redox-os/redoxfs/commit/b272cc2d19054ddb9cb257d5ae110750cff43f50).

## TFS

Next Generation File System

- [@ticki](https://github.com/ticki) Fix several compile errors in `atomic-hashmap`. Details [here](https://github.com/redox-os/tfs/commit/32980a7b45f7e31c3760c7535b414c44abd35b24).
- [@ticki](https://github.com/ticki) Added `conc::Guard::{try,maybe}_map`. Also added tests for it and `Guard::new` et al. Details [here](https://github.com/redox-os/tfs/commit/a89569cc6f10a46baf4ba7b0d17251fbd1126411).
- [@ticki](https://github.com/ticki) Introduced `control-flow`, a crate to control control-flow outside closures. Details [here](https://github.com/redox-os/tfs/commit/3c67c36a6b290fe383352507d67189f6fc58c2db).
- [@ticki](https://github.com/ticki) Added `defer!()` as shortcut for `defer!(())` in `control-flow`. Details [here](https://github.com/redox-os/tfs/commit/deb2ea257d456e8963d2133030065f39b1327b6f).
- [@ticki](https://github.com/ticki) Switch `conc` to `parking_lot` Mutex instead of spin locks. Details [here](https://github.com/redox-os/tfs/commit/ba1bd2862dc9815cb1acdc326532e868d2809a3c).
- [@ticki](https://github.com/ticki) Fixed some compile errors in `atomic-hashmap`. https://twitter.com/ticki_/status/901478579925602304. Details [here](https://github.com/redox-os/tfs/commit/8c266e54d71285af21a70146b97a2182a2980ae6).
- [@ticki](https://github.com/ticki) Removed the last errors and warnings from `atomic-hashmap`. Details [here](https://github.com/redox-os/tfs/commit/3e7dcdb0c586d0d8bb3f25bfd948d2f418a4ab10).

## Cookbook

A collection of package recipes for Redox.

- [@ids1024](https://github.com/ids1024) Patched `patch` to not to call `chown`. Details [here](https://github.com/redox-os/cookbook/pull/65).
- [@ids1024](https://github.com/ids1024) Passed -p to cp, to make running autotools unnecessary. Details [here](https://github.com/redox-os/cookbook/pull/66).
- [@7h0ma5](https://github.com/7h0ma5) Added a recipe for `ncurses`. Details [here](https://github.com/redox-os/cookbook/pull/67).
- [@7h0ma5](https://github.com/7h0ma5) Added a recipe for `readline`. Details [here](https://github.com/redox-os/cookbook/pull/68).
- [@ids1024](https://github.com/ids1024) Added symlinks to `uutils` package. Details [here](https://github.com/redox-os/cookbook/pull/69).
- [@Nickforall](https://github.com/Nickforall) Fixed `ncurses` failing to compile. Details [here](https://github.com/redox-os/cookbook/pull/71).
- [@ids1024](https://github.com/ids1024) Simplified `git patch` a bit. Details [here](https://github.com/redox-os/cookbook/pull/72).
- [@ids1024](https://github.com/ids1024) Added `--debug` argument to `cook.sh` in order to build in debug mode, unstripped. Details [here](https://github.com/redox-os/cookbook/pull/73).
- [@ids1024](https://github.com/ids1024) Used release tarball for `curl`, with a couple patches. Details [here](https://github.com/redox-os/cookbook/pull/74).
- [@ids1024](https://github.com/ids1024) Bumped `python` version. Details [here](https://github.com/redox-os/cookbook/pull/76).
- [@jackpot51](https://github.com/jackpot51) Added `-i` to `autoreconf` for `curl`. Details [here](https://github.com/redox-os/cookbook/pull/77).
- [@ids1024](https://github.com/ids1024) Added a recipe for `perl`. Details [here](https://github.com/redox-os/cookbook/pull/78).
- [@ids1024](https://github.com/ids1024) Made a couple of fixes for Perl, and added initial recipes for `automake` and `autoconf`. Details [here](https://github.com/redox-os/cookbook/pull/79).
- [@jackpot51](https://github.com/jackpot51) Pulled forked `pastel`. Details [here](https://github.com/redox-os/cookbook/commit/0fb76a8ef221bbbf42dc8c170fbc3008f17fd37a).
- [@xTibor](https://github.com/xTibor) Added `ffmpeg` recipe. Details [here](https://github.com/redox-os/cookbook/pull/80).
- [@xTibor](https://github.com/xTibor) Removed unnecessary disable `ffmpeg` flags. Details [here](https://github.com/redox-os/cookbook/pull/81).
- [@jackpot51](https://github.com/jackpot51) Use `-unknown` for `gcc` and `g++`. Details [here](https://github.com/redox-os/cookbook/commit/cc5f7523bf9567eb17372c27ea8e514ae78e2ece).
- [@xTibor](https://github.com/xTibor) Switched `ffmpeg` to a working release branch, fixed hardcoded arch. Details [here](https://github.com/redox-os/cookbook/pull/82).
- [@jackpot51](https://github.com/jackpot51) Fixed tabulation, allowed recipe override of `DEBUG`. Details [here](https://github.com/redox-os/cookbook/commit/b991094bbdb18f048f94eef592ed96b5e3b1f046).
- [@jackpot51](https://github.com/jackpot51) Added slashes after source and build to support symlinks. Details [here](https://github.com/redox-os/cookbook/commit/d1c72f4de2d385635dbf8a292fc32c6b93b074b6).
- [@AgostonSzepessy](https://github.com/AgostonSzepessy) Added support for dependency info to packages. Details [here](https://github.com/redox-os/cookbook/pull/83).

## Userutils

User and group management utilities.

- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock and Cargo.toml. Details [here](https://github.com/redox-os/userutils/commit/bc31f4d49060b902eda82785c6be52d8ccbae331).
- [@andre-richter](https://github.com/andre-richter) Fixed unused extern crates. Details [here](https://github.com/redox-os/userutils/pull/13).

## Coreutils

The Redox coreutils.

- [@jackpot51](https://github.com/jackpot51) Removed extra `mut` in `tr`. Details [here](https://github.com/redox-os/coreutils/commit/0866995408522df8f662a3e74d062a0960a9b527).
- [@ids1024](https://github.com/ids1024) Remove `chmod`, `env`, and `ls`, which `uutils` has better versions of. Details [here](https://github.com/redox-os/coreutils/pull/175).
- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock and Cargo.toml. Details [here](https://github.com/redox-os/coreutils/commit/923f48fac93b79e1ea637e585a0717e19f565761).
- [@jackpot51](https://github.com/jackpot51) Fixed `extern crate`s everywhere. Details [here](https://github.com/redox-os/coreutils/commit/6183f6b02530ba83ed040fdf6770097f78e6d512).
- [@dabbydubby](https://github.com/dabbydubby) Changed `pwd`'s description from "return working directory name" to "print working directory". Details [here](https://github.com/redox-os/coreutils/pull/177).
- [@ids1024](https://github.com/ids1024) Used the released version of `filetime`. Details [here](https://github.com/redox-os/coreutils/pull/179).
- [@dabbydubby](https://github.com/dabbydubby) Reformatted, restructured and fixed few bugs in `mv`. Details [here](https://github.com/redox-os/coreutils/pull/180).
- [@dabbydubby](https://github.com/dabbydubby) Ported changes from mv.rs to cp.rs. Details [here](https://github.com/redox-os/coreutils/pull/181).

## Netstack

Redox OS network stack.

- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock. Details [here](https://github.com/redox-os/netstack/commit/cce699888aa12286cb16539a5acea212f61d95b2).
- [@jackpot51](https://github.com/jackpot51) Added debug messages and updated lock file. Details [here](https://github.com/redox-os/netstack/commit/4d6bf893973fec64b123690ea80be251dfe7a1ac).
- [@jackpot51](https://github.com/jackpot51) Made a change to send events on connect in `tcpd`. Details [here](https://github.com/redox-os/netstack/commit/5f70470c5c668c83ddd4d63b1ee87bae5647a038).
- [@jackpot51](https://github.com/jackpot51) Updated dependencies and a better implementation of C socket. Details [here](https://github.com/redox-os/netstack/commit/47179f97019ee36c9fb785ad01fe0dd351065691).

## Netutils

Network Utilities for Redox.

- [@ids1024](https://github.com/ids1024) Use `pbr` for `wget`'s progress bar. Details [here](https://github.com/redox-os/netutils/pull/28).
- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock and Cargo.toml. Details [here](https://github.com/redox-os/netutils/commit/849b72c5b9e77a654a51521276dc6f2223a67aec).
- [@jackpot51](https://github.com/jackpot51) Removed unused import in `telnetd`. Details [here](https://github.com/redox-os/netutils/commit/4e4485c8cada27a9908f5b1b65ecd6090a9cefa2).
- [@jackpot51](https://github.com/jackpot51) Added debug implementations. Details [here](https://github.com/redox-os/netutils/commit/ec1a835a9d4a95a8e41c4e994a540d298d897cd4).

## Extrautils

Extra utilities for Redox (and Unix systems).

- [@bblancha](https://github.com/bblancha) Added support for `tar` for processing symlinks. Details [here](https://github.com/redox-os/extrautils/pull/28).
- [@ids1024](https://github.com/ids1024) Added support for `tar` to set file times. Details [here](https://github.com/redox-os/extrautils/pull/29).
- [@ids1024](https://github.com/ids1024) Tried to fix travis by installing `liblzma`. Details [here](https://github.com/redox-os/extrautils/pull/30).
- [@ids1024](https://github.com/ids1024) Installed `lzma` with `no-sudo` method. Details [here](https://github.com/redox-os/extrautils/pull/31).
- [@ids1024](https://github.com/ids1024) Added support for `bzip2` extraction in tar. Details [here](https://github.com/redox-os/extrautils/pull/32).
- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock and Cargo.toml. Details [here](https://github.com/redox-os/extrautils/commit/11ababb42ea76fbd95f9fcc738cd79e899b827e2).
- [@jackpot51](https://github.com/jackpot51) Updated lock file. Details [here](https://github.com/redox-os/extrautils/commit/c2d8a74178bd6681345a043fdf0795fdb32de1f7).
- [@jackpot51](https://github.com/jackpot51) Patched termion to fix `less`. Details [here](https://github.com/redox-os/extrautils/commit/b8d6b2a1bbf4b18f0d6366a9c6c66228a17d242d).
- [@jackpot51](https://github.com/jackpot51) Update `libpager`. Details [here](https://github.com/redox-os/extrautils/commit/d7bc422f0185f30690e2f96fc101582d263f181d).
- [@jackpot51](https://github.com/jackpot51) Update to new `termion`. Details [here](https://github.com/redox-os/extrautils/commit/722de2c0ab3728d8bf7a9f778a37a0ae879d6662).

## Orbital

Redox Windowing and Compositing System.

- [@jackpot51](https://github.com/jackpot51) Removed `mut`s. Details [here](https://github.com/redox-os/orbital/commit/ca660480a99e5e2a662d47fcec68c83f81efa64d).
- [@jackpot51](https://github.com/jackpot51) Removed unnecessary `mut`s. Details [here](https://github.com/redox-os/orbital/commit/8dcf7acdac80b2db3629a7c15170aaa3ba347d6a).
- [@ids1024](https://github.com/ids1024) Added scheme to `PATH`. Details [here](https://github.com/redox-os/orbital/pull/15).
- [@jackpot51](https://github.com/jackpot51) Updated Cargo.lock. Details [here](https://github.com/redox-os/orbital/commit/4b957fc5aa006ea17b2d5f26ac2686c6ef1002c4).
- [@jackpot51](https://github.com/jackpot51) Made some work on zbuffer support. Details [here](https://github.com/redox-os/orbital/commit/f18e62ecd3ecb55345dcd098626283b8f8852cfa).
- [@jackpot51](https://github.com/jackpot51) Fixed zbuffer calculation. Details [here](https://github.com/redox-os/orbital/commit/1b894937317854ea0083afb5333af71ee69a3445).
- [@jackpot51](https://github.com/jackpot51) Replace front with first for `Vec`. Details [here](https://github.com/redox-os/orbital/commit/2f0a01cacbb953fb50d4d27123dc557213627d9e).
- [@jackpot51](https://github.com/jackpot51) Fixed some rendering issues. Details [here](https://github.com/redox-os/orbital/commit/f55fb1e68b2bd019a3777f2e337111d5ef0686bf).
- [@ids1024](https://github.com/ids1024) Removed unused imports that were triggering a lint. Details [here](https://github.com/redox-os/orbital/pull/17).
- [@jackpot51](https://github.com/jackpot51) Removed the background from config. Details [here](https://github.com/redox-os/orbital/commit/d65026420e8fcbb514f71b0ab0fde338b452c165).

## Orbtk

The Orbital Widget Toolkit. Compatible with Redox and SDL2.

- [@jackpot51](https://github.com/jackpot51) Fixed some list bugs. Details [here](https://github.com/redox-os/orbtk/commit/4f59f7ee387d0ad03d2e66422d7cfb43c5f51130).
- [@jackpot51](https://github.com/jackpot51) Added a WIP of a file dialog example. Details [here](https://github.com/redox-os/orbtk/commit/87df2a88171a1c33a589aa255dc11c9a1dd843ce).
- [@jackpot51](https://github.com/jackpot51) Added the ability to convert an `orbclient` window into an `orbtk` one. Also fixed list logic. Details [here](https://github.com/redox-os/orbtk/commit/b2fccf3b1342a36dc30f3aa2295db2133b6a70d8).
- [@jackpot51](https://github.com/jackpot51) Removed prints. Details [here](https://github.com/redox-os/orbtk/commit/b6c38c46c48f514aa69ac69c97bb9b66dcea2906).
- [@jackpot51](https://github.com/jackpot51) Added a file open dialog. Details [here](https://github.com/redox-os/orbtk/commit/cf00aaf0eb97d375ed6bb722ca40ea61ddd72dba).
- [@jackpot51](https://github.com/jackpot51) Released 0.2.21. Details [here](https://github.com/redox-os/orbtk/commit/0475e13b04da972e5afe0308598aa1afe4083554).
- [@jackpot51](https://github.com/jackpot51) Updated documentation. Details [here](https://github.com/redox-os/orbtk/commit/aed5c3de221474d07388b8cb4498c8f4b7f57251).
- [@jackpot51](https://github.com/jackpot51) Released 0.2.22. Details [here](https://github.com/redox-os/orbtk/commit/c95f6841ea0153ba403e7ab9ad6ab0f97129e83e).
- [@jackpot51](https://github.com/jackpot51) Fixed docs badge. Details [here](https://github.com/redox-os/orbtk/commit/51c9968ef4f3725f54c9af90c5c6b7a9ea1262a7).
- [@jackpot51](https://github.com/jackpot51) Added borders around menu entries. Details [here](https://github.com/redox-os/orbtk/commit/92cd78d632fec144816e04c9cc75d08ca871f642).
- [@jackpot51](https://github.com/jackpot51) Fixed textbox scrolling. Details [here](https://github.com/redox-os/orbtk/commit/7d62923f19b67805dc42bffbdf6a0d612ccc6b25).
- [@jackpot51](https://github.com/jackpot51) Released 0.2.25. Details [here](https://github.com/redox-os/orbtk/commit/33713e8c59f3029294ba0cff9ef1fcb35bb70186).
- [@jackpot51](https://github.com/jackpot51) Removed print. Details [here](https://github.com/redox-os/orbtk/commit/75da2a1ab3cb79039d018d4934c6f7c38e325764).

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

- Andre Richter 🎂
- Brayden 🎂
- Bob Sun 🎂
- Christopher Vittal 🎂
- Fabian Würfl 🎂
- Jacob Humphrey 🎂
- James Campos 🎂
- Jeff Warner 🎂
- Jonathan 🎂
- Josh Leverette 🎂
- Ken Reese 🎂
- Mihal Malostanidis 🎂
- nivkner 🎂
- Oliver Smith 🎂
- Thomas Gatzweiler 🎂

If I missed something, feel free to contact me [@goyox86](https://github.com/goyox86) or send a PR to the [Redox website](https://github.com/redox-os/website).
