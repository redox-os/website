+++
title = "This Week in Redox 12"
author = "Ticki"
date = "2016-03-11T21:24:55+01:00"
+++

This is the 12th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

This week have been dedicated to documentation, for the great points [/u/rozaliev brought up](https://www.reddit.com/r/rust/comments/481e09/redox_vs_linux_in_10_years/d0gz5v3). This means we have a lot new documentation initiatives...

*(edited by Ticki)*

# PSA
If you have  questions, ideas, or are curious about Redox, you are recommended to join `#redox` on `irc.mozilla.org`, and chat with us!

# What's new in Redox?

- [@ticki](https://github.com/ticki) is working on a Rust-style book, [The Redox Operating-System](http://www.redox-os.org/book/book/). **This is currently the single, most complete source of information about Redox**. If you're interested in Redox, you should definitely go check it out.

- [@jackpot51](https://github.com/jackpot51) has added a brand-new [Discourse forum](https://discourse.redox-os.org). He also did a full redesign of the website (as you might notice on this very page).

- [@ticki](https://github.com/ticki) has [completely rewritten](https://github.com/redox-os/redox/pull/552) `libredox`'s IO and process, making `libredox` almost 100% compatible with `libstd`. [@jackpot51](https://github.com/jackpot51) have also done some extensive changes, to `path` and `fs`. Now you can easily port your Rust program to Redox!

- [@ticki](https://github.com/ticki) made [URLs have three different internal representations](https://github.com/redox-os/redox/pull/522), yielding a modest improvement in performance.

- [@jackpot51](https://github.com/jackpot51) has ported `ed` to Redox.

- [@ticki](https://github.com/ticki) has improved ZFS's error handling and the handling of SPA.

- [@nounoursheureux](https://github.com/nounoursheureux) [has added](https://github.com/redox-os/extrautils/pull/3) `grep` (currently not supporting regular expressions) to [extrautils](https://github.com/redox-os/extrautils).

- [@jackpot51](https://github.com/jackpot51) has added hash bang (`#!`) support.

- [@ticki](https://github.com/ticki) has added `cksum` (DJB2 checksums), `cur` (simple pager), `rem` (reminders and countdowns), `mtxt` (stream editor) to [extrautils](https://github.com/redox-os/extrautils).

- [@ticki](https://github.com/ticki) is working on a formal proof of the correctness of the kernel.

- [@lazyoxen](https://github.com/lazyoxen) [has added](https://github.com/redox-os/extrautils/pull/2) `calc`, a simple calculator, to [extrautils](https://github.com/redox-os/extrautils).

- [@ticki](https://github.com/ticki) has added raw mode support and [libterm](https://github.com/ticki/libterm) support for the terminal.

- [@nounoursheureux](https://github.com/nounoursheureux) has improved the `let` command, and added the initial implementation of shell functions.

- [@stratact](https://github.com/stratact) have improved `wc` by better tracking of the various counts.

- [@jackpot51](https://github.com/jackpot51) has redesign our temporary file system, `redoxfs`.

- [@ticki](https://github.com/ticki) has made all the coreutils performing much better.

- [@alicemaz](https://github.com/alicemaz) has written an `ed` clone in Rust, which runs on Redox too!

- [@jackpot51](https://github.com/jackpot51) has improved the ANSI terminal support.

- [@ticki](https://github.com/ticki) has added extensive documentation to many primitives in the kernel.

- [@skylerberg](https://github.com/skylerberg) and [@jackpot51](https://github.com/skylerberg) has added piping and redirection to [Ion](https://github.com/redox-os/ion).

- [@jackpot51](https://github.com/jackpot51) has improved the performance of [OrbTK](https://github.com/redox-os/orbtk).

- [@jackpot51](https://github.com/jackpot51) has added an "application selector" for the launcher.

- [@stratact](https://github.com/stratact) refactored scheme's path, by migrating away from manual index-tracking of slices by using iterators/combinators which resulted in cleaner/easier to read code.

- [@ticki](https://github.com/ticki) has written a tool for rendering man pages.

- [@jackpot51](https://github.com/jackpot51) has added file metadata to libredox. This makes `du` a lot faster.

- [@mmstick](https://github.com/mmstick) has `source`, control variables, and `ionrc` loading for [Ion](https://github.com/redox-os/ion).

- [@ticki](https://github.com/ticki) is working on a port of SDL2 to Redox.

- We now got [ISOs](https://static.redox-os.org/) ready to download and install!


# Handy links

1. [The Glorious Book](http://www.redox-os.org/book/book/)
2. [The Holiest Forum](https://discourse.redox-os.org/)
3. [The Shiny ISOs](https://static.redox-os.org/)
4. [Redocs](https://doc.redox-os.org/kernel/)
5. [Fancy GitHub organization](https://github.com/redox-os)
6. [Our Holy Grail of a Website](http://www.redox-os.org/)

# What's next?

- Games, games, games.
- Writable ZFS (I'm looking at you, Ticki).
- Complete the book.
- Refine the syscall interface.
- Formal verification.

# New contributors

Since the list of contributors are growing too fast, we'll now only list the new contributors. This might change in the future.

Sorted in alphabetical order.

- lundbrik 🎂
- mmstick 🎂
- reddraggone9 🎂
- steveklabnik 🎂

If I missed something, feel free to contact me (Ticki) or send a PR to [Redox website](https://github.com/redox-os/website).
