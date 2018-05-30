+++
title = "RSoC: Porting Redox to AArch64 - 0x01"
author = "wizofe"
date = "2018-05-30T18:33:21+00:00"
+++

# Introductory session

...and here we go! :floppy_disk: All excited. A first calendar entry to describe my attempt on ARM64 support in Redox OS. 
Specifically, looking into the [Raspberry Pi2/3(B)/3+](https://web.stanford.edu/class/cs140e/docs/BCM2837-ARM-Peripherals.pdf) (all of them having a Cortex-A53 ARMv8 64-bit microprocessor, although for all my experiments I am going to use the Raspberry Pi 3(B)).

Yesterday, I had [my](https://github.com/wizofe) first meeting in Cambridge with [@microcolonel](https://github.com/raw-bin)! Very very inspiring, got many ideas and motivation. He reminded me that the first and most important thing I fell in love with Open Source is its people :) 

* * * 

## Discussion Points

Everything started with a personal introduction, background and motivation reasons that we both participate in this project. It's very important to note that we don't want it to be a one-off thing but definitely the start of a longer support and experimentation with OS support and ARM.

* * *

### Redox boot flow on AArch64

Some of the points discussed:

	* boot
	* debug
	* MMU setup
	* TLS
	* syscalls

The current work by @microcolonel, is happening on the realms of `qemu-system-aarch64` platform. But what should I need to put my attention, when porting to the Rpi3? Here are some importants bits:
	
	[ ] Typical AArch64 exception level transitions post reset: EL3 -> EL2 -> EL1
    [x] Setting up a buildable u-boot (preferably the u-boot mainline) for RPi3 
	[ ]	Setting up a BOOTP/TFTP server on the same subnet as the RPi3
	[ ] Packaging the redox kernel binary as a (fake) Linux binary using u-boot's mkimage tool
	[ ] Obtaining an FDT blob for the RPi3 (Linux's DTB can be used for this). In hindsight, u-boot might be able to provide this too (u-boot's own generated )
	[ ] Serving the packaged redox kernel binary as well as the FDT blob to u-boot via BOOT/TFTP
	[x] Statically expressing a suitable PL011 UART's physical base address within Redox as an initial debug console
	
Note: I've already completed (as shown) two important steps, which I am going to describe on my next blog post (to keep you excited ;-) 

* * *

### Challenges with recursive paging for AArch64

@microcolonel is very fond of recursive paging. He seems to succesfully to make it work on qemu and it seems that it may be possible in sillicon as well. This is for 48-bit Virtual Addresses with 4 levels of translation. 

As AArch64 has separate descriptors for page tables and pages which means that in order for recursive paging to work there must not be any disjoint bitfields in the two descriptor types. This is the case today but it is not clear if this will remain in the future. 

The problem is that if recursive paging doesn't work on the physical implementation that may time much longer than expected to port for the RPi3. Another point, is that as opposed to x86_64, AArch6 has a separate translation scheme for user-space and kernel space. So while x86_64 has a single cr3 register containing the base address of the trnslation tables, AArch64 has two registers, ttbr_el0 for user-space and ttbr_el1 for the kernel. In this realm, there has been @microcolonel's work to extend the paging schemes in Redox to cope with this.

* * *
### TLS, Syscalls and Device Drivers

The Redox kernel's reliance on Rust's #[thread_local] attribute results in llvm generating references to the tpidr_el0 register. On AArch64 tpidr_el0 is supposed to contain the user-space TLS region's base address. This is separate from tpidr_el1 which is supposted to contain the kernel-space TLS region's base address.

To fix this, @microcolonel has modified llvm such that the use of a 'kernel' code-model and an aarch64-unknown-redox target results in the emission og tpidr_el1. TLS support is underway at present.

* * * 

### Device drivers and FDT


For the device driver operation using fdt it's very important to note the following:

	* It will be important to create a registry of all the device drivers present
	* All device drivers will need to implement a trait that requires publishing of a device-tree compatible string property
	* As such, init code can then match the compatible string with the tree of nodes in the device tree in order to match drivers to their respective data elements in the tree

* * *

### Availability of @microcolonel's code base

As he still expects his employer's open source contribution approval there are still many steps to be done to port Redox OS.

The structure of the code to be published was also discussed. At present @microcolonel's work is a set of patches to the following repositories:

	* Top level redox checkout (build glue etc)
	* Redox kernel submodule (core AArch64 support)
	* Redox syscall's submodule (AArch64 syscall support)
	* Redox's rust submodule (TLS support, redox toolchain triplet support)

Possible ways to manage the publishing of this code were also discussed. One way is to create AArch64 branches for all of the above and push them out to the redox github. This is TBD with **@jackpot51**.

* * *
 
### Feature parity with x86_64

It's very important to stay aligned with the current x86_64 port and for that reason the following work is important to be underways:

	* Syscall implementation
	* Context switch support
	* kmain -> init invocation
	* Filesystem with apps
	* Framebuffer driver
	* Multi-core support
	* (...) (to be filled with a whole list of the current x86_64 features)

*Attaining feature parity would be the first concrete milestone for the AArch64 port as a whole.*

* * *

### My next steps

As a result of the discussion and mentoring, the following steps were decided for the future:

	[x] Get to a point where u-boot can be built from source and installed on the RPi3
	[x] Figure out the UART base and verify that the UART's data register can be written to from the u-boot CLI (which should provoke an immediate appearance of characters on the CLI)
	[ ] Setup a flow using BOOTP/DHCP and u-boot that allows Redox kernels and DTBs to be sent to u-boot over ethernet
	[ ] Once microcolonel's code has been published, start by hacking in the UART base address and a DTB blob
	[ ] Aim to reach kstart with println output up and running.

### Next steps for @microcolonel

	[ ] Complete TLS support
	[ ] Get Board and CPU identification + display going via DTB probes
	[ ] Verify kstart entry on silicon. microcolonel means to use the Lemaker Hikey620 Linaro 96Board for this. It's a Cortex-A53 based board just like the RPi3. The idea is to quickly check if recursive paging on silicon is OK. This can make wizofe's like a lot rosier. :)
	[ ] Make the UART base address retrieval dynamic via DTB (as opposed to the static fixed address used at present which isn't portable)
	[ ] Get init invocation from kmain going
	[ ] Implement necessary device driver identification traits and registry
	[ ] Implement GIC and timer drivers (Red Flag for RPi3 here, as it has no implementation of GIC but rather a closed propietary approach)
	[ ] Focus on user-land bring-up

* * *

### Future work

If we could pick up the most important plan for the future of Redox that would be a roadmap!

Some of the critical items that should be discussed:

	* Suitable tests and Continuous integration (perhaps with Jenkins)
	* A pathway to run Linux applications under Redox. FreeBSD's linuxulator (system call translator) would be one way to do this. This would make complex applications such as firefox etc usable until native solutions become available in the longer term.
	* Self hosted development. Having redox bootable on a couple of popular laptops with a focus on featurefulness will go a great way in terms of perception. System76 dual boot with Pop_OS! ? ;)
	* A strategy to support hardware assisted virtualization.

* * *

Thanks for reading! Hope to see you next time here. For any questions feel free to email me: code -@- wizofe dot uk. Many many insights are taken from @microcolonel's very detailed summary; The following part of the blog is my own experimentation and exploration on the discussed matters! 

* * * 
