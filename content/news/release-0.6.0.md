+++
title = "Redox OS 0.6.0"
author = "jackpot51"
date = "2020-12-24"
+++

**You can download the 0.6.0 images**
[**here**](https://gitlab.redox-os.org/redox-os/redox/-/jobs/31100/artifacts/browse/build/img/)

## Overview

A number of new projects have been introduced during this release cycle, and
many improvements have been landed. Very many bugs have been squashed. This list
is an extreme over-simplification of the thousands of commits done since the
last release. Hopefully, releases will happen more often so this is not always
the case.

- [rmm](https://gitlab.redox-os.org/redox-os/rmm/), a complete rewrite of
the kernel memory manager. This has eliminated kernel memory leaks, which became
quite an issue with the previous memory manager. Additionally, multi-core
support is far more stable.

- Much of the work of RSoC, sponsored by donations to Redox OS, has been
integrated into this new release. This includes work on ptrace, strace, gdb,
disk partitioning, logging, io_uring, and more.

- [relibc](https://gitlab.redox-os.org/redox-os/relibc/) has seen a large amount
of work, culminating in improvements for anything that depends on it (i.e.
everything in userspace).

- [pkgar](https://gitlab.redox-os.org/redox-os/pkgar/) is a new package format.
It is much faster to create and extract than the previous tar format.

- [cookbook](https://gitlab.redox-os.org/redox-os/cookbook/) has been redesigned
to support a new rust-based build system. This build system uses toml files
instead of shell scripts, and a number of packages have been ported to it.

- A large portion of this release cycle was spent struggling with a breaking
change in Rust nightlies, where the `asm` macro was redesigned. This change was
completed many months ago, but other issues kept us from a release.

<a href="/img/release/0.6.0.png"><img class="img-responsive" src="/img/release/0.6.0.png"/></a>

## Code Changes

Please use the following links to see many of the code changes since the last
release:

- [redox](https://gitlab.redox-os.org/redox-os/redox/compare/0.5.0...0.6.0)
- [cookbook](https://gitlab.redox-os.org/redox-os/cookbook/compare/0.5.0...0.6.0)
- [kernel](https://gitlab.redox-os.org/redox-os/kernel/compare/0.5.0...0.6.0)
- [relibc](https://gitlab.redox-os.org/redox-os/relibc/compare/0.5.0...0.6.0)
- Many other repositories have changed, but are not tracked in the main Redox
  repository. I encourage you to browse through our
  [projects on the Redox OS GitLab](https://gitlab.redox-os.org/redox-os)

## Discussion

- [Discourse](https://discourse.redox-os.org/t/redox-os-0-6-0-release/1414)
- [Hacker News](https://news.ycombinator.com/item?id=25533563)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/kjr932/redox_os_060/)
- [Reddit /r/rust](https://www.reddit.com/r/rust/comments/kjr949/redox_os_060/)
- [Patreon](https://www.patreon.com/posts/45415783)
- [Twitter](https://twitter.com/redox_os/status/1342291855896002560)
