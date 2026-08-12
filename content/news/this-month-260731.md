+++
title = "This Month in Redox - July 2026"
author = "Ribbon and Ron Williams"
date = "2026-07-31"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. July was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## EEVDF: Significant CPU Context Switch Cost Reduction and Scaling Improvement

Akshit Gaur's Redox Summer of Code project, implementing an EEVDF scheduler, has completed development and the work has been merged. All that's left is some experimentation and a report. Thanks for the excellent work Akshit!

He also implemented some kernel optimizations that, in a synthetic benchmark, reduced the average time needed for CPU context switch from around ~1.150 microseconds down to around ~250 nanoseconds! Since context switching is often a bottleneck, this is expected to improve the overall performance quite a bit.

He also implemented the following optimizations:

- Eliminated a linear scan for blocked CPU contexts that ran on every context switch, the scan was broken into two parts and their time complexity brought down to O(log N) and O(1) from O(N).

- Moved the data structure holding all the runnable contexts to per-CPU hardware thread, significantly reducing lock contention and ensuring better scaling for multi-core systems. He also implemented work-stealing to go with it.

## ARM64 Real Hardware Fixes and Amlogic Meson UART ARM64 Support 

Luiz Fernando implemented the support for this UART model line which was tested using [Amlogic S905W2](https://gadgetversus.com/processor/amlogic-s905w2-specs/), this work also improved a lot of ARM code that will help other UART boards.

He also improved the general ARM64 support and compatibility by:

- Fixing FP register corruption, PTE shareability, DeviceTree panics, and `mmap` memory type
- Preserving UEFI cacheability in bootloader bootstrap memory mappings to fix the Amlogic S905W2 SoC and other possible boards/SoCs hanging in kernel entry

## Improved System Installation

Wildan Mubarok implemented more options in the GUI-based installer, including choice of installation methods, network-based installation and image snapshot creation (system backup or customized installation image), making the system installation flexible and customizable. The installer can also be launched from Linux. It is not yet available for download.

Only installation to a image file is supported when opened on Linux.

(Screenshots of Redox installer taken from Linux)

<img src="/img/screenshot/install-method.png" class="img-responsive" alt="Installation methods"/>

<img src="/img/screenshot/image-file-config.png" class="img-responsive" alt="System image file creation configuration"/>

<img src="/img/screenshot/sys-install-profile.png" class="img-responsive" alt="System profile configuration"/>

## uutils `grep` and `sed` Implementations On Redox!

auronandace successfully built and tested the uutils [grep](https://github.com/uutils/grep) and [sed](https://github.com/uutils/sed) implementations, he also replaced GNU `grep` and `sed` in `os-test` test suite usage.

## Better Package Manager Reliability and Information

Wildan Mubarok implemented a cURL network backend as fallback when the `reqwest` network backend is not working (can be used with `--curl` option or `reqwest` error question prompt), he also improved the `pkg info` command log information for more and better information about a package.

- `curl` package information

```
$ pkg info curl
status:        not installed
name:          curl
version:       TODO
remote:        static.redox-os.org
remote_path:   https://static.redox-os.org/pkg/x86_64-unknown-redox
target:        x86_64-unknown-redox
storage_size:  3588719 bytes
network_size:  1531013 bytes
blake3:        4d65055a229968a26ceef0c8edd443fd4e299684abcc5e4e219c6860d7b82be7
source_id:     a05f34973e6c4bb629d018f7cb51487be1c904d8
build_id:      9643e194463dee251544778dcde684ec0124b9f4
build_date:    2026-07-03T06:09:58Z
depends:       ca-certificates, nghttp2, openssl3, zstd
```

## Ratatui on Redox!

Ribbon successfully built and tested the [Ratatui](https://ratatui.rs/) demos.

<img src="/img/screenshot/ratatui-about.png" class="img-responsive" alt="Ratatui about demo"/>

- Ratatui traceroute demo

<img src="/img/screenshot/ratatui-traceroute.png" class="img-responsive" alt="Ratatui traceroute demo"/>

- Ratatui chart 1 demo

<img src="/img/screenshot/ratatui-chart.png" class="img-responsive" alt="Ratatui chart 1 demo"/>

- Ratatui chart 2 demo

<img src="/img/screenshot/ratatui-chart2.png" class="img-responsive" alt="Ratatui chart 2 demo"/>

- Ratatui color rendering demo

<img src="/img/screenshot/ratatui-color-rendering.png" class="img-responsive" alt="Ratatui color rendering demo"/>

- Ratatui mouse drawing demo

<img src="/img/screenshot/ratatui-mouse-drawing.png" class="img-responsive" alt="Ratatui mouse drawing demo"/>

- Ratatui calendar demo

<img src="/img/screenshot/ratatui-calendar-demo.png" class="img-responsive" alt="Ratatui calendar demo"/>

## QR Code on Redox!

Wildan Mubarok fixed and Ribbon tested the [Iced](https://iced.rs/) QR Code demo.

<img src="/img/screenshot/iced-qr-code.png" class="img-responsive" alt="Iced QR Code demo"/>

## Markdown on Redox!

Wildan Mubarok fixed and Ribbon tested the Iced Markdown editor/viewer demo, which is the first graphical Markdown viewer to work on Redox!

<img src="/img/screenshot/iced-markdown.png" class="img-responsive" alt="Iced Markdown demo"/>

## Matrix on Redox!

Ribbon successfully built and tested [rusty-rain](https://github.com/cowboy8625/rusty-rain) to show the classic Matrix text rain.

Wildan Mubarok fixed and Ribbon also tested the Iced Matrix rain demo.

- rusty-rain demo

<img src="/img/screenshot/rusty-rain.png" class="img-responsive" alt="rusty-rain demo"/>

- Iced Matrix demo

<img src="/img/screenshot/iced-matrix.png" class="img-responsive" alt="Iced Matrix demo"/>

## More Demos!

Wildan Mubarok fixed more Iced, `winit` and `softbuffer` library demos! Ribbon also fixed and tested more demos.

- [pipes-rs](https://github.com/lhvy/pipes-rs) demo

<img src="/img/screenshot/pipes-rs.png" class="img-responsive" alt="pipes-rs demo"/>

- Iced clock demo

<img src="/img/screenshot/iced-clock.png" class="img-responsive" alt="Iced clock demo"/>

- Iced bézier curve demo

<img src="/img/screenshot/iced-bezier.png" class="img-responsive" alt="Iced bezier demo"/>

- Iced solar system demo

<img src="/img/screenshot/iced-solar-system.png" class="img-responsive" alt="Iced solar system demo"/>

- Iced color editor demo

<img src="/img/screenshot/iced-color-edit.png" class="img-responsive" alt="Iced color editor demo"/>

- `softbuffer` fruit demo

<img src="/img/screenshot/softbuffer-fruit-demo.jpg" class="img-responsive" alt="softbuffer fruit demo"/>

- Rust Cairo GUI demo, this is a classic Cairo-based GUI demo written in Rust that Ribbon fixed

<img src="/img/screenshot/rust-cairo-demo.png" class="img-responsive" alt="rust-cairo demo"/>

## Cookbook TUI Editor

Wildan Mubarok implemented the `repo_editor` tool that makes the Cookbook TUI more flexible for recipe build and scripts, also adding new options and support mouse.

<img src="/img/screenshot/repo-editor.png" class="img-responsive" alt="Cookbook TUI repo_editor showing a recipe list and build option buttons"/>

## Boot Improvements

- (boot) bjorn3 fixed the ability to dynamically link `init`, but not enabled by default yet

## Kernel Improvements

- (kernel) Aadarsh (aka EuclidDivisionLemma) did various preparations for NUMA support such as SRAT parsing and physical memory allocator adaptation
- (kernel) Ibuki Omatsu fixed `futex` usage in shared memory
- (kernel) Wildan Mubarok fixed logging for memory leak detection
- (kernel) Benton60 fixed the queue length behavior and a queue size overflow in events and pipes to fix a `poll` function hang

## Driver Improvements

- (driver) bjorn3 implemented cursor planes support in graphics API
- (driver) bjorn3 enabled unconditional compilation of BCM2835 storage driver to prevent breakage accumulation and bundle in ARM64 image
- (driver) bjorn3 fixed a race condition in xHCI driver when receiving events before unmasking interrupts
- (driver) bjorn3 deduplicated some code in xHCI driver
- (driver) Wildan Mubarok fixed the BCM2835 storage driver initialization
- (driver) Wildan Mubarok did a small cleanup of the code in the NVMe driver

## System Improvements

- (sys) Ibuki Omatsu migrated more `redox-scheme` library code to use the `libredox` library rather than using raw system calls, as part of the Capabilities work
- (sys) Ron Steinke fixed a possible deadlock in `redox-scheme` library, where any userspace process taking exclusive locks on two different files could hang
- (sys) bjorn3 implemented the support for Unix socket hosting in `ramfs`
- (sys) bjorn3 updated the IPC daemon to allow reusing the same path for multiple Unix sockets after deleting the socket
- (sys) bjorn3 removed legacy scheme path usage in `fpath` function
- (sys) bjorn3 added a `/dev/ptmx` symbolic link
- (sys) bjorn3 fixed a hang when trying to create a Unix socket in a scheme that doesn't support this
- (sys) bjorn3 fixed unlink in `ramfs`
- (sys) bjorn3 simplified some code
- (sys) Wildan Mubarok fixed ARM random number generation seed detection
- (sys) auronandace improved PTY daemon correctness

## Relibc Improvements

- (libc) Ibuki Omatsu fixed TCB deallocation
- (libc) 4lDO2 and Wildan Mubarok fixed TCB deallocation in `pthread_join` function
- (libc) Anhad Singh unified the C standard library and dynamic linker code to fix some problems and bugs that were also blocking the CI
- (libc) Anhad Singh fixed `malloc_usable_size` function
- (libc) Luiz Fernando fixed the dynamic linker PLT relocations
- (libc) bjorn3 fixed an unwind safety bug in `openat` function
- (libc) bjorn3 fixed Unix socket connection not working in `/scheme/*` paths
- (libc) Wildan Mubarok allowed the panic handler to provide information when the TCB was not initialized yet, providing panic code location instead of a page fault log that doesn't give the crash location in memory, improving the ability to debug the panic
- (libc) Wildan Mubarok improved the `openat` function logging parsing to improve error investigation
- (libc) Wildan Mubarok fixed a panic in `posix_exit` function
- (libc) Wildan Mubarok fixed a race condition in `pthread_join` function
- (libc) Wildan Mubarok fixed a hang when creating a Unix socket with relative path
- (libc) Landon Propes implemented the `tcdrain`, `tcflow`, and `tcsendbreak` functions
- (libc) auronandace continued improving POSIX compliance
- (libc) auronandace eliminated more C header file fragments by including definitions in the `cbindgen` configuration file
- (libc) auronandace moved more definitions written in C to Rust via `cbindgen`
- (libc) auronandace added documentation to more functions and definitions
- (libc) auronandace reduced the usage of `as` casting to prevent problems in code refactorings
- (libc) auronandace applied many Clippy lints
- (libc) auronandace did more header and code cleanup
- (libc) Hamidreza Kalbasi fixed some possible undefined behavior

## RedoxFS Improvements

- (redoxfs) Wildan Mubarok fixed upward traversal in symbolic linking

## Desktop Improvements

- (gui) Ibuki Omatsu migrated more Orbital application code to `libredox` library
- (gui) Wildan Mubarok implemented faster window resize feedback in Orbital which gave a massive responsiveness improvement by separating the window content resize calculation from window geometry resize
- (gui) Wildan Mubarok improved Orbital launcher (taskbar) and window title bar semi-transparent color rendering performance by 50x using SIMD
- (gui) Wildan Mubarok improved semi-transparent window rendering performance by 3x using SIMD
- (gui) Wildan Mubarok enabled SIMD in Orbital wallpaper resize which reduced processing time in non-KVM QEMU by almost 8x, the resize time of 1280x800 resolution was reduced from 4.5 seconds to 587ms
- (gui) Wildan Mubarok improved the Orbital keyboard shortcut manual OSD to follow screen DPI size
- (gui) Wildan Mubarok fixed the Orbital window close and maximize buttons being activated by mouse click hold and not release
- (gui) Wildan Mubarok fixed the Orbital window titlebar drag needing two mouse clicks to work
- (gui) Wildan Mubarok fixed a massive Orbital performance slowdown when the Orbital keyboard shortcut manual OSD ("Super" key) is shown
- (gui) Wildan Mubarok fixed transparent window flickering on resize or movement in Orbital
- (gui) bjorn3 refactored and cleaned up code in Orbital

## Security Improvements

- (safe) bjorn3 disabled non-root user access to `serio`, `irq`, and `display.vesa` schemes
- (safe) bjorn3 greatly simplified file permission handling in the `randd` daemon

## Programs

- (app) Wildan Mubarok enabled half softfloat functions in `libgcc` for recipe compilation with SIMD
- (app) Wildan Mubarok ported the new `winit` polling system (pump events) to fix Wayland Rust applications and improve Wayland Rust performance
- (app) Wildan Mubarok fixed a error in our Rust fork
- (app) Wildan Mubarok fixed `winit`, `softbuffer` and `iced` demos
- (app) Bendeguz Pisch ported [dos2unix](https://dos2unix.sourceforge.io/)
- (app) auronandace ported the `python3-colorama` and `python3-requests` libraries

## Testing Improvements

- (test) Ibuki Omatsu migrated more `acid` test suite code to `libredox` library
- (test) Wildan Mubarok added the `fetch-changed.sh` script to update GitLab CI jobs without a Git rebase, which reduced the effort to test MR reviews
- (test) Wildan Mubarok reduced GitLab CI job startup time by reducing toolchain downloading
- (test) Wildan Mubarok updated the `relibc` Makefile to clean test binaries from all CPU architectures to prevent outdated leftover binaries
- (test) auronandace enabled 4 `os-test` tests that no longer hang
- (test) bjorn3 fixed Orbital tests on Linux
- (test) bjorn3 added a panic message for manual daemon launch without a `init` service configuration

## Build System Improvements

- (build) Wildan Mubarok implemented the support for custom remote or local package repositories on Cookbook
- (build) Wildan Mubarok implemented the `python` template to easily configure Python applications using pip and cross-compile their C, C++ or Rust dependencies if needed
- (build) Wildan Mubarok implemented the `make cookbook` command to update Cookbook binaries with local changes (when `make pull` is not used)
- (build) Wildan Mubarok implemented the `make lcrp.recipe` command for quick static recipe local changes testing
- (build) Wildan Mubarok implemented the `make p.--all-compiled` (install all compiled recipes to the Redox image) command
- (build) Wildan Mubarok improved the `make unfetch` command to remove downloaded tarballs if no BLAKE3 hash is found
- (build) Wildan Mubarok improved the `make f.recipe` command with `local` rule to download the recipe source again if the `source` directory is missing
- (build) Wildan Mubarok improved the `make fetch` command to remove the `repo.tag` file to make the `make push` command trigger a rebuild
- (build) Wildan Mubarok improved the `make u.recipe` command with `binary` rule and the `make u.--all REPO_BINARY=1` command to not clean the `target` directory to preserve downloaded binaries
- (build) Wildan Mubarok implemented the `make f.--all-binaries` (update all downloaded recipe packages if they changed) and `make rp.--all-binaries` (install all downloaded recipe packages to the Redox image) commands
- (build) Wildan Mubarok added the `unused-libs.sh` (check unused recipe dependencies) and `open-recipe.sh` (open the specified recipe configuration in the specified text editor) scripts
- (build) Wildan Mubarok made many fixes to cross-compilation of Python programs (when C, C++ or Rust dependencies are used)
- (build) Wildan Mubarok fixed a recipe source fetch bug when the `same_as` data type is used with recipe rules, which caused the source to be erased with possible local changes after a recipe rule change
- (build) Wildan Mubarok fixed `relibc` being compiled when `REPO_BINARY` is enabled
- (build) Wildan Mubarok fixed the `make sc.recipe` command ignoring if `REPO_BINARY` is enabled and building recipe dependencies
- (build) Wildan Mubarok fixed and simplified most scripts
- (build) Konstantin Shabanov fixed the Podman Build in Nix flake

## Documentation Improvements

- (doc) Ribbon documented the microkernel benefit of [less maintenance cost](https://doc.redox-os.org/book/microkernels.html#less-maintenance-cost)
- (doc) Ribbon improved the microkernel [better debugging](https://doc.redox-os.org/book/microkernels.html#better-and-cheaper-debugging-on-real-hardware) benefit clarity by mentioning real-hardware (quicker and cheaper to debug)
- (doc) Ribbon documented the Rust benefit of [better code quality with much less effort](https://doc.redox-os.org/book/why-rust.html#better-code-quality-with-much-less-effort)
- (doc) Ribbon documented [when `relibc` ABI breaks in dynamic and static linking](https://doc.redox-os.org/book/developer-faq.html#when-relibc-abi-breaks)
- (doc) Ribbon added sub-sections in [Application Porting notes](https://doc.redox-os.org/book/porting-applications.html#notes) section to ease reading
- (doc) Ribbon documented that the `make rebuild` command update downloaded packages if `REPO_BINARY` is enabled
- (doc) Ribbon improved the `make lc.recipe` command behavior documentation:

  - Disable automatic remote Git repository fetch to prevent the breakage of local changes and clean existing recipe binaries
  - Automatically download sources if they don't exist
  - Enable source compilation with pre-built dependencies when `REPO_BINARY` is enabled

- (doc) Ribbon documented that packages at `repo` directory are always preserved after single recipe or full recipe source and binary cleanup
- (doc) Ribbon simplified command examples

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

<img src="/img/screenshot/file-name.type" class="img-responsive"/>

-->

<!--

The following template is for hardware photos

<img src="/img/hardware/file-name.type" class="img-responsive"/>

-->

<!--

The following template is for YouTube videos

## Title

<iframe width="800" height="640" src="insert-the-video-embed-link-here" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

-->
