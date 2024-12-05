+++
title = "This Month in Redox - December 2024"
author = "Ribbon and Ron Williams"
date = "2024-12-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. (Month) was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Self-Hosting Improvements

Anhad Sigh successfully compiled GNU Bash with dynamic linking, this is one part of the goals to allow more programs to work on Redox and dynamically link relibc to speed up the Redox development.

## Relibc Improvements

- Josh Megnauth fixed a memory overflow
- Josh Megnauth implemented missing structs on `netinet.h` function group
- Josh Megnauth implemented the `stdnoreturn.h` function group
- plimkilde added TODOs for the remaining POSIX functions

## Netowrking Improvements

- Steffen Butzer fixed some bugs in the implementation of the Address Resolution Protocol
- Guillaume Gielly implemented the `ifconfig` command for network management on the Redox network stack

## Programs

- Josh Megnauth fixed and updated Lua
- Josh Megnauth fixed GLib
- Josh Megnauth added a demo for OpenJazz
- Amir Ghazanfari improved the process to quit the Sodium text editor

## Build System Improvements

- Andrey Turkin fixed the recipe operations on the installer after `pkgutils` removal

## Documentation Improvements

- Jack Lin fixed broken links on the Cookbook README

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
- [X/Twitter @redox_os]()
- [X/Twitter @jeremy_soller]()
- [Hacker News]()
-->
