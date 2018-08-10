+++
title = "RSoC: Implementing a FAT32 Filesystem in Redox"
author = "Deepak Sirone"
date = "2018-05-29T15:27:18+05:30"
+++

This is a blog post about the work which I have done so far in implementing a FAT32 filesystem in Redox. Currently the Redox [bootloader](https://github.com/redox-os/bootloader) as well as the userspace filesystem [daemon](https://github.com/redox-os/redoxfs/tree/master/src/bin) supports only RedoxFS.

#### Goals identified
* Modify the bootloader using Rust to support loading the kernel from commonly supported filesystems
* Write a userspace daemon which can mount FAT32 filesystems

Currently the Redox bootloader is purely written in assembly. The bootloader can either be assembled along with the filesystem image or a standalone kernel image. The `-D FILESYSTEM` and `-D KERNEL` options during assembly time take care of this. Extending the bootloader to read a filesystem is rather tedious using assembly and so it was decided that Rust is the way to go.

The first week was mainly spent in exploring the bootloader code.

#### Roughly the bootloader boots as follows:
* The first 512 bytes of the harddrive(bootsector) gets loaded into physical address `0x7c00` by the BIOS and execution jumps there
* The bootsector code loads the rest of the startup code starting from the disk using repeated BIOS interrupt `13h` calls and jumps to it
* The code then jumps to either the RedoxFS module(if `-D FILESYSTEM` option is used) or to another module (if the `-D KERNEL` option is used) to load the kernel into memory
* The CPU is switched to [unreal mode](https://wiki.osdev.org/Unreal_Mode) in order to access the full 32-bit address space before loading the kernel, as the CPU is still in [real mode](https://wiki.osdev.org/Real_Mode) and the kernel is bigger than a megabyte
* After the kernel is loaded starting `0x100000`, the rest of the initialization proceeds including setting the page tables, initializing the display, setting the GDT and finally jumping to the kernel in [long mode](https://wiki.osdev.org/Long_Mode)

The RedoxFS filesystem is an [extent based filesystem](https://en.wikipedia.org/wiki/Extent_(file_systems)) and the bootloader parses the root inode to figure out where the kernel lives on the disk. It then loads each extent in succession.

#### The following workflow was decided to modify the bootloader:
* Develop a 64-bit stub in Rust which parses the MBR/GPT and loads a module for the specific filesystem where the kernel resides
* The module loads the kernel into memory and jumps to it

Currently I am using the `-D KERNEL` to insert the stub into the bootloader image. It is based on an old version of Philip Opperman's blog OS which has been hacked to mimic the Redox kernel's linker addresses as well as page size. The stub repo which I am currently using can be found [here](https://github.com/deepaksirone/redox-loader). qemu does not boot the disk when using the `-machine q35` flag if the size of the disk image is too small. So the image is padded with about 8MB worth of zeroes, aligned to 512 bytes. Currently the stub does not support printing functions and hence the only was to verify that it is running is by using qemu's gdb debug target.

#### Future Work
* Add printing/debug capability to the stub
* Add MBR/GPT parsing functionality to the stub 
* Begin work on the bootloader FAT32 module
* Decide on things like where to load the module in memory, location of the kernel on disk etc.
* Write a blog post on Redox's memory map and related stuff
