+++
title = "This Month in Redox - March 2024"
author = "Ribbon and Ron Williams"
date = "2024-03-30"
+++

This is our third update for 2024, March was a very exciting month.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Merch](https://redox-os.creator-spring.com/)

## Nonprofit Crypto Wallets

We added two new donation options for the Redox OS Nonprofit, Bitcoin and Ethereum.

This will give our donors more choices for supporting Redox development.

- [Bitcoin](https://bitcoin.org/) - 3NhKNtLMBg7xvU3AeEQBxKii1Qm72R6pWg
- [Ethereum](https://ethereum.org/en/) - 0x083e29156955A4c0f7eAA406e1167Bd1bE88933E

## Performance Improvements

4lDO2 replaced the Redox memory manager buddy allocator with a linked-list-based O(1) frame allocator that reduced the global memory allocation overhead from 35% to 0.9% ! while the overhead reduction at boot was 95% !

He also reduced the base system call overhead a lot, from 344 to 56 cycles on his CPU.

The program loading was improved to the point where it opens instantly (using a NVMe SSD).

We are very excited with the upcoming optimizations.

## Finishing The libredox Migration

The [libredox](https://crates.io/crates/libredox) library was [planned](https://www.redox-os.org/news/this-month-240131/#stable-abi) to offer a stable ABI on Redox, this required the migration of many system components and libraries.

4lDO2 finished the migration of all system components, only some Rust libraries are left.

This achievement will help us to speed up the development with breaking changes.

## Scheme Cancellation

4lDO2 implemented the scheme cancellation to mimic the POSIX signals behavior when closing file descriptors, it improves the compability with POSIX programs.

## RedoxFS

Jeremy fixed a serious bug on the records, they were being deallocated on read when the size of the record doesn't match the expectations.

Jeremy plans to implement safe wrappers for block allocation and deallocation that insures such things are very difficult to do.

Thankfully there are very few places doing raw block allocation and deallocation so it was easy to review them all.

## Drivers

bjorn3 removed more duplicated code and moved more drivers to device categories.

He also fixed some bugs.

## Boot Loader

bjorn3 implemented many changes to make our kernel "boot loader agnostic", it will allow Redox to be booted from GRUB or [Limine](https://limine-bootloader.org/).

## Build System

4lDO2 improved the recipe search algorithm a lot, now it takes around 1 second (using a NVMe SSD) to verify the location and sources of all recipes on the filesystem configuration.

## Programs

The Apache HTTP server was ported by Chocimier to the point where it host at localhost.

More programs compiled successfully, still need to be tested inside of Redox.

## Python Support

[RustPython](https://rustpython.github.io/) was enabled by default in the `desktop` and `dev` builds to offer Python 3.11+ support.

CPython is still work-in-progress.

## Documentation

Ribbon updated the [build system dependencies list](https://doc.redox-os.org/book/ch08-01-advanced-build.html#install-the-necessary-packages-and-emulators) for each supported operating system on the [bootstrap.sh](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/bootstrap.sh?ref_type=heads) script for manual configuration, now it's in pair with the script.

He added [references](https://doc.redox-os.org/book/ch09-08-references.html) to help with program porting, ideas and source code documentation.

He documented the method to port graphical programs to Orbital by using the [liborbital](https://gitlab.redox-os.org/redox-os/liborbital) library.

He also improved the porting documentation with more accurate information, fixed some things and did cleanup.

## Packages

Ribbon improved the [package policies](https://gitlab.redox-os.org/redox-os/cookbook#package-policy), the binary size limit was reduced from 100MB to 50MB to improve the RAM usage with static binaries.