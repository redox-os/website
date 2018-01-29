+++
title = "This Week in Redox 35"
author = "goyox86"
date = "2018-01-26 15:54:24 +0000"
+++

This is the 35th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by [@goyox86](https://github.com/goyox86))*

# PSA

If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org`, [our Discourse forum](https://discourse.redox-os.org/) or you can get an invite to our chat by sending an email request to `info@redox-os.org`.

# What's new in Redox?

## TL;DR

Hello people! Welcome to the 35th edition of TWiRx!

We started this year with [@jackpot51](https://github.com/jackpot51) being featured on the [Changelog](https://changelog.com/podcast/280) talking about building a secure operating system in Rust and about Redox in general. Make sure you listen to the episode, it's pretty good! (specially the part on which Jeremy says **SPOILER ALERT!**: "Redox is not going away")

This month we've also got the [Redox Crash Challenge](https://www.reddit.com/r/rust/comments/7rv9vw/redox_os_crash_challenge/) going on. An initiative to attempt to cause the system to:

- Escalate privilege.
- Lock up.
- Kernel panic.
- Program crash.
- Any other unexpected behavior.

Basically, a fun way of testing and discover bugs in the system, and ultimately hardening it!

So far, it has been productive! We have found (and successfully fixed) few bugs:

- An issue with too many arguments to exec not returning E2BIG: [redox-os/kernel#81](https://github.com/redox-os/kernel/issues/81)
- An issue with the kernel attempting to remap kernel code (and failing due to protections) in: [redox-os/kernel#79](https://github.com/redox-os/kernel/issues/79)
- An issue with address validation allowing overflows: [redox-os/kernel@dcb49be](https://github.com/redox-os/kernel/commit/dcb49be48133cf811dcd870e8af5f7ffaffc2ab0)
- An issue with su allowing login as any user by pressing `Ctrl+D`: [redox-os/userutils@02759b4](https://github.com/redox-os/userutils/commit/02759b4a5a347726e6e81d4ee46a2ade86fd9e1e)

Without further ado, let's start with this week's work!

We begin with the **kernel**, where `SIGCONT/SIGSTOP` signals were implemented, a bug in the TLS when forking was fixed (this one was causing some programs to crash and/or miss behave), along with the implementation of `waitpid` on `PGID`.

One interesting thing I saw in the kernel was the start of the work on PTI (Page Table Isolation) as a mitigation for the recently discovered [Meltdown vulnerability](https://en.wikipedia.org/wiki/Meltdown_(security_vulnerability)). I was gladly impressed while looking at the [changes](https://github.com/redox-os/kernel/commit/a6550341bbe3614d595dd8ba8113517f3a25f637), how small, isolated they were. All of this, without mentioning the time frame in which they were made. One of the advantages of having a microkernel!

Also in the low level, **syscall**, our system call interface crate, got a bunch of additions like: `WUNTRACED`/`WCONTINUED`, `wif*` functions, and a few more `wait` calls.

A quick look at **Redoxfs** reveals a small change to enter into the null namespace by [@jackpot51](https://github.com/jackpot51).

Moving up to the **drivers** [@ids1024](https://github.com/ids1024) have been busy working on an `ATAPI` driver which gives support for CD-ROM drives along with an [implementation](https://github.com/ids1024/iso9660-rs) of the ISO-9660 filesystem (the standard filesystem for CD-ROM drives). I think is pretty cool!

On the **Ion** shell We saw the addition of the `isatty` builtin by [@Sag0Sag0](https://github.com/Sag0Sag0) as well as many small fixes and improvements.

In the **Cookbook**, the collection of package recipes for Redox, [@zachlute](https://github.com/zachlute) added the `logd` package which implements a log daemon located at `log:` for collecting all log output.

During this period, I saw a lot of activity on the GUI front, particularly **Orbtk** and **Orbutils** namely: Changes to allow apps to add classes and pseudo-classes to widgets, the addition of a `Style` trait to remaining widgets,
correction on the initialization of fonts in `WindowBuilder`, the implementation of `KeyPressed` and `KeyReleased` events plus some other goodies. Good work [@blackle](https://github.com/blackle) and [@FloVanGH](https://github.com/FloVanGH)!

Lastly (but not least) we have the **Userutils** **Coreutils** and **Extrautils** with bugfixes for `su`, updates to `README` and some unused code removal respectively.

Looking forward to see you soon in the next issue of TWiRx.

BTW! keep trying to [crash Redox](https://www.reddit.com/r/rust/comments/7rv9vw/redox_os_crash_challenge/) and report bugs!

## Redox

Redox: A Rust Operating System - Main Repo

- [@fengalin](https://github.com/fengalin) Docker: Added `autopoint`. Details [here](https://github.com/redox-os/redox/pull/1132).
- [@dogHere](https://github.com/dogHere) Added `autopoint` as a dependency for ubuntu. Details [here](https://github.com/redox-os/redox/pull/1133).
- [@bugabinga](https://github.com/bugabinga) Added dependency `xargo` to manual setup. Details [here](https://github.com/redox-os/redox/pull/1139).
- [@jackpot51](https://github.com/jackpot51) Added `logd`. Details [here](https://github.com/redox-os/redox/commit/4135772f20ba8354945e9966ebcc1741d48200da).
- [@FloVanGH](https://github.com/FloVanGH) Added `orbgame` to the readme. Details [here](https://github.com/redox-os/redox/pull/1140).

## book

The Redox book

- [@bmusin](https://github.com/bmusin) Replaced "I" with "We" for consistency with rest of text. Details [here](https://github.com/redox-os/book/pull/113)

## kernel

The Redox microkernel

- [@jackpot51](https://github.com/jackpot51) Added support for stop/cont signals. Details [here](https://github.com/redox-os/kernel/commit/7906f6891e2501795d86f028363c6d5e434218ed).
- [@jackpot51](https://github.com/jackpot51) Fixed TLS when forking, fixed signal delivery to self. Details [here](https://github.com/redox-os/kernel/commit/c912f4280005fa0e9ce96c58f95b96d9bcbe1595).
- [@jackpot51](https://github.com/jackpot51) Made a change to use separate stopped status. Details [here](https://github.com/redox-os/kernel/commit/b6878760c72f73032cf3004d14f0966db0362d69).
- [@jackpot51](https://github.com/jackpot51) Added support for `WCONTINUED` and `WUNTRACED`, Fixed issues with `SIGCONT`. Details [here](https://github.com/redox-os/kernel/commit/49d5c3392835070ae295a1ef1bb46337d9da1ad3).
- [@jackpot51](https://github.com/jackpot51) Fixed stop signal by switching context after stopping. Details [here](https://github.com/redox-os/kernel/commit/9313909fe9547970807424e99cbafef4e0ead285).
- [@jackpot51](https://github.com/jackpot51) Implemented `waitpid` on `PGID`. Details [here](https://github.com/redox-os/kernel/commit/083c444a6823530e77dc0eb45f990f078348807e).
- [@wartman4404](https://github.com/wartman4404) Made an update to write `hpet` timer twice. Details [here](https://github.com/redox-os/kernel/pull/74).
- [@jackpot51](https://github.com/jackpot51) Added PML4 constants. Details [here](https://github.com/redox-os/kernel/commit/670d7b00d3d927e3c1583958e97c16a7db0c3851).
- [@jackpot51](https://github.com/jackpot51) Added trampolines for PTI support. Details [here](https://github.com/redox-os/kernel/commit/a6550341bbe3614d595dd8ba8113517f3a25f637).
- [@jackpot51](https://github.com/jackpot51) Added `rbx` to saved registers in syscall stack. Details [here](https://github.com/redox-os/kernel/commit/192a8ce793a5d0f8806768a1c1a25054244a43c0).
- [@jackpot51](https://github.com/jackpot51) WIP: Added per-cpu interrupt stack used before mapping kernel heap. Details [here](https://github.com/redox-os/kernel/commit/d82ffd16cbee1eaa203acac9ca44f0b9a73b0b9d).
- [@dlrobertson](https://github.com/dlrobertson) Updated debugging docs. Details [here](https://github.com/redox-os/kernel/pull/75).
- [@jackpot51](https://github.com/jackpot51) Updated PTI patch to inline PTI functions. Details [here](https://github.com/redox-os/kernel/commit/5b389c7ffaec7eba8259571b0fabb74f3e84bb6d).
- [@jackpot51](https://github.com/jackpot51) Used `fninit` in start. Details [here](https://github.com/redox-os/kernel/commit/1e533b3ad5524d226efcd5c883fa51c132753a11).
- [@jackpot51](https://github.com/jackpot51) Removed comment from linker file. Details [here](https://github.com/redox-os/kernel/commit/98fb50a086f33a85279decbf6fdffcee3d04b25f).
- [@jackpot51](https://github.com/jackpot51) Disabled PTI by default. Details [here](https://github.com/redox-os/kernel/commit/fee95a040667d18411a1e2416fb7edd43f04a56c).
- [@jackpot51](https://github.com/jackpot51) Removed debugging print. Details [here](https://github.com/redox-os/kernel/commit/89df5e5343d412e5de50391582e56e0adb7f725d).
- [@jackpot51](https://github.com/jackpot51) Fixed potential overflows in validate_slice and validate_slice_mut, require memory to be userspace. Details [here](https://github.com/redox-os/kernel/commit/dcb49be48133cf811dcd870e8af5f7ffaffc2ab0).
- [@jackpot51](https://github.com/jackpot51) Fixed #81 by limiting arguments to 4095, Fix #79 by limiting mappable sections to the 2GB mark. Details [here](https://github.com/redox-os/kernel/commit/f3205e6e3491e48f1a41d87e47b3b26ef34852f1).
- [@biotty](https://github.com/biotty) Made a change to operate on word size as possible. Details [here](https://github.com/redox-os/kernel/pull/83).

## Drivers

Redox OS Drivers

- [@ids1024](https://github.com/ids1024) AHCI: Implemented basic ATAPI support (Needed for CD drives). Details [here](https://github.com/redox-os/drivers/pull/22).
- [@ids1024](https://github.com/ids1024) AHCI: Refactored duplicated ATA command code into a method. Details [here](https://github.com/redox-os/drivers/pull/23).

## Syscall

Redox Rust Syscall Library

- [@jackpot51](https://github.com/jackpot51) Added `WUNTRACED`. Details [here](https://github.com/redox-os/syscall/commit/88a0512d71c4cfaaa8a9102159416d7f1d09b68a).
- [@jackpot51](https://github.com/jackpot51) Added `WCONTINUED`. Details [here](https://github.com/redox-os/syscall/commit/8f012900589854cd54ac0a6edb9a3f2b0e017669).
- [@jD91mZM2](https://github.com/jD91mZM2) Added `wif*` functions. Details [here](https://github.com/redox-os/syscall/pull/22).
- [@jackpot51](https://github.com/jackpot51) Released version `0.1.36`. Details [here](https://github.com/redox-os/syscall/commit/7ab7dbe3c80b9b829dd1537fbbacd240092d7019).
- [@jackpot51](https://github.com/jackpot51) Added more `wait` related calls. Details [here](https://github.com/redox-os/syscall/commit/7c805d2a289ec19bf505256eb90395913d9f50b9).
- [@ids1024](https://github.com/ids1024) Removed the `core_intrinsics` feature. Details [here](https://github.com/redox-os/syscall/pull/23).

## Ion

The Ion Shell. Compatible with Redox and Linux.

- [@mmstick](https://github.com/mmstick) Made some pipeline fixes & tests. Details [here](https://github.com/redox-os/ion/pull/665).
- [@gibfahn](https://github.com/gibfahn) Used `libc::__error()` rather than `libc::__errno_location()` on macOS. Details [here](https://github.com/redox-os/ion/pull/666).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Added the `isatty` builtin. Details [here](https://github.com/redox-os/ion/pull/667).
- [@jackpot51](https://github.com/jackpot51) Updated redox-syscall, to use `WUNTRACED` for `waitpid` in Redox. Details [here](https://github.com/redox-os/ion/pull/668).
- [@blackle](https://github.com/blackle) Made a change to call `execve` from `fork_and_exec` in `sys/redox.rs` so they can share code. Details [here](https://github.com/redox-os/ion/pull/669).
- [@its-suun](https://github.com/its-suun) Fixed issue board link. Details [here](https://github.com/redox-os/ion/pull/670).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Cleaned up builtin `isatty`. Details [here](https://github.com/redox-os/ion/pull/671).
- [@Sag0Sag0](https://github.com/Sag0Sag0) Updated methods used to print to `stdout` and `stderr`. Details [here](https://github.com/redox-os/ion/pull/672).
- [@spacingnix](https://github.com/spacingnix) Fixed an array parsing issue. Details [here](https://github.com/redox-os/ion/pull/673).
- [@aimof](https://github.com/aimof) Removed tests dependency. Details [here](https://github.com/redox-os/ion/pull/675).
- [@jD91mZM2](https://github.com/jD91mZM2) Implemented `CD_CHANGE` function. Details [here](https://github.com/redox-os/ion/pull/676).
- [@jD91mZM2](https://github.com/jD91mZM2) Moved `binary::main` into actual `main`. Details [here](https://github.com/redox-os/ion/pull/677).
- [@aimof](https://github.com/aimof) Added tests to #638 array parsing issue. Details [here](https://github.com/redox-os/ion/pull/678).
- [@jackpot51](https://github.com/jackpot51) Synchronized Redox and Unix job_control. Details [here](https://github.com/redox-os/ion/pull/680).

## Cookbook

A collection of package recipes for Redox.

- [@zachlute](https://github.com/zachlute) Added the `logd` recipe. Details [here](https://github.com/redox-os/cookbook/pull/119).

## Orbtk

The Orbital Widget Toolkit. Compatible with Redox and SDL2.

- [@blackle](https://github.com/blackle) Made an update to unpress buttons regardless of left_button state. Details [here](https://github.com/redox-os/orbtk/pull/64).
- [@blackle](https://github.com/blackle) [WIP] Allowed apps to add classes and pseudoclasses to widgets. Details [here](https://github.com/redox-os/orbtk/pull/65).
- [@blackle](https://github.com/blackle) Added `Style` trait to remaining widgets, allow apps to remove classes. Details [here](https://github.com/redox-os/orbtk/pull/66).
- [@blackle](https://github.com/blackle) Initialized font correctly in `WindowBuilder`. Details [here](https://github.com/redox-os/orbtk/pull/67).
- [@FloVanGH](https://github.com/FloVanGH) Implemented `KeyPressed` and `KeyReleased` events. Details [here](https://github.com/redox-os/orbtk/pull/69).
- [@FloVanGH](https://github.com/FloVanGH) Fix bug when `x > 200` the entries of `Combobox` were not being drawn. Details [here](https://github.com/redox-os/orbtk/pull/70).
- [@FloVanGH](https://github.com/FloVanGH) Widget children tree part one / two. Details [here](https://github.com/redox-os/orbtk/pull/74).

## Orbutils

The Orbital Utilities. Compatible with Redox and SDL2.

- [@blackle](https://github.com/blackle) Updated calendar and file_manager to use new CSS in Orbtk. Details [here](https://github.com/redox-os/orbutils/pull/38).
- [@blackle](https://github.com/blackle) Fixed build with toolchain. Details [here](https://github.com/redox-os/orbutils/pull/39).

## Redoxfs

The Redox Filesystem.

- [@jackpot51](https://github.com/jackpot51) Enter null namespace for redoxfs. Details [here](https://github.com/redox-os/redoxfs/commit/78c5e1c6d26657eff9d7e97a979d4524f718ab63).

## Userutils

User and group management utilities.

- [@jackpot51](https://github.com/jackpot51) Fix bug causing ctrl-d to log in any user with su, Document su's logic, Return error code of shell from su. Details [here](https://github.com/redox-os/userutils/commit/02759b4a5a347726e6e81d4ee46a2ade86fd9e1e).

## Coreutils

The Redox coreutils.

- [@dabbydubby](https://github.com/dabbydubby) Updated the readme to show only included files. Details [here](https://github.com/redox-os/coreutils/pull/192).

## Extrautils

Extra utilities for Redox (and Unix systems).

- [@bmusin](https://github.com/bmusin) Remove unused `use` of `AsciiExt`. Details [here](https://github.com/redox-os/extrautils/pull/33).
- [@bmusin](https://github.com/bmusin) Change `man` constant names to `MAN_PAGE`. Details [here](https://github.com/redox-os/extrautils/pull/34).

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

- [@aimof](https://github.com/aimof) 🎂
- [@biotty](https://github.com/biotty) 🎂
- [@blackle](https://github.com/blackle) 🎂
- [@bmusin](https://github.com/bmusin) 🎂
- [@bugabinga](https://github.com/bugabinga) 🎂
- [@dogHere](https://github.com/dogHere) 🎂
- [@gibfahn](https://github.com/gibfahn) 🎂
- [@its-suun](https://github.com/its-suun) 🎂
- [@Nopey](https://github.com/Nopey) 🎂
- [@spacingnix](https://github.com/spacingnix) 🎂
- [@wartman4404](https://github.com/wartman4404) 🎂
- [@zachlute](https://github.com/zachlute) 🎂

If I missed something, feel free to contact me [@goyox86](https://github.com/goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
