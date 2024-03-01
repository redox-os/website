+++
title = "This Month in Redox - February 2024"
author = "Ribbon and Ron Williams"
date = "2024-02-29"
+++

This is our second update for 2024, and for February, we continue to march ahead.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Merch](https://redox-os.creator-spring.com/)

## Massive Performance Improvement

Jeremy Soller improved the file read/write performance a lot with the implementation of records in RedoxFS.

Using `dd` to measure the impact of an increased block size (`dd bs=n`),
Jeremy tested copying from `/dev/zero` to `/dev/null` as a benchmark for a RAM-based scheme,
and compared that against copying from the raw disk scheme, and from the disk scheme via the RedoxFS file system scheme.
The following results were observed.

|  Block size  | `/dev/zero`  |   raw disk   |    RedoxFS   |
| ------------ | ------------ | ------------ | ------------ |
|     4KiB     |  110 MiB/s   |   22 MiB/s   |   6 MiB/s    |
|     4Mib     |   1.6 GiB/s  |  600 MiB/s   |  170* MiB/s  |
*After the addition of records described below.

(Some results omitted)

In order to separate the size of RedoxFS read/write operations from the disk block size,
the concept of "records" was introduced, where the record size is a power of two multiple of the block size.

For large files, a record size of 128KiB was chosen, as this gives a good balance between sequential access and random access speeds.

As an anecdotal example, command start-up time for the first run of a large program is about 3 times faster than previously.

4lDO2 discovered a related optimization opportunity.

In the Rust standard library, the default buffer size for most built-in read/write APIs, including `std::io::copy`, is 8KiB.

If you copy a 30 MiB file with an 8 KiB buffer size, the process will take 3840 scheme call roundtrips to complete.
This could take a long time if there are other processes competing for CPU time in the scheduler.
This is because Redox doesn't support direct context switching yet, and `dd` doesn't use parallelized or batched I/O.

Redox hasn't yet specialized `std::fs::copy`, which uutils's `cp` program uses directly.
Linux and MacOSX have an optimization (fclonefileat/clone_file_range) that allows a larger buffer size,
which can be optimized more aggressively.

We plan to implement this in `relibc` in the near future.

The record size optimization is an example of low-hanging fruit for performance improvements.
We still have many other improvements planned,
and will do our best to keep you up to date.

## Kernel

bjorn3 fixed an assert statement bug after a switch from `RWLock` to `RWSpinLock`, the kernel now runs fine with debug assertions enabled. The context switching code is also slightly less unsafe.

He also did a cleanup and deduplication of x86 and x86_64 code, so that much more code is common between the two CPU types.

## Network Driver Cleanup

bjorn3 refactored parts of the network drivers, and improved handling of MAC addresses.

## Relibc

Darley continues to improve relibc, and has added a pure Rust implementation of cryptography functions.

## Path Format Migration

The migration to UNIX-format paths is progressing, with better support for programs using the legacy path format.

- RedoxFS now recognizes both old and new format paths
- Conversion between old and new format has been improved
- Relibc support for old and new path formats has been improved

Next on our list is to update the Rust libraries that are still using the legacy path format,
switching to UNIX-format-only if possible, or with support for both old and new format if needed.

## Orbital

The winit support for client side decorations, hidden windows, maximization, and updating flags after window creation was implemented in Orbital.

## Wine

[Boxedwine](https://github.com/danoon2/Boxedwine) is being ported!

The goal of Boxedwine is to make Wine work in a wide range of systems by emulating the Linux kernel and CPU inside an SDL2 program, as SDL2 supports many interfaces, operating systems and hardware.

Currently Boxedwine only supports 16/32-bit Windows binaries and Wine versions from 1.8 until 5.0 (because of Linux-specific interfaces on newer Wine versions).

The current blocker of our port is a crash at runtime.

## QEMU

We implemented an option to use the NVMe interface of QEMU to test and debug Redox faster, it can be called with the `make qemu_nvme` command.

## Build System Configuration

We added an option to confirm all questions without user intervention and more packages to build recipes on the build system bootstrap script.

## WIP Recipes

Ribbon packaged more programs as always, from Rust-written emulators to tools, notable WIP ports are [Audacity](https://www.audacityteam.org/), [Celestia](https://celestiaproject.space/), [KiCad](https://www.kicad.org/) and [Neothesia](https://github.com/PolyMeilex/Neothesia).

You can monitor the software ports additions and improvements [here](https://gitlab.redox-os.org/redox-os/cookbook/-/commits/master).

He also moved the WIP recipes into categories, like the working recipes.

He added upcoming new categories:

- `finance` (Finance programs, like personal finance management, market information and crypto wallets)
- `math` (Mathematics programs, like calculators)
- `science` (Science programs, like data analyzers)

## Contribution Guide

The [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md) document was updated with a better guide to contribute and new goals.

We added a goal to improve the Orbital UI and UX to match with the COSMIC Desktop while we don't have GPU rendering yet.

## Documentation

The porting documentation in the book was improved with better context and organization of sections.

## Other Improvements

- ARM64 fixes
- Calc additions and improvements
- Ion shell improvements
- Improvements for ARM device drivers
- Documentation improvements (mostly porting documentation)

## Looking Forward

Everything keeps rolling along, but there's still lots to do.
If you would like to participate,
join us on [Matrix](https://matrix.to/#/#redox-join:matrix.org).

Watch for our next update at the end of March. See you then!

