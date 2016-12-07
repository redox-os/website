+++
title = "This Week in Redox 14"
author = "Ticki"
date = "2016-04-30T19:47:46+01:00"
groups = ["news"]
+++

This is the 14th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

Whew, what a long week... ;P

*(edited by Ticki)*

# PSA
If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# What's new in Redox?

- [@jackpot51](https://github.com/jackpot51) has replaced the old filesystem with a much faster and better one, supporting memory caching, complete write support, persistent (on-disk) file creation, and efficient (O(1)) renaming. This will act as a temporary replacement for the WIP ZFS support.

- [@ticki](https://github.com/ticki) has added [a new syscall](https://github.com/redox-os/redox/pull/608), `SYS_SUPERVISE` with the purpose of allowing processes to control, sandbox, and supervise their child processes. This acts as a simpler, and yet more expressive, replacement for ptrace. In addition to this new syscall, a new flag to `SYS_CLONE` was added, together with a `spawn_supervised` method on `Command`.

- [@jackpot51](https://github.com/jackpot51) has made `std:net` (almost) on par with the upstream libstd.

- [@ticki](https://github.com/ticki) has completed [ralloc](https://github.com/redox-os/ralloc), the efficient memory allocator of Redox. While it is complete, not all bugs are fixed yet. Supports metacircular reallocation, block queue, efficient inplace reallocation, cache efficient lookups, and memory management debugging.

- [@ticki](https://github.com/ticki) has improved the infrastructure slightly, by creating a new handy [a library](https://github.com/ticki/mars) for making Mattermost/Slack bots, along with [a Rust Playground bot built on it](https://github.com/redox-os/playbot) (à la #rust's `playbot`) and [a few other bots](https://github.com/redox-os/bots).

- [@jackpot51](https://github.com/jackpot51) has moved the filesystem into userspace!

- [@ticki](https://github.com/ticki) has created a new Rust-based build system, [cake](https://github.com/ticki/cake), which will replace Make for building Redox in the near future.

- [@nounoursheureux](https://github.com/nounoursheureux) has added [a better kernel logging system](https://github.com/redox-os/redox/pull/627). This will soon be generalized to userspace logs as well.

- [@wesleywiser](https://github.com/wesleywiser) has added [multiple buffers](https://github.com/redox-os/sodium/pull/40) for Sodium.

- [@jackpot51](https://github.com/jackpot51) is working on DHCP/DNS support.

- [@nounoursheureux](https://github.com/nounoursheureux) has added process-local environment variables.

- [@stratact](https://github.com/stratact) has added menu support to OrbTK.

- [@jackpot51](https://github.com/jackpot51) added a simple initial implementation of `wget`.

- [@ticki](https://github.com/ticki) has added `dem`, a small commandline-based Democracy clone, to `games-for-redox` for fun.

- The kernel now supports basic UDP networking.

- [@nounoursheureux](https://github.com/nounoursheureux) has added `export` to Ion.

- [@mmstick](https://github.com/mmstick) has improved the [implementation of `cat`](https://github.com/redox-os/coreutils/pull/54).

- [@jackpot51](https://github.com/jackpot51) and [@ticki](https://github.com/ticki) have written manpages for most of the tools. The simple [docgen tool](https://github.com/redox-os/redox/commit/4857985d3c4c70421f384624655145ee15980095) is used for the generation of documentation, which is placed in `/refs`.

- ... and many small things.

# Pictures

Redox running on Thinkpad T-420:

<img class="img-responsive" src="http://www.redox-os.org/img/hardware/thinkpad-t420.png"/>

Redox running on ASUS eeePC 900:

<img class="img-responsive" src="http://www.redox-os.org/img/hardware/asus-eepc-900.png"/>

Redox running on Panasonic Toughbook CF-18:

<img class="img-responsive" src="http://www.redox-os.org/img/hardware/panasonic-toughbook-cf18.png"/>

# Handy links

1. [The Glorious Book](https://doc.redox-os.org/book/)
2. [The Holiest Forum](https://discourse.redox-os.org/)
3. [The Shiny ISOs](https://static.redox-os.org/)
4. [Redocs](http://www.redox-os.org/docs/)
5. [Fancy GitHub organization](https://github.com/redox-os)
6. [Our Holy Grail of a Website](http://www.redox-os.org/)
7. [Our Nice Code of Conduct](http://www.redox-os.org/coc/)
8. [The Extreme Screenshots](http://www.redox-os.org/screens/)

# What's next?

- Use ralloc by default.
- Switch to Cake.
- Writable ZFS.
- Extend the book.

# New contributors

Since the list of contributors are growing too fast, we'll now only list the new contributors. This might change in the future.

Sorted in alphabetical order.

- craftytrickster 🎂
- dalance  🎂
- nilset 🎂
- tpitale 🎂
- wesleywiser 🎂

If I missed something, feel free to contact me (Ticki) or send a PR to [Redox website](https://github.com/redox-os/website).
