+++
title = "GSoC Project: Making Redox Self-hosting, Status Report 3"
author = "ids1024"
date = "2017-07-24T15:42:51-07:00"
+++

This is a continuation of [status report 1](/news/gsoc-self-hosting-1/) and [status report 2](/news/gsoc-self-hosting-2/).

# Git

Git is now more or less working in Redox. This primarily required fixing a variety of bugs and Posix incompatibilities, primarily in newlib and redoxfs. Newlib wasn't passing environmental variables on exec; I've [fixed that](https://github.com/redox-os/newlib/pull/45) although there are still some improvements to make in that area. Redoxfs wasn't matching Posix for permissions handing on [file creation](https://github.com/redox-os/redoxfs/pull/25) and [unlink](https://github.com/redox-os/redoxfs/pull/26). There was a small bug in [getcwd](https://github.com/redox-os/newlib/pull/47), and a kernel issue with [dup2](https://github.com/redox-os/kernel/pull/34) as well as [cloexec handling](https://github.com/redox-os/kernel/pull/37). For some reason the default SHA1 implementation in git wasn't working; I'm not sure why, but [overriding it](https://github.com/redox-os/cookbook/pull/51) addresses that for now. Redoxfs's [fcntl](https://github.com/redox-os/redoxfs/pull/24) function was misbehaving, so I fixed that. Newlib defined [`tv_nsec`](https://github.com/redox-os/newlib/pull/44) with the wrong type; that was hard to debug since, given that it was running on a little endian machine and happened to start as zero, it seemed to behave correctly in tests.

<img class="img-responsive" src="/img/screenshot/redox-git.png"/>

It seems to be working fairly well, if you can ignore the warnings about newlib functions that aren't properly implemented yet.

# Building C software

It was already possible to build simple things like Lua under Redox (since I ported gcc, make, and dash), but more complex software has some issues. I am currently struggling with getting autotools based builds to work on Redox (warning: trying to read and understand a ./configure script may cause mental illness). I've gotten a configure to run and generate a Makefile; the build doesn't complete successfully yet though. I've been working with GNU binutils specifically, but it should apply equally to other software using autotools.

<img class="img-responsive" src="/img/screenshot/redox-configure.png"/>

I've ported [gawk](https://github.com/redox-os/cookbook/pull/46) and [sed](https://github.com/redox-os/cookbook/pull/48) to Redox, as well as [GNU grep](https://github.com/redox-os/cookbook/pull/52). Autotools uses a [#! with a space](https://github.com/redox-os/kernel/pull/32), for some reason. I also addressed [a few issues](https://github.com/redox-os/dash/pull/2) in dash.

I've implemented [dirname](https://github.com/redox-os/coreutils/pull/166), added a ['-f' argument](https://github.com/redox-os/coreutils/pull/164) to rm, and fixed [directory support](https://github.com/redox-os/coreutils/pull/170). I [added fcntl](https://github.com/redox-os/newlib/pull/40) to newlib, and added a [-v argument](https://github.com/redox-os/extrautils/pull/24) and [-c argument](https://github.com/redox-os/extrautils/pull/25) to grep. I also added [octal support](https://github.com/redox-os/coreutils/pull/174) to tr. Cat with a - argument wasn't working due to an [arg-parser](https://github.com/redox-os/arg-parser/pull/1) issue.

I added [uname](https://github.com/redox-os/kernel/pull/39) to the sys scheme, and a [uname utility](https://github.com/redox-os/coreutils/pull/172) to coreutils.

I've been using expr from uutils (a Rust implementation of coreutils), since Redox's coreutils doesn't provide that currently. Redox should use uutils utilities for that and more; I've [patched chmod](https://github.com/uutils/coreutils/pull/1054) from uutils to run on Redox, and submitted a PR upstream. I intend to look into making Redox use portions of uutils by default where suitable.

I've looked into porting Perl (which would be needed to run autotools itself). Perl is awkward to cross compile though, and there are still some issues, so that isn't available yet. Perl requires ssh access a target machine to cross-compile (yes, really); but luckily a project called [perl-cross](http://arsv.github.io/perl-cross/) provides an alternate build system to address that. That much seems to work, but some other things need to be fixed.

# Upstreaming

I've upstreamed Redox support to [filetime](https://github.com/alexcrichton/filetime/pull/8) and [tar-rs](https://github.com/alexcrichton/tar-rs/pull/120), which are used in cargo and generally useful (redox's tar command uses tar-rs). Cmake-rs required a [small fix](https://github.com/alexcrichton/cmake-rs/pull/35) to target Redox.

# Other libc functions

I've implemented [`getpwnam` and `getpwid`](https://github.com/redox-os/newlib/pull/38), as well as [`utime`, `utimes`, and `futimes()`](https://github.com/redox-os/newlib/pull/39).
