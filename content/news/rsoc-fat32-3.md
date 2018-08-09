+++
title = "RSoC: FAT32 Filesystem in Redox - 3"
author = "Deepak Sirone"
date = "2018-08-09T22:39:51+05:30"
+++

This is the third blog post about implementing a FAT32 filesystem in Redox.

#### The previous blog posts in this series are
* [RSoC: FAT32 Filesystem in Redox-1](https://www.redox-os.org/news/rsoc-fat32-1/)
* [RSoC: FAT32 Filesystem in Redox-2](https://www.redox-os.org/news/rsoc-fat32-2/)

In the previous blog post the future work was detailed as follows:

#### TODO
* Write a clean read() and if possible a write() API [done]
* Decide on a FAT32 implementation [done]
* Write adapters/wrappers over the read/write API to support the FAT32 implementation [done]
* Decide on where to put the kernel in the filesystem [done]
* Read in the kernel and transfer execution to it [done]
* Cleanup unnecessary code in the stub to make the code even smaller [done]

The previous blog post discusses how raw disk reads were implemented in the loader stub. The next step was to implement a clean read API which can be used by different filesystem libraries in order to read their respective filesystems. Since the raw reads from the BIOS interrupt had a granularity in terms of sectors(each sector being 512 bytes), the reads had to be translated in order to provide byte level granularity. The `clone_from_slice` function ensures that a direct call to `memcopy` is not required. The refined read function is [here](https://github.com/deepaksirone/redox-loader/blob/master/src/fs/mod.rs#L69).

The next step was to write code to parse [MBR](https://en.wikipedia.org/wiki/Master_boot_record) partitions. This was relatively straightforward and the code can be found [here](https://github.com/deepaksirone/redox-loader/blob/master/src/fs/disk.rs).

Moving further, the next step was to decide on a FAT32 implementation. Rust provides [read](https://doc.rust-lang.org/std/io/trait.Read.html), [write](https://doc.rust-lang.org/std/io/trait.Write.html) and [seek](https://doc.rust-lang.org/std/io/trait.Seek.html) traits which when implemented for a struct, allows the read, write and seek functions to be called on it. So implementing the three traits for the `MBR` partition was the next goal. Unfortunately the loader is written with no support for the standard library. Instead it is wrtten using a baremetal library called [libcore](https://doc.rust-lang.org/beta/core/) which supports the traits only through the [core_io_crate](https://github.com/jethrogb/rust-core_io). The `core_io` crate requires a specific version of the Rust compiler to compile which breaks the rest of the loader. At first we considered [fatfs](https://github.com/rafalh/rust-fatfs) but it turned out that it depended on the `core_io` crate. Finally we decided on [fatrs](https://gitlab.com/susurrus/fat-rs) as it had it's own trait called a `StorageDevice` which did not depend on any `core_io` traits. The implementation of the trait for the `Partition` struct can be found [here](https://github.com/deepaksirone/redox-loader/blob/master/src/fs/fat32/mod.rs). The `fatrs` library did have a few bugs of it's own which was fixed in this [fork](https://gitlab.com/deepaksirone/fat-rs).

With the FAT32 implementation running smoothly, the final lap had begun which was to load the kernel at address `0x100000` which is the first megabyte of memory, setup the environment including the page tables for the kernel and then transfer control to it. The problem was that the loader stub was currently loaded at the exact same location and the page tables could not be setup exactly as the kernel would have liked because some pages were used by the loader. The fix was inspired by a discussion with [@jackpot51](https://github.com/jackpot51) where we decided that we should initially copy the kernel at address `0x400000` and then drop into real mode as in the previous blog post, to copy the kernel at `0x100000`. Real mode does not have paging and hence all the page tables could be setup exactly like the original [asm bootloader](url_here) does. After this the real mode code jumps to the kernel and begins execution. A primary change which was made to the [real mode code](https://github.com/deepaksirone/redox-loader/blob/master/bootloader/x86_64/kernel_copy.asm) was the introduction of [unreal mode](https://wiki.osdev.org/Unreal_Mode) which ensures that data can be both read and written above the 1MB mark.   

Currently the kernel is loaded from a FAT32 partition and the rest of userspace i.e. init and friends are still loaded from a RedoxFS partition.


#### Future Work
* Write a FAT32 userspace daemon which can access a FAT32 partition from userspace
* Add code to read the UUID from a RedoxFS parition
* Do some more code cleanup
