+++
title = "This Month in Redox - July 2024"
author = "Ribbon and Ron Williams"
date = "2024-07-31"
+++

July was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Massive Performance Improvements

4lDO2 reduced the time to make a context switch by 60-70% !

Redox is becoming faster than Linux in some workloads (with all exploit mitigations disabled), more exciting optimizations are coming.

## POSIX Signals

4lDO2 started to move the POSIX signals implementation from the kernel to userspace.

You can read his post about the work on [this](https://www.redox-os.org/news/kernel-11/) link.

## Web Servers

We successfully compiled and executed the first web server on Redox!

[Simple HTTP Server](https://github.com/TheWaWaR/simple-http-server) is an advanced HTTP web server written in Rust, the contributor lgh-127001 successfully served a website.

He is also improving the Apache HTTP Server port.

## Self-Hosting Update

We finally successfully built Rust, C and C++ Hello World programs!

4lDO2 also fixed Cargo and built a Hello World program from it.

It's a first step to test the compilation of more complex programs.

## Kernel Improvements

- Andrey Turkin improved the ARM64 code on the kernel.
- Andrey Turkin fixed the debug code of the kernel.

## Userspace Improvements

- bjorn3 updated most system daemons to use the new scheme format.

## Driver Improvements

- bjorn3 fixed an undefined bahvior bug on the ps2d driver's vmmouse implementation.
- 4lDO2 fixed a panic on the inputd driver and updated the dependencies of all drivers.
- The contributor Ramla Ijaz fixed some bugs.
- bjorn3 updated most drivers to use the new scheme format.
- bjorn3 improved the driver development by adding a symbolic link on the `drivers-initfs` recipe configuration to use the source code of the `drivers` recipe, now developers will have less problems to test their changes inside of Redox.
- bjorn3 did a cleanup of the graphics subsystem and ran `rustfmt` on the entire code.

## Relibc Improvements

- 4lDO2 moved the POSIX singals implementation from the kernel to relibc and added stubs for the `setresuid` and `setresgid` functions.
- The contributor Derick Eddington fixed four incorrectness bugs on relibc.
- The contributor plimkilde refactored the `rand48` functions to reduce unsafe code.
- plimkilde improved the `random_bool()` function by adding the missing modulo.

## Programs

wget is finally working thanks to 4lDO2 and Ribbon!

- 4lDO2 fixed most bugs on the COSMIC programs
- Ron Williams fixed the Helix text editor.
- bjorn3 converted the Orbital recipes to TOML, fixing the "desktop-minimal" variant.
- Ribbon converted more recipes to TOML to remove obsolete and broken code from our package system.

More exciting Rust programs were packaged as usual.

## Orbital Improvements

Ribbon configured Orbital to launch the FFMPEG media player (ffplay) when video and audio files are opened from graphical programs.

## Build System Improvements

- bjorn3 updated the system configuration on the filesystem configuration to use the new scheme format.
- bjorn3 converted the standalone Orbital recipes to TOML.
- Ribbon improved the `dev.toml` filesystem configuration to improve our tests inside of Redox, like self-hosting compilation.
- Ribbon renamed the `vga` and `efi` QEMU options to `gpu` and `uefi`, it avoid confusion with the VGA interface (the `vga` option on QEMU select the video type) and the old UEFI revision (the final revision of EFI is called UEFI)
- Ribbon enabled the `shell` data type to easily change the default terminal shell before boot.
- Ribbon updated the GCC and LLVM package versions for the MacOSX target, GCC was updated from versions 4.9/7.x to 14.x and LLVM from 16 to 18.

## Other Improvements

- The contributor ids1024 fixed the strace compilation without the "advanced" feature flag.
- Andrey Turkin fixed the warnings on the redox_liner crate.

## Documentation

A list of the improvements this month:

- The contributor Deft Punk improved the wording and grammar of the book.
- Now the book recommend the [Gentoo](https://gentoo.org) package documentation for dependency configuration on recipes and [FreeBSD](https://freebsd.org) to find C/C++ feature flags easily, the Gentoo dependency classification helps a lot with not/badly documented C/C++ programs and libraries.
- The "Weekly Images" section was renamed "Daily Images" on the "Running Redox in a virtual machine" and "Running Redox on real hardware" pages, it was called "weekly" because breaking changes stopped the image update for weeks, but they are configured to be created daily.
- Some sections of the website FAQ were copied to the book, it improved the reading and information distribution (more easy to find).
- The "Scripts" section on the "Build System" page was improved, he added a command to sort in alpahbetical order the output of the include-recipes.sh script, it will save time from packagers adding recipes to the package build server configuration.
- Now the website and book READMEs recommend the [lychee](https://lychee.cli.rs/) tool to verify broken links
- Now the website READMEs has instructions to install [Hugo](https://gohugo.io/)
- Ribbon added explanation comments on most configuration files of the build system.
- Wildan Murdock copied the instructions to build a recipe with relibc on the relibc README.
- Ribbon did a big cleanup of the comments on the configuration files of the build system.
- Ribbon updated the screenshots of the `redox` repository README.

## Website Improvements

- Now the Home page is clear that we aim to be a complete Linux/BSD alternative.
- The RedoxFS section context on the FAQ was fixed.
- Some sections of the FAQ were improved.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).
