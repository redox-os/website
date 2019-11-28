+++
title = "Real hardware breakthroughs, and focusing on rustc"
author = "jackpot51"
date = "2019-11-27T21:00:00-07:00"
+++

System76 Galago Pro (galp3-c) running Redox OS.
<img class="img-responsive" src="/img/hardware/system76-galp3-c.jpg"/>

---

After the addition of the
[NVMe driver a couple months ago](https://gitlab.redox-os.org/redox-os/drivers/tree/master/nvmed),
I have been running Redox OS permanently (from an install to disk) on a
[System76 Galago Pro (galp3-c)](https://system76.com/laptops/galago),
with
[System76 Open Firmware](https://github.com/system76/firmware-open)
as well as the un-announced, in-development, GPLv3
[System76 EC firmware](https://github.com/system76/ec)
. This particular hardware has full support for the
[keyboard](https://gitlab.redox-os.org/redox-os/drivers/tree/master/ps2d),
[touchpad](https://gitlab.redox-os.org/redox-os/drivers/tree/master/ps2d),
[storage](https://gitlab.redox-os.org/redox-os/drivers/tree/master/nvmed),
and
[ethernet](https://gitlab.redox-os.org/redox-os/drivers/tree/master/rtl8168d),
making it easy to use with Redox.

This particular machine has had a
[debugging port](https://twitter.com/system76/status/1191768795846713344)
soldered on, using the unused CEC pin of the HDMI port as RX, and then a custom
HDMI to USB serial cable for closed-chassis debug. Now I can get serial output
from the board, using the Intel LPSS UART on the PCH, which is supported in
[this commit to the kernel](https://gitlab.redox-os.org/redox-os/kernel/commit/90b113f0470b22d33ff088d2ec27a07b51e71d36),
and
[an earlier commit fixing memory-mapped serial ports](https://gitlab.redox-os.org/redox-os/kernel/commit/c27a6c149b918a50516876fcfdb103ee30c5137c).
This has allowed for easier debugging of the kernel and drivers.

I am fairly satisfied with how things are going, and will continue to focus on
running a permanently installed Redox system. My work on real hardware has
improved
[drivers](https://gitlab.redox-os.org/redox-os/drivers/commit/c7f02e5e2141c0dbf07bc82fd40ee7d6cad95229)
and
[services](https://gitlab.redox-os.org/redox-os/redoxfs/commit/3191d7d18202d77b67fca6c437abe6d89d249a61),
added
[HiDPI support](https://gitlab.redox-os.org/redox-os/orbutils/commit/e2f940488e961dbbe54051c16d2006efbb7c9d9d)
to a
[number of applications](https://gitlab.redox-os.org/redox-os/orbterm/commit/f851dca2938116e58da90a233e9c98edcc1374e2),
and spawned the creation of new projects such as
[pkgar](https://gitlab.redox-os.org/redox-os/pkgar)
to make it easier to
[install Redox from a live disk](https://gitlab.redox-os.org/redox-os/installer/commit/5762840f792c4bf1c6b0de18b3674e91830577e1).

It has also become easier than ever to cross-compile for Redox, with the
[redoxer tool](https://gitlab.redox-os.org/redox-os/redoxer)
which can build, run, and test using commands similar to cargo. It automatically
manages a Redox toolchain and can run executables and tests for Redox inside of
a container on demand.


However, a long-standing issue (*the* longstanding issue?) of Redox OS has been
this: To allow the compilation of Rust binaries **on** Redox OS.

Attempts have been made in the past to address this issue. In 2017, Redox OS
participated in the Google Summer of Code. Through the
[excellent work done by ids1024](https://www.redox-os.org/news/gsoc-self-hosting-final/),
Redox OS was able to get close to self-hosting. This work was then amplified by
the creation of a C library written in Rust,
[relibc](https://gitlab.redox-os.org/redox-os/relibc). Subsequent work by
[over 40 contributors](https://gitlab.redox-os.org/redox-os/relibc/-/graphs/master)
has led to significant POSIX C library compatibility, and a significant increase
in the
[number of available packages](https://gitlab.redox-os.org/redox-os/cookbook/tree/master/recipes).

Work was later done to
[convert Redox OS to a different Rust target family](https://github.com/rust-lang/rust/pull/60547),
finally unifying Rust support for Redox OS with that of other Unixen. Finally,
Redox specific support code could largely be eliminated from codebases. This led
to a great number of Rust crates suddenly gaining Redox OS support.

It seemed that as though the dream of self-hosting would soon be reality. After
many heartbreaking hours (days, weeks, months?) of compiling rustc, then finding
some error requiring more work in relibc, I was finally able to compile a
statically linked rustc - only to discover that rustc is no longer capable of
running statically linked!

Then began work on relibc's
[ld.so](https://github.com/redox-os/relibc/tree/master/src/ld_so),
which provides dynamic linking support for executables. Tragically, the work to
support dynamic linkage in Rust for Redox OS defaulted everything to dynamic
linkage, which took some time to sort out properly. This is where work was
halted on porting rustc to Redox OS.

Building Redox OS on Redox OS has always been one of the highest priorities of
the project. Rustc seems to be only a few months of work away, after which I can
begin to improve the system while running on it permanently, at least on one
machine. With Redox OS being a microkernel, it is possible that even the driver
level could be recompiled and respawned without downtime, making it incredibly
fast to develop for. With this in place, I would work more efficiently on
porting more software and tackling more hardware support issues, such as
filling in the USB stack and adding graphics drivers.

But, more importantly than what I will be able to do, is the contributions by
others that will be unlocked by having a fully self-hosted, microkernel
Operating System written in Rust, Redox OS.
