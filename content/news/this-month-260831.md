+++
title = "This Month in Redox - August 2026"
author = "Ribbon and Ron Williams"
date = "2026-08-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. August was a very exciting month for Redox! Here's all the latest news.

Sorry for the delayed report, we are very busy.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## ARM64 Multi-core Support

lbecher implemented it and did some fixes, more testing need to be done to determine the performance improvements.

## Ring Buffer Communication For More Parallelism

After some months of work Ibuki Omatsu and Anhad Singh implemented a ring buffer communication API equivalent to io_uring on Linux to improve performance, with guidance from 4lDO2 and help from Wildan Mubarok to fix bugs.

This work improve the general system performance and I/O performance by 10x!!

- redox-ring benchmark

<img src="/img/screenshot/ring-bench.png" class="img-responsive" alt=""/>

- In-memory filesystem (ramfs) benchmark

<img src="/img/screenshot/ring-ramfs-bench.png" class="img-responsive" alt=""/>

- redox-ring-dyn benchmark

<img src="/img/screenshot/ring-dyn-bench.png" class="img-responsive" alt=""/>

## Significant Native Compilation Performance Improvement and OOM Fixes

After months of Wildan Mubarok investigation on gradual GCC compilation performance degradation, he fixed a kernel memory leak that caused the `os-test` test suite compilation time in GCC (on QEMU) take from 2 hours up to 10 hours and OOM errors during months, once fixed the compilation time was reduced from 10 hours to around 30 minutes.

The leak was worsened by the lack of page fault-based memory allocation.

## NUMA Support

Aadarsh (aka EuclidDivisionLemma) implemented the initial support for [NUMA](https://en.wikipedia.org/wiki/Non-uniform_memory_access)-based memory management, as he can only use the QEMU emulation, we need help from people with hardware supporting NUMA to know the size of performance improvement.

## Conclusion of the Scheduler Improvements RSoC project

Akshit Gaur wrote the [last EEVDF article](https://www.redox-os.org/news/rsoc-eevdf/) giving the complete explanation after optimizations, thanks a lot Akshit for the great work and effort.

## QEMU on Redox!

Ribbon and Wildan Mubarok confirmed/tested the QEMU is working on Redox, Ribbon tested the server variant of Redox in QEMU terminal mode.

Currently the performance is not good because we lack CPU hardware acceleration (like Linux KVM) from Redox.

- Redox server on QEMU above Redox desktop

<img src="/img/screenshot/qemu-on-redox.jpg" class="img-responsive" alt=""/>

## Dual-boot Installation from Linux!

Wildan Mubarok improved the Linux support of Redox installer to allow a dual-boot installation of Redox.

- Redox running on triple-boot

<img src="/img/screenshot/triple-boot.jpg" class="img-responsive" alt=""/>

## Mednafen Showcase

Mednafen was ported by never showcased, see a screenshot below:

- Castlevania Symphony Of The Night running on Redox

<img src="/img/screenshot/castle-sotn.jpg" class="img-responsive" alt=""/>

## Better relibc Contribution Philosophy and Goals

4lDO2 documented the `relibc` (our POSIX/C Standard Library) safety philosophy and goals to reduce the probability of undefined behavior and logic bugs being introduced, by concentrating unsafe code in wrapper functions for better oversight/review and using more Rust-like error handling to give more information than POSIX errors (easing the investigation of certain classes of bugs).

- [relibc CONTRIBUTING.md document](https://gitlab.redox-os.org/redox-os/relibc/-/blob/master/CONTRIBUTING.md)
- [4lDO2 MR to improve safety documentation](https://gitlab.redox-os.org/redox-os/relibc/-/merge_requests/1622)

## Kernel Improvements

- (kernel) 4lDO2 merged the `redox_syscall` library code into the `kernel` repository to ease changes
- (kernel) Akshit Gaur did more improvements and fixes to EEVDF scheduler work stealing and Wildan Mubarok did some fixes

## Driver Improvements

- (drivers) bjorn3 did some code cleanup

## System Improvements

- (sys) bjorn3 did a code deduplication on IPC daemon

## Relibc Improvements

- (libc) 4lDO2 moved most of unsafe socket code to [leaf functions](https://en.wikipedia.org/wiki/Leaf_routine) to reduce bugs by using concentration for much better readability
- (libc) bjorn3 fixed the `getsockname` and `getpeername` functions address length computation
- (libc) Wildan Mubarok improved the `LD_DEBUG` environment variable to show the `relibc` shared object memory location range to greatly improve crash debugging on dynamic linking
- (libc) Wildan Mubarok fixed a double close bug in `fstatat` function
- (libc) auronandace implemented `TIOCGSID`

## Networking Improvements

- (net) 

## RedoxFS Improvements

- (redoxfs) 

## Security Improvements

- (safe) Ibuki Omatsu reimplemented the `contain` sandbox management tool to use the new namespace management

## Programs

- (app) 

## Testing Improvements

- (test) 4lDO2 implemented benchmark metrics on `acid` test suite to detect performance regressions
- (test) Wildan Mubarok started to use and enable Clippy on CI

## Build System Improvements

- (build) Wildan Mubarok implemented the `COOKBOOK_TREELESS_CLONE` environment variable to enable treeless clone in all recipes to greatly save storage space
- (build) Wildan Mubarok reimplemented most of script logic in Cookbook to reduce script maintenance cost and Ribbon fixed some regressions
- (build) Wildan Mubarok fixed the `make rebuild-push` command (verify recipe source or package changes, incrementally rebuild or download and push new changes) not updating the filesystem configuration recipes, now the system can be properly and quickly updated in a existing Redox filesystem image

## Documentation Improvements

- (doc) Wildan Mubarok updated and improved the [Installing Redox](https://doc.redox-os.org/book/installing.html) page with information for the new GUI installer options

## Website Improvements

- (web) Wildan Mubarok added LaTeX math support and improved the website dark mode to clearly show LaTeX formulas to fix the formulas in the [last EEVDF article](https://www.redox-os.org/news/rsoc-eevdf/)

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

Use the `desktop` variant for a graphical interface. If you prefer a terminal-style interface, or if the `desktop` variant doesn't work, please try the `server` variant.

- If you want to test in a virtual machine use the "harddrive" images
- If you want to test on real hardware use the "livedisk" images

Read the following pages to learn how to use the images in a virtual machine or real hardware:

- [Running Redox in a virtual machine](https://doc.redox-os.org/book/running-vm.html)
- [Running Redox on real hardware](https://doc.redox-os.org/book/real-hardware.html)

Sometimes the daily images are outdated and you need to build Redox from source.
For instructions on how to do this, read the [Building Redox](https://doc.redox-os.org/book/podman-build.html) page.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

<!--

## Discussion

Here are some links to discussion about this news post:

- [floss.social @redox]()
- [floss.social @soller]()
- [Patreon]()
- [Phoronix]()
- [Reddit /r/redox]()
- [Reddit /r/rust]()
- [X/Twitter @redox_os]()

-->

<!--

The following template is for screenshots

<img src="/img/screenshot/file-name.type" class="img-responsive" alt=""/>

-->

<!--

The following template is for hardware photos

<img src="/img/hardware/file-name.type" class="img-responsive" alt=""/>

-->

<!--

The following template is for YouTube videos

## Title

<iframe width="800" height="640" src="insert-the-video-embed-link-here" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

-->
