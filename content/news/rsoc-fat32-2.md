+++
title = "RSoC: FAT32 Filesystem in Redox - 2"
author = "Deepak Sirone"
date = "2018-07-03T16:28:33+05:30"
+++

This is the second blog post about implementing a FAT32 filesystem in Redox. In the previous blog post the future work was detailed as follows:

#### TODO
* Add printing/debug capability to the stub [done]
* Add MBR/GPT parsing functionality to the stub [done]
* Begin work on the bootloader FAT32 module [done]
* Decide on things like where to load the module in memory, location of the kernel on disk etc. [TODO]
* Write a blog post on Redox's memory map and related stuff [TODO]

Initially the idea was to write a stub from the ground up and the reason behind this was to minimize the code size in order to have a fast boot. But it turned out to be very tedious and a lot of the work was already done in the Redox kernel. The fully fledged Redox kernel is about 8.6 MB in size. So the effort was on to strip down the Redox kernel to just support what was necessary to have disk reads.

Stripping down the kernel started with the serial console debug support. Qemu maps the serial console to stdio with the `-serial mon:stdio` option. The serial console code depended on the [arch](https://gitlab.redox-os.org/redox-os/kernel/tree/master/src/arch/x86_64) submodule and the [syscall](https://gitlab.redox-os.org/redox-os/syscall) crate and they were pulled in. After the arch submodule was pulled in I realized that all the subsystems initialized in the kstart function in [start.rs](https://gitlab.redox-os.org/redox-os/kernel/blob/master/src/arch/x86_64/start.rs#L51) would be useful at some point. So I began to get each of the subsystems working.

Getting the paging and the GDT initializations to work was straightforward. Setting up the IDT required that all the external interrupt handlers be disabled. Syscalls are completely disabled as the [INT 80h handler](https://github.com/deepaksirone/redox-loader/blob/master/src/arch/x86_64/interrupt/syscall.rs#L5) is mostly commented out.

With the base stub ready I started working on getting disk reads working. Initially the idea was to port the ahci driver such that it dosen't make use of Redox schemes. Again that meant a near complete rewrite of the driver and after discussions with [@jackpot51](https://github.com/jackpot51/) it was decided that the disks should be read after dropping to real mode, using BIOS interrupts.


To do this I referred to the OsDev article [here](https://forum.osdev.org/viewtopic.php?f=1&t=23125). The code should be loaded to a location which can be addressed in real mode i.e. a usable chunk of memory below the 1MB mark. The pages where the code is loaded should be both executable and writable as there is an interleaving of code and data. The stub adaptation of this code is [here](https://github.com/deepaksirone/redox-loader/blob/master/bootloader/x86_64/real.asm).

#### Roughly the code works as follows:
* Disable interrupts as we are going to alter the IDT pointer
* Save the stack pointer, the present IDTR, the GDTR and the stack arguments
* Load the address of a new GDT into the GDTR and the address of the real mode IDT into the IDTR
* The new GDT has a 16-bit protected mode code descriptor as well as the 64-bit Redox code descriptor
* Do a far return into 16-bit protected mode by executing a 64-bit `retfq` istruction
* In 16-bit protected mode, paging and protected mode is turned off and the stack is set to the real mode location
* All the segment registers are loaded with 0 so they can address from `0` to `0xffff` that is the [first segment](https://wiki.osdev.org/Real_Mode#Memory_Addressing)
* Do a far jmp to real mode code
* In real mode the disk interrupt `INT 13h` is called and is tested if the read worked
* After the operations in real mode are complete, paging and protected mode is enabled
* A far jmp is used to get back to kernel mode code
* The original GDT is restored and all the data segments are restored with their appropriate descriptors

The real mode is loaded at address `0xb000` during booting. The pages starting from `0x9000` and `0xa000` are used for the real mode stack. The pages starting from `0xc000` upto `0x70000` can be used to read in disk data. This gives a total of 100 pages(each page being 4096 bytes) worth of disk data per drop into real mode. After some more testing the code can be moved further towards the bootsector ending address of `0x7e00` giving more disk data per drop.

Before dropping to real mode from the stub, all the pages from `0x9000` upto `0x70000` are [identity mapped](https://wiki.osdev.org/Identity_Paging) and given write permission in the [init_real_mode](https://github.com/deepaksirone/redox-loader/blob/master/src/fs/mod.rs#L37) function. The function which drops to real mode can be found [here](https://github.com/deepaksirone/redox-loader/blob/master/src/fs/mod.rs#L69)

#### The drop works as follows:
* Cast the address `0xb000` as an extern "C" function using the `mem::transmute()` function
* [TODO] Compute the amount of data needed to be read in the drop
* Save all the registers in the stack and call the function
* [TODO] Return and copy all the data that is read into the supplied buffer from the pages mentioned above
* [TODO] Jump to step 2 till no more bytes are left to be read

The stub is currently about 250K in size. There is still a lot of code which can be eliminated to make the code even smaller. For some reason printing in real mode using `INT 10h` causes the far jmp into long mode to fail.

#### Future Work
* Write a clean read() and if possible a write() API
* Decide on a FAT32 implementation
* Write adapters/wrappers over the read/write API to support the FAT32 implementation
* Decide on where to put the kernel in the filesystem
* Read in the kernel and transfer execution to it
* Cleanup unnecessary code in the stub to make the code even smaller

#### Miscellaneous Stuff
* The MBR parsing code can be found [here](https://github.com/deepaksirone/redox-loader/blob/master/src/fs/mbr.rs)
* IMHO the Redox kernel is much easier to read and understand than the Linux kernel
* Build fixes for the kernel: [graphical_debug](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/91) , [version_fix](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/92)
