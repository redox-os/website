+++
title = "Redox OS 0.7.0"
author = "jackpot51"
date = "2022-04-28"
+++

## Overview

A lot has changed since release [0.6.0](/news/release-0.6.0/)! First thing, it
is impossible to collect all the changes that happened since December 24, 2020
into one set of release notes, so this will focus on the highlights.

It was very important to me that this be a release targeting the foundations of
Redox OS. This includes, the bootloader, the filesystem, the package manager,
the kernel, the drivers, and much more. The focus was on enabling Redox OS to
boot on the widest set of hardware possible.

- [bootloader](https://gitlab.redox-os.org/redox-os/bootloader): The bootloader
was completely rewritten so that both the BIOS and UEFI versions share most of
the same code, and are both predominantly written in Rust. This has led to
greatly improved hardware support, and allowed for RedoxFS to be improved.

- [kernel](https://gitlab.redox-os.org/redox-os/kernel): A number of fixes and
new features were added to the kernel, and code was removed. Hardware support
was improved, as well as performance.
  - Preliminary support for aarch64 has been added
  - All paths are now required to be UTF-8, and the kernel enforces this
  - CPU specific variables use the GS register, with various improvements coming
    from this
  - All physical memory is mapped, recursive paging has been removed
  - ACPI AML code was moved to acpid, a new userspace daemon
  - Inline assembly rewritten to be stable with future compilers
  - Initfs moved to a new file, which significantly improves packaging
  - Many kernel issues have been fixed

- [redoxfs](https://gitlab.redox-os.org/redox-os/redoxfs): RedoxFS was rewritten
to be a Copy-on-Write filesystem, with transactional updates and signatures for
both metadata and data. This design greatly increases the reliability of
RedoxFS. Additionally, transparent encryption was added, using AES with hardware
acceleration if available. The bootloader now uses the same driver code as the
operating system does, and this allows the bootloader to unlock the filesystem,
allowing the kernel and initfs to be encrypted and hashed by the filesystem.

- [relibc](https://gitlab.redox-os.org/redox-os/relibc): Relibc has had constant
various changes that have enabled the porting of more software, as well as
fixing issues in many C programs and libraries. This work was incredibly varied
and hard to summarize.

- [rust](https://gitlab.redox-os.org/redox-os/rust): We now have a version of
rustc that can run on Redox OS! There is still work to be done to improve the
performance and to ensure cargo can run on Redox OS projects from inside Redox
OS.

I really wanted to go into more depth, but the time since the last release has
been pretty long and the changes wild and free (as in freedom). I hope to create
Redox OS releases more regularly, which will also decrease the changes that have
to be rediscovered in order to write the release notes.

## Images

Verify compressed images with sha256sum: https://static.redox-os.org/releases/0.7.0/SHA256SUM

Extract compressed images with gunzip before flashing to a USB drive, or loading
in a VM.

- **UEFI (recommended)**
  - **USB (recommended)**: https://static.redox-os.org/releases/0.7.0/redox_2022-04-28_570_livedisk-efi.bin.gz
  - SSD: https://static.redox-os.org/releases/0.7.0/redox_2022-04-28_570_harddrive-efi.bin.gz
- BIOS
  - **USB (recommended)**: https://static.redox-os.org/releases/0.7.0/redox_2022-04-28_570_livedisk.bin.gz
  - CD: https://static.redox-os.org/releases/0.7.0/redox_2022-04-28_570_livedisk.iso.gz
  - SSD: https://static.redox-os.org/releases/0.7.0/redox_2022-04-28_570_harddrive.bin.gz

## Discussion

TODO: discussion
