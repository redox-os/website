+++
title = "This Week in Redox 9"
author = "Ticki"
date = "2015-12-21T21:01:00+02:00"
+++

This is the 9th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- [@jackpot51](https://github.com/jackpot51) and [@stratact](https://github.co/stratact) are working on OrbTK, a tool kit for UI widgets, layouts, and other stuff. Works on Linux, too!

- [@domtheporcupine](https://github.com/DomThePorcupine) have written an awesome bootstrapping script making it possible to get started with hacking on Redox in just a few minutes.

- [@ticki](https://github.com/ticki) have begun writing `orbital-sdl2`, a emulation layer for running Orbital-based applications outside Redox.

- [@polymetric1](https://github.com/polymetric1) has improved a `CONTRIBUTING.md` as a quick but extensive guide for new contributors.

- [@ticki](https://github.com/ticki) has written a new buffer data structure for Sodium, the [insert buzzword here] editor. This makes Sodium a lot faster.

- [@skylerberg](https://github.com/skylerberg) have written a lexer and a parser for `ion` (the shell).

- [@jackpot51](https://github.com/jackpot51) have ported `ion` (shell) to Linux.

- [@ticki](https://github.com/ticki) has refactored the libraries to do less reexports in the root, make less use of pointer sized integers, and a bunch of other changes.

- [@jackpot51](https://github.com/jackpot51) and [@ticki](https://github.co/ticki) have moved a lot of parts to seperate repositories, making them submodules to `redox-os/redox`.

- [@fischmax](https://github.com/fischmax) have seperated alt and alt-gr (now alt-gr does not yield alt anymore).

- [@ticki](https://github.com) is working on compression for Osmium (archive format).

- [@jackpot51](https://github.com/jackpot51) is working on a pipe syscall.

- And lots of other small changes.


# What does it look like?

Changes have not affected the appereance a lot:

![start](https://raw.githubusercontent.com/redox-os/redox/bbe19afced47cd4d84088deb4aa40c64b93f0e73/img/screenshots/start.png)


# What's next?

- Fix bugs in Sodium introduced by the new buffering mechanism
- Get the piping syscall to work
- Improve multithreading
- Get full support for orbital on Linux systems
- Make ZFS writable

# Contributors

(sorted like `Contributors` section on Github)

Whew! 7 new contributors.

- jackpot51
- ticki
- stratact
- tedsta
- k0pernicus
- polymetric1
- esell
- lazyoxen
- domtheporcupine
- achanda
- nobbz
- stryan
- ambaxter
- fischmax
- mgattozzi
- maximilianmeister
- nounoursheureux
- bheesham
- layered-esell
- skylerberg
- hauleth
- shadowcreator
- coder543
- n3mes1s
- flashyoshi
- remram44
- flosse
