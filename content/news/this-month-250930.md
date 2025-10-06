+++
title = "This Month in Redox - September 2025"
author = "Ribbon and Ron Williams"
date = "2025-09-30"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. September was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## RustConf Presentation

Jeremy Soller presented "10 Years of Rust and Redox" at RustConf this year,
with some great stories about the history of Redox,
and some awesome insights into Redox's future.
Jeremy's talk was one of the Marquee presentations, on the main stage to all RustConf attendees.
Many people felt it was one of the most enjoyable and informative sessions at the conference.
Grab some popcorn and enjoy an entertaining presentation with a surprise ending!

You can see the slides on [this](https://github.com/jackpot51/rustconf2025/blob/main/10%20Years%20of%20Redox%20and%20Rust.pdf) link.

<iframe width="800" height="640" src="https://www.youtube.com/embed/xlccq9EbXGA?si=ETYWSkPUVK35Gm97" title="10 Years of Rust and Redox" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Multi-threaded By Default!

Jeremy Soller and bjorn3 fixed some key bugs in multi-threading and enabled it by default for x86. This can give a massive performance improvement depending on the hardware specifications.

- ffplay playing a 1080p video with good CPU decoding performance after multi-core and multi-threading support was enabled

<a href="/img/screenshot/ffplay-1080p-video.jpg"><img class="img-responsive" alt="ffplay playing a 1080p video" src="/img/screenshot/ffplay-1080p-video.jpg"/></a>

## Massive Small File Performance Improvement On RedoxFS

Jeremy Soller implemented [inode data inlining](https://en.wikipedia.org/wiki/Inode#Inlining) for small files which resulted in a massive performance improvement, a reduction of storage I/O operations, size of file caching and frequency of context switches by a factor of 2 in all small file operation types.

Wildan Mubarok measured that a benchmark to add packages to an existing QEMU image became 7.5 times faster!

## Massive Installation Performance Improvement

Jeremy Soller improved `lived` to preserve the original live disk data in memory (writes go to temporary memory), the installer can find this and use a new clone feature in RedoxFS to quickly clone the filesystem to a new disk (potentially the new disk also has encryption).

This prevents having to run a thread for the new RedoxFS and context switch to the original RedoxFS and also `lived`, the whole clone is done in a single transaction with a large write cache, meaning it also has much fewer switches to the storage driver.

Including the inode data inlining optimization the benchmark is 10 times faster than before!

## LZ4 Compression On RedoxFS

Jeremy Soller implemented LZ4 compression which saved storage space and improved performance.

## Redox on Google Pixel!

Jeremy Soller successfully ported Redox to Google Pixel 3! currently only the screen is working.

- Redox running on Google Pixel 3

<a href="/img/hardware/google-pixel3.jpg"><img class="img-responsive" alt="Redox running on Google Pixel 3" src="/img/hardware/google-pixel3.jpg"/></a>

## Redox on BlackBerry!

Paul Sajna (sajattack) [ported Redox to BlackBerry KEY2 LE](https://chaos.social/@sajattack/115155756125794494), currently the keyboard is not working.

He wrote an article about the achievement:

https://blog.paulsajna.com/redox-in-your-pocket/

- Redox running on Blackberry KEY2 LE

<a href="/img/hardware/blackberry-key2-le.jpg"><img class="img-responsive" alt="Redox running on Blackberry KEY2 LE" src="/img/hardware/blackberry-key2-le.jpg"/></a>

## Redox on Hackaday!

Tyler August wrote an article about Redox on BlackBerry in Hackaday, quite possibly the first Redox OS article there.

https://hackaday.com/2025/09/24/who-wants-a-rusty-old-smartphone/

## OpenSSH on Redox!

The moment finally came, Wildan Mubarok successfully ported OpenSSH to Redox.

It will allow us to remotely control the system on both QEMU and real hardware.

## Nginx and PHP on Redox!

Wildan Mubarok successfully ported Nginx and PHP to Redox.

## Neovim on Redox!

Wildan Mubarok successfully ported Neovim.

## CPython 3.12 on Redox!

A recent version of CPython is finally working on Redox, thanks to the amazing work of Wildan Mubarok!

## OpenSSL 3.x on Redox!

Wildan Mubarok successfully ported the 3.x version of OpenSSL to allow more programs or their recent/latest stable versions to work.

## Deadlock Prevention and Detection at Compile-Time

Jeremy Soller implemented Ordered Locks in the kernel,
based on the [ordered_locks crate](https://docs.rs/ordered-locks/latest/ordered_locks/), to assign tokens to locks.
It uses the Rust type system and [typestates](https://en.wikipedia.org/wiki/Typestate_analysis) to detect potential deadlocks at compile-time.
We weren't able to use the `ordered_locks` crate directly due to dependencies,
but we are happy to share ideas or [implementation](https://gitlab.redox-os.org/redox-os/kernel/-/blob/master/src/sync/ordered.rs?ref_type=heads).

Some potential deadlocks were fixed using this, making Redox's multi-threading more reliable.

## Server Demo Variant

Wildan Mubarok created the `server-demo` variant with OpenSSH, Nginx, PHP, CPython, SQLite 3.x, Rsync, Neovim and others included.

## Expanded Redoxer

Wildan Mubarok improved the Redoxer Docker container to use local packages inside the container instead of downloading a new one each time it runs, which is important for the CI to avoid random errors caused by new packages.

Wildan Mubarok expanded Redoxer to allow Rust programs using C libraries compiled to Redox to work.

## Test Reports

Ron Williams created a repository to store the results of test suites that we can run (currently [os-test](https://sortix.org/os-test/) and [Open POSIX Test Suite](https://posixtest.sourceforge.net/)).

- https://gitlab.redox-os.org/redox-os/test-results

## Complete TOML Migration of Recipes

bjorn3 finished the conversion of the most important and relevant remaining recipes from shell scripts to TOML.
It fixed some bugs and will allow our build system and software porting to be improved, expanded and tested more easily.

## New Home Page!

Wildan Mubarok improved the Redox website home page with a responsive design, more information and additional links. Click on the Redox logo in the header of this article to see the new layout.

## Bootloader Improvements

- (boot) bjorn3 updated the code to Rust 2024 edition
- (boot) bjorn3 did a code cleanup

## Kernel Improvements

- (kernel) bjorn3 fixed booting on Intel Meteor Lake CPUs
- (kernel) bjorn3 fixed an interrupt race condition on ARM64 and RISC-V thanks to Andrey Turkin
- (kernel) bjorn3 fixed a memory leak
- (kernel) bjorn3 fixed and improved the debugger
- (kernel) bjorn3 fixed false positives in the debugger
- (kernel) bjorn3 implemented partial support for RISC-V on the debugger
- (kernel) bjorn3 unified the debugger code from all CPU architectures
- (kernel) bjorn3 improved the debugging output handling
- (kernel) bjorn3 replaced scrolling with wraparound on graphical debug to improve performance
- (kernel) bjorn3 updated the code to Rust 2024 edition
- (kernel) bjorn3 reduced more code duplication between x86 and x86_64
- (kernel) bjorn3 reduced code duplication in logging between CPU architectures
- (kernel) bjorn3 unified the arguments code between CPU architectures
- (kernel) bjorn3 unified the GDT handling between x86 and x86_64
- (kernel) bjorn3 simplified the panic backtrace code
- (kernel) bjorn3 fixed `rust-analyzer` on disabled code
- (kernel) bjorn3 did many code cleanups
- (kernel) Elle Rhumssa removed an unnecessary memory allocation on DTB
- (kernel) Elle Rhumssa reduced unsafe Rust code
- (kernel) Elle Rhumssa improved documentation

## Driver Improvements

- (drivers) Jeremy Soller fixed the xHCI driver in x86 on real hardware
- (drivers) Jeremy Soller fixed USB hot plugging
- (drivers) Jeremy Soller fixed some USB hubs
- (drivers) Jeremy Soller added the Thinkpad T60 PCI ID on the Intel Gigabit ethernet driver configuration
- (drivers) Jeremy Soller updated the ACPI driver to use the latest version of [Rust-OSDev](https://rust-osdev.com/)'s [`acpi`](https://github.com/rust-osdev/acpi/) crate, led by Isaac Woods. Isaac has rewritten the AML support and improved ACPI in general. Please show Isaac some love if you can.
- (drivers) bjorn3 fixed a panic in video drivers on 4K displays

## Relibc Improvements

- (relibc) Jeremy Soller fixed RISC-V
- (relibc) Jeremy Soller implemented the `pthread_getattr_np()` function
- (relibc) 4lDO2 fixed a panic
- (relibc) 4lDO2 applied more fixes to POSIX signals
- (relibc) 4lDO2 improved the safety of C pointers
- (relibc) 4lDO2 improved the [redox-rt explanation](https://gitlab.redox-os.org/redox-os/relibc#redox-rt)
- (relibc) Ibuki Omatsu implemented the `getens()` function
- (relibc) Wildan Mubarok implemented the `posix_getdents()` function
- (relibc) Wildan Mubarok implemented the `shadow.h` function group
- (relibc) Wildan Mubarok implemented the argon2 algorithm in the `crypt()` function
- (relibc) Wildan Mubarok exposed the CPU count to programs
- (relibc) Wildan Mubarok fixed a panic in the `getpeername()` function
- (relibc) Wildan Mubarok fixed the `relibc-tests` recipe
- (relibc) Wildan Mubarok fixed the `PATH` environment variable
- (relibc) Josh Megnauth implemented the `readlinkat()`, `fdopendir()`, `fdclosedir()`, and `fchmodat()` functions
- (relibc) Josh Megnauth fixed a bug that prevented symbolic link renaming
- (relibc) Josh Megnauth added a test for the `lstat()` function
- (relibc) Elle Rhumssa improved stability and security
- (relibc) Elle Rhumssa did code cleanups

## Packaging Improvements

- (pkg) Wildan Mubarok fixed the cache of downloaded packages to avoid unnecessary downloads
- (pkg) Wildan Mubarok properly implemented the offline mode of the installer
- (pkg) Wildan Mubarok implemented a plain progress bar

## Orbital Improvements

- (orb) Wildan Mubarok fixed C/C++ programs running on ARM64 and RISC-V
- (orb) Jeremy Soller added a shortcut for the GUI installer in the app menu

## Programs

- (programs) Wildan Mubarok ported rsync
- (programs) Wildan Mubarok fixed Cargo
- (programs) Wildan Mubarok fixed the GNU Bash and Git `PATH` environment variable
- (programs) Wildan Mubarok fixed the `ncurses` and `ncursesw` dynamic linking
- (programs) Josh Megnauth partially ported the **Fish shell**
- (programs) Jeremy Soller fixed many programs by compiling it as statically linked for ARM64 and RISC-V
- (programs) Jeremy Soller updated the `mpg123` (1.33.2), `libogg` (1.3.4), and `libtheora` (1.2.0) library versions
- (programs) Jeremy Soller fixed the dynamic linking of OpenAL, `mpg123`, and `libtheora` libraries
- (programs) Jeremy Soller fixed the `ncurses` static linking

## Testing Improvements

- (tests) Joshua Williams added many [POSIX signals tests](https://gitlab.redox-os.org/redox-os/redox-posix-tests)

## Debugging Improvements

- (debug) Wildan Mubarok enabled [stepping](https://en.wikipedia.org/wiki/Stepping_%28debugging%29) on GCC
- (debug) Jeremy Soller fixed the `iostat` tool

## Build System Improvements

- (build) Wildan Mubarok implemented a method to add new recipe binaries in the existing QEMU image using the `make p.recipe-name` command
- (build) Wildan Mubarok implemented the support to overwrite package files using the filesystem configuration after their installation for more flexibility and better customization
- (build) Wildan Mubarok created a recipe for Cookbook to ease self-hosting
- (build) Wildan Mubarok implemented partial self-hosting support
- (build) Wildan Mubarok implemented an environment variable to set the number of CPU threads (COOKBOOK_MAKE_JOBS) for recipe build systems to avoid the compilation to run out of memory
- (build) Wildan Mubarok fixed local compilation of meta-packages
- (build) Wildan Maubarok fixed the option to change the build method of recipes in meta-packages, like local and remote packages in the same meta-package
- (build) Wildan Mubarok reduced the recipe rebuild time
- (build) Jeremy Soller simplified CMake dynamic linking
- (build) Jeremy Soller did a recipe cleanup

## Documentation Improvements

- (doc) Ribbon added a [issue label filter](https://gitlab.redox-os.org/groups/redox-os/-/issues/?label_name%5B%5D=tracking%20issue) for tracking issues to help developers to find our development priorities and roadmap
- (doc) Ribbon improved the [build system breaking change prevention and fixing guide](https://doc.redox-os.org/book/troubleshooting.html#prevent-and-fix-breaking-changes) to cover more scenarios
- (doc) Ribbon fixed and improved the [microkernel advantages](https://doc.redox-os.org/book/microkernels.html#advantages-of-microkernels) explanation
- (doc) Ribbon added the [Better Expansion](https://doc.redox-os.org/book/microkernels.html#better-expansion) microkernel advantage
- (doc) Ribbon fixed and improved the [microkernel benefits](https://doc.redox-os.org/book/why-a-new-os.html#benefits-1) in the "Why a New OS?" page
- (doc) Wildan Mubarok did some improvements and cleanup to the porting documentation
- (doc) Wildan Mubarok documented [how to create and mount a RedoxFS partition](https://doc.redox-os.org/book/redoxfs.html#tooling)

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

The following template is for screenshots or photos

<a href="/img/screenshot/image-name.png"><img class="img-responsive" alt="Description" src="/img/screenshot/image-name.png"/></a>

-->

<!--

The following template is for YouTube videos

## Title

<iframe width="800" height="640" src="insert-the-video-embed-link-here" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

-->
