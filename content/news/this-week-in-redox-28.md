+++
title = "This Week in Redox 28"
author = "goyox86"
date = "2017-08-11T13:00:00+00:00"
+++

This is the 28th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

## TL;DR

Welcome to the 28th edition of "This Week in Redox"!

The team has been very busy working on cool stuff this last weeks!

Starting with the **kernel**, [@cookie545445](https://github.com/cookie545445) improved the portability of the kernel codebase by isolating `X86_64` dependent code into subfolders and [@ids1024](https://github.com/ids1024) added support for file descriptions, updated `pipe` to use `FIFO` flag, reverted a freeze caused by  a double locking finishig with the implementation of `F_DUPFD`.

**Ion** flow continues fast and steady! Some cool features were added by [@mmstick](https://github.com/mmstick): `$contains`, `$starts_with`, `$ends_with()`, `$replace()`, `$replacen()` and `$repeat()`. He also removed the dependency on the `peg` crate, enabled function pipelining/redirecting, `rustfmt`ed the whole codebase and implemented `contains`, `starts_with`, and `ends_with` builtins. Also in **Ion**, [@huntergoldstein](https://github.com/huntergoldstein) implemented command line options for `pushd` and `dirs`. Meanwhile, [@bb010g](https://github.com/bb010g) switched **Ion** from `HISTORY_FILE` to `HISTFILE` for history tracking.

On **drivers** land, the star of this week is the work being done by [@jackpot51](https://github.com/jackpot51) in the `XCHI` controller driver (which means that USB support is around the corner!). He also simplified `vesad` control logic.

Next stop is **Redoxfs**, where [@jackpot51](https://github.com/jackpot51) and [@ids1024](https://github.com/ids1024) enabled deallocating on resizing and fixed a freeze caused by a double lock respectively.

**TFS** folks where also very busy these last weeks! Notably [@ticki](https://github.com/ticki) who published a [blog post](http://ticki.github.io/blog/fearless-concurrency-with-hazard-pointers/) about the new shiny [conc](https://crates.io/crates/conc) crate which uses hazard pointers instead of epochs for doing concurrent memory reclamation. [@ticki](https://github.com/ticki) was also busy improving the documentation of the `conc` crate, rewriting `conc::sync::treiber` and adding `conc::Guard::{try,maybe}_map` while [@cedenday](https://github.com/cedenday) added a few trait derivations to `speck`'s `Key`.

[@Abogical](https://github.com/Abogical) added the `whois` utility to **Netutils** and [@ids1024](https://github.com/ids1024) added `gzip` and `xz` extraction support to **extrautils**'s `tar`.

And! Last but not least in the **cookbook**: [@jackpot51](https://github.com/jackpot51) switched to a Redox patched version of `findutils` and `uutils`, while [@ids1024](https://github.com/ids1024) enabled C++ support in the `gcc` recipe, replaced the target triple from `"x86_64-elf-redox-*` to `x86_64-unknown-redox-*`. Ultimately, new recipes for `bash`, `xz` and `patch` were alsoe added this week.

On a side note, I'm gonna be on holidays until September 7th and in consequence there will be radio silence during that period. But don't panic! we will be back sooner than you think!

Enjoy the rest of this weeks issue!

## Kernel

- [@ids1024](https://github.com/ids1024) Added file descriptions to be shared between file descriptors. Details [here](https://github.com/redox-os/kernel/pull/42).
- [@cookie545445](https://github.com/cookie545445) Move x86_64-specific code to `arch/x86_64`. Details [here](https://github.com/redox-os/kernel/pull/43).
- [@ids1024](https://github.com/ids1024) Made an update to use FIFO flag for pipe. Details [here](https://github.com/redox-os/kernel/pull/44).
- [@ids1024](https://github.com/ids1024) Prevented a freeze due to double locking. Details [here](https://github.com/redox-os/kernel/pull/45).
- [@ids1024](https://github.com/ids1024) Implemented `F_DUPFD`. Details [here](https://github.com/redox-os/kernel/pull/46).
- [@jackpot51](https://github.com/jackpot51) Updated the `syscall` crate. Details [here](https://github.com/redox-os/kernel/commit/5c5e5da7c2503dc68cd254259fe7992ce29df8d6).

## Ion

[Ion](https://github.com/redox-os/ion) is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

- [@huntergoldstein](https://github.com/huntergoldstein) Replaced the use of `RawFd` with `File` for `RefinedJob`. Details [here](https://github.com/redox-os/ion/commit/b4a8ae4832e395885905fe9c5a1a69fa337268de).
- [@bb010g](https://github.com/bb010g) Switched from `HISTORY_FILE` to `HISTFILE`. Details [here](https://github.com/redox-os/ion/pull/484).
- [@huntergoldstein](https://github.com/huntergoldstein) Made the `read` builtin detect if `stdin` is a TTY. Details [here](https://github.com/redox-os/ion/pull/484).
- [@mmstick](https://github.com/mmstick) Fixed implicit `cd` support. Details [here](https://github.com/redox-os/ion/commit/b9c84c4b4b9471881288032a3d6b7610eb168e1d).
- [@mmstick](https://github.com/mmstick) Removed `@len()` & migrated logic into `$len()`. Details [here](https://github.com/redox-os/ion/commit/ac15f60161fda79685fcf9ae7d203be8e38b32b8).
- [@mmstick](https://github.com/mmstick) Implemented `$contains`, `$starts_with`, and `$ends_with`. Details [here](https://github.com/redox-os/ion/commit/64fde92c3c648acbe356b768fd89a3961f9ea00f).
- [@mmstick](https://github.com/mmstick) Made a change to use macros to simplify string method handling. Details [here](https://github.com/redox-os/ion/commit/64065e824e28659af0fc5c341c92454293a19d8c).
- [@mmstick](https://github.com/mmstick) Implemented `$replace()` and `$replacen()`. Details [here](https://github.com/redox-os/ion/commit/1e724f206eb528b337f97e56b3b44b8bf6000373).
- [@mmstick](https://github.com/mmstick) Updated `$replace()` and `$replacen()` tests. Details [here](https://github.com/redox-os/ion/commit/111f277922a7492187bf62e4fb541a1a6a453106).
- [@mmstick](https://github.com/mmstick) Implemented `$repeat()`. Details [here](https://github.com/redox-os/ion/commit/cdb07add47056bc808f7708cd0e9d2efbf5e721e).
- [@mmstick](https://github.com/mmstick) Improved whitespace splitting. Details [here](https://github.com/redox-os/ion/commit/bba8d80462cf3552491e82fcf5a6f6224eed1dfb).
- [@mmstick](https://github.com/mmstick) Fixed typo in Redox submodule which fixed `istty` check. Details [here](https://github.com/redox-os/ion/commit/f922fc7f073d2b56b80da2807420c42b64424e44).
- [@huntergoldstein](https://github.com/huntergoldstein) Implemented command line options to `pushd` and `dirs`. Details [here](https://github.com/redox-os/ion/pull/486).
- [@mmstick](https://github.com/mmstick) Fixed an issue with ranges. Details [here](https://github.com/redox-os/ion/commit/133ae5ff1e14af3bee21e83f9145849a2cdab0fd).
- [@mmstick](https://github.com/mmstick) Made some fixes to background job execution. Details [here](https://github.com/redox-os/ion/commit/2f43297f63d3a6f37c09873451ca45283673f387).
- [@mmstick](https://github.com/mmstick) Refactored pipeline execution mode. Details [here](https://github.com/redox-os/ion/commit/421d1787c611dfd97d1ac03b4cffa1709acb7ddc).
- [@mmstick](https://github.com/mmstick) Made some background and foreground fixes. Details [here](https://github.com/redox-os/ion/commit/2b99617ae07b7f5d6e58494f5fbec1cb3d3446f0).
- [@mmstick](https://github.com/mmstick) Improved error status. Details [here](https://github.com/redox-os/ion/commit/7c48958bf11bfe78b2c28894c1224251cc36e8e2).
- [@mmstick](https://github.com/mmstick) Implemented `contains`, `starts_with`, and `ends_with` builtins. Details [here](https://github.com/redox-os/ion/commit/d8ab85e3ecc5253e44dccbaf79db0e70c929c23d).
- [@mmstick](https://github.com/mmstick) Fixed stable builds. Details [here](https://github.com/redox-os/ion/commit/51da75fd7ac8b1721e8e6e485caf5aa2397a8f8c).
- [@mmstick](https://github.com/mmstick) Refactored & commented `shell::pipe_exec`. Details [here](https://github.com/redox-os/ion/commit/fe2f3e07366c97896ca9842c6e71e474186ca277).
- [@mmstick](https://github.com/mmstick) Made some fixes to `ends-with` and also some refactoring. Details [here](https://github.com/redox-os/ion/commit/fe2f3e07366c97896ca9842c6e71e474186ca277).
- [@mmstick](https://github.com/mmstick) Did a lot of work on removing the dependency on PEG. Details [here](https://github.com/redox-os/ion/commit/81b7b70a4763ab7b4ce800ab738056ee90b14daa), [here](https://github.com/redox-os/ion/commit/b19966cb66dc088614ee9dcbb11d8c4d7ce182da), [here](https://github.com/redox-os/ion/commit/c28aec0fc664faf758c533f47590179d1777c9b9) and [here](https://github.com/redox-os/ion/commit/82da6dd1ef9dbda9ac5e0894aef0a71750f7bdcd).
- [@mmstick](https://github.com/mmstick) Refactored the parser module. Details [here](https://github.com/redox-os/ion/commit/60962fc5883842f66926e924b5f76ae931190150).
- [@mmstick](https://github.com/mmstick) Fixed some parser and pipelines tests. Details [here](https://github.com/redox-os/ion/commit/f2372922a57f501eb143962ef7c23d23d779d661).
- [@mmstick](https://github.com/mmstick) Switched to a patched version of `termion`. Details [here](https://github.com/redox-os/ion/commit/444d0274c44798a05f03ced6bdf2090d5b48129c).
- [@mmstick](https://github.com/mmstick) Enabled function pipelining. Details [here](https://github.com/redox-os/ion/commit/d270b4b9f9e2a8e26d482d5724958f3d87b2398f) and [here](https://github.com/redox-os/ion/commit/9ba6961b06f907c627765d56862766778e3e91ea).
- [@huntergoldstein](https://github.com/huntergoldstein) Replaced `ExpanderFunctions` with the `Expander` trait. Details [here](https://github.com/redox-os/ion/pull/488).
- [@mmstick](https://github.com/mmstick) Enabled redirecting functions. Details [here](https://github.com/redox-os/ion/commit/885bd579d980d3672f30ce06eb64c9c393f9ea1d).
- [@mmstick](https://github.com/mmstick) Updated function piping output. Details [here](https://github.com/redox-os/ion/commit/b79d8b2b45ddf518656b6861962e35b4d1e49e0d).
- [@mmstick](https://github.com/mmstick) Enabled creating background jobs from functions. Details [here](https://github.com/redox-os/ion/commit/b79d8b2b45ddf518656b6861962e35b4d1e49e0d).
- [@mmstick](https://github.com/mmstick) Implemented an `env` variable namespace. Details [here](https://github.com/redox-os/ion/commit/c5b1d29a3ad1029d7b20140e3e4ffc781b44e1bc).
- [@mmstick](https://github.com/mmstick) Implemented string namespace plugins support. Details [here](https://github.com/redox-os/ion/commit/3c9d959ee083854d8a42de415ff4173dfcbdc70c).
- [@mmstick](https://github.com/mmstick) Ran `rustfmt` across the entire project. Details [here](https://github.com/redox-os/ion/commit/03ae1f86e4c630cc6c51f5c0e5f0bd72845a4fe4) and [here](https://github.com/redox-os/ion/commit/3a7f977595d481b10a046d91c6e5eb3f6ea1730d).
- [@mmstick](https://github.com/mmstick) Documented plugin support and Vim highlighting. Details [here](https://github.com/redox-os/ion/commit/d144f190bdc3fda5760333896fb4511728010326).
- [@jackpot51](https://github.com/jackpot51) Fixed Redox the namespaces plugin. Details [here](https://github.com/redox-os/ion/commit/ce5a57e7fd6f6e9d8f5e84725df6c935644ef0cc).

## Drivers

- [@jackpot51](https://github.com/jackpot51) Refactored the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/b4209a6a9ca0527f2a0981e1eb4c6d73d25b2e26).
- [@jackpot51](https://github.com/jackpot51) Added missing imports in the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/84a8a6c0640325b2c545bbdfbb47a82d4a4a9774).
- [@jackpot51](https://github.com/jackpot51) Added more debugging to the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/545ec4d21fa6b239cb7ee27f86a21baea9563f9b).
- [@jackpot51](https://github.com/jackpot51) Updated the `EventSte` structure in the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/832f830cc4f0b77e493515cc227516cefa31f14e).
- [@jackpot51](https://github.com/jackpot51) Simplyfied `vesad` using `ptyd` for control logic. Details [here](https://github.com/redox-os/drivers/commit/eb64f59d10d39a5373c2d1048c79e91841168a31).
- [@jackpot51](https://github.com/jackpot51) Started work on grabbing device information on the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/646e8c9eac0fe62588b4aa2e595cb73f719d50dd).
- [@jackpot51](https://github.com/jackpot51) Added support for reading device, config, interface, and endpoint descriptions in the XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/096a9a6e52d2d6db92220e40885a96a0f3e13816).
- [@jackpot51](https://github.com/jackpot51) Improved the format of debugging data in XHCI. Details [here](https://github.com/redox-os/drivers/commit/144cc2a995b1434c0cca72f74e5ad511c8e31ad2) and [here](https://github.com/redox-os/drivers/commit/0231e4489276867ff6ee1f48e3eec8c887e43ab6).
- [@jackpot51](https://github.com/jackpot51) Cleaned up the XHCI driver, added basic IRQ event functions and cleaned up `e100d` and `rtl8168d`. Details [here](https://github.com/redox-os/drivers/commit/14d816507914b7c4c2c5e6389f3aeeea0e911b3f).
- [@jackpot51](https://github.com/jackpot51) Improved the ring state machine in XHCI driver. Details [here](https://github.com/redox-os/drivers/commit/87342d6fce2c8869e676d0a557e7e4e96f526ad1).

## Redoxfs

- [@jackpot51](https://github.com/jackpot51) Added a change to deallocate when node size changes. Details [here](https://github.com/redox-os/redoxfs/commit/e95be4caf33e38246a14be6691f11dd5c4c61b7a).
- [@jackpot51](https://github.com/jackpot51) Fixed a typo. Details [here](https://github.com/redox-os/redoxfs/commit/1e9cec60924ca1d52727c846e02ee63a2c096bc2).
- [@ids1024](https://github.com/ids1024) Made a fix to avoid corrupting free nodes. Details [here](https://github.com/redox-os/redoxfs/pull/30).
- [@ids1024](https://github.com/ids1024) Removed unneeded uses of `mut`. Details [here](https://github.com/redox-os/redoxfs/pull/31).

## TFS

[TFS](https://github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

- [@ticki](https://github.com/ticki) Published a new blog "Fearless concurrency with hazard pointers" about the new shiny [conc](https://crates.io/crates/conc) crate. Details [here](http://ticki.github.io/blog/fearless-concurrency-with-hazard-pointers/).
- [@ticki](https://github.com/ticki) Fixed some compile errors in `atomic-hashmap`. Details [here](https://github.com/redox-os/tfs/commit/7118c7bf135647a3e452831e2836b6df79326d4e).
- [@ticki](https://github.com/ticki) Fix documentation for wrong use of `Guard::new`. Details [here](https://github.com/redox-os/tfs/commit/f8a080e4415982b34f34a30235b2bb91d42b8450).
- [@ticki](https://github.com/ticki) Improved documentation of `atomic-hashmap`. Details [here](https://github.com/redox-os/tfs/commit/27b8c62e29f718347dacd6d44c4add6dfa9f4d74).
- [@cedenday](https://github.com/cedenday) Fixed a typo in `conc::atomic`. Details [here](https://github.com/redox-os/tfs/pull/62).
- [@ticki](https://github.com/ticki) Updated `conc` documentation to include pros/cons against `crossbeam`. Details [here](https://github.com/redox-os/tfs/commit/00c4266b810383f2917060f5f0d48a41ef05bf62).
- [@ticki](https://github.com/ticki) Fixed unsoundness in `conc` relating to use of `Sync` and `Send`. Details [here](https://github.com/redox-os/tfs/commit/8810393f1901c7662c0f82b5633184bc73c31a3c).
- [@ticki](https://github.com/ticki) Fixed a rare (happens around one time in every 2^64 or 2^32 calls) bug in `conc`. Details [here](https://github.com/redox-os/tfs/commit/35f6732c948820b61baea70ef3b09dc39aa098a6).
- [@ticki](https://github.com/ticki) Add a dynamic settings system to `conc` for setting parameters. Details [here](https://github.com/redox-os/tfs/commit/4d7d2ee12ef0fe92afa5ef0bb795e734a4a83f72).
- [@ticki](https://github.com/ticki) Reorganized the ABA loops in `atomic-hashmap`. Details [here](https://github.com/redox-os/tfs/commit/90747afc9b2919370db4cbf6119dab79791cf3a6).
- [@ticki](https://github.com/ticki) Fixed the orderings of `conc::sync::Stm<T>`. Details [here](https://github.com/redox-os/tfs/commit/0d54c1c7d0d3378b2aa99470d1bdb00804edb4a3).
- [@ticki](https://github.com/ticki) Updated confusing sections in `conc`'s docs after Reddit feedback. Details [here](https://github.com/redox-os/tfs/commit/1be02574aff4f8dfbe3bd5c24beb7b59129f544a).
- [@ticki](https://github.com/ticki) Updated docs of `conc` with overview of the API. Details [here](https://github.com/redox-os/tfs/commit/8b632e6b4c7b2c1236ab361d0a979911bc84cfd7).
- [@ticki](https://github.com/ticki) Bumped `conc` to 0.2.0. Details [here](https://github.com/redox-os/tfs/commit/6373a99b63cdcc76786399498190283d00b6a2c2).
- [@ticki](https://github.com/ticki) Fixed a final test in `conc`. Details [here](https://github.com/redox-os/tfs/commit/19a787f0ee1ea773a3da722c9cfa6b6c6aee749a).
- [@ticki](https://github.com/ticki) Enabled optional stacktraces for `conc` debug mode. Details [here](https://github.com/redox-os/tfs/commit/ccd76872028fa757a9a32d753701aaa907feac35).
- [@ticki](https://github.com/ticki) Added runtime debug tools to `conc`. Details [here](https://github.com/redox-os/tfs/commit/2064401318e667c96ea0fc3a5b44ff31369ee1c9).
- [@ticki](https://github.com/ticki) Fixed issues where successful CAS in `conc::sync::treiber` is regarded as final. Details [here](https://github.com/redox-os/tfs/commit/3b5d91e942e33015225b197acc5d6fe05074bade).
- [@cedenday](https://github.com/cedenday) Added basic benchmarking to `speck`. Details [here](https://github.com/redox-os/tfs/pull/55).
- [@cedenday](https://github.com/cedenday) Added trait derivations to `speck`'s `Key`. Details [here](https://github.com/redox-os/tfs/pull/59).
- [@ticki](https://github.com/ticki) Updated the library-wide docs of `conc` with usage information. Details [here](https://github.com/redox-os/tfs/commit/f5ee6a850be9786ca4ab01ee3feb8910407631ef).
- [@ticki](https://github.com/ticki) Rewrote `conc::sync::treiber` to consider [#57](https://github.com/redox-os/tfs/issues/57). Details [here](https://github.com/redox-os/tfs/commit/a558832f98f5810eb4daf07683ecbf944aa241a2).
- [@ticki](https://github.com/ticki) Updated the library-wide docs of `conc` with usage information. Details [here](https://github.com/redox-os/tfs/commit/f5ee6a850be9786ca4ab01ee3feb8910407631ef).
- [@ticki](https://github.com/ticki) Rename `conc::Guard::as_raw()` to `as_ptr()` and implement `PartialEq` for `Guard`. Details [here](https://github.com/redox-os/tfs/commit/ddaed7e3dc357ec640e9abdcdd299249df308f43).
- [@ticki](https://github.com/ticki) Added `conc::Guard::{try,maybe}_map`. Details [here](https://github.com/redox-os/tfs/commit/a89569cc6f10a46baf4ba7b0d17251fbd1126411).

## Coreutils

- [@jackpot51](https://github.com/jackpot51) Replaced `termion`. Details [here](https://github.com/redox-os/coreutils/commit/5ecb96ef9db86980e2b85919f6b45710756f092d)

## Userutils

- [@jackpot51](https://github.com/jackpot51) Replaced `termion`. Details [here](https://github.com/redox-os/userutils/commit/f6fd552f45cb684f498720296e39a636b6c66b1e).
- [@jackpot51](https://github.com/jackpot51) Updated password read to new method in `passwd` and `su`. Details [here](https://github.com/redox-os/userutils/commit/f6fd552f45cb684f498720296e39a636b6c66b1e).

## Netutils

- [@jackpot51](https://github.com/jackpot51) Replaced `termion`. Details [here](https://github.com/redox-os/netutils/commit/cdc0ebd10322ce0e9885da558a9d89d5c5d8abc4)
- [@Abogical](https://github.com/Abogical) Added the `whois` utility. Details [here](https://github.com/redox-os/netutils/pull/24), [here](https://github.com/redox-os/netutils/pull/25) and [here](https://github.com/redox-os/netutils/pull/27).
 - [@ids1024](https://github.com/ids1024) Made `wget` use the `-O` argument, matching standard behavior. Details [here](https://github.com/redox-os/netutils/pull/26).

## Extrautils

- [@jackpot51](https://github.com/jackpot51) Replaced and updated `termion`. Details [here](https://github.com/redox-os/extrautils/commit/001600d7f7e4bea018837eef11c6a8bdca0d1285) and [here](https://github.com/redox-os/extrautils/commit/afb9afd51e9c81853e2e4f79adf99b9adddd02c3) respectively.
 - [@ids1024](https://github.com/ids1024) Added gzip and xz extraction support, along with verbose support to `tar`. Details [here](https://github.com/redox-os/extrautils/pull/26).
 - [@ids1024](https://github.com/ids1024) Implemented `--directory` and `--strip-components` for `tar`. Details [here](https://github.com/redox-os/extrautils/pull/27).

## Orbital

- [@jackpot51](https://github.com/jackpot51) Removed a bunch of unnecessary muts. Details [here](https://github.com/redox-os/orbital/commit/ca660480a99e5e2a662d47fcec68c83f81efa64d) and [here](https://github.com/redox-os/orbital/commit/8dcf7acdac80b2db3629a7c15170aaa3ba347d6a).

## Cookbook

The [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes of Redox.

- [@jackpot51](https://github.com/jackpot51) Switched to a Redox patched version of `findutils` and `uutils`. Details [here](https://github.com/redox-os/cookbook/commit/e9c632537d700b59d1539826e19541605ca61709).
- [@ids1024](https://github.com/ids1024) Enabled C++ support in the `gcc` recipe. Details [here](https://github.com/redox-os/cookbook/pull/57).
- [@ids1024](https://github.com/ids1024) Switch the target triple from `"x86_64-elf-redox-*` to `x86_64-unknown-redox-*`. Details [here](https://github.com/redox-os/cookbook/pull/59).
- [@ids1024](https://github.com/ids1024) Added a recipe for `bash`. Details [here](https://github.com/redox-os/cookbook/pull/60).
- [@ids1024](https://github.com/ids1024) Added a recipe for `xz`. Details [here](https://github.com/redox-os/cookbook/pull/61).
- [@ids1024](https://github.com/ids1024) Made `xz` a build dependency of `extrautils`. Details [here](https://github.com/redox-os/cookbook/pull/62).
- [@ids1024](https://github.com/ids1024) Added a recipe for `patch`. Details [here](https://github.com/redox-os/cookbook/pull/61).
- [@ids1024](https://github.com/ids1024) Made a change to user system `pkg` when cookbook is running on Redox. Details [here](https://github.com/redox-os/cookbook/pull/64).
- [@ids1024](https://github.com/ids1024) Patched `patch` to prevent it from calling `chown`. Details [here](https://github.com/redox-os/cookbook/pull/65).
- [@ids1024](https://github.com/ids1024) Passed `-p` to `cp` in order to make running autotools unnecessary. Details [here](https://github.com/redox-os/cookbook/pull/66).
- [@ids1024](https://github.com/ids1024) Opened a PR for making `rustc` backtraces work on Redox. Details [here](https://github.com/rust-lang/rust/pull/43635).
- [@goyox86](https://github.com/goyox86) Added some permission and misc (mostly `mode_t` related) constants to Redox on the `libc` crate (this is part of the ongoing `exa` port). Details [here](https://github.com/rust-lang/libc/pull/715).

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

- Abogical 🎂
- garasubo 🎂

If I missed something, feel free to contact me (goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
