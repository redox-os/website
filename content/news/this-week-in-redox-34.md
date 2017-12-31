+++
title = "This Week in Redox 34"
author = "goyox86"
date = "2017-12-31 15:45:47 +0000"
+++

This is the 34th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by [@goyox86](https://github.com/goyox86))*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

## TL;DR

Welcome to the last TWiRx of the year!

2017 has been a fantastic! The project has been more active and vibrant than ever.
The team worked super hard and shipped a ton of interesting stuff! I am preparing a summary of the most interesting things that happened in 2017 and I will be publishing it in a few days. So stay tuned!

Without further ado, here is what happened this last few weeks:

Big news! We were surprised this week by [@jackpot51](https://github.com/jackpot51) and his news about the plans to create a foundation to support and foster Redox OS and it's ecosystem. This is really good news! More on it on the upcoming issues. 

In the main top-level repo (**redox**) `netdb` (which contains the default `/etc/hosts` and friends) is now included in the filesystem by default. Also, [@jD91mZM2](https://github.com/jD91mZM2) fixed the rust toolchain to `nightly-2017-12-21` as the `ring` does not work with the latest `nightly`.

In the **kernel** there was a super cool page table optimization made by [@weclaw1](https://github.com/weclaw1), basically now we use bits `51-61` in the first entries of each page table as a counter for used entries. After this change, checking if page table is empty is a `O(1)` operation instead of `O(n)`, where `n` is the number of entries, Neato!

The `null` and `zero` daemons which implement the `null:` and `zero:` schemes respectively where moved to userspace by [@Arcterus](https://github.com/Arcterus), along with a shinny new `frename` implementation.

As you might suspect, the **syscall** crate the new, shinny `frename` call, <3.

**Redoxfs** got renaming support with the implementation of `frename`. 

**Ion**, The Redox (and Linux) shell, saw a lot of activity, notably the addition of the `exec` builtin by [@dlrobertson](https://github.com/dlrobertson), the addition of a title bar setting and the ability to produce any character using hex code by [@jackpot51](https://github.com/jackpot51). [@nihathrael](https://github.com/nihathrael) was busy adding the `@lines()` and `@reverse()` methods while [@mmstick](https://github.com/mmstick) made a change to use a static map for simple color lookups, removed `Shell::update_variables`, added `UID` and `EUID`, added support for enabling forks to ignore streams, fixed `EAGAIN` error on forks and started to work on library/binary separation.

The **cookbook** saw the birth of a `newlib` test suite, packages for the recently moved to userspace `nulld` and `zerod` daemons, some improvements to the `bash` along a fixed the `raw-bin` (which was broken because of the recent changes to `redox_users`'s API).   

On the GUI side of things, **Orbtk** the widget toolkit saw a change by [@FloVanGH](https://github.com/FloVanGH) who used `include_bytes!` to load icons on ComboBoxes.

Also UI related, **Orbterm**, the terminal emulator, received an Ion related fix which unsets the `COLUMNS` and `LINES` variables while [@jD91mZM2](https://github.com/jD91mZM2) landed the initial configuration support.

**libextra** got a new `unwrap_or_exit` helper meant to simplify a lot of repetitive code in the `*utils` (and CLI apps) packages.

Finally, in the land of the utils (**coreutils** and **userutils**), there were only two minor changes related to using `unwrap_or_exit` and the new APIs exposed by `redox_users`.

Thanks to all the people who supported the project this year, from the contributors to the patreons, and all the people that spread the word, and the Rust community for creating such an amazing tool, enabling us our ultimate objective: to create a modern, lightweight fast and above all, a safer operating system. 

See you next year! 

## Redox

Redox: Main repository.

- [@jackpot51](https://github.com/jackpot51) Added `netdb`. Details [here](https://github.com/redox-os/redox/commit/df6b9508f8c6d2a7df248f51770dd59f1f910663).
- [@jackpot51](https://github.com/jackpot51) Updated `cookbook`. Details [here](https://github.com/redox-os/redox/commit/3e8de546cbcee2a222e0772745ab1ab1b2e5fb3d).
- [@jackpot51](https://github.com/jackpot51) Updated the `kernel`. Details [here](https://github.com/redox-os/redox/commit/a3f28dfe339057a7f1316a2886feaf7b9f6c61b3).
- [@Arcterus](https://github.com/Arcterus) Moved `null:` and `zero:` schemes to user space. Details [here](https://github.com/redox-os/redox/pull/1123).
- [@NilSet](https://github.com/NilSet) Made a temporal change to use `bash` as shell until #1124 is fixed. Details [here](https://github.com/redox-os/redox/pull/1125).
- [@jackpot51](https://github.com/jackpot51) Updated the `cookbook` and the `kernel`. Details [here](https://github.com/redox-os/redox/commit/090f2e48db279804676e1bc7db37cef68f1ea626).
- [@jD91mZM2](https://github.com/jD91mZM2) Created `rust-toolchain`. Details [here](https://github.com/redox-os/redox/pull/1126).
- [@NilSet](https://github.com/NilSet) Installed realpath for cookbook CI. Details [here](https://github.com/redox-os/redox/pull/1127).
- [@jackpot51](https://github.com/jackpot51) Updated cookbook. Details [here](https://github.com/redox-os/redox/commit/f687912444a17eaa01461f6d79f331a8f481214e).
- [@jackpot51](https://github.com/jackpot51) Updated `rust` to the same commit as `rust-toolchain`. Details [here](https://github.com/redox-os/redox/commit/d65e3e474cac77207bbcb66c9b3536e706cf4ec1).
- [@jackpot51](https://github.com/jackpot51) Updated `rust` and `kernel`. Details [here](https://github.com/redox-os/redox/commit/efb55996d7ee10288015c028dafcd6ffa10b5004).
- [@jackpot51](https://github.com/jackpot51) Updated `cookbook`. Details [here](https://github.com/redox-os/redox/commit/d2789c27abdfc849595435f7437c534e94655a65).
- [@jackpot51](https://github.com/jackpot51) Updated `kernel`. Details [here](https://github.com/redox-os/redox/commit/175050faa08c507b665bc602add601340cc7043f).
- [@jackpot51](https://github.com/jackpot51) Reverted "Use bash as shell until #1124 is fixed". Details [here](https://github.com/redox-os/redox/pull/1128).
- [@ids1024](https://github.com/ids1024) Made a change in order to not mentioning `rustup override set` in the README. Details [here](https://github.com/redox-os/redox/pull/1129).

## Kernel

The Redox microkernel

- [@weclaw1](https://github.com/weclaw1) Made a page table optimization. Details [here](https://github.com/redox-os/kernel/pull/66).
- [@Arcterus](https://github.com/Arcterus) Moved `null` and `zero` from kernel space to user space. Details [here](https://github.com/redox-os/kernel/pull/67).
- [@NilSet](https://github.com/NilSet) Made a change to check if current namespace exists. Details [here](https://github.com/redox-os/kernel/pull/69).
- [@jackpot51](https://github.com/jackpot51) Added `clippy` lints, as well as made some improvements based on `clippy` suggestions. Details [here](https://github.com/redox-os/kernel/pull/70).
- [@jackpot51](https://github.com/jackpot51) Added `frename`. Details [here](https://github.com/redox-os/kernel/commit/059cc8078d778d238963525df8011635bc27bf66).
- [@jackpot51](https://github.com/jackpot51) Used TLS alignment to fix https://github.com/redox-os/redox/issues/1124 (was causing Ion to pagefault). Details [here](https://github.com/redox-os/kernel/commit/22aca69ac97859789b8c912723f1703f3b913940).

## Ion

The Ion Shell. Compatible with Redox and Linux.

- [@dlrobertson](https://github.com/dlrobertson) Added the `exec` builtin. Details [here](https://github.com/redox-os/ion/commit/a2c5e5d4e1ca68c3ce77cb2135291e3ad410ba7c).
- [@AgustinCB](https://github.com/AgustinCB) Replaced `writeln!(stderr, ...)` by calls to `eprintln!`. Details [here](https://github.com/redox-os/ion/pull/644).
- [@mmstick](https://github.com/mmstick) Don't expand prompt function outputs. Fixing #641. Details [here](https://github.com/redox-os/ion/commit/29e64d768d321691d96a844fbfa4d58416cf752f).
- [@dlrobertson](https://github.com/dlrobertson) Fixed errors with `sys::execve` on linux. Details [here](https://github.com/redox-os/ion/pull/646).
- [@jackpot51](https://github.com/jackpot51) Added title bar setting, also added the ability to produce any character using hex code. Details [here](https://github.com/redox-os/ion/pull/647).
- [@mmstick](https://github.com/mmstick) Made a change to use static maps for simple color lookups. Details [here](https://github.com/redox-os/ion/commit/7cb16bc349c69b9c18a67323c779b5142d425e04).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added manpage for Ion. Details [here](https://github.com/redox-os/ion/pull/648).
- [@nihathrael](https://github.com/nihathrael) Added `@lines()` method (#441). Details [here](https://github.com/redox-os/ion/pull/649).
- [@nihathrael](https://github.com/nihathrael) Reformated the code. Details [here](https://github.com/redox-os/ion/pull/650).
- [@mmstick](https://github.com/mmstick) Removed `Shell::update_variables`. Details [here](https://github.com/redox-os/ion/commit/8cdf371e22fb312f792d7be2a30b756c4d6f72ca).
- [@nihathrael](https://github.com/nihathrael) Add `@reverse()` method (#441). Details [here](https://github.com/redox-os/ion/pull/651).
- [@mmstick](https://github.com/mmstick) Added `UID` and `EUID` string variables. Details [here](https://github.com/redox-os/ion/commit/adde38d82bca7ad5595db57898e75694cb3278ac).
- [@dlrobertson](https://github.com/dlrobertson) Fixed type casts in `sys::redox`. Details [here](https://github.com/redox-os/ion/pull/652).
- [@dlrobertson](https://github.com/dlrobertson) Updated test builtin option parsing. Details [here](https://github.com/redox-os/ion/pull/654).
- [@mmstick](https://github.com/mmstick) Update version & dependencies. Details [here](https://github.com/redox-os/ion/commit/b07029d33602b97c42a210d79e12c4460836aef2).
- [@nihathrael](https://github.com/nihathrael) Made tests variable naming consistent. Use @ for arrays. Details [here](https://github.com/redox-os/ion/pull/655).
- [@gnieto](https://github.com/gnieto) Fixed issues with escaping on double quote context. Details [here](https://github.com/redox-os/ion/pull/657).
- [@covercash2](https://github.com/covercash2) Made a fix for issue #585. Details [here](https://github.com/redox-os/ion/pull/659).
- [@mmstick](https://github.com/mmstick) Forks may now ignore streams. Details [here](https://github.com/redox-os/ion/commit/166585796d037b259f2bf6933309a0a1498a87fb).
- [@mmstick](https://github.com/mmstick) Fixed `EAGAIN` fork errors. The `waitpid()` function is required to reap child processes. The forking code was not using it, it would eventually cause EAGAIN errors, to occur. With this change, this will no longer be the case. Closes #589. Details [here](https://github.com/redox-os/ion/commit/bc49acb6b9555942ba8d568914d61389052e9b2b).
- [@mmstick](https://github.com/mmstick) Initial library/binary separation. Details [here](https://github.com/redox-os/ion/commit/c1c44ecbc51112bbeb765d6b32be7b1c77c8b1f0).
- [@mmstick](https://github.com/mmstick) Fixed some Redox errors. Details [here](https://github.com/redox-os/ion/commit/e22a3954a1f52931d1491ca16131660865df67d2).
- [@mmstick](https://github.com/mmstick) Fixed the Redox build. Details [here](https://github.com/redox-os/ion/commit/f0486f80eadd0e5e7ae23441c20658f69c111f2d).
- [@jackpot51](https://github.com/jackpot51) Fixed the Redox build. Details [here](https://github.com/redox-os/ion/commit/9c57cefcd11d994f6a3674ed13b9a8a02816b5fe).
- [@mmstick](https://github.com/mmstick) Overhauled the foreground job control. Details [here](https://github.com/redox-os/ion/pull/661).

## Cookbook

A collection of package recipes for Redox.

- [@jackpot51](https://github.com/jackpot51) Added `newlibtest` repo. Details [here](https://github.com/redox-os/cookbook/commit/4fcefcc47e9e1a96539acfbd6169cfabcda8a862).
- [@jackpot51](https://github.com/jackpot51) Fixed build of `newlibtest`. Details [here](https://github.com/redox-os/cookbook/commit/527599d49c24d24eeecc1438c75477d3a3c59221).
- [@Arcterus](https://github.com/Arcterus) Added recipes for `nulld` and `zerod`. Details [here](https://github.com/redox-os/cookbook/pull/116).
- [@NilSet](https://github.com/NilSet) Tried to fix the CI. Details [here](https://github.com/redox-os/cookbook/pull/117).
- [@jackpot51](https://github.com/jackpot51) Allowed missing `llvm-source` in `rust` recipe. Details [here](https://github.com/redox-os/cookbook/commit/d9ede42f67a30f31481eae46aa1ee1cae0764af3).
- [@jackpot51](https://github.com/jackpot51) Made the `bash` patch smaller. Details [here](https://github.com/redox-os/cookbook/commit/02669e4b6201dcb5e9864ebd757d39eebe0280e9).
- [@raw-bin](https://github.com/raw-bin) Fixed a breakage due to missing `set{uid,gid)` definitions. Details [here](https://github.com/redox-os/cookbook/pull/118).

## libextra

Extra stuff, we use in the Redox project.

- [@goyox86](https://github.com/goyox86) Added `unwrap_or_exit`. Details [here](https://github.com/redox-os/libextra/pull/11).

## Orbtk

The Orbital Widget Toolkit. Compatible with Redox and SDL2.

- [@FloVanGH](https://github.com/FloVanGH) Used `include_bytes!` to load icons of ComboBox. Details [here](https://github.com/redox-os/orbtk/commit/e71c9fef16d065d2933e491d144159984e77c26e).

## Orbterm

Orbital Terminal, compatible with Redox and Linux.

- [@jackpot51](https://github.com/jackpot51) Made a change to unset `COLUMNS` and `LINES` to fix issues when running Ion. Details [here](https://github.com/redox-os/orbterm/commit/4f5ab77aa8c65c418faf51e60aaf32a590fbc06d).
- [@jD91mZM2](https://github.com/jD91mZM2) Initial config support. Details [here](https://github.com/redox-os/orbterm/pull/8).

## redoxfs

The Redox Filesystem

- [@jackpot51](https://github.com/jackpot51) Added a stub for `frename`. Details [here](https://github.com/redox-os/redoxfs/commit/2e6e272c722d011518951c99481fe474f47bb9ed).
- [@jackpot51](https://github.com/jackpot51) Implemented `frename` fixing #37 and fix #11 by checking names. Details [here](https://github.com/redox-os/redoxfs/commit/40e2a3e2216e89bcda5128256d98c11c10718672).

## syscall

Redox Rust Syscall Library

- [@jackpot51](https://github.com/jackpot51) Added `frename`. Details [here](https://github.com/redox-os/syscall/commit/414b8e0be011c70d5c55692f4dd835184f33579f).

## userutils

User and group management utilities

- [@goyox86](https://github.com/goyox86) Migrated the code to the recently added `unwrap_or_exit` from `libextra`. Details [here](https://github.com/redox-os/userutils/pull/22).

## coreutils

The Redox coreutils.

- [@goyox86](https://github.com/goyox86) Updated `redox_users` and `libextra` and used their new APIs. Details [here](https://github.com/redox-os/coreutils/pull/191).


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

- [@Arcterus](https://github.com/Arcterus) 🎂
- [@weclaw1](https://github.com/weclaw1) 🎂
- [@nihathrael](https://github.com/nihathrael) 🎂
- [@gnieto](https://github.com/gnieto) 🎂

If I missed something, feel free to contact me [@goyox86](https://github.com/goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
