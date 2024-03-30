+++
title = "This Month in Redox - March 2024"
author = "Ribbon and Ron Williams"
date = "2024-03-30"
+++

March was a very exciting month for Redox! Here's all the latest news.

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

4lDO2 replaced the Redox memory manager buddy allocator with a linked-list-based O(1) frame allocator that reduced the global memory allocation overhead from 35% to 0.9%, while the overhead reduction at boot was 95%!
Read all about it in his excellent post "[Significant performance and correctness improvements to the kernel](/news/kernel-10)".

He also reduced the base system call overhead a lot, from 344 to 116 cycles on x86_64!

The program loading was improved to the point where it opens instantly (using a NVMe SSD).

We are very excited about these and other upcoming optimizations!

## Finishing The libredox Migration

The [libredox](https://crates.io/crates/libredox) library is part of our strategy
to provide a [stable ABI](https://www.redox-os.org/news/this-month-240131/#stable-abi) on Redox.
`libredox` greatly reduces the impact of breaking changes on Redox,
and allows us to make improvements to core functionality more rapidly.
This required the migration of many system components and libraries from using the less-stable `redox_syscall` crate to `libredox`.

4lDO2 finished the migration of all system components, leaving only a few Rust crates to be updated.

## Scheme Cancellation

4lDO2 implemented scheme request cancellation on some system components to mimic the POSIX signals behavior and fix a bug when closing file descriptors. This is one of several steps we are taking to make our signal implementation more compatible with POSIX signals.

## RedoxFS

Jeremy fixed a bug on his recent `records` optimization on RedoxFS.
Records were being deallocated on read when the size of the record didn't match expectations.
This has been corrected.

Jeremy plans to implement safe wrappers for block allocation and deallocation that insures such things are very difficult to do in future.

Thankfully there are very few places doing raw block allocation and deallocation so it was easy to review them all.

## Drivers

bjorn3 removed more duplicated code and moved more drivers to device categories.

He also fixed some driver bugs during the cleanup.

## Boot Loader

bjorn3 implemented many changes to make our kernel "boot loader agnostic". It will allow Redox to be booted from GRUB or [Limine](https://limine-bootloader.org/).

## Build System

4lDO2 improved the build system's recipe search algorithm a lot, now it takes around 1 second (using a NVMe SSD) to verify the location and sources of all recipes (packages) on the filesystem configuration.

## Web Server

The Apache HTTP server was ported by Chocimier to the point where it can host pages using localhost.
There is still work to be done, but this is an exciting first step for the Redox Server edition!

## Packages and Porting

We are continuing to add programs to our package build system. Several more programs compiled successfully, but still need to be tested on Redox.
With hundreds of programs packaged and ready for testing, we have lots of work ahead of us, but we continue to make good progress.

## Python Support

[RustPython](https://rustpython.github.io/) was enabled by default in the `desktop` and `dev` builds to offer Python 3.11+ support.
We still need to work on the support libraries and we need to do testing to see how complete our Python support is.

CPython is still work-in-progress.

## Documentation

Ribbon made several improvements to the book:

- added to the [references](https://doc.redox-os.org/book/ch09-08-references.html) list, including additions to the Program Porting, Ideas and Source Code sections.
- documented the method to port graphical programs to Orbital by using the [liborbital](https://gitlab.redox-os.org/redox-os/liborbital) library.
- updated the [build system dependencies list](https://doc.redox-os.org/book/ch08-01-advanced-build.html#install-the-necessary-packages-and-emulators) for each supported operating system in the [bootstrap.sh](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/bootstrap.sh?ref_type=heads) script for manual configuration, to make sure the documentation matches the script.
- improved the porting documentation with more accurate information, fixed some things and did cleanup.

## Packages

Ribbon improved the [package policies](https://gitlab.redox-os.org/redox-os/cookbook#package-policy) documentation, the binary size limit was reduced from 100MB to 50MB to improve the RAM usage with static binaries.

## Looking Forward

We are happy to see some progress on Redox as a web server,
and we are very excited with the recent performance and stability improvements.
If you would like to help out, join us on [Matrix](https://matrix.to/#/#redox-join:matrix.org).

Look for the next update at the end of April!
