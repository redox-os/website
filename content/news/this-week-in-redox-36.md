+++
title = "This Week in Redox 36"
author = "goyox86"
date = "2018-03-07 17:16:57 +0000"
+++

This is the 36th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by [@goyox86](https://github.com/goyox86))*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

Hello again!

Welcome to another issue of TWiRx! 

First of all, Sorry for the gap between the last release and this one. It has just been crazy at work! 

Maybe the most exciting news for this period is the birth of a new project, [relibc](https://github.com/redox-os/relibc) Yes! A C standard library written in Rust. Why? Mainly because it's easier to develop than `newlib` (our current C library), cross platform support is easier and last but not least, it has the potential to improve security. It's a cool project that needs tons of help and it has great potential. We would be happy to mentor you, just send a mail to `info@redox-os.org` and we will give you access to our [Mattermost](https://chat.redox-os.org/) or just ask on the [Discourse forum](https://discourse.redox-os.org/) for more info.

As usual, we start our journey from the bottom of the stack making our way up to userland. There at the bottom, we have the **kernel**, where Mr [@jackpot51](https://github.com/jackpot51) switched to a linked list allocator and added the ACPI cargo feature. He also shipped a fix for a bug the signals mechanism. Basically, if a signal was delivered while the process was blocked, it would handle the signal and then go back to an unblocked state.

Moving a bit, we get to the **drivers** level, we have a couple of fixes for `vesad` and `ps2d` by [@xTibor](https://github.com/xTibor) and [@jackpot51](https://github.com/jackpot51) respectively. The `vesad` one was related to Unicode character input and the one in `ps2d` was related to resizing `ps2d` bounding box when `vesad` resizes. Also, [@dlrobertson](https://github.com/dlrobertson) allowed PCI config space parsing to handle types.

One of the surprising news on this issue, is related to **Ion**, Redox's shell. There has been significantly less activity on it, mainly because of the fact that [@mmstick](https://github.com/mmstick) Ion's maintainer and original creator is transitioning to a new job and hope everything is going great for him!

Anyways, here is what happened in **Ion** in the last few weeks: [@abeaumont](https://github.com/abeaumont) fixed some typos in the manual while [@Sag0Sag0](https://github.com/Sag0Sag0) made `popd`/`pushd` update `PWD`
and [@forbjok](https://github.com/forbjok) fixed cd'ing into a symlinked directory along with various issues fixes by [@Sag0Sag0](https://github.com/Sag0Sag0) and [@zen3ger](https://github.com/zen3ger).

In the **cookbook** front, most of the activity came from [@jackpot51](https://github.com/jackpot51) and [@xTibor](https://github.com/xTibor) in the shape of updates and tweaks for the `rust` and `cargo` packages as well as a new package for `netsurf` plus lots of improvements to the `sdl` package: updates video to the latest orbital protocol, support for mouse wheel scrolling and middle/right buttons, the implementation of `SDL_RESIZABLE` and `SDL_WM_SetCaption` along with a fix for a page fault on `SDL_Quit`.

Our next station is GUIs where **Orbclient**, the Orbital client library, saw a few improvements notably, faster image rendering with falling back to legacy function and the implementation of parallel rendering and window overwriting by [@robbycerantola](https://github.com/robbycerantola) while **Orbtk** got it's version `0.2.27`.

**Orbutils** was ported to the most recent version of the `users` crate by [@MggMuggins](https://github.com/MggMuggins) while `FileManager` got a fix for a panic on Unicode filenames and **Orbterm** Redox's terminal emulator (also compatible with Linux) saw a fix for Unicode character input. Both of them by [@xTibor](https://github.com/xTibor).

Also GUI related, the **Sodium** text editor compilation was fixed by [@jamessral](https://github.com/jamessral).

Our **users** crate has been under a lot of activity, mostly from [@MggMuggins](https://github.com/MggMuggins) who implemented: removal of users and groups, "unset" passwords (not to be confused with blank ones), improvements of users and groups writing, timeouts and lastly he brought iterators over users and groups back. Nicely done!

As usual our last stop is on the **\*_utils** crates: **Userutils**, **Coreutils** and **Netutils**.

**Userutils** was ported to `users`'s new API. It got also implementations for `usermod`, `groupmod`, `userdel` and `groupdel` plus the migration from our own `ArgParser` to the more powerful `clap-rs` crate. All of this by [@MggMuggins](https://github.com/MggMuggins)

In **Coreutils**, [@dlrobertson](https://github.com/dlrobertson) made the update to the new `users` API.

Finishing with **Netutils** where [@batonius](https://github.com/batonius) implemented `dhcpd` support for `netcfg` and [@Nickforall](https://github.com/Nickforall) Fixed deprecation warning on the `ping` and `dns` binaries.

Now I leave you with the details!

See you soon!

## Kernel

The Redox microkernel

- [@jackpot51](https://github.com/jackpot51) Updated lock file. Details [here](https://github.com/redox-os/kernel/commit/50bbdd3f5ee32b5c083ed6a48881faa02bba08c5).
- [@jackpot51](https://github.com/jackpot51) Updates for new nightly. Details [here](https://github.com/redox-os/kernel/commit/015b79430e27f4fbcc8ab3125746330a6c90d366).
- [@jackpot51](https://github.com/jackpot51) Added linked list allocator with automatic resizing, fixed memory leaks in exec and removed some warnings. Details [here](https://github.com/redox-os/kernel/commit/761fe30bf38c8b0832e5eef977e1646f9da5b69e).
- [@jackpot51](https://github.com/jackpot51) Removed some debug messages. Details [here](https://github.com/redox-os/kernel/commit/797d86b7a7e9b22f72511ce51100a9c1d6eb601c).
- [@jackpot51](https://github.com/jackpot51) Added the ACPI feature. Details [here](https://github.com/redox-os/kernel/commit/3af29649554d3f99cac845fbf121c8dc88376887).
- [@jackpot51](https://github.com/jackpot51) Fixed the delivery of signals when a signal uses the default handler, make context status update on every switch. Details [here](https://github.com/redox-os/kernel/commit/c020ce7d8ac76913b93850b162fe9783514d7c63).

## Drivers

Redox OS Drivers

- [@jackpot51](https://github.com/jackpot51) Removed unnecessary parenthesis. Details [here](https://github.com/redox-os/drivers/commit/78cff3f57cae934ce690b8d130e9a015662d0077).
- [@jackpot51](https://github.com/jackpot51) Removed unnecessary parenthesis. Details [here](https://github.com/redox-os/drivers/commit/0897ddff17becd94990df0f8a536ea6187b752d2).
- [@jackpot51](https://github.com/jackpot51) Removed unnecessary unsafe. Details [here](https://github.com/redox-os/drivers/commit/1461404502ce86787007f33c603825721a31a239).
- [@dlrobertson](https://github.com/dlrobertson) Allowed using a device ID range in TOML config. Details [here](https://github.com/redox-os/drivers/pull/26).
- [@xTibor](https://github.com/xTibor) Fixed Unicode character input in `vesad`. Details [here](https://github.com/redox-os/drivers/pull/27).
- [@jackpot51](https://github.com/jackpot51) Resized `ps2d` bounding box when `vesad` resizes. Details [here](https://github.com/redox-os/drivers/commit/42adde5809a18c660ad6fd80272ad33ff9f8794f).
- [@dlrobertson](https://github.com/dlrobertson) Allowed PCI Config space parsing to handle types. Details [here](https://github.com/redox-os/drivers/pull/28).
- [@jackpot51](https://github.com/jackpot51) Fixed BAR variables. Details [here](https://github.com/redox-os/drivers/commit/7fbb2c32e265c0a2edb2fcf3c17ccddc64d5c283).

## Ion

The Ion Shell. Compatible with Redox and Linux.

- [@abeaumont](https://github.com/abeaumont) Fixed some typos in the manual. Details [here](https://github.com/redox-os/ion/pull/686).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Made `popd` and `pushd` update `PWD` to fix issue #683. Details [here](https://github.com/redox-os/ion/pull/687).
- [@braco](https://github.com/braco) Made `README` clearer. Details [here](https://github.com/redox-os/ion/pull/688).
- [@forbjok](https://github.com/forbjok) Fixed cd'ing into a symlinked directory losing the original path. Details [here](https://github.com/redox-os/ion/pull/689).
- [@chrisbarrett](https://github.com/chrisbarrett) Made some small grammatical fixes to readme. Details [here](https://github.com/redox-os/ion/pull/691).
- [@PigeonF](https://github.com/PigeonF) Fixed color code in setup.ion. Details [here](https://github.com/redox-os/ion/pull/694).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Made `pushd` change directory. Fix issue #697. Details [here](https://github.com/redox-os/ion/pull/698).
- [@zen3ger](https://github.com/zen3ger) Fixed doctests. Details [here](https://github.com/redox-os/ion/pull/700).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Fix issue #699. Details [here](https://github.com/redox-os/ion/pull/701).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added dummy `--login` argument to ion. Details [here](https://github.com/redox-os/ion/pull/702).

## Cookbook

A collection of package recipes for Redox.

- [@jackpot51](https://github.com/jackpot51) Updated branch to use for Redox rust. Details [here](https://github.com/redox-os/cookbook/commit/805590c6357aa03321b9c13f9dd61d9834953a40).
- [@jackpot51](https://github.com/jackpot51) Updated branch of cargo. Details [here](https://github.com/redox-os/cookbook/commit/66bb39e16212e51e6e27580c2f13aff1b107eb5e).
- [@jackpot51](https://github.com/jackpot51) Used `llvm-tblgen-4.0` to fix build on newer Ubuntu. Details [here](https://github.com/redox-os/cookbook/commit/d9a6f3eba7e212aaa2283234ddf4edf918635fce).
- [@jackpot51](https://github.com/jackpot51) Updated `rust` recipe config. Details [here](https://github.com/redox-os/cookbook/commit/b0253dca869dfcfc964b9549bf89b80fad3b40e6).
- [@jackpot51](https://github.com/jackpot51) Disabled submodule management and set verbosity level to 2 in rust recipe. Details [here](https://github.com/redox-os/cookbook/commit/497252d9af2b21291e445f5d1e22aa78f7c06ef8).
- [@MggMuggins](https://github.com/MggMuggins) Linked `whoami` to `id`. Details [here](https://github.com/redox-os/cookbook/pull/120).
- [@xTibor](https://github.com/xTibor) `sdl`: Updated video to the latest orbital protocol. Details [here](https://github.com/redox-os/cookbook/pull/121).
- [@xTibor](https://github.com/xTibor) Added `netsurf` recipe. Details [here](https://github.com/redox-os/cookbook/pull/122).
- [@xTibor](https://github.com/xTibor) `sdl`: Implement mouse wheel scrolling, middle and right buttons. Details [here](https://github.com/redox-os/cookbook/pull/123).
- [@jackpot51](https://github.com/jackpot51) Updated `netsurf` recipe. Details [here](https://github.com/redox-os/cookbook/commit/2ff556bce142909c8a66fb474a0154552aa767b4).
- [@jackpot51](https://github.com/jackpot51) Fixed `pkg-config` with autotools programs. Details [here](https://github.com/redox-os/cookbook/commit/f0f05be025fc947df1df87a39e51d27141fa2a8b).
- [@xTibor](https://github.com/xTibor) Added `libpng` and `libjpeg` and enabled JPEG support in `netsurf`. Details [here](https://github.com/redox-os/cookbook/pull/124).
- [@xTibor](https://github.com/xTibor) `curl`: Enabled zlib support. Details [here](https://github.com/redox-os/cookbook/pull/125).
- [@xTibor](https://github.com/xTibor) `sdl`: Implemented `SDL_RESIZABLE` and `SDL_WM_SetCaption`. Details [here](https://github.com/redox-os/cookbook/pull/127).
- [@xTibor](https://github.com/xTibor) `sdl`: Fixed page fault on SDL_Quit. Details [here](https://github.com/redox-os/cookbook/pull/128).
- [@jackpot51](https://github.com/jackpot51) Made some fixes for `pkg-config`. Add libpng to netsurf. Details [here](https://github.com/redox-os/cookbook/commit/a1d531d79bd5d07b3503da8747f4c68f53419f56).
- [@jackpot51](https://github.com/jackpot51) Fixed `extrautils` build. Details [here](https://github.com/redox-os/cookbook/commit/7cdcd9b0a16889c20d201da7e6c0733446e181a7).
- [@xTibor](https://github.com/xTibor) `netsurf`: Enabled freetype support. Details [here](https://github.com/redox-os/cookbook/pull/129).
- [@jackpot51](https://github.com/jackpot51) Added `zlib` dependency to `freetype`. Details [here](https://github.com/redox-os/cookbook/commit/5339744140f60c35f426c6418f076d0c35fb9458).
- [@jackpot51](https://github.com/jackpot51) Added include flags to `freetype`. Details [here](https://github.com/redox-os/cookbook/commit/cc22c487ecd3a8bc8ff13c12c989d5a3101af32c).
- [@jackpot51](https://github.com/jackpot51) Fixed `expat` link. Details [here](https://github.com/redox-os/cookbook/commit/16a8304066f0fbc5c1a5130a0017b636f14f8127).
- [@jackpot51](https://github.com/jackpot51) Fixed `libpng` link. Details [here](https://github.com/redox-os/cookbook/commit/060870c8bd79c9f00eb25f90ec0202391fac7655).
- [@jackpot51](https://github.com/jackpot51) Autogen for `libpng`. Details [here](https://github.com/redox-os/cookbook/commit/f369f548184d7909497fdaafcebeb81dce8e7ea7).
- [@xTibor](https://github.com/xTibor) Updated `ffmpeg` to `3.4`. Details [here](https://github.com/redox-os/cookbook/pull/130).
- [@xTibor](https://github.com/xTibor) Added `libpng` build dependency to `freetype`. Details [here](https://github.com/redox-os/cookbook/pull/131).

## Orbtk

The Orbital Widget Toolkit. Compatible with Redox and SDL2.

- [@robbycerantola](https://github.com/robbycerantola) Made an update to use `orbclient` `0.3.13` with drawing mode property. Details [here](https://github.com/redox-os/orbtk/pull/83).
- [@jackpot51](https://github.com/jackpot51) Released v0.2.27. Details [here](https://github.com/redox-os/orbtk/commit/c11ba724feeb7f362b4dceeed1597048031254ad).
- [@ZakCodes](https://github.com/ZakCodes) Filtered example fix. Details [here](https://github.com/redox-os/orbtk/pull/85).
- [@ZakCodes](https://github.com/ZakCodes) Fixed issue #84. Details [here](https://github.com/redox-os/orbtk/pull/86).

## Orbclient

The Orbital Client Library. Compatible with Redox and SDL2.

- [@FloVanGH](https://github.com/FloVanGH) Updated to `sdl2` 0.31.0. Details [here](https://github.com/redox-os/orbclient/pull/42).
- [@robbycerantola](https://github.com/robbycerantola) Implemented `PartialEq` for `Color`, fixed compiler warnings. Details [here](https://github.com/redox-os/orbclient/pull/43).
- [@robbycerantola](https://github.com/robbycerantola) Implemented fast image rendering with falling back to legacy function. Details [here](https://github.com/redox-os/orbclient/pull/44).
- [@robbycerantola](https://github.com/robbycerantola) Implemented parallel rendering  and window overwriting. Details [here](https://github.com/redox-os/orbclient/pull/45).
- [@robbycerantola](https://github.com/robbycerantola) Added an image opaque drawing method. Details [here](https://github.com/redox-os/orbclient/pull/46).
- [@robbycerantola](https://github.com/robbycerantola) Implemented window drawing mode property . Details [here](https://github.com/redox-os/orbclient/pull/47).
- [@jackpot51](https://github.com/jackpot51) Released v0.3.13. Details [here](https://github.com/redox-os/orbclient/commit/2d100bdf8bee8b0b02dda835803a1c5e555dbbc9).
- [@jackpot51](https://github.com/jackpot51) Fixed time dependency. Details [here](https://github.com/redox-os/orbclient/commit/4bf16d059e18ad31dd7c46abc84300c92bdeaaa2).
- [@robbycerantola](https://github.com/robbycerantola) Implemented faster `pixel()` and even faster `image_fast()`. Details [here](https://github.com/redox-os/orbclient/pull/48).


## Orbutils

The Orbital Utilities. Compatible with Redox and SDL2.

- [@MggMuggins](https://github.com/MggMuggins) Ported to new `redox_users`. Details [here](https://github.com/redox-os/orbutils/pull/40).
- [@xTibor](https://github.com/xTibor) Fixed panic on unicode filenames in `FileManager`. Details [here](https://github.com/redox-os/orbutils/pull/41).
- [@robbycerantola](https://github.com/robbycerantola) Made a temporary patch for displaying JPG files with `Viewer`. Details [here](https://github.com/redox-os/orbutils/pull/43).
- [@jackpot51](https://github.com/jackpot51) Deleted `rust-toolchain`. Details [here](https://github.com/redox-os/orbutils/commit/6764004b9f6f386af17031d302430a89057ba77e).


## Orbterm

Orbital terminal, compatible with Redox and Linux

- [@xTibor](https://github.com/xTibor) Fixed unicode character input. Details [here](https://github.com/redox-os/orbterm/pull/10).
- [@jackpot51](https://github.com/jackpot51) Prepared for using alpha in terminal. Details [here](https://github.com/redox-os/orbterm/commit/387bcda6137a4d11c913985f01d18a3c7f953b3e).
- [@jackpot51](https://github.com/jackpot51) Implemented alpha blend orbterm. Details [here](https://github.com/redox-os/orbterm/commit/94bedde06943fe4f7c04ceeca596c6d7b470debf).


## Sodium

Sodium: The Text Editor

- [@jamessral](https://github.com/jamessral) Removed extra parenthesis around function argument to compile. Details [here](https://github.com/redox-os/sodium/pull/85).

## Users

Redox OS APIs for accessing users and groups information

- [@MggMuggins](https://github.com/MggMuggins) Implemented remove. Details [here](https://github.com/redox-os/users/pull/9).
- [@MggMuggins](https://github.com/MggMuggins) Implemented unset. Details [here](https://github.com/redox-os/users/pull/10).
- [@MggMuggins](https://github.com/MggMuggins) Improved write. Details [here](https://github.com/redox-os/users/pull/11).
- [@MggMuggins](https://github.com/MggMuggins) Implemented timeouts, iters and some bugfixes. Details [here](https://github.com/redox-os/users/pull/13).

## Userutils

User and group management utilities

- [@MggMuggins](https://github.com/MggMuggins) Ported to `redox_users` break-api. Details [here](https://github.com/redox-os/userutils/pull/25).
- [@MggMuggins](https://github.com/MggMuggins) Fixed #26. Details [here](https://github.com/redox-os/userutils/pull/27).
- [@MggMuggins](https://github.com/MggMuggins) Implemented `usermod`, `groupmod`, `userdel`, `groupdel`. Also, fixed `passwd` and `useradd`. Details [here](https://github.com/redox-os/userutils/pull/28).
- [@MggMuggins](https://github.com/MggMuggins) Ported CLI args parsing to `clap-rs`. Details [here](https://github.com/redox-os/userutils/pull/30).
- [@MggMuggins](https://github.com/MggMuggins) Remove `ArgParser` dependency and `whoami`. Details [here](https://github.com/redox-os/userutils/pull/32).
- [@MggMuggins](https://github.com/MggMuggins) Implement missing functionality in `groupmod` and `usermod`. Details [here](https://github.com/redox-os/userutils/pull/33).

## Coreutils

The Redox coreutils.

- [@dlrobertson](https://github.com/dlrobertson) Updated to use new `redox_users` API. Details [here](https://github.com/redox-os/coreutils/pull/195).

## Netutils

Network Utilities for Redox

- [@batonius](https://github.com/batonius) Implemented `dhcpd` support for `netcfg`. Details [here](https://github.com/redox-os/netutils/pull/30).
- [@Nickforall](https://github.com/Nickforall) Fix deprecation warning on ping and dns binaries. Details [here](https://github.com/redox-os/netutils/pull/31).

## ptyd

Psuedo-terminal daemon

- [@jackpot51](https://github.com/jackpot51) Fix #2 by blocking if more than 64 packets are collected. Details [here](https://github.com/redox-os/ptyd/commit/416206e1dba05164d8dcb335c6b861f1b207c1c7).

## Book

The Redox book

- [@xTibor](https://github.com/xTibor) Various updates and fixes. Details [here](https://github.com/redox-os/book/pull/114).
- [@victorz](https://github.com/victorz) Fixed grammar in book.json. Details [here](https://github.com/redox-os/book/pull/117).
- [@dlrobertson](https://github.com/dlrobertson) Random updates. Details [here](https://github.com/redox-os/book/pull/119).
- [@MggMuggins](https://github.com/MggMuggins) Cleared up the documentation for setting up and compiling. Details [here](https://github.com/redox-os/book/pull/121).
- [@Nickforall](https://github.com/Nickforall) Fixed the "preparing the build" chapter linking back to a previous chapter as next step. Details [here](https://github.com/redox-os/book/pull/123).


# Handy links

1. [The Glorious Book](https://doc.redox-os.org/book/)
2. [The Holiest Forum](https://discourse.redox-os.org/)
3. [The Shiny ISOs](https://github.com/redox-os/redox/releases)
4. [Redocs](http://www.redox-os.org/docs/)
5. [Fancy GitHub organization](https://github.com/redox-os)
6. [Our Holy Grail of a Website](http://www.redox-os.org/)
7. [The Extreme Screenshots](http://www.redox-os.org/screens/)

# New contributors

- [@abeaumont](https://github.com/abeaumont) 🎂
- [@Arzte](https://github.com/Arzte) 🎂
- [@braco](https://github.com/braco) 🎂
- [@chrisbarrett](https://github.com/chrisbarrett) 🎂
- [@Coding-Doctors](https://github.com/Coding-Doctors) 🎂
- [@forbjok](https://github.com/forbjok) 🎂
- [@jamessral](https://github.com/jamessral) 🎂
- [@PigeonF](https://github.com/PigeonF) 🎂
- [@victorz](https://github.com/victorz) 🎂
- [@ZakCodes](https://github.com/ZakCodes) 🎂
- [@zen3ger](https://github.com/zen3ger) 🎂

If I missed something, feel free to contact me [@goyox86](https://github.com/goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
