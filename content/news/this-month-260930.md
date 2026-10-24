+++
title = "This Month in Redox - September 2026"
author = "Ribbon and Ron Williams"
date = "2026-09-30"
+++

Redox OS is a complete Unix-like general-purpose microkernel-based operating system
written in Rust. September was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Redox at RustConf

RustConf was in Montreal this year, September 8-11.
I gave a quick update on Redox's recent progress.
I didn't have time to read through the slides, and the slide navigator was slow to respond,
so the presentation was quite rushed.
As you watch the video, please pause to read the slides more thoroughly.
You can watch on [the Rust Foundation's YouTube channel](https://www.youtube.com/@rustfoundation/videos) or here:

[Lightning Talk "Redox OS Update" | RustConf 2026](https://www.youtube.com/watch?v=OJk75nPnZng)

<iframe width="800" height="450" src="https://www.youtube.com/embed/OJk75nPnZng?si=jHXS6m-DDALNMdV7" title="Lightning Talk &quot;Redox OS Update&quot; | RustConf 2026" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

There were lots of other great topics, so browse the full list of videos.
A couple of highlights: Rust for GPU was a key topic this year, with 4 presentations, and there was an interesting presentation on [important considerations
when using Unsafe Rust](https://www.youtube.com/watch?v=bTAEymCp7Ts).

And a special thanks to Ernest Kissiedu for introducing me to many potential Redox partners and funders.
Ernest is a free agent right now, so if you are looking for a gregarious galvanizer who knows
everyone in the Rust community, you can [find him on LinkedIn](https://www.linkedin.com/in/ernest-kissiedu-a3a772252/).

As I mentioned in my presentation, we are particularly looking for donors for our Redox Summer of Code program.
Please donate at the links above to help support our students!

And if you have any contact info for corporate sponsors,
please email me at president@redox-os.org.

RustConf next year is September 7-10, 2027, in Vancouver, Canada, the most beautiful city in the world,
if you like mountains, water, tree-filled parks and seaside walks.
(Note that Vancouver Island and Vancouver, Oregon are completely different places.)
I plan to be there, and I hope to see you there.

- Ron Williams

## External Display Hot-plugging Support on Intel Tiger Lake GPUs

Jeremy Soller and bjorn3 implemented the support for external display hot-plugging on Intel GPU driver for Tiger Lake generation, now external displays can be used without a system reboot.

## More Boot Fixes

Jeremy Soller reduced panics on PS/2 driver to fix more boot hangs due to PS/2 errors.

## Significant Kernel TLB Misses Reduction

4lDO2 reduced kernel TLB misses by around 75% !! which improved copy-on-write memory management performance.

## Direct Context Switching

4lDO2 implemented the "direct context switching" technique to bypass the scheduler and hence its expensive `BTreeMap` Rust data structure access on context switching, which reduced IPC latency by 24% and improved I/O performance by 5% when using small buffers !

## More JIT Support!

Wildan Mubarok implemented page fault handling, which allows program crashes to be handled correctly using POSIX signals.

Shortly after being implemented, the feature was used to identify and fix LLVM JIT and others, caused by incorrect calculation in TLS initialization.

The page fault handling is currently only implemented for x86-64 and i586.

## uutils 0.11.0 Upgrade

Wildan Mubarok updated `uutils` from version 0.6.0/0.7.0 to 0.11.0 !! it was possible after a TLS bug has been fixed.

## Initial `rlimit` Implementation

Landon Propes implemented the `getrlimit` and `setrlimit` functions to allow programs to use system resource limits.

## Redox on Google Cloud!

Aadarsh (aka EuclidDivisionLemma) configured Google Cloud (GCP) to make Redox boot successfully.

<img src="/img/screenshot/gcp.png" class="img-responsive" alt="Redox running on Google Cloud"/>

## WebKitGTK3 Correct HTML Layout Rendering

Wildan Mubarok fixed broken HTML layout, he also added a shortcut for the browser demo in Orbital launcher bar.

<img src="/img/screenshot/webkitgtk3-correct-layout.jpg" class="img-responsive" alt="Correct WebKitGTK website HTML layout"/>

## Better SDL2 Performance

Wildan Mubarok implemented a way for the SDL2 OpenGL buffer to reuse the Orbital OpenGL buffer and skip buffer copy in OpenGL synchronization, which probably doubled performance in his non-JIT non-KVM test.

Higher performance gains are expected in QEMU KVM and real hardware.

## Clang Support in Redox Build System

Wildan Mubarok implemented the support for Clang cross-compilation, which allow more strict compilation and fixing to reduce UB of many programs written in C/C++.

Compilation with Clang can be enabled by writing a new option in the `.config` file:

```
export REDOXER_USE_CLANG=true
```

## i586 Dynamic Linking

Wildan Mubarok fixed the i586 dynamic linking, which greatly helps old x86-32 computers with small memory capacity and easily scale tested programs.

Dynamic linking for i586 programs has been enabled for all recipes but the amount of available compiled programs is still small.

## Redox Terminal Migration To `alacritty_terminal` Library

bjorn3 migrated the Redox terminal from `ransid` library to `alacritty_terminal` to support more escape codes, reflowing on display resize and more.

It also greatly simplified terminal code.

## Boot Improvements

- (boot) 4lDO2 updated kernel debug names in userspace bootstrapping to show `initfs`, `initnsmgr`, and `procmgr` daemon names for more clarity on debugging

## Kernel Improvements

- (kernel) 4lDO2 removed unnecessary AVX registers save/restore operations to reduce IPC latency by 14%
- (kernel) 4lDO2 reduced by 5% the page fault overhead in a test making randomized writes while frequently forking
- (kernel) 4lDO2 implemented a wrapper to get references of other hardware threads blocks in safe code
- (kernel) 4lDO2 fixed some bugs in real-time sig-related `sigentry` assembly and partially fixed incorrect "disable signals" state
- (kernel) 4lDO2 fixed the `XSAVE` instruction area size calculation, which fixed unused `FXSAVE` instruction space and reduced memory usage
- (kernel) 4lDO2 fixed AVX detection
- (kernel) 4lDO2 did some code simplification
- (kernel) Ibuki Omatsu reimplemented `fdtbl` using Radix trees to avoid expensive reallocations when growing a vector-based file table, which reduced latency during table growth
- (kernel) Ibuki Omatsu fixed a `EFAULT` error on read-only payload in call/stdfscall system calls
- (kernel) MJ Pooladkhay fixed a panic in SRAT iterator due to over-read past a table
- (kernel) MJ Pooladkhay implemented unused contiguous physical memory transfer to the buddy memory allocator
- (kernel) AArch Angel fixed other CPU cores not stealing work from CPU core 0 in work stealing
- (kernel) Wildan Mubarok fixed signals not being handled inside futexes
- (kernel) Wildan Mubarok enabled RISC-V boot testing on CI
- (kernel) Aadarsh simplified NUMA code
- (kernel) Val Lorentz fixed some Clippy warnings

## Driver Improvements

- (driver) Jeremy Soller fixed a Intel HD Audio driver panic when path to DAC is not found
- (driver) bjorn3 finished the migration of video/graphics drivers and daemons API to Linux DRM to unify code and reduce application porting effort
- (driver) bjorn3 implemented the support for Linux DRM events
- (driver) bjorn3 improved Linux DRM compliance
- (driver) bjorn3 implemented a basic [network block device](https://en.wikipedia.org/wiki/Network_block_device) driver to speedup network boot in the future
- (driver) bjorn3 fixed multi-display support in VirtIO-GPU driver
- (driver) bjorn3 implemented a macro to simplify Intel GPU driver register access code
- (driver) bjorn3 improved graphics code readability by moving many code to separated modules

## System Improvements

- (sys) bjorn3 fixed a panic in Redox terminal scrolling when using shadow buffer
- (sys) bjorn3 moved the `getty` tool from `userutils` repository to `base` repository to ease changes
- (sys) bjorn3 ported `getty` tool to Linux for faster testing
- (sys) bjorn3 did a big code simplification of the boot log daemon
- (sys) bjorn3 did some code refactoring and cleanups
- (sys) Yoh Deadfall implemented `SO_SNDBUF` in Unix datagram socket
- (sys) Wildan Mubarok fixed a 1 year old file permission regression in `/etc/group` file

## Relibc Improvements

- (libc) 4lDO2 added safety wrappers to strto\* functions for input sanitization on integer parsing
- (libc) Wildan Mubarok implemented the `getentropy` and `gethostbyname2` (currently only support `AF_INET`) functions
- (libc) Wildan Mubarok reduced unsafe Rust in timer code
- (libc) Wildan Mubarok fixed a double close bug on `posix_spawn` function
- (libc) Wildan Mubarok fixed ARM64 weak symbol loading and TLS relocation
- (libc) Wildan Mubarok fixed `dlclose` function underflow in ARM64
- (libc) Wildan Mubarok fixed TLS relocation and `printf` long double in i586
- (libc) Wildan Mubarok fixed a dynamic linker bug where some applications in `PATH` environment variable were being treated as executables in current directory
- (libc) Wildan Mubarok fixed a incorrect `symlinkat` error code when a symbolic link exists
- (libc) Wildan Mubarok fixed timeout reset in `setsockopt` function
- (libc) Rostyslav Toch implemented the `readv` and `writev` functions
- (libc) Rostyslav Toch implemented the `posix_madvise` function for Linux
- (libc) auronandace implemented `ENOMEM` error handling in `vasprintf` function
- (libc) auronandace reduced unsafe Rust code from strto\* and wcsto\* functions
- (libc) auronandace applied more Clippy lints
- (libc) auronandace reduced more `as` casting usage to prevent problems in code refactorings
- (libc) auronandace documented the `strncasecmp` and `strcasecmp` functions
- (libc) Elora Burns fixed bugs related to POSIX regex matching

## Networking Improvements

- (net) Konstantin Shabanov fixed the `ping` tool not showing the website domain before IP address

## Desktop Improvements

- (desk) bjorn3 fixed Orbital multi-display mouse cursor handling

## Packaging Improvements

- (pkg) bjorn3 removed most `/home/user` path usage in package data configuration in preparation for factory reset support and better package integrity
- (pkg) Wildan Mubarok implemented more options for package analysis and partial extraction in `pkgar` CLI
- (pkg) Wildan Mubarok implemented description in packages, initially to differentiate meta-packages from common packages
- (pkg) Wildan Mubarok fixed a symbolic link error on package reinstallation, which fixes it and incomplete installation restart in some packages
- (pkg) Wildan Mubarok fixed a overcount bug in package extraction plain progress (no progress bar) counter
- (pkg) Wildan Mubarok changed the network module to use the `ureq` library and updated `ring` library version

## Programs

- (app) Wildan Mubarok ported the [BIND9](https://www.isc.org/bind/) DNS server
- (app) Wildan Mubarok enabled cross-compilation in Lua 5.3 compatibility layer
- (app) Wildan Mubarok expanded dynamic linking in COSMIC applications and reduced compilation time by using our recipes on its `-sys` crates
- (app) Wildan Mubarok enabled dynamic linking in SDL2_image, SDL2_ttf, and SDL2_mixer. Reducing the size of multiple packages
- (app) Wildan Mubarok expanded SDL2_mixer format support
- (app) Wildan Mubarok updated OpenSSH from version 9.8p1 to 10.5p1
- (app) Wildan Mubarok updated SDL2_image from version 2.0.4 to 2.8.12
- (app) Wildan Mubarok updated SDL2_ttf from version 2.0.15 to 2.24.0
- (app) Wildan Mubarok updated SDL2_mixer from version 2.8.1 to 2.8.2
- (app) Wildan Mubarok updated OpenTyrian to version 2.1.20260913
- (app) Wildan Mubarok fixed a crash in keyboard capture handling in GTK's Orbital backend
- (app) Wildan Mubarok fixed a incorrect keyboard handling in GTK port, which fixed a QEMU crash
- (app) Stephen Seo fixed the puzzle obfuscation logic of Redox's Redoku game

## Testing Improvements

- (test) 4lDO2 implemented on `acid` test suite the support for CPU metrics such as data L2 cache hits/misses and unaligned fetches, depending on CPU model
- (test) 4lDO2 implemented basic AMD performance counters support in `acid` test suite
- (test) thesupertechie contributor added a report for HP ENVY Laptop 16 h1055cl laptop (status: Booting)

## Build System Improvements

- (build) Wildan Mubarok implemented the `build.compiler` recipe data type to choose the cross-compiler (GCC or Clang) and disable LTO when needed
- (build) Wildan Mubarok updated the "Package Files" section of Cookbook web mode to say the package type as meta-package when the section is empty
- (build) Wildan Mubarok disabled automatic recipe source fetch on recipe rule change to `local`, to fix accidental existing source overwrite and sometimes wrong behavior by downloading pre-built packages instead of source
- (build) Wildan Mubarok fixed the `binary` recipe rule unnecessarily building host dependencies from `source` rule
- (build) Wildan Mubarok fixed Cookbook not installing recipe package dependencies by default
- (build) Wildan Mubarok fixed unnecessary updates on recipe Git sources when not using default branch
- (build) Wildan Mubarok fixed incorrect environment variable parsing in `.config` file due to invisible whitespaces
- (build) Wildan Mubarok enabled RISC-V and i586 testing in Redoxer
- (build) Mohammed Naser improved Cookbook error report to clearly show the failure reason when a ignored recipe build dependency is used

## Documentation Improvements

- (doc) Ribbon improved the [Windowing and Graphics](https://doc.redox-os.org/book/graphics-windowing.html) page with better explanations
- (doc) Ribbon [documented how to launch a Redox image from Redox QEMU port](https://doc.redox-os.org/book/running-vm.html#redox) (experimental)
- (doc) Ribbon [documented more application debugging methods](https://doc.redox-os.org/book/troubleshooting.html#applications)
- (doc) Ribbon [documented FLOSS desktop and web browser 2FA applications](https://doc.redox-os.org/book/signing-in-to-gitlab.html#2fa-apps) on GitLab sign-in page

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

### Programs

To test the changes on applications and libraries, see if the wanted program is available in the following lists and run the following command to install them: `sudo pkg install package-name`

- [x86-64 packages](https://static.redox-os.org/pkg/x86_64-unknown-redox/)
- [ARM64 packages](https://static.redox-os.org/pkg/aarch64-unknown-redox/)
- [RISC-V packages](https://static.redox-os.org/pkg/riscv64gc-unknown-redox/)
- [i586 packages](https://static.redox-os.org/pkg/i586-unknown-redox/)

There's also a package web interface if you want detailed package information:

- [x86-64 packages](https://static.redox-os.org/web/x86_64-unknown-redox/)
- [ARM64 packages](https://static.redox-os.org/web/aarch64-unknown-redox/)
- [RISC-V packages](https://static.redox-os.org/web/riscv64gc-unknown-redox/)
- [i586 packages](https://static.redox-os.org/web/i586-unknown-redox/)

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
