+++
title = "Redox Summer of Code 2023 Wrapup"
author = "Ron Williams and Jeremy Soller"
date = "2023-09-04"
+++

This year's Redox Summer of Code program has seen us add some exciting capabilities to Redox. Our three interns each came up with their own project proposals, and delivered major new functionality. In addition to our paid internships, our volunteer contributors also made major strides this summer.

## Redox Summer of Code Projects

### VirtIO drivers - Andy-Python-Programmer

Andy is the creator of the [Aero Operating System](https://github.com/Andy-Python-Programmer/aero). For his first RSoC internship this year, Andy suggested implementing the VirtIO standard for Redox, for use when running Redox in a virtual machine/emulator such as QEMU.  This allows Redox to support a variety of devices efficiently, and will allow us to add GPU acceleration when running in an emulator. Andy has completed block device and network drivers, as well as 2D graphics. 3D acceleration is still to come.

You can read about Andy's work on VirtIO [here](/news/rsoc-virtio-1) and [here](/news/rsoc-virtio-2). Here's a [recent interview](https://blog.rust.careers/post/andy-python-interview/) with Andy where he discusses Redox, Aero, and his work on VirtIO.

### Revirt-U and using Linux drivers on Redox - Enygmator

This is Enygmator's third RSoC internship. Their goal: To have a Linux instance running in a virtual machine on Redox, giving Redox the ability to use Linux's device drivers. This requires implementing virtual machine infrastructure for Redox (Revirt-U) plus a way to communicate from Redox to the Linux instance. It will greatly expand Redox's driver compatibility when running on real hardware, without sacrificing Redox's separation of drivers from the kernel.

You can read about Enygmator's work [here](/news/rsoc-2023-eny-1). Congratulations to Enygmator on their recent graduation and new job!

### On-demand paging - 4lDO2

Back for his fourth RSoC (he never really left, he's been a constant contributor), 4lDO2 has added on-demand paging and other memory management enhancements. This work is quite broad in scope, as it replaces not only how memory management works for applications, but also kernel access to user-space memory, application sharing of memory with device drivers, and even how physical hardware addresses are mapped to virtual addresses in user-space device drivers. It also gives a nice performance bump, and leaves room for further memory management optimization.

You can read about 4lDO2's work [here](/news/kernel-8) and [here](/news/kernel-9).

## Other Contributions

Our many volunteer contributors continue to help move Redox forward. Our focus this summer has been on improving Redox compatibility with POSIX and Linux.

We have our own implementation of the C standard library called `relibc`, compatible with Linux and Redox. We have rewritten many `libc` functions in Rust. Redox has also moved large chunks of functionality from the kernel into user-space, and a lot of that functionality can be found in the Redox variant of `relibc`. This summer, we've had eight different contributors to `relibc`, with a few of the additions being:

- various time and clock related functions
- group id handling
- wide-char/wide-string functions
- improved ARM64/AArch64 compatibility
- several memory management related improvements
- a few bug fixes

Some other contributions and accomplishments this summer include:

- Rust GUI libraries [Slint](https://slint.dev/) and [Iced](https://iced.rs/) both have upstream support for Redox's Orbital Windowing System as a backend, using the [softbuffer](https://github.com/rust-windowing/softbuffer) and [winit](https://github.com/rust-windowing/winit) crates.
- Some elements of the [Cosmic Desktop](https://github.com/pop-os/cosmic-epoch) have been tested against Redox, in particular [cosmic-text](https://github.com/pop-os/cosmic-text) and [libcosmic](https://github.com/pop-os/libcosmic).
- Rust code cleanup (move to 2021 Edition and removal of warnings) is ongoing. Some of our new contributors are helping out here.
- We have a draft implementation of the 9p protocol, which will allow Redox running in QEMU to access the host Linux filesystem.
- [nushell](https://www.nushell.sh/) is essentially working - it doesn't exit cleanly but is otherwise ok.
- [crossterm](https://github.com/crossterm-rs/crossterm) is working well, although there are some improvements to be done on the Redox side before we upstream our changes.
- A few hundred FOSS applications have been packaged for cross-compilation to Redox. Most of these programs do not yet work, but it has helped us improve our build system and prioritize our POSIX and Linux compatibility work.

## Request for Donations

For those of you that would like to provide financial support for Redox and our Summer of Code program, you can donate using these links:

- [Patreon](https://www.patreon.com/redox_os)
- [Donorbox](https://donorbox.org/redox-os)
- Or see our [Donations](/donate) page for more options.

Or consider supporting one of the many Open Source projects that we depend on, e.g.:

- [ACPI in Rust](https://github.com/rust-osdev/acpi)
- [uutils (CoreUtils in Rust)](https://github.com/uutils/coreutils)
- Or your favorite Written-in-Rust application - Join us on [Matrix Chat](/community) to let us know what it is!

## Find Out More

If you have questions, join us on [Matrix Chat](/community)! You can see other
discussions of this post on social media at the links below:

- [Fosstodon (Mastodon)](https://fosstodon.org/@redox/111012742441776976)
- [Hacker News](https://news.ycombinator.com/item?id=37391282)
- [Lemmy.world](https://lemmy.world/post/4492733)
- [Patreon](https://www.patreon.com/posts/88801964?pr=true)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/16ao25r/redox_summer_of_code_2023_wrapup/)
- [Twitter](https://twitter.com/redox_os/status/1699049750031708611)
