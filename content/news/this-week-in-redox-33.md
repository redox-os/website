+++
title = "This Week in Redox 33"
author = "goyox86"
date = "2017-12-12 16:23:52 +0000"
+++

This is the 33rd post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by [@goyox86](https://github.com/goyox86))*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

## TL;DR

Hello and welcome back to another issue of TWiRx!

First of all, apologies for disappearing for a while but I've been super busy at work.

With that out of the way, let's start our tour!

The fact that I was super busy these last couple of weeks did not mean that the rest of the team was idle too, in fact, they were super busy which means I have a ton of progress to share!

Lets's start with the main repo where [@sajattack](https://github.com/sajattack) and [@HarryU](https://github.com/HarryU) made some fixes to the `bootstrap.sh` script and [@dlrobertson](https://github.com/dlrobertson) made it possible to keep debug info in a `.sym` file. Also, [@jackpot51](https://github.com/jackpot51) switched us to the `smolnetd` network stack!

The **bootloader** that has been updated to **Redoxfs** version 3.

In lower land of the **kernel** [@jackpot51](https://github.com/jackpot51) implemented `fchown` and `fchmod`. He also improved multi-core support while [@dlrobertson](https://github.com/dlrobertson) was busy improving the debugging support by preventing the discarding of the `.debug` section
as well as documenting on how to use `gdb`.

Keeping things low level (not really because Redox drivers are in userspace ;)), we have the **drivers** where [@jackpot51](https://github.com/jackpot51) made some `vesad` related updates in `ransid` and a fix of an error (`E0133`) on `pcid` was shipped by [@ghatdev](https://github.com/ghatdev).

Also driver-related is **ransid**, the ANSI terminal driver, who got two new versions released (`0.4.4` and `0.4.5`) containing an ICH implementation and fixes to DCH.

The system call interface, AKA the **syscall** crate saw the birth of `fchown` and `fchmod` which should make porting easier.

Before departing from the lower level layer we have **Redoxfs** with it's new major version, 3, with a new block size of `4096` bytes. This new version also includes changes enabling to set block size programmatically, a simplified disk cache and implementations of `fchmod` and `fchown`.

That's it with low level stuff. Let's move up in the stack!

What do we have there? Well, unsurprisingly, **Ion** is the first. As always it was a busy period for the **Ion** folks. Notably: The addition of the `status`, `bool`, and `is` builtins by [@Sag0Sag0](https://github.com/Sag0Sag0) as well as the migration to XDG and the implementation of a "command not found" hook by [@jD91mZM2](https://github.com/jD91mZM2). All of that along [@mmstick](https://github.com/mmstick)'s work on implementation of recursive aliases, the start of the migration of the error handling to the `failure` crate, the implementation of `huponexit` and the fixed to multi-line array assignments.

Continuing our trip, we stop at the **cookbook**, our software packages recipes repository. Let's see, we have new packages for: `libzip`, `libpng`, `cmatrix`, `netdb`, `mdp`, `TiMidity++` and the `GeneralUser GS` sound fonts along with a big increase in the set of binaries we use from `uutils`.

Switching gears to the GUI is **Orbclient** where [@robbycerantola](https://github.com/robbycerantola) implemented antialiased circles and lines.

Also in the GUI department, the **Orbtk** toolkit saw new version `0.2.26` including a `Grid` by [@FloVanGH](https://github.com/FloVanGH), fixes to label backgrounds, splitting of CSS into separate files, addition of border radii to button to `Button` and many more from [@jackpot51](https://github.com/jackpot51), without forgetting [@jsalzbergedu](https://github.com/jsalzbergedu) who allowed the user to specify a theme.

**Orbutils** was the object of [@BojanKogoj](https://github.com/BojanKogoj)'s attention this period with updates on the run instructions and the addition of a new shinny `Calendar` app. Also, [@MggMuggins](https://github.com/MggMuggins) updated all the code related to `redox_users` as we changed that API quite a lot during the last few weeks.

Next in the queue, is **Orbterm**, the terminal emulator. **Orbterm** released two new versions: `0.3.1` and `0.3.2` with improved resize performance by [@jackpot51](https://github.com/jackpot51) and the extraction of width and heights into fields by [@xTibor](https://github.com/xTibor).

**Sodium**, the text editor got a bit of love from [@sajattack](https://github.com/sajattack) who made a change to infer file to save to from file opened.

On the utils section, the **userutils** crate was under heavy refactoring and improvement primarily by [@MggMuggins](https://github.com/MggMuggins) who added `groupadd` and `useradd` as well refactored of almost all the rest of the tools. Related to this work is the one done by [@goyox86](https://github.com/goyox86) on the **redox_users** crate improving error handling and propagation by moving it to the `failure` crate. [@MggMuggins](https://github.com/MggMuggins) also extended `redox_users` API with the `add_user`, `add_group` and `get_gid` functions.

The **coreutils** package got lots of attention too. Here [@Mojo4242](https://github.com/Mojo4242) simplified `dd`, [@Tommoa](https://github.com/Tommoa) made some performance improvements for `cat`, while [@jackpot51](https://github.com/jackpot51) was shipping `chown` and using more utilities from `uutils` instead of our own.

Lastly but not least is **extrautils** who experienced a small change to use `cksum` from `uutils`.

Phew! That was a lot of work <3

See you soon!

## Redox

Redox: A Rust Operating System.

- [@HarryU](https://github.com/HarryU) Made a fix to check that `xargo` isn't already installed before trying to install. Details [here](https://github.com/redox-os/redox/pull/1110).
- [@jackpot51](https://github.com/jackpot51) Switched to `smolnetd`. Details [here](https://github.com/redox-os/redox/commit/49537bfae63003b986670f25b6196dd1188c5879).
- [@dlrobertson](https://github.com/dlrobertson) Implemented a change to keep debug info in a `.sym` file. Details [here](https://github.com/redox-os/redox/pull/1114).
- [@TSleepingCat](https://github.com/TSleepingCat) Removed broken old kernel link. Details [here](https://github.com/redox-os/redox/pull/1118).
- [@sajattack](https://github.com/sajattack) Added `cmake` dependency to `bootstrap.sh`. Details [here](https://github.com/redox-os/redox/pull/1120).

## Bootloader

Redox OS Bootloader.

- [@jackpot51](https://github.com/jackpot51) Updated to RedoxFS 3. Details [here](https://github.com/redox-os/bootloader/commit/615d9e136512a21cc5fb22b5ab74389e078d3fb7).

## Book

The Redox book.

- [@covercash2](https://github.com/covercash2) Listed `cmake` as a dependency. Details [here](https://github.com/redox-os/book/pull/112).

## Kernel

The Redox microkernel.

- [@jackpot51](https://github.com/jackpot51) Added `fchown` and `fchmod`. Details [here](https://github.com/redox-os/kernel/commit/789e290c9bef002cf6e908c75113dd6dd04f0a9e).
- [@jackpot51](https://github.com/jackpot51) Released version `0.1.32`. Details [here](https://github.com/redox-os/kernel/commit/578c57840afd1fc32559bfa2372509f2b5910581).
- [@dlrobertson](https://github.com/dlrobertson) Made a change to prevent discarding the `.debug` section. Details [here](https://github.com/redox-os/kernel/pull/64).
- [@dlrobertson](https://github.com/dlrobertson) Added documentation on using `gdb`. Details [here](https://github.com/redox-os/kernel/pull/65).
- [@jackpot51](https://github.com/jackpot51) Allowed other processors to pick up work. Details [here](https://github.com/redox-os/kernel/commit/dd7c61b830151ee39cda159508b142716e2d5c47).
- [@jackpot51](https://github.com/jackpot51) Improved multi-core support. Details [here](https://github.com/redox-os/kernel/commit/c2644adf3d37b68911df5087f641150d583c65fa).

## Ion

The Ion Shell. Compatible with Redox and Linux.

- [@AgustinCB](https://github.com/AgustinCB) Made a change to use less heap. Details [here](https://github.com/redox-os/ion/pull/596).
- [@AgustinCB](https://github.com/AgustinCB) Cleaned up some technical debt and added some tests. Details [here](https://github.com/redox-os/ion/pull/598).
- [@bheesham](https://github.com/bheesham) Added code block for multi-line comments in the docs. Details [here](https://github.com/redox-os/ion/pull/599).
- [@AgustinCB](https://github.com/AgustinCB) Updated the documentation of string methods. Details [here](https://github.com/redox-os/ion/pull/600).
- [@mmstick](https://github.com/mmstick) Updated dependencies. Details [here](https://github.com/redox-os/ion/commit/63c02c37148fbd77e51783cbf2f7836385a03645).
- [@mmstick](https://github.com/mmstick) Applied `rustfmt` and closed #602. Details [here](https://github.com/redox-os/ion/commit/39c30f62eda1ab0def87bb91cec67edb2bbf0fc0).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added builtin `status`. Details [here](https://github.com/redox-os/ion/pull/603).
- [@AgustinCB](https://github.com/AgustinCB) Tested and refactored array methods. Details [here](https://github.com/redox-os/ion/pull/605).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added the `bool` builtin. Details [here](https://github.com/redox-os/ion/pull/606).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added the `is` builtin. Details [here](https://github.com/redox-os/ion/pull/609).
- [@mmstick](https://github.com/mmstick) Re-enabled empty strings and allowed empty outputs. Closing #611 and #573. Details [here](https://github.com/redox-os/ion/commit/03cd9f222bf12a68b496bf600d631f38943fd2b2).
- [@dlrobertson](https://github.com/dlrobertson) Updated the `disown` command. Details [here](https://github.com/redox-os/ion/pull/612).
- [@AgustinCB](https://github.com/AgustinCB) Added `split_at` to the manual. Details [here](https://github.com/redox-os/ion/pull/613).
- [@AgustinCB](https://github.com/AgustinCB) Merged `unescape` methods. Details [here](https://github.com/redox-os/ion/pull/614).
- [@AgustinCB](https://github.com/AgustinCB) Added functions to the manual. Details [here](https://github.com/redox-os/ion/pull/615).
- [@dlrobertson](https://github.com/dlrobertson) Improved bad argument parsing of `setup.ion`. Details [here](https://github.com/redox-os/ion/pull/618).
- [@mmstick](https://github.com/mmstick) Stopped liner's background thread in the children of a fork. Details [here](https://github.com/redox-os/ion/commit/906295d29773686941c680d807548a183aee61a9).
- [@mmstick](https://github.com/mmstick) Reverted `fork` Changes. Details [here](https://github.com/redox-os/ion/commit/09640b7a8c65a660bdc5c996cba428f6df71e574).
- [@mmstick](https://github.com/mmstick) Fixed the `not/and/or` builtins to not require re-submission to the statement splitter. Closing #607. Details [here](https://github.com/redox-os/ion/commit/7d9584ee254b6019343d034a4de07e2b5c3e19bd).
- [@mmstick](https://github.com/mmstick) Implemented recursive aliases. Closing #610. Details [here](https://github.com/redox-os/ion/commit/cc876e00c5cae3d0ff899b2a80ced83dc3c1ae30).
- [@mmstick](https://github.com/mmstick) Started the process of porting errors to `failure`. Details [here](https://github.com/redox-os/ion/commit/2d18c829831dc4805d5fb9ea905c09a00f703ee4).
- [@mmstick](https://github.com/mmstick) Applied `rustfmt`. Details [here](https://github.com/redox-os/ion/commit/48f55c0e378fc1194ee93625be393ec363aac257).
- [@mmstick](https://github.com/mmstick) Fixed some endlessly-looping alias expansions, resolving problems with `alias ls = ls --color`. Details [here](https://github.com/redox-os/ion/commit/95fefdd8078b618513e84297241606046dcf3357).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Fixed "and/or followed by let results in command not found issue". Details [here](https://github.com/redox-os/ion/pull/620).
- [@mmstick](https://github.com/mmstick) Reverted "Fix "and/or followed by let results in command not found issue" (#620)", , This reverts commit daab4fb0c49d3b39a6e34532253a21698a86a3a2.. Details [here](https://github.com/redox-os/ion/commit/982798cae60e1e213d3246fbdf193b4ffc50a9e3).
- [@liftedkilt](https://github.com/liftedkilt) Fixed some typos. Details [here](https://github.com/redox-os/ion/pull/623).
- [@anxiousmodernman](https://github.com/anxiousmodernman) Allowed builtins in aliases. Details [here](https://github.com/redox-os/ion/pull/624).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added manual pages for almost all builtins. Details [here](https://github.com/redox-os/ion/pull/625).
- [@jD91mZM2](https://github.com/jD91mZM2) Migrated to `xdg`. Details [here](https://github.com/redox-os/ion/pull/626).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added manual pages for almost all builtins. Details [here](https://github.com/redox-os/ion/pull/628).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added ability for `which` builtin to process multiple arguments. Details [here](https://github.com/redox-os/ion/pull/629).
- [@jD91mZM2](https://github.com/jD91mZM2) Implemented a "command not found" hook. Details [here](https://github.com/redox-os/ion/pull/630).
- [@AgustinCB](https://github.com/AgustinCB) Fixed #627. Details [here](https://github.com/redox-os/ion/pull/631).
- [@mmstick](https://github.com/mmstick) Updated `README.md`. Details [here](https://github.com/redox-os/ion/commit/79a1de620f332a2de2c831d06c90928a6b61c7ee).
- [@mmstick](https://github.com/mmstick) Added a color namespace test. Details [here](https://github.com/redox-os/ion/commit/132aa50224a9c5481861a30ef5112cc16138fa0a).
- [@covercash2](https://github.com/covercash2) Made newlines in prompt display correctly. Details [here](https://github.com/redox-os/ion/pull/632).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added tests for the `is` builtin. Details [here](https://github.com/redox-os/ion/pull/633).
- [@mmstick](https://github.com/mmstick) Updated `rustfmt` config. Details [here](https://github.com/redox-os/ion/commit/3d5939a4cdfbbe0d73a8e07d93aa4f051ebd369f).
- [@jD91mZM2](https://github.com/jD91mZM2) Disowned using `&!`. Details [here](https://github.com/redox-os/ion/pull/635).
- [@AgustinCB](https://github.com/AgustinCB) Fixed panic on heredoc. Details [here](https://github.com/redox-os/ion/pull/636).
- [@jD91mZM2](https://github.com/jD91mZM2) Updated `rust-xdg` URL in `Cargo.toml`. Details [here](https://github.com/redox-os/ion/pull/637).
- [@mmstick](https://github.com/mmstick) Improved job control builtin documentation. Details [here](https://github.com/redox-os/ion/commit/20946e0a586b3038f3d4dc0efc03cb3549886aad).
- [@mmstick](https://github.com/mmstick) Implemented huponexit shell option. Details [here](https://github.com/redox-os/ion/commit/c3eb46cadffe4fe1eb6d51327f81d7c6c40aab48).
- [@mmstick](https://github.com/mmstick) Fixed issues w/ multi-line Array Assignments. This fix will ensure that comments within multi-line array assignments are properly. Closing #642. Details [here](https://github.com/redox-os/ion/commit/e9eb6d087d0aaac8e9b25e467a9a609d43920a6e).
- [@mmstick](https://github.com/mmstick) Made a multi-line array test fix. Details [here](https://github.com/redox-os/ion/commit/86cd3be4e4908c29b7ac0b0d5c0af10f673bb821).
- [@mmstick](https://github.com/mmstick) Added a few more integration tests. Details [here](https://github.com/redox-os/ion/commit/446692400a4f213dc97a6d8149b4a44de1ab9eb7).
- [@mmstick](https://github.com/mmstick) Made a change to only borrow builtin args when needed. Details [here](https://github.com/redox-os/ion/commit/e81543bfc389136a355815d3e47e5266adb405b8).

## Drivers

Redox OS Drivers

- [@jackpot51](https://github.com/jackpot51) Updated `ransid` for `vesad`. Details [here](https://github.com/redox-os/drivers/commit/ce05b12a7a4b80a3aa0b0ccb3a7df023f0cf8c08).
- [@jackpot51](https://github.com/jackpot51) Removed debug statements. Details [here](https://github.com/redox-os/drivers/commit/b7fe49ccd0977e4675449068ee822990a16f5f0a).
- [@ghatdev](https://github.com/ghatdev) Fixed error `E0133` on `pcid`. Details [here](https://github.com/redox-os/drivers/pull/21).

## Cookbook

A collection of package recipes for Redox.

- [@sajattack](https://github.com/sajattack) Added recipes for `libzip` and `libpng`. Details [here](https://github.com/redox-os/cookbook/pull/103).
- [@sajattack](https://github.com/sajattack) Fixe the `xz` recipe. Details [here](https://github.com/redox-os/cookbook/pull/104).
- [@raw-bin](https://github.com/raw-bin) Fix miscellaneous problems with the `xz` recipe causing Redox build failures. Details [here](https://github.com/redox-os/cookbook/pull/106).
- [@sajattack](https://github.com/sajattack) Added recipe for `cmatrix`. Details [here](https://github.com/redox-os/cookbook/pull/107) and [here](https://github.com/redox-os/cookbook/pull/108).
- [@xTibor](https://github.com/xTibor) Added recipes for `TiMidity++` and `GeneralUser GS`. Details [here](https://github.com/redox-os/cookbook/pull/109).
- [@jackpot51](https://github.com/jackpot51) Replaced `cargo` branch. Details [here](https://github.com/redox-os/cookbook/commit/3abc40d3283e35676aaae97200e312f440c8a447).
- [@xTibor](https://github.com/xTibor) Fixed `ffmpeg` package version. Details [here](https://github.com/redox-os/cookbook/pull/110).
- [@sajattack](https://github.com/sajattack) Added recipe for `netdb`. Details [here](https://github.com/redox-os/cookbook/pull/111).
- [@jackpot51](https://github.com/jackpot51) Added dependency directories for `curl`. Details [here](https://github.com/redox-os/cookbook/commit/36bbaca4cffa1f7aa6ece13cb6463a83367b0719).
- [@jackpot51](https://github.com/jackpot51) Added the `async` flag for the `sdl` recipe. Details [here](https://github.com/redox-os/cookbook/commit/d155f52d99c9851695b5a6a122dc2d672dbd6edb).
- [@jackpot51](https://github.com/jackpot51) Updated the `sdl` patch. Details [here](https://github.com/redox-os/cookbook/commit/72c6f2331413f234a956ce05a678826eb54e7043).
- [@jackpot51](https://github.com/jackpot51) Disabled some CPU optimizations that may break machines. Details [here](https://github.com/redox-os/cookbook/commit/bef342ff07cb980f68c0cc362a11cff4ef8e2eb1).
- [@sajattack](https://github.com/sajattack) Added recipe for `cmatrix` and `terminfo`. Details [here](https://github.com/redox-os/cookbook/commit/1750721923b266141fd862269f12e4bd834a3ec5).
- [@jackpot51](https://github.com/jackpot51) Updated the `sdl` recipe to require 32 bpp. Details [here](https://github.com/redox-os/cookbook/commit/123c12ad393c748098d80b3e857fe2cca934aaf0).
- [@xTibor](https://github.com/xTibor) Added the `ca-certificates` dependency to the `git` recipe. Details [here](https://github.com/redox-os/cookbook/pull/112).
- [@jackpot51](https://github.com/jackpot51) Added an `unfetch` script. Details [here](https://github.com/redox-os/cookbook/commit/00bac37c7288ed1371cd34a8bfc375de13c372e7).
- [@jackpot51](https://github.com/jackpot51) Used `poll` with `git`. Details [here](https://github.com/redox-os/cookbook/commit/7d02f68aad6b8e5d3a923b44cd07359f53aacadc).
- [@xTibor](https://github.com/xTibor) Added an `ncursesw` recipe as well as some `terminfo` changes. Details [here](https://github.com/redox-os/cookbook/pull/114).
- [@xTibor](https://github.com/xTibor) Added `mdp` recipe. Details [here](https://github.com/redox-os/cookbook/pull/115).
- [@jackpot51](https://github.com/jackpot51) Use all possible binaries from `uutils`. Details [here](https://github.com/redox-os/cookbook/commit/94ceffa8607aee9519f11ff2a3ab1383f3d69295).

## Orbclient

The Orbital Client Library. Compatible with Redox and SDL2.

- [@robbycerantola](https://github.com/robbycerantola) Implemented antialiased circle and line. Details [here](https://github.com/redox-os/orbclient/pull/37).
- [@robbycerantola](https://github.com/robbycerantola) Add handy function to get pixel color at position `x,y`. Details [here](https://github.com/redox-os/orbclient/pull/38).

## Orbtk

The Orbital Widget Toolkit. Compatible with Redox and SDL2.

- [@jackpot51](https://github.com/jackpot51) Released version 0.2.26. Details [here](https://github.com/redox-os/orbtk/commit/3e7431cf878721146cb90f75e779428fb16fa0db).
- [@FloVanGH](https://github.com/FloVanGH) Implemented grid. Details [here](https://github.com/redox-os/orbtk/pull/59).
- [@jackpot51](https://github.com/jackpot51) Fixed the menu widget. Details [here](https://github.com/redox-os/orbtk/commit/6b72f96534bcc70a3dfab76b61a9367fdec02e52).
- [@jackpot51](https://github.com/jackpot51) Made a change prevent setting label background. Details [here](https://github.com/redox-os/orbtk/commit/c32dd4b5d1f99c42b3610c22745cdc847297816d).
- [@jackpot51](https://github.com/jackpot51) Moved CSS into separate file. Details [here](https://github.com/redox-os/orbtk/commit/7e68164e19987109720d7a1e426ce4bb010bf409).
- [@jackpot51](https://github.com/jackpot51) Added border radii, renamed border-thickness to standard border-width, added menu selector and hover class to button. Details [here](https://github.com/redox-os/orbtk/commit/3803b7ae1e837a67a12e6f43de7912c3ac79edd1).
- [@jackpot51](https://github.com/jackpot51) Added focus class to text box. Details [here](https://github.com/redox-os/orbtk/commit/63821d98f46db04b391d5156f528a3a7e68db2c4).
- [@jackpot51](https://github.com/jackpot51) Used selector for drawing text. Details [here](https://github.com/redox-os/orbtk/commit/7d04798cbbec0d6720cba1a6283343aac92264b2).
- [@jsalzbergedu](https://github.com/jsalzbergedu) Allowed the user to specify a theme. Details [here](https://github.com/redox-os/orbtk/pull/61).

## Orbutils

The Orbital Utilities. Compatible with Redox and SDL2.

- [@BojanKogoj](https://github.com/BojanKogoj) Added run instructions. Details [here](https://github.com/redox-os/orbutils/pull/33).
- [@BojanKogoj](https://github.com/BojanKogoj) Added a Calendar application. Details [here](https://github.com/redox-os/orbutils/pull/34).
- [@MggMuggins](https://github.com/MggMuggins) Changed use of `redox_users` and update Cargo.lock. Details [here](https://github.com/redox-os/orbutils/pull/35).
- [@MggMuggins](https://github.com/MggMuggins) Fixed some logic mistakes. Details [here](https://github.com/redox-os/orbutils/pull/37).

## Orbterm

Orbital Terminal, compatible with Redox and Linux.

- [@jackpot51](https://github.com/jackpot51) Removed debug print. Details [here](https://github.com/redox-os/orbterm/commit/471ad771044c8ccedebc1318709bf28a8e8709d9).
- [@jackpot51](https://github.com/jackpot51) Released version 0.3.1. Details [here](https://github.com/redox-os/orbterm/commit/60657729ed60e85b358437daafc798a8914113ca).
- [@jackpot51](https://github.com/jackpot51) Improved resize performance. Details [here](https://github.com/redox-os/orbterm/commit/789ac6b115638f4803bef4300405ec29fd13116a).
- [@jackpot51](https://github.com/jackpot51) Released version 0.3.2. Details [here](https://github.com/redox-os/orbterm/commit/fb4c13f4bdc6e26dc17358bb78e2a63a60d999e1).
- [@xTibor](https://github.com/xTibor) Extracted block widths and heights into fields. Details [here](https://github.com/redox-os/orbterm/pull/6).
- [@jackpot51](https://github.com/jackpot51) Made a change to by default, set block height to twice block width. Details [here](https://github.com/redox-os/orbterm/commit/546ead80fc9335e1b58143353e814188f2bdf8e1).

## ransid

Rust ANSI Driver - A backend for terminal emulators in Rust.

- [@jackpot51](https://github.com/jackpot51) Released version 0.4.4 - Implementing ICH and fixing DCH. Details [here](https://github.com/redox-os/ransid/commit/81314edeabffd405541c52a6547004a5fbbfe2ea).
- [@jackpot51](https://github.com/jackpot51) Fix margins on resize. Details [here](https://github.com/redox-os/ransid/commit/5531d9658080481986f8b9bf0fc14f82f93580e7).
- [@jackpot51](https://github.com/jackpot51) Released version 0.4.5. Details [here](https://github.com/redox-os/ransid/commit/4aaf8d1743f9e247c924c8a7353cfdc42f896b7f).

## Redoxfs

The Redox Filesystem.

- [@jackpot51](https://github.com/jackpot51) Updated the lock format. Details [here](https://github.com/redox-os/redoxfs/commit/a0ec6670252ea9f557d136f38fe05aba51226895).
- [@jackpot51](https://github.com/jackpot51) Made a change to set block size programmatically. Details [here](https://github.com/redox-os/redoxfs/commit/513bfaf805b7161128737052be6c56d1cdf51abb).
- [@jackpot51](https://github.com/jackpot51) Shipped version 3 - bump block size to 4096. Details [here](https://github.com/redox-os/redoxfs/commit/47c9acc41779c0a7821047f9f490585bf10766f7).
- [@jackpot51](https://github.com/jackpot51) Released version 0.3.0. Details [here](https://github.com/redox-os/redoxfs/commit/1701198b11ea212ae899662ceb1dbcc9f85d17d6).
- [@jackpot51](https://github.com/jackpot51) Released version 0.3.1 - Fixing an issue with new FUSE. Details [here](https://github.com/redox-os/redoxfs/commit/2dd4c920c7beca8ae71ed8d948c67b8c9c7f7fe4).
- [@jackpot51](https://github.com/jackpot51) Simplified disk cache. Details [here](https://github.com/redox-os/redoxfs/commit/16d6f6b93acccf2d62da7e1c45b2bd31c1a58ee9).
- [@jackpot51](https://github.com/jackpot51) Moved cache to a `HashMap`. Details [here](https://github.com/redox-os/redoxfs/commit/53a1e6d49f259bbcd642e4a60734de82971d3706).
- [@jackpot51](https://github.com/jackpot51) Released version 0.3.2. Details [here](https://github.com/redox-os/redoxfs/commit/38b24ad3215a8bd36fe8c532729fb175266474b4).
- [@jackpot51](https://github.com/jackpot51) Added `fchmod` and `fchown`. Details [here](https://github.com/redox-os/redoxfs/commit/eac37c7dc5adebce1d844f76e42d9a0afa9ac147).
- [@jackpot51](https://github.com/jackpot51) Fixed error with borrowing packed fields. Details [here](https://github.com/redox-os/redoxfs/commit/f206dab653f34a7362c5050fce0e637e17c64004).

## syscall

Redox Rust Syscall Library.

- [@jackpot51](https://github.com/jackpot51) Add `fchown` and `fchmod` system calls. Details [here](https://github.com/redox-os/syscall/commit/0e73ef14a4023a553b8681d6898a624a607fad29).
- [@jackpot51](https://github.com/jackpot51) Released version 0.1.32. Details [here](https://github.com/redox-os/syscall/commit/3c765737a5e9146ffb241c67050c1be9bf28aab7).

## Sodium

Sodium: The Text Editor.

- [@sajattack](https://github.com/sajattack) Made a change to infer file to save to from file opened. Details [here](https://github.com/redox-os/sodium/pull/83).

## users

Redox OS APIs for accessing users and groups information.

- [@MggMuggins](https://github.com/MggMuggins) Added `add_user`, `add_group`, `get_gid` and fixed an empty user list issue. Details [here](https://github.com/redox-os/users/pull/5).
- [@goyox86](https://github.com/goyox86) Improved error handling using the `failure` crate. Details [here](https://github.com/redox-os/users/pull/7).

## userutils

User and group management utilities.

- [@MggMuggins](https://github.com/MggMuggins) Implemented `groupadd` and fixed for `passwd` compile. Details [here](https://github.com/redox-os/userutils/pull/17).
- [@fraang](https://github.com/fraang) Added missing included utility. Also added missing word. Details [here](https://github.com/redox-os/userutils/pull/19).
- [@goyox86](https://github.com/goyox86) Migrated to the new errors on `rust_users`. Details [here](https://github.com/redox-os/userutils/pull/20).
- [@MggMuggins](https://github.com/MggMuggins) Add additional flags to `useradd` and `groupadd`. Also updated cargo files. Details [here](https://github.com/redox-os/userutils/pull/21).

## coreutils

The Redox coreutils.

- [@Mojo4242](https://github.com/Mojo4242) Simplified `dd`. Details [here](https://github.com/redox-os/coreutils/pull/185).
- [@jackpot51](https://github.com/jackpot51) Added `chown` and updated `Cargo.lock`. Details [here](https://github.com/redox-os/coreutils/commit/4f9d09b99f50e5e57053189e0d5a19d3cc969be6).
- [@jackpot51](https://github.com/jackpot51) Allow empty `gid` or `uid`. Details [here](https://github.com/redox-os/coreutils/commit/8dd64e7fc03ce23c5f5055fe9b7bbb87945e159a).
- [@jackpot51](https://github.com/jackpot51) Updated `chown`. Details [here](https://github.com/redox-os/coreutils/commit/2f9049c48c28ff55a2ba8d38510264ba80502c39).
- [@Mojo4242](https://github.com/Mojo4242) Cleaned up dead code. Details [here](https://github.com/redox-os/coreutils/pull/188).
- [@Mojo4242](https://github.com/Mojo4242) Fixed status option on `dd`. Details [here](https://github.com/redox-os/coreutils/pull/189).
- [@Tommoa](https://github.com/Tommoa) Made a performance improvement for `cat` without arguments. Details [here](https://github.com/redox-os/coreutils/pull/190).
- [@jackpot51](https://github.com/jackpot51) Used more commands from `uutils`. Details [here](https://github.com/redox-os/coreutils/commit/a5e7ea5ad6fd21c4018569fe9722e05f3b4de783).

## extrautils

Extra utilities for Redox (and Unix systems).

- [@jackpot51](https://github.com/jackpot51) Used `cksum` from `uutils`. Details [here](https://github.com/redox-os/extrautils/commit/e549bd73a1327793d057da694d1a3b80cb8a944a).

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

- [@anxiousmodernman](https://github.com/anxiousmodernman) 🎂
- [@bheesham](https://github.com/bheesham) 🎂
- [@covercash2](https://github.com/covercash2) 🎂
- [@FloVanGH](https://github.com/FloVanGH) 🎂
- [@fraang](https://github.com/fraang) 🎂
- [@ghatdev](https://github.com/ghatdev) 🎂
- [@HarryU](https://github.com/HarryU) 🎂
- [@jD91mZM2](https://github.com/jD91mZM2) 🎂
- [@liftedkilt](https://github.com/liftedkilt) 🎂
- [@MggMuggins](https://github.com/MggMuggins) 🎂
- [@raw-bin](https://github.com/raw-bin) 🎂
- [@sajattack](https://github.com/sajattack) 🎂
- [@Sag0Sag0](https://github.com/Sag0Sag0) 🎂
- [@TSleepingCat](https://github.com/TSleepingCat) 🎂
- [@Tommoa](https://github.com/Tommoa) 🎂

If I missed something, feel free to contact me [@goyox86](https://github.com/goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
