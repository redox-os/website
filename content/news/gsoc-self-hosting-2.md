+++
title = "GSoC Project: Making Redox Self-hosting, Status Report 2"
author = "ids1024"
date = "2017-07-08 16:52:23-07:00"
+++

As [previously reported](/news/gsoc-self-hosting-1/), I am working on making Redox self hosting for the Google Summer of Code.

# Cargo

Based on how far I was at the time of my last report, I was hoping cargo would be working on Redox by now. But that is not yet the case.

It took a while to find one bug that was interfering with cargo; [an issue with the implementation of `Convdar` on Redox](https://github.com/rust-lang/rust/pull/43082/). The remaining issue seems to be in [jobserver-rs](https://github.com/alexcrichton/jobserver-rs); the modifications I made to it to run on Redox were incorrect. It should be possible to port that properly once Redox has full support for signals and signal handlers.

Cargo also is unable to fetch the registry; I'm not sure why, but hopefully it will work better once Redox switches to a network stack based on [smoltcp](https://github.com/m-labs/smoltcp).

# Symlinks

`symlink()` and `readlink()` are two functions I've had to comment out of C code I've ported, and the `gcc` and `dash` packages needed to use scripts for `/bin/cc` and `/bin/sh` since symlinks weren't available, so it seemed about time to [implement symlinks](https://github.com/redox-os/redoxfs/pull/18). To be able to create symlinks when building Redox, I also had to [make symlinks work in redoxfs's fuse mount](https://github.com/redox-os/redoxfs/pull/20), and [improve support for symlinks in upstream tar-rs](https://github.com/alexcrichton/tar-rs/pull/117).

There were various other small things to address, like adjusting [libstd](https://github.com/redox-os/rust/pull/6) and [newlib](https://github.com/redox-os/newlib/pull/33), and adding a [readlink command](https://github.com/redox-os/coreutils/pull/156).

# Other libc functions

I added the [`getppid()` system call](https://github.com/redox-os/kernel/pull/26) (which was trivial), and [sent a PR](https://github.com/redox-os/newlib/pull/32) adding that function to Redox's newlib, along with `inet_pton()` and `inet_ntop()`. And later I added [`gethostname()`](https://github.com/redox-os/newlib/pull/37). The goal here is mainly to reduce the amount of patching needed for C programs.

# Git

One issue with git was caused by a [bug in Redox's pipe scheme](https://github.com/redox-os/kernel/pull/29). With some dificulty, I managed to create a [recipe for git](https://github.com/redox-os/cookbook/pull/40) that includes support for http(s) via curl; it was somewhat dificult tricking it into finding the dependencies and linking correctly. I added a way to [specify build dependencies](https://github.com/redox-os/cookbook/pull/39) for static libraries needed by C programs in the cookbook, which helps with git since it depends on several libraries.

Git still doesn't work yet.

# Python

I've created an initial [patch and recipe for python](https://github.com/redox-os/cookbook/pull/37), which now runs although it is not fully functional. This was partially because LLVM and Rust require Python to build, so it should be available for full self-hosting; although it looks like they require Python 2... but I makes a good screenshot anyway.

<img class="img-responsive" src="/img/screenshot/redox-python.png"/>
