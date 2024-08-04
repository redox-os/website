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

## Servo and Redox Proposal for NGI Sargasso

[Servo](https://servo.org/) and Redox have partnered for a joint application for funding by [NGI Sargasso](https://ngisargasso.eu/)!

The proposed project includes porting SpiderMonkey and WebRender to Redox,
improvements to Servo's cross-compilation support, and a written-in-Rust font stack.
The application was submitted for NGI Sargasso's Open Call 4, and we await their response.

Thanks to [Igalia](https://www.igalia.com/) and the Servo team for partnering with us!

## NLnet Redox Signals project

The funding for the [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/) project has been finalized!
As part of the [NGI Zero Core Fund](https://nlnet.nl/core), NLnet will be donating 26,500 EUR,
covering implementation of POSIX-style signals and process lifecycle management in userspace.

4lDO2 has moved the bulk of the signal handling code into our libc alternative, `relibc`.
He has also implemented a large chunk of process lifecycle management,
so Redox now handles the Session/Process Group/Process/Thread hierarchy more correctly.
One area that has shown lots of improvement is the handling of thread and process exit.
Some programs that were hanging on exit are now exiting cleanly;
this is most notable for build tools, including Cargo.

You can read about some of this work in his recent news post, [Towards userspaceification of POSIX - part I](https://www.redox-os.org/news/kernel-11/).

## Web Servers

Redox now has a working web server!

[Simple HTTP Server](https://github.com/TheWaWaR/simple-http-server) is an advanced HTTP web server written in Rust.
Contributor Bendeguz Pisch has gotten the server to work and has successfully served a website.

He is also improving the Apache HTTP Server port.

## Self-Hosting Update

We finally successfully built Hello World programs in Rust, C and C++ inside of Redox!

4lDO2 also fixed Cargo and built a Hello World program from it.

It's a first step to test the compilation of more complex programs inside of Redox.

## Kernel Improvements

Andrey Turkin improved the ARM64 code on the kernel, and fixed some of the debug code.

## UEFI Improvements

bjorn3 fixed a violation of the UEFI specification (calling runtime services with interrupts enabled) and added workarounds for buggy firmware.

These changes will allow more computers to boot Redox.

## Userspace Improvements

- bjorn3 updated most system daemons to use the new scheme format.

## Driver Improvements

- bjorn3 fixed an undefined bahvior bug on the ps2d driver's vmmouse implementation.
- 4lDO2 fixed a panic on the inputd driver and updated the dependencies of all drivers.
- The contributor Ramla Ijaz fixed some bugs.
- bjorn3 updated most drivers to use the new scheme format.
- bjorn3 did a cleanup of the graphics subsystem and ran `rustfmt` on the entire code.

## Relibc Improvements

- 4lDO2 moved the POSIX singals implementation from the kernel to relibc and added stubs for the `setresuid` and `setresgid` functions.
- The contributor Derick Eddington fixed four incorrectness bugs on relibc.
- The contributor plimkilde refactored the `rand48` functions to reduce unsafe code.
- plimkilde improved the `random_bool()` function by adding the missing modulo.

## Programs

wget is finally working thanks to 4lDO2 and Ribbon!

Now COSMIC Terminal and Nushell can exit properly.

- 4lDO2 fixed most known bugs on the COSMIC programs
- Ron Williams fixed the Helix text editor.
- bjorn3 converted the Orbital recipes to TOML, fixing the "desktop-minimal" variant.
- Ribbon converted more recipes to TOML to remove obsolete and broken code from our package system.

More exciting Rust programs were packaged as usual.

## Orbital Improvements

- Ribbon configured Orbital to launch the FFMPEG media player (ffplay) when video and audio files are opened from graphical programs.

## Build System Improvements

- bjorn3 updated the system configuration on the filesystem configuration to use the new scheme format.
- bjorn3 converted the standalone Orbital recipes to TOML.
- bjorn3 improved the driver development experience by adding a symbolic link to the `drivers` code in the `drivers-initfs` recipe.
This eliminates the duplication of the source tree of the `drivers` recipe,
so any driver changes/debug code will appear in both the regular and `initfs` versions automatically.
- Ribbon improved the `dev.toml` filesystem configuration to improve our tests inside of Redox, like self-hosting compilation.
- Ribbon renamed the `vga` and `efi` QEMU options to `gpu` and `uefi`, to avoid confusion with the VGA interface (the `vga` option on QEMU to select the video type) and the old UEFI revision (the final revision of EFI is called UEFI)
- Ribbon enabled the `shell` data type to easily change the default terminal shell before boot.
- Ribbon updated the GCC and LLVM package versions for the MacOSX target, GCC was updated from versions 4.9/7.x to 14.x and LLVM from 16 to 18.

## Other Improvements

- The contributor ids1024 fixed the strace compilation without the "advanced" feature flag.
- Andrey Turkin fixed the warnings on the redox_liner crate.

## Documentation

A list of the improvements this month:

- The contributor Deft Punk improved the wording and grammar of the book.
- Now the book recommends the [Gentoo](https://gentoo.org) package documentation for dependency configuration on recipes and [FreeBSD](https://freebsd.org) to find C/C++ feature flags easily. The Gentoo dependency classification helps a lot with not/poorly documented C/C++ programs and libraries.
- The "Weekly Images" section was renamed "Daily Images" on the "Running Redox in a virtual machine" and "Running Redox on real hardware" pages, it was called "weekly" because breaking changes stopped the image update for weeks, but they are configured to be created daily.
- Some sections of the website FAQ were copied to the book, it improved the reading and information distribution (to make things easier to find).
- The "Scripts" section on the "Build System" page was improved, a command was added to sort in alpahbetical order the output of the include-recipes.sh script, it will save time from packagers adding recipes to the package build server configuration.
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
