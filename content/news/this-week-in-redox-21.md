+++
title = "This Week in Redox 21"
author = "goyox86"
date = "2017-06-08T13:16:00+00:00"
+++

This is the 21st post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by goyox86)*

# PSA
If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# What's new in Redox?

## Kernel

- [@ids1024](https://github.com/ids1024) Updated to the new std::ptr API.  Details [here](https://github.com/redox-os/kernel/pull/21).
- [@jackpot51](https://github.com/jackpot51) Added some fixes on process syscalls to avoid substract overflows. Details [here](https://github.com/redox-os/kernel/commit/8d899258424f121df196ef38f2d3988e59339828).

## Ion

[Ion](https://github.com/redox-os/ion) is a shell for UNIX platforms, and is the default shell in Redox. It is still a work in progress, but much of the core functionality is complete. It is also currently significantly faster than Bash, and even Dash, making it the fastest system shell to date.

-  [@mmstick](https://github.com/mmstick) Fixed a panic when trying to create a pipe without a command. Details [here](https://github.com/redox-os/ion/commit/fe47660701d05544616da656aedd97e28e1fb0ca).
- [@mmstick](https://github.com/mmstick) Implemented a filename escaper. Details [here](https://github.com/redox-os/ion/commit/29497ada7fcf656c30da89d9689769163913fdf1).

- [@iori-yja](https://github.com/iori-yja) Changed the shebang of `run_examples.sh` to make the script to be ran on both Linux or BSD. Details [here](https://github.com/redox-os/ion/pull/290).

-  [@huntergoldstein](https://github.com/huntergoldstein) Fixed the parsing of statements with multiple escaped characters. Details [here](https://github.com/redox-os/ion/pull/292).

## Drivers

- [@TheSchemm](https://github.com/TheSchemm) Added the initial version of the Intel HD Audio driver!  Details [here](https://github.com/redox-os/drivers/pull/13).

## Coreutils

- [@ids1024](https://github.com/ids1024) Implement the `stat` command. Details [here](https://github.com/redox-os/coreutils/pull/153).

## TFS

[TFS](github.com/redox-os/tfs) is a modular, fast, and feature rich next-gen file system, employing modern techniques for high performance, high space efficiency, and high scalability.

Two weeks ago TFS made its another appearance in [Reddit](https://www.reddit.com/r/programming/comments/6clnp9/tfs_nextgeneration_file_system_written_in_rust/) catching a lot of attention!

- [@ticki](https://github.com/ticki) Fixed tests in the `concurrent` crate.  Details [here](https://github.com/redox-os/tfs/commit/25f663973923b48cd2913f68ae898973e4b92bb9)
- [@ticki](https://github.com/ticki) Removed a sneaky bug from `parking_lot` usage in TLS dtors. Details [here](https://github.com/redox-os/tfs/commit/348a091e6c7d7ad191e7cfc2b7c4df6192b88b5a).
- [@ticki](https://github.com/ticki) Allowed usage of the `concurrent` API in TLS dtors. Details [here](https://github.com/redox-os/tfs/commit/709a13313e47aaa2394e6b4fecd88f012ff00bfe).
- [@ticki](https://github.com/ticki) Continued replacing the usage of `crossbeam` with the homemade `concurrent` in the `tm` crate. Details [here](https://github.com/redox-os/tfs/commit/b84a6e2fd1030a27e4dbf5cce842354d73246f4f).
- [@ticki](https://github.com/ticki) Moved the STM from the `tm`  into the `concurrent` crate in a module called `sync`. Details [here](https://github.com/redox-os/tfs/commit/d8ff5dd20ccb6463712db05d7c3a4809e2d24c1f).
- [@ticki](https://github.com/ticki) Renamed the `concurrent` to`conc`. Details [here](https://github.com/redox-os/tfs/commit/aef4e42fcf5b18c44bff5569ea8d8fc281bdda75).
- [@ticki](https://github.com/ticki) Renamed `conc::Option` to `conc::Atomic` and added `_raw` versions of CAS methods it. Details [here](https://github.com/redox-os/tfs/commit/fab3e084508024dd3f96c7240e82186201175d9f) and [here](https://github.com/redox-os/tfs/commit/eb4a97cdb284b2d2387f60cc18a387e234f46b4a).
- [@ticki](https://github.com/ticki) Moved the specification to it's own folder and set to use Latin Modern on it along swtching to XeTeX. Details [here](https://github.com/redox-os/tfs/commit/0e64173024ef476351437c1da5a767804117801c), [here](https://github.com/redox-os/tfs/commit/5cf09b5783aab5299cbaac04b62d83e1d96dda25) and [here](https://github.com/redox-os/tfs/commit/31c3229600c362a51e28f2e505e9c58a7f49212f) respectively.
-  [@ticki](https://github.com/ticki) Added Treiber stacks to `conc`. Details [here](https://github.com/redox-os/tfs/commit/492717a7d2274d5c5020f0a80342ba0f365ccc67) and [here](https://github.com/redox-os/tfs/commit/66744682df2c1c5a6e4e13e877d6b629836659df).

## Package Management

Work on this topic continues specially on the [cookbook](https://github.com/redox-os/cookbook) the collection of package recipes of Redox.

- [@iori-yja](https://github.com/iori-yja) Changed the shebang of shell scripts to make them able to be ran on both Linux or BSD. Details [here](https://github.com/redox-os/cookbook/pull/12).
- [@ids1024](https://github.com/ids1024) Added cookbook recipes for gcc, binutils and newlib. Details [here](https://github.com/redox-os/cookbook/pull/11).
- [@jackpot51](https://github.com/jackpot51) Added a recipe for GNU make to the cookbook. Details [here](https://github.com/redox-os/cookbook/commit/c8a927f64364c78d799ff7bcbc64d7f23ad7c35d).

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

- Aistis Raulinaitis 🎂
- Geordon Worley 🎂
- Hunter Goldstein 🎂
- ioriveur 🎂
- Iori Yoneji 🎂
- Oliver Jan Krylow 🎂
- Will 🎂

If I missed something, feel free to contact me (goyox86) or send a PR to [Redox website](https://github.com/redox-os/website).
