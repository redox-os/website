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

<iframe width="800" height="450" src="https://www.youtube.com/embed/OJk75nPnZng?si=jHXS6m-DDALNMdV7" title="Lightning Talk "Redox OS Update" | RustConf 2026" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

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

bjorn3 also used display mirroring as the default external display handling behavior.

## More JIT Support!

Wildan Mubarok implemented page fault handling, which fixed LLVM JIT and others.

Currently only implemented for x86.

## uutils 0.11.0 Upgrade

Wildan Mubarok updated `uutils` from version 0.6.0/0.7.0 to 0.11.0 !!, which should fix many bugs.

## Initial `rlimit` Implementation

Landon Propes implemented the `getrlimit` and `setrlimit` functions to allow programs to use system resource limits.

## Redox on Google Cloud!

Aadarsh (aka EuclidDivisionLemma) configured Google Cloud (GCP) to make Redox boot successfully.

<img src="/img/screenshot/gcp.png" class="img-responsive" alt=""/>

## WebKitGTK3 Correct HTML Layout Rendering

Wildan Mubarok fixed broken HTML layout, he also added a shortcut for the browser demo in Orbital launcher bar.

<img src="/img/screenshot/webkitgtk3-correct-layout.jpg" class="img-responsive" alt=""/>

## GLVND Port

Wildan Mubarok ported the [GLVND](https://gitlab.freedesktop.org/glvnd/libglvnd) library to allow some GLX programs to work in Orbital.

## Clang Support in Redox Build System

Wildan Mubarok implemented the support for Clang cross-compilation, which allow better compiler optimizations and tooling.

## i586 Dynamic Linking

Wildan Mubarok fixed the i586 dynamic linking, which greatly helps old x86-32 computers with small memory capacity and easily scale tested programs.

Currently he enabled for basic applications.

## Kernel Improvements

- (kernel) Aadarsh simplified NUMA code
- (kernel) Val Lorentz fixed some Clippy warnings

## Driver Improvements

- (driver) Jeremy Soller fixed a Intel HD Audio driver panic when path to DAC is not found
- (driver) bjorn3 implemented the support for Linux DRM events
- (driver) bjorn3 fixed multi-display support in VirtIO-GPU driver
- (driver) bjorn3 implemented a macro to simplify Intel GPU driver register access code

## System Improvements

- (sys) bjorn3 fixed a panic in Redox terminal scrolling when using shadow buffer
- (sys) bjorn3 moved the `getty` tool from `userutils` repository to `base` repository to ease changes
- (sys) bjorn3 ported `getty` tool to Linux for faster testing
- (sys) bjorn3 did some code refactoring
- (sys) Yoh Deadfall implemented `SO_SNDBUF` in Unix datagram socket

## Relibc Improvements

- (libc) Wildan Mubarok implemented the `getentropy` and `gethostbyname2` (currently only support `AF_INET`) functions
- (libc) Wildan Mubarok fixed ARM64 weak symbol loading and TLS relocation
- (libc) Wildan Mubarok fixed `dlclose` function underflow in ARM64
- (libc) Wildan Mubarok fixed i586 TLS relocation
- (libc) Wildan Mubarok fixed a dynamic linker bug where some applications in `PATH` environment variable were being treated as executables in current directory
- (libc) Rostyslav Toch implemented the `posix_madvise` function for Linux
- (libc) auronandace applied more Clippy lints
- (libc) auronandace reduced more `as` casting usage to prevent problems in code refactorings

## Networking Improvements

- (net) Konstantin Shabanov fixed the `ping` tool not showing the website domain before IP address

## RedoxFS Improvements

- (rfs) 

## Desktop Improvements

- (desk) bjorn3 fixed Orbital multi-display mouse cursor handling

## Packaging Improvements

- (pkg) bjorn3 removed most `/home/user` path usage in package data configuration in preparation for factory reset support and better package integrity
- (pkg) Wildan Mubarok implemented description in packages, initially to differentiate meta-packages from common packages

## Programs

- (app) Wildan Mubarok enabled cross-compilation in Lua 5.3 compatibility layer
- (app) Wildan Mubarok updated OpenTyrian to version 2.1.20260913
- (app) Wildan Mubarok fixed a crash in keyboard capture handling in GTK's Orbital backend
- (app) Stephen Seo fixed the puzzle obfuscation logic of Redox's Redoku game

## Build System Improvements

- (build) Wildan Mubarok fixed the `binary` recipe rule unnecessarily building host dependencies from `source` rule
- (build) Mohammed Naser improved Cookbook error report to clearly show the failure reason when a ignored recipe build dependency is used

## Documentation Improvements

- (doc) 

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
