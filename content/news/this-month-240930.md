+++
title = "This Month in Redox - September 2024"
author = "Ribbon and Ron Williams"
date = "2024-09-30"
+++

September was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Kernel Improvements

- Andrey Turkin fixed some bugs
- The time precision of TSC was improved

## Scheme Improvements

4lDO2 implemented the `getdents` system call to simplify the scheme interface, it will speedup the scheme development and ease the bug fixing.

## USB Improvements

- Tim Finnegan improved our xHCI driver to be compliant with the standard.
- Tim Finnegan improved the documentation of the xHCI driver

## Relibc Improvements

- The `endian` function was implemented
- The `poll` system call was improved to follow more the Linux behavior

## RISC-V Port

Andrey Turkin started the RISC-V port and sent improvements to our toolchain.

## Programs

- The `dd` tool from uutils was fixed.
- Bendeguz Pisch fixed the Perl 5 recipe

## Build System Improvements

- The `path` data type was implemented on Cookbook to specify a local folder, it reduce the size of scripts

## Documentation Improvements

- The boot process documentation was improved
- Ribbon added the "Benchmarks" section on the "Performance" page of the book to explain how to do simple benchmarks on Redox, you can read the section on [this](https://doc.redox-os.org/book/ch09-10-performance.html#benchmarks) link
- Ribbon documented how to get the [CPU information](https://doc.redox-os.org/book/ch02-09-tasks.html#show-cpu-information) and [show the system log](https://doc.redox-os.org/book/ch02-09-tasks.html#show-the-system-log) in the [Tasks](https://doc.redox-os.org/book/ch02-09-tasks.html) page

## Art

Ribbon packaged the Ubuntu wallpapers from most recent versions and PopOS wallpapers.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

<!--
## Discussion

Here are some links to discussion about this news post:

- [Fosstodon @redox]()
- [Fosstodon @soller]()
- [Patreon]()
- [Phoronix]()
- [Reddit /r/redox]()
- [Reddit /r/rust]()
- [Twitter @redox_os]()
- [Twitter @jeremy_soller]()
-->
