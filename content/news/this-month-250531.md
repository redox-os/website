+++
title = "This Month in Redox - May 2025"
author = "Ribbon and Ron Williams"
date = "2025-05-31"
+++

Redox OS is a Unix-like general-purpose microkernel-based operating system
written in Rust. May was a very exciting month for Redox! Here's all the latest news.

- GTK 3 Demo running on Redox

<a href="/img/screenshot/gtk3.png"><img class="img-responsive" alt="GTK 3 Demo running on Redox" src="/img/screenshot/gtk3.png"/></a>

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Redox is hiring!

Redox is seeking an OS/kernel developer, based in the EU, for a one year position, paid through a combination of grants and contract work, with the possibility of additional work to follow. If you are a committed FOSS developer, with expertise in Rust, device drivers and performance-optimized software, we are interested in hearing from you.

This is a fully remote position, but based in the EU for the reasons described below.

### Responsibilities

- Implement performance improvements such as ring-buffer based device drivers and services, smart schedulers and techniques to reduce context switching
- Implement POSIX, WASI and other OS APIs
- Implement security and virtualization features
- Write blog posts and other documentation describing the work
- Participate in developer chat related to the work
- Support applications for grants, create deliverables and report milestone completion

### Qualifications

- University degree in Computer Science or a related field, or self-taught equivalent
- Demonstrated track record in operating system or low level software development
- Rust expertise, especially in no_std and bare-metal contexts
- Substantial body of work in open source
- Able to work independently at a high level of productivity
- Able to interact positively with community members of varying skills and backgrounds
- Flexibility in how payments are received - a portion of your compensation may be in the form of grants from other foundations, and there may be some adjustments in the compensation amounts due to differences in the tax treatments for grants
- As some of our current grants (and potential future grants) are from EU organizations, preference will be given to EU-based developers, and in particular, countries where the tax treatment of grants is advantageous; we hope to have opportunities in future that are open more broadly
- Please see https://philea.eu/how-we-can-help/policy-and-advocacy/analysing-the-legal-environment-for-philanthropy-in-europe/ for more information about tax treatment of grants for individuals

Please email your resume/CV, and a list of your most significant open source contributions, with links, to info@redox-os.org and CC president@redox-os.org

## Redox is looking for new board members!

Jacob Schneider, who has been a Redox director since January 2024, has resigned due to other commitments. We want to thank Jacob (JCake) for his contributions to Redox, and we wish him the best in future endeavors!

Redox would like to add two volunteers to the board of directors. The board is responsible for the governance and guidance of the Redox financials, community and the Redox OS brand. We have a formal meeting every quarter, and we have a chat room where we discuss issues like fundraising and such.

We are particularly looking for people who have been contributing to Redox, but we are open to volunteers from the broader FOSS community. As this is a position of trust, we will either need to know you or know someone who knows you. And you must be above the age of majority in your area.

The position of director is unpaid, but there is no rule preventing you from doing paid work for Redox, if and when such an opportunity exists. However, we would very much like to add at least one board member who has no interest in being paid for work for Redox.

Please contact Ron Williams on Matrix, or email president@redox-os.org

## X11 on Redox!

Jeremy Soller has implemented X11 support in the Orbital display server!! This allows programs using X11 to work on Redox without changes to the GUI code.

The mechanism for X11 support is conceptually similar to how Wayland supports X11 programs through XWayland. He also enabled the [DRI](https://en.wikipedia.org/wiki/Direct_Rendering_Infrastructure) backend to improve rendering performance, although it does not yet fully support graphics acceleration.

It is expected that this code will become part of our Wayland support.

- xeyes running on Redox

<a href="/img/screenshot/xeyes.png"><img class="img-responsive" alt="xeyes running on Redox" src="/img/screenshot/xeyes.png"/></a>

- X11 programs running on Redox

<a href="/img/screenshot/x11.png"><img class="img-responsive" alt="X11 programs running on Redox" src="/img/screenshot/x11.png"/></a>

- glxgears running on Redox

<a href="/img/screenshot/glxgears.png"><img class="img-responsive" alt="glxgears running on Redox" src="/img/screenshot/glxgears.png"/></a>

- xterm running on Redox

<a href="/img/screenshot/xterm.png"><img class="img-responsive" alt="xterm running on Redox" src="/img/screenshot/xterm.png"/></a>

## GTK 3 on Redox!

After X11 Jeremy Soller successfully ported the GTK 3 toolkit!!

## Mesa3D EGL on Redox!

Jeremy Soller enabled the Mesa3D EGL!!

It will improve the X11 2D rendering.

## More Boot Fixes

bjorn3 updated the `lived` configuration to allow the livedisk image to work when other storage drivers aren't initialized. If you were having problems with the daily images hanging part way through booting, consider trying again once the images are updated or build the image from source. This fix provides a workaround for some systems where the disk driver was hanging when reading a non-RedoxFS disk.

## Kernel Improvements

- (kernel) Ivan Tan fixed a problem with ARM64/Raspberry Pi 3B+ timer interrupts that was causing programs to not be correctly woken after sleep

## Driver Improvements

- (drivers) bjorn3 improved the PS/2 driver debugging by giving better panic locations
- (drivers) Arne de Bruijn implemented the support for the Right+Ctrl key combination on the PS/2 driver

## System Improvements

- (system) Jeremy Soller created the `/var` directory and its sub-directories to comply with the Linux [FHS](https://refspecs.linuxfoundation.org/FHS_3.0/fhs/index.html) standard and make some programs work
- (system) bjorn3 enabled the boot switch to VT 2 on the `minimal` variant to reduce confusion about if boot was hanging or not

## Relibc Improvements

- (relibc) Jeremy Soller fixed a deadlock when logging scopes
- (relibc) Jeremy Soller fixed a dangling pointer with empty scandir
- (relibc) Jeremy Soller fixed the DTPMOD and DTPOFF relocation
- (relibc) Jeremy Soller fixed select macros
- (relibc) Jeremy Soller improved the `scanf()` parsing
- (relibc) Jeremy Soller added support for extended regex
- (relibc) Jeremy Soller implemented the `flink()` function
- (relibc) Jeremy Soller improved the dynamic linker debugging
- (relibc) Jeremy Soller moved the `htonl()`, `htons()`, `ntohl()` and `ntohs()` functions to the `netinet/in.h` function group to port more programs
- (relibc) Josh Megnauth improved the error handling for functions that make DNS requests
- (relibc) zinzaguras improved the GNU Bash shebang in scripts

## Programs

- (programs) Jeremy Soller fixed the libgif, libwebp, libgcrypt and libgpg-error libraries
- (programs) Jeremy Soller fixed the libass compilation
- (programs) Jeremy Soller ported the [PCRE2](https://github.com/PCRE2Project/pcre2) and libtasn1 libraries
- (programs) Jeremy Soller updated the Pango version to 1.56.3
- (programs) Jeremy Soller updated the Cairo version to 1.18.4
- (programs) Jeremy Soller updated the Pixman version to 0.46
- (programs) Jeremy Soller updated the Fontconfig version to 2.16.0
- (programs) Jeremy Soller updated the libjpeg to version to 9f
- (programs) Jeremy Soller updated the libass version to 0.17.3
- (programs) Jeremy Soller updated the libxslt version to 1.1.43
- (programs) Jeremy Soller updated the libsoup version to 3.6.5
- (programs) Jeremy Soller updated the libwebp version to 1.5.0
- (programs) Jeremy Soller updated the libgif version to 5.2.2
- (programs) Jeremy Soller updated the libgcrypt version to 1.11.1
- (programs) Jeremy Soller updated the libgpg-error version to 1.55
- (programs) Jeremy Soller enabled dynamic linking on SQLite, curl, libnettle, GnuTLS, libxml2, XZ, libogg, libvorbis, libjpeg, PCRE, libexpat, gdk-pixbuf, libsndfile, libmodplug, libpsl and jansson
- (programs) Jeremy Soller enabled more features on GStreamer
- (programs) Jeremy Soller converted the gdk-pixbuf recipe to TOML
- (programs) Jeremy Soller made significant progress on porting WebKitGtk (still WIP)
- (programs) Josh Megnauth fixed the RustPython compilation
- (programs) Fabio Di Francesco fixed the Gigalomania and SDL2 Gears dynamic linking
- (programs) Ribbon packaged some programs
- (programs) Ribbon fixed some WIP recipes and updated more TODOs

## Build System Improvements

- (build-system) Jeremy Soller implemented a Cookbook template for Meson to simplify the recipe configuration
- (build-system) zinzaguras implemented NixOS support on the Native Build

## Documentation Improvements

- (doc) Ribbon applied many improvements, fixes and cleanup to the [porting documentation](https://doc.redox-os.org/book/porting-applications.html)
- (doc) Ribbon improved the [Microkernels](https://doc.redox-os.org/book/microkernels.html) page
- (doc) Ribbon replaced Rufus by [balenaEtcher](https://etcher.balena.io/) as the recommended method to flash the Redox image to a USB drive on Windows
- (doc) Ribbon added the porting recomendation to use the FreeBSD dependencies of programs to avoid Linux-specific kernel features present on Linux dependencies which don't work on Redox
- (doc) Ribbon documented `source.script` data type used for applying patches and other recipe source changes
- (doc) Ron Williams wrote and Ribbon added a recipe script template for Cargo profiles
- (doc) Ron Williams wrote and Ribbon added a recipe script template for Cargo examples with flags
- (doc) Ribbon added links for the GCC, LLVM and Rust cross-compilers fork sources in the [porting documentation](https://doc.redox-os.org/book/porting-applications.html#cross-compiler)
- (doc) Ribbon improved and fixed the Cookbook template explanations
- (doc) Ribbon fixed and improved the explanation about the new linkage system
- (doc) Ribbon improved the explanation of recipe data types
- (doc) Ribbon removed the wrong information about "Automagic Dependencies" (but it can be added again once we start to use Cookbook for native compilation)
- (doc) Ribbon documented a practice of some Rust programs and libraries to use Cargo packages instead of Cargo examples for their examples
- (doc) Ribbon fixed the explanation of the `scripts/recipe-match.sh` and `scripts/print-recipe.sh` scripts
- (doc) Ribbon added a note on the `make r.recipe` command explanation explaining that it can't be used to replace the `make all`, `make prefix` and `make fstools` commands
- (doc) David da Silva fixed some typos on the book

## How To Test The Changes

To test the changes of this month download the `server` or `desktop` variants of the [daily images](https://static.redox-os.org/img/).

(Use the `server` variant for a terminal interface and the `desktop` variant for a graphical interface, if the `desktop` variant doesn't work use the `server` variant)

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

## Discussion

Here are some links to discussion about this news post:

- [floss.social @redox](https://floss.social/@redox/114626030138919154)
- [X/Twitter @redox_os](https://x.com/redox_os/status/1930299891013571008)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/1l3a19n/this_month_in_redox_may_2025/)
- [Reddit /r/rust](https://www.reddit.com/r/rust/comments/1l3a32m/this_month_in_redox_may_2025/)

<!--

The following template is for screenshots or photos

<a href="/img/screenshot/image-name.png"><img class="img-responsive" alt="Description" src="/img/screenshot/image-name.png"/></a>

-->

<!--

The following template is for YouTube videos

## Title

<iframe width="800" height="640" src="insert-the-video-embed-link-here" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

-->
