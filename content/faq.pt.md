+++
title = "FAQ"
+++

This page covers the most asked questions.

### What is an Unix-like OS?

Any OS with [Unix] design aspects, such as shell, "everything is a file" concept, multitasking and multiuser.

It's important to remind that Unix was the first modern multitasking system of the world, then any system used his design choices in some way.

- [Wikipedia article]

[Unix]: https://en.wikipedia.org/wiki/Unix
[Wikipedia article]: https://en.wikipedia.org/wiki/Unix-like

### How Redox is inspired on other systems?

[Plan 9] - maybe the most perfect operating system of the history, bring the concept of "everything is a file" to it's highest level, doing all the system communication from the filesystem.

You just need to mount your software on some path and it have the required functionality, any software can work with this interface.

- [Drew DeVault explain the Plan 9]
- [How Redox use the Plan 9 design]

[Plan 9]: http://9p.io/plan9/index.html
[Drew DeVault explain the Plan 9]: https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html
[How Redox use the Plan 9 design]: https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html

[Minix] - the most important Unix-like system with a microkernel, it has advanced features such as system modularity, [kernel panic] resistence, driver reincarnation, protection against bad drivers and secure interfaces for [process comunication].

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

### Which processor architectures Redox support?

The most maintained/updated is x86_64 (AMD64), the second is x86 and ARM64 is incomplete yet.
