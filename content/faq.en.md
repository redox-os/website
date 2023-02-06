+++
title = "FAQ"
+++

This page covers the most asked questions.



- [What is an Unix-like OS?](#what-is-an-unix-like-os)
- [How Redox is inspired by other systems?](#how-redox-is-inspired-by-other-systems)
- [What is a microkernel?](#what-is-a-microkernel)
- [Which devices Redox support?](#which-devices-redox-support)
- [How to build Redox?](#how-to-build-redox)
- [How to report bugs on Redox?](#how-to-report-bugs-on-redox)
- [How to contribute for Redox?](#how-to-contribute-for-redox)
- [I have a problem/question for Redox team](#i-have-a-problemquestion-for-redox-team)
- [How to update the sources and compile the changes?](#how-to-update-the-sources-and-compile-the-changes)
- [How to insert files inside Redox QEMU harddisk](#how-to-insert-files-inside-redox-qemu-harddisk)
- [How to troubleshoot your build in case of errors](#how-to-troubleshoot-your-build-in-case-of-errors)
- [How to launch QEMU without GUI](#how-to-launch-qemu-without-gui)



### What is an Unix-like OS?


Any OS with [Unix] design aspects, such as shell, "everything is a file" concept, multitasking and multiuser.


It's important to remind that Unix was the first modern multitasking system of the world, then any system used his design choices in some way.


- [Wikipedia article]

[Unix]: https://en.wikipedia.org/wiki/Unix
[Wikipedia article]: https://en.wikipedia.org/wiki/Unix-like

### How Redox is inspired by other systems?


[Plan 9] - This Bell Labs OS bring the concept of "everything is a file" to the highest level, doing all the system communication from the filesystem.


You just need to mount your software on some path and it have the required functionality, any software can work with this interface.


- [Drew DeVault explain the Plan 9]
- [How Redox use the Plan 9 design]


[Plan 9]: http://9p.io/plan9/index.html
[Drew DeVault explain the Plan 9]: https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html
[How Redox use the Plan 9 design]: https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html

[Minix] - the most influential Unix-like system with a microkernel, it has advanced features such as system modularity, [kernel panic] resistence, driver reincarnation, protection against bad drivers and secure interfaces for [process comunication].


Redox is largely inspired by Minix, it have basically the same features but written in Rust.

[Minix]: https://minix3.org/
[kernel panic]: https://en.wikipedia.org/wiki/Kernel_panic
[process comunication]: https://en.wikipedia.org/wiki/Inter-process_communication
[How Redox implement the Minix microkernel design]: https://doc.redox-os.org/book/ch04-01-microkernels.html


[BSD] - This Unix OS [family] did several improvements on Unix systems, the most notable is [BSD sockets], that brings network communication inside the Unix filesystem (before Plan 9).


- [FreeBSD documentation]


[family]: https://en.wikipedia.org/wiki/Research_Unix
[BSD sockets]: https://en.wikipedia.org/wiki/Berkeley_sockets
[FreeBSD documentation]: https://docs.freebsd.org/en/books/developers-handbook/sockets/

[Linux] - the most advanced monolithic kernel of the world and biggest open-source project of the world, it brings several improvements/optimizations to Unix-like systems.


Redox tries to implement the Linux performance improvements in a microkernel design.


[Linux]: https://www.kernel.org/

### What is a microkernel?


- [Redox Book explanation]

[Redox Book explanation]: https://doc.redox-os.org/book/ch04-01-microkernels.html


### Which devices Redox support?


#### CPU


- x86_64/AMD64 (Intel/AMD)
- x86/i686 (Intel/AMD, incomplete)
- ARM64 (WIP, incomplete)


#### Internet


- Intel ethernet
- Realtek ethernet


(Wi-Fi soon)


#### Sound


- Intel chipsets
- Realtek chipsets


#### Video


- VGA (BIOS)
- GOP (UEFI)
- [LLVMpipe] (Software Rendering)


(Intel/AMD and others in the future)


[LLVMpipe]: https://docs.mesa3d.org/drivers/llvmpipe.html

#### Storage


- IDE (PATA)
- AHCI (SATA)
- NVMe

(USB soon)


#### Input


- PS/2 keyboards
- PS/2 mouse
- PS/2 touchpad


### How to build Redox?


Currently Redox has a bootstrap script Debian/Ubuntu/Pop OS! with unmaintained support for other distributions.


We are moving to use Podman as our main compilation method, actually it's mature and compile like the raw script.


(Podman avoid environment problems on compilation)


- [Redox Book Guide] (Debian/Ubuntu/Pop OS!)
- [Redox Book Advanced Guide] (Debian/Ubuntu/Pop OS!)
- [Redox Book Podman Guide]
- [Redox Book Podman Advanced Guide]

[Redox Book Guide]: https://doc.redox-os.org/book/ch02-05-building-redox.html
[Redox Book Advanced Guide]: https://doc.redox-os.org/book/ch08-01-advanced-build.html
[Redox Book Podman Guide]: https://doc.redox-os.org/book/ch02-06-podman-build.html
[Redox Book Podman Advanced Guide]: https://doc.redox-os.org/book/ch08-02-advanced-podman-build.html


### How to report bugs on Redox?


- [Redox Book Bug Report Guide]

[Redox Book Bug Report Guide]: https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html


### How to contribute for Redox?


- [GitLab Guide]
- [Redox Book Contribution Guide]
- [How to make pull requests properly]

[GitLab Guide]: https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md
[Redox Book Contribution Guide]: https://doc.redox-os.org/book/ch10-02-low-hanging-fruit.html
[How to make pull requests properly]: https://doc.redox-os.org/book/ch12-04-creating-proper-pull-requests.html


### I have a problem/question for Redox team


- Read all the [Redox book] to see if it answer your questions/fix your problem.
- If the book is not enough for you, make your question/say your problem on [Redox Support] or [Redox Dev] rooms on Matrix.

[Redox book]: https://doc.redox-os.org/book/
[Redox Support]: https://matrix.to/#/#redox-support:matrix.org
[Redox Dev]: https://matrix.to/#/#redox-dev:matrix.org


### How to update the sources and compile the changes?


- [Book Rebuild Guide]

[Book Rebuild Guide]: https://doc.redox-os.org/book/ch09-02-coding-and-building.html#the-full-rebuild-cycle


### How to insert files inside Redox QEMU harddisk


- [Book QEMU Guide]

[Book QEMU Guide]: https://doc.redox-os.org/book/ch09-02-coding-and-building.html#patch-an-image


### How to troubleshoot your build in case of errors


- [Book Troubleshooting Guide]
- [GitLab Troubleshooting Guide]

[Book Troubleshooting Guide]: https://doc.redox-os.org/book/ch08-05-troubleshooting.html
[GitLab Troubleshooting Guide]: https://gitlab.redox-os.org/redox-os/redox#help-redox-wont-compile


### How to launch QEMU without GUI


- Run `make qemu vga=no`


QEMU terminal will looks like a container/chroot.
