+++
title = "The Internet on Redox"
author = "Jackpot51 & Ticki"
date = "2016-07-28T17:51:00-07:00"
+++

Recently there have been questions about Redox on [Github](https://github.com/redox-os/redox/issues/675) and [Reddit](https://www.reddit.com/r/Redox/comments/4t93qg/is_redox_oficially_dead/) about the state of the project. Commenters have stated that git commits are regular, but the project has not released any news. The truth is that we have been working very diligently to bring a huge update, and near a possible release milestone (even though we had no plans on doing so).

So, instead of the regular "This Week in Redox", we bring you a summer edition, featuring internet support, a memory allocator, and loads of loads of more.

Working autonomously, with no direction, we stumbled on a massive list of changes that make Redox much, much more interesting.

If you would like, [go to our github and star, watch, fork, pull, and/or build](https://github.com/redox-os/redox). Don't forget to checkout out [our organization page](https://github.com/redox-os), it contains most of our repositories.

## 1. Internet support

Major changes to the Redox network stack allow for routing to the internet and back:

- DHCP using `dhcpd`
- DNS integrated into `std::net::lookup_host`
- HTTP using `wget [path]`
- IRC using `irc [nickname]`
 - This means we can kinda code in rust from redox via #rust's playbot ;-)
- added basic netcat command, `nc`

#### Images downloaded from [here](http://static.redox-os.org) using `wget`
<img class="img-responsive" src="https://chat.redox-os.org/api/v3/public/files/get/zoa4meoqjbbcdju9ghd7745phe/aduzjsjphirwtj6togzspotzko/6izutbttt3fhmqxrbihouu6i1c/umrx67rhwifrirabmjznweozaa/works.png?d=%7B%22filename%22%3A%22umrx67rhwifrirabmjznweozaa%2Fworks.png%22%7D&h=%242a%2410%24Qo9E5tp5RaJFUrLdB3jweedFDlroJTjs4KoK16DdkKRL1unXEX0Ke"/>

#### IRC client
<img class="img-responsive" src="http://i.imgur.com/98vCnlu.png"/>

## 2. Ralloc.

[Ralloc](https://github.com/redox-os/ralloc) is a brand-new memory allocator,
which is now the default in Redox. Ralloc features high security and many
debugging utilities, along with a good performance (although, it is to be
improved).

We have been able to remove links to the C library (newlib) from our Rust
standard library. Ralloc has been much more performant, as it minimizes
expensive syscalls.

Ralloc is quite memory efficient, due to using arbitrarily sized blocks in the
bookkeeping.

- Custom out-of-memory handlers

- Thread-specific OOM handlers.

- Debug check: double free

- Debug check: memory leaks.

- Partial deallocation.

- Separate deallocation

- Static checking

- Lock reuse

- Platform agnostic

- Local allocators

- Safe SBRK

- Advanced logging

- Arbitrary alignments

Here's an example log of the inner workings of ralloc:

```
|   : BRK'ing a block of size, 80, and alignment 8.            (at bookkeeper.rs:458)
|   : Pushing 0x5578dacb2000[0x0] and 0x5578dacb2050[0xffb8].  (at bookkeeper.rs:490)
|x  : Freeing 0x1[0x0].                                        (at bookkeeper.rs:409)
x|  : BRK'ing a block of size, 4, and alignment 1.             (at bookkeeper.rs:458)
x|  : Pushing 0x5578dacc2008[0x0] and 0x5578dacc200c[0xfffd].  (at bookkeeper.rs:490)
x|x : Reallocating 0x5578dacc2008[0x4] to size 8 with align 1. (at bookkeeper.rs:272)
x|x : Inplace reallocating 0x5578dacc2008[0x4] to size 8.      (at bookkeeper.rs:354)
_|x : Freeing 0x5578dacb2058[0xffb0].                          (at bookkeeper.rs:409)
_|x : Inserting block 0x5578dacb2058[0xffb0].                  (at bookkeeper.rs:635)
```

## 3. TTF and PNG support
Using [rusttype](https://github.com/dylanede/rusttype), we are able to display TTF fonts in pure Rust without using FreeType!

- orbfont, a TTF renderer for orbital
- character map for viewing TTF fonts
- ttf in terminal
- add start menu
- PNG and BMP backgrounds and cursors are now supported, use the /etc/orbital.conf file to configure the background path
- Viewer can display PNGs
- Viewer will show alpha as a grid like the other image viewers

#### Start menu and character map
<img class="img-responsive" src="http://i.imgur.com/E28ATd4.png"/>

## 4. Games
- added reblox
- pythoneer added texture mapping

#### pixelcannon running on Redox (at 150 FPS)

<img class="img-responsive" src="https://camo.githubusercontent.com/50f9b4f7be76c453538b0e03fa89220a853bafe0/687474703a2f2f692e696d6775722e636f6d2f734d776b6f6d632e676966"/>

#### reblox
<img class="img-responsive" src="https://chat.redox-os.org/api/v3/public/files/get/zoa4meoqjbbcdju9ghd7745phe/aduzjsjphirwtj6togzspotzko/6izutbttt3fhmqxrbihouu6i1c/3rj6xzmmeidpfe51r3hmubyjey/reblox.png?d=%7B%22filename%22%3A%223rj6xzmmeidpfe51r3hmubyjey%2Freblox.png%22%7D&h=%242a%2410%24YAFV%2FpZ.rQ0355RxnHVKhu3DjK7bBjQBVao3m1Bedxy847PeR4aX2"/>

## 5. Terminal ANSI
Lots of changes have been happening beneath the hood to ensure feature completeness and correctness in the Redox terminal

- [Ransid](https://github.com/redox-os/ransid) unifies the ANSI handling in both the kernel terminal and terminal emulator. It brings a lot of new features, color support, raw mode, bold, underlined, and inverted text.
- [Termion](https://github.com/ticki/termion) has been overhauled, and released. It supports many new features, and is the client counterpart to the ransid server. They are developed together, in addition with testing termion on Linux, to ensure feature completeness.
- [Liner](https://github.com/movingtomars/liner) is a new crate similar to readline that provides line editing on top of termion. It has history and auto-completion features.
- [Ion](https://github.com/redox-os/ion), our shell, has been updated to allow complete use of these crates, including auto completion and pretty colors.
- terminal bold support
- colorized default prompt for ion

#### Terminal with TTF fonts, obligatory `screenfetch`
<img class="img-responsive" src="http://i.imgur.com/YDCSuiz.png"/>

## 6. Handbook
We have started a handbook, which can be viewed [here](https://github.com/redox-os/handbook/blob/master/index.md), and made a terminal viewer for MD files

- MD terminal renderer `mdless`
- less and mdless can read from a pipe by reconnecting to the terminal (only works in kernel terminal until PTTY system)

#### `info` displaying the Redox handbook, using `mdless`
<img class="img-responsive" src="http://i.imgur.com/beTS2Dz.png"/>

## 7. RedoxFS
Our filesystem, [RedoxFS](https://github.com/redox-os/redoxfs), can be used on Linux using FUSE and has been tested thoroughly, builds are done by mounting a new filesystem using the FUSE driver.

- improve redoxfs performance
- fixed write support in redoxfs

## 8. Kernel
- Kernel security - check all pointers - https://github.com/redox-os/redox/commit/3f53e5f3cdb94354061576e9509e38cd2021b3e7
- removed allocation from syslog, it is now a ring buffer like in Linux and BSD
- many debugs go into syslog, so they can be reviewed using less syslog:
- magical ansi terminal size detection when using vga=no `\x1B[s\x1B[9999;9999f\x1B[6n\x1B[u`
- add simple `reboot` command
- fixed udp scheme
- huge networking fixes
- ability to configure ip, subnet, router, and dns netcfg:
- ability to use router to get to the big internet
- Removing some allocations.

## 9. Ports and Libc
- Nasm and ndisasm ported to Redox
- Can compile binutils now. In comes as, ar, ld, objdump, readelf, etc.
- Convert ports to use a patch system
- Removing libc from our libstd

## What's next?

- ANSI Sodium (text editor) through Termion.
- Major overhaul to ralloc, with the focus on performance.
- More networking utilities (including a text-based web "browser")
- Improvements to `mdless`.
- Improvements to RANSI.
- Magnet — the package manager.

## Thanks to

This list is likely incomplete, please contact Jackpot or Ticki for updating it.

- Jackpot51
- Ticki
- nilset
- mmstick
- stratact
- ca1ek

and many more...

## 10. There was probably more

Due to the amount of time since the last update, and the hundreds of commits since, it was hard to create a list about what had changed. My recommendation: [go to our github and star, watch, fork, pull, and/or build](https://github.com/redox-os/redox). Don't forget to checkout out [our organization page](https://github.com/redox-os), it contains most of our repositories.
