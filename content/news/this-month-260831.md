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

## More Boot Fixes

Wildan Mubarok improved UEFI compatibility, which allowed the MSI Modern 14 C7M laptop to boot!

He also fixed a bug that expanded the PS/2 mouse compatibility.

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

Aadarsh (aka EuclidDivisionLemma) implemented the initial support for [NUMA](https://en.wikipedia.org/wiki/Non-uniform_memory_access)-based memory management, as he can only use the QEMU emulation, we need help from people with hardware supporting NUMA to know the size of performance improvement. Cloud services such as AWS, Google Cloud and Azure also have support for it.

He also implemented local node allocation (locality of data) by default and a API to modify NUMA allocation policies.

## Process Priority Support Conclusion of the Scheduler Improvements RSoC project

Akshit Gaur implemented the support for process priorities and system priority tuning, which improved general performance.

He also wrote the [last EEVDF article](https://www.redox-os.org/news/rsoc-eevdf/) giving the complete explanation after optimizations, thanks a lot Akshit for the great work and effort.

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

- (kernel) 4lDO2 reduced binary size by 2.2% by removing DTB code when not reached (x86-64 image, for example)
- (kernel) 4lDO2 merged the `redox_syscall` library code into the `kernel` repository to ease changes
- (kernel) Akshit Gaur did more improvements and fixes to EEVDF scheduler work stealing and Wildan Mubarok did some fixes, which improved performance
- (kernel) Aadarsh (aka EuclidDivisionLemma) improved memory deallocation performance by reducing thread locking
- (kernel) Aadarsh (aka EuclidDivisionLemma) fixed a panic in NUMA code
- (kernel) Wildan Mubarok moved all scheme path handling to user-space
- (kernel) Wildan Mubarok fixed a potential bug where process killing could create zombie processes

## Driver Improvements

- (driver) MJ Pooladkhay implemented PCI multi-vector MSI-X support, which allow more driver performance features
- (driver) MJ Pooladkhay fixed VirtIO device completions being lost
- (driver) Wildan Mubarok fixed a `pcid` bug that Clippy detected
- (driver) bjorn3 did some code deduplication and cleanup

## System Improvements

- (sys) Ibuki Omatsu implemented multi-threading support for schemes
- (sys) Wildan Mubarok ported [rldd](https://github.com/zatrazz/rldd) to be our `ldd` tool implementation
- (sys) Wildan Mubarok fixed some off-by-one file locking bugs, which helped SQLite and `libsoup`
- (sys) Wildan Mubarok removed the a `inputd` non-fatal panic when no display is available
- (sys) bjorn3 fixed potential `inputd` deadlocks
- (sys) bjorn3 did some code deduplication

## Relibc Improvements

- (libc) 4lDO2 moved most of unsafe socket and `getaddrinfo` function code to [leaf functions](https://en.wikipedia.org/wiki/Leaf_routine) to reduce bugs by using concentration for much better readability
- (libc) 4lDO2 implemented the `RELIBC_COMMIT_HASH` environment variable to show the `relibc` commit hash to fully confirm if static objects were updated with local changes or up-to-date
- (libc) Ibuki Omatsu fixed broken `SCM_RIGHTS` on `recvmsg` function, a bug that was revealed after file descriptor allocation migration to user-space
- (libc) bjorn3 fixed the `getsockname` and `getpeername` functions address length computation, which fixed some `mio` library tests
- (libc) Wildan Mubarok implemented the `rlct_clone` function for Linux to fix `pthread` tests on Linux ARM64
- (libc) Wildan Mubarok implemented mode read (except line buffering) and write (except borrowing) support and handling in `setvbuf` function
- (libc) Wildan Mubarok improved the `LD_DEBUG` environment variable to show the `relibc` shared object memory location range to greatly improve crash debugging on dynamic linking
- (libc) Wildan Mubarok improved `epoll` performance by calling the `open` function directly
- (libc) Wildan Mubarok reduced application and library launch time by using constant functions in `stdio` initialization
- (libc) Wildan Mubarok reduced unsafe Rust code in `timer_t`
- (libc) Wildan Mubarok added more Unix socket tests
- (libc) Wildan Mubarok fixed the `clock_getres` function behavior
- (libc) Wildan Mubarok fixed a double close bug in `fstatat` function
- (libc) Wildan Mubarok fixed TLS load offset on ARM64, which fixed a `tokio` library panic on package manager
- (libc) Wildan Mubarok fixed 64KiB-paged ELF loading on Linux ARM64
- (libc) Wildan Mubarok fixed the `pthread_kill-self` test
- (libc) Wildan Mubarok fixed a time/timer test
- (libc) auronandace implemented `tcgetsid` function
- (libc) auronandace replaced `SYS_DUP_INTO`, `SYS_READ`, and `SYS_WRITE` system calls with `SYS_CALL` system call to reduce system calls
- (libc) auronandace did some code cleanup
- (libc) auronandace, Wildan Mubarok, and Ibuki Omatsu fixed all Clippy tests and enabled on CI
- (libc) Ben McCann implemented POSIX base in `tzset` and POSIX handling in `mktime` functions
- (libc) Ben McCann added more tests to `tzset` function
- (libc) Sunam Kang implemented `MSG_NOSIGNAL` in `sendto` function

## Networking Improvements

- (net) Wildan Mubarok improved DHCP missing DNS error handling messages

## RedoxFS Improvements

- (rfs) Wildan Mubarok implemented `O_SYMLINK` to allow symlink mid-path 
- (rfs) Wildan Mubarok improved partition mount error handling to show error codes

## Security Improvements

- (safe) bjorn3 implemented rootless display opening on `inputd`
- (safe) Ibuki Omatsu reimplemented the `contain` sandbox management tool to use the new namespace management, which now creates a per-process filter scheme that holds an actual namespace file descriptor, mediating all `openat` function calls by providing a file descriptor filter to programs (full `chroot` implementation is still WIP)
- (safe) Wildan Mubarok updated the CA certificates to be up-to-date, which also fixed GnuTLS

## Packaging Improvements

- (pkg) Wildan Mubarok fixed a double counting bug in package extraction progress bar

## Desktop Improvements

- (desk) bjorn3 ported the Orbital login manager to `winit` and `softbuffer` libraries to allow Wayland testing in the future
- (desk) bjorn3 disabled window decorations in fullscreen Orbital windows
- (desk) bjorn3 fixed fullscreen or maximized Orbital window resize on display resize

## Installer Improvements

- (install) Wildan Mubarok fixed the input data handling of new GUI installer options

## Programs

- (app) Wildan Mubarok updated GNU nano from version 7.2 to 9.2
- (app) Wildan Mubarok updated the Kibi from version 0.3.2 to 0.3.3
- (app) Wildan Mubarok fixed WebKit TLS bugs
- (app) Wildan Mubarok fixed the EGL support on GTK3 port
- (app) Wildan Mubarok fixed EGL partial rendering on Mesa3D

## Testing Improvements

- (test) 4lDO2 implemented benchmark metrics on `acid` test suite to detect performance regressions
- (test) Wildan Mubarok started to use and enable Clippy on CI
- (test) Wildan Mubarok reduced the Redox image CI verification time from around 25 minutes to around 7 minutes

## Build System Improvements

- (build) Wildan Mubarok updated the Cookbook recipe target list item combination to allow `--all-*` options usage, for example: `make r.base,--all-binaries`
- (build) Wildan Mubarok implemented the `COOKBOOK_TREELESS_CLONE` environment variable to enable treeless clone in all recipes to greatly save storage space
- (build) Wildan Mubarok reimplemented most of script logic in Cookbook to reduce script maintenance cost and Ribbon fixed some regressions
- (build) Wildan Mubarok fixed the `make rebuild-push` command (verify recipe source or package changes, incrementally rebuild or download and push new changes) not updating the filesystem configuration recipes, now the system can be properly and quickly updated in a existing Redox filesystem image
- (build) Konstantin Shabanov fixed the Nix flake on Podman and Native builds
- (build) Konstantin Shabanov applied `cargo fix` on code
- (build) Ribbon replaced the `ls` tool by `tree` in `show-package.sh` script to make it much more useful by showing all recipe package directories and files

## Documentation Improvements

- (doc) Wildan Mubarok updated and improved the [Installing Redox](https://doc.redox-os.org/book/installing.html) page with information for the new GUI installer options
- (doc) Ribbon properly documented with more detail [why we prefer POSIX/Linux source compatibility over binary compatibility](https://doc.redox-os.org/book/developer-faq.html#why-redox-prefer-to-port-software-from-source-instead-of-binary-compatibility) on Developer FAQ
- (doc) Ribbon documented the debugging tip that [Linux KVM usage change bug behavior](https://doc.redox-os.org/book/troubleshooting.html#virtual-machine)

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

- [floss.social @redox]
- [floss.social @soller]
- [Patreon]
- [Phoronix]
- [Reddit /r/redox]
- [Reddit /r/rust]
- [X/Twitter @redox_os]

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
