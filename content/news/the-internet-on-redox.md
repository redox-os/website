+++
title = "The Internet on Redox"
author = "Jackpot51"
date = "2016-07-28-17:51:00-07:00"
+++

# The Internet on Redox

Recently there have been questions about Redox on [Github](https://github.com/redox-os/redox/issues/675) and [Reddit](https://www.reddit.com/r/Redox/comments/4t93qg/is_redox_oficially_dead/) about the state of the project. Commenters have stated that git commits are regular, but the project has not released any news. The truth is that we have been working very diligently to bring a huge update, and near a possible release milestone (even though we had no plans on doing so).

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

## 2. TTF and PNG support
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

## 3. Games
- added reblox
- pythoneer added texture mapping

#### pixelcannon running on Redox (at 150 FPS)

<img class="img-responsive" src="https://camo.githubusercontent.com/50f9b4f7be76c453538b0e03fa89220a853bafe0/687474703a2f2f692e696d6775722e636f6d2f734d776b6f6d632e676966"/>

#### reblox
<img class="img-responsive" src="https://chat.redox-os.org/api/v3/public/files/get/zoa4meoqjbbcdju9ghd7745phe/aduzjsjphirwtj6togzspotzko/6izutbttt3fhmqxrbihouu6i1c/3rj6xzmmeidpfe51r3hmubyjey/reblox.png?d=%7B%22filename%22%3A%223rj6xzmmeidpfe51r3hmubyjey%2Freblox.png%22%7D&h=%242a%2410%24YAFV%2FpZ.rQ0355RxnHVKhu3DjK7bBjQBVao3m1Bedxy847PeR4aX2"/>

## 4. Terminal ANSI
Lots of changes have been happening beneath the hood to ensure feature completeness and correctness in the Redox terminal
- [Ransid](https://github.com/redox-os/ransid) unifies the ANSI handling in both the kernel terminal and terminal emulator. It brings a lot of new features, color support, raw mode, bold, underlined, and inverted text.
- [Termion](https://github.com/ticki/termion) has been overhauled, and released. It supports many new features, and is the client counterpart to the ransid server. They are developed together, in addition with testing termion on Linux, to ensure feature completeness.
- [Liner](https://github.com/movingtomars/liner) is a new crate similar to readline that provides line editing on top of termion. It has history and auto-completion features.
- [Ion](https://github.com/redox-os/ion), our shell, has been updated to allow complete use of these crates, including auto completion and pretty colors.
- terminal bold support
- colorized default prompt for ion
- created `ransid`, a rust ansi driver. Support for all termion ansi codes has been added and both the kernel console and the terminal emulator use it for consistent ansi handling
- Underline and color invert support in ransid
- integrated liner with ion, allowing for line editing.  ransid was a critical piece in making the two terminals work with liner

#### Terminal with TTF fonts, obligatory `screendump`
<img class="img-responsive" src="http://i.imgur.com/YDCSuiz.png"/>

## 5. Handbook
We have started a handbook, which can be viewed [here](https://github.com/redox-os/handbook/blob/master/index.md), and made a terminal viewer for MD files

- MD terminal renderer `mdless`
- less and mdless can read from a pipe by reconnecting to the terminal (only works in kernel terminal until PTTY system)

#### `info` displaying the Redox handbook, using `mdless`
<img class="img-responsive" src="http://i.imgur.com/beTS2Dz.png"/>

## 6. Ralloc.
Thanks to [ralloc](https://github.com/redox-os/ralloc), we have been able to remove links to the C library (newlib) from our Rust standard library. Ralloc has been much more performant, as it minimizes expensive syscalls.
 - Fix deadlock in ralloc.
 - Make it a lot faster by metacircular allocations.
 - ralloc has microcaches.
 - lock reuse and more in ralloc.
 - debug mode for ralloc: double frees, memory leaks and more
 - security mode for ralloc: enhanced security, useful for security critical programs.
 - New static and debug utilities for ralloc
 - Thread local allocators and partial deallocation
 - ralloc has better logging, better perf, better debug checking, global OOM handler, and is the default.
 - ralloc TLS'n'stuff
 - Ralloc local/global pattern

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

## 9. Ports and Libc
- Nasm and ndisasm ported to Redox
- Can compile binutils now. In comes as, ar, ld, objdump, readelf, etc.
- Convert ports to use a patch system
- Removing libc from our libstd

## 10. There was probably more
Due to the amount of time since the last update, and the hundreds of commits since, it was hard to create a list about what had changed. My recommendation: [go to our github and star, watch, fork, pull, and/or build](https://github.com/redox-os/redox). Don't forget to checkout out [our organization page](https://github.com/redox-os), it contains most of our repositories.
