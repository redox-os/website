+++
title = "Toolchain Upgrade"
author = "Ribbon"
date = "2023-09-12"
+++

We are happy to announce that our [rustc](https://github.com/rust-lang/rust), [GCC](https://gcc.gnu.org/) and [LLVM](https://llvm.org/) forks have been updated to a recent version.

While rustc and LLVM had recent versions for a long time, GCC was at version 8.2.0 from 2018.

As GCC is used to build all recipes (software ports) written in C and C++, many improvements will come to Redox programs!

### Current Versions

- rustc - [1.74.0-nightly](https://gitlab.redox-os.org/redox-os/rust/-/tree/redox-2023-09-07?ref_type=heads)
- GCC - [13.2.0](https://gitlab.redox-os.org/redox-os/gcc/-/tree/redox-13.2.0?ref_type=heads)
- GNU Binutils - [2.41](https://gitlab.redox-os.org/redox-os/binutils-gdb/-/tree/redox-2.41?ref_type=heads)
- LLVM - [17.0.0-rc4](https://gitlab.redox-os.org/redox-os/llvm-project/-/tree/redox-2023-09-07?ref_type=heads)

### Developers

If you are a developer/tester of Redox, we recommend that you download a new build system copy.

You can do that by running the [bootstrap.sh](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/bootstrap.sh?ref_type=heads) script again or running the commands from [this](https://doc.redox-os.org/book/advanced-build.html#clone-the-repository) page.

Pop OS and Ubuntu are the recommended Linux distributions for development and Podman for others, there's partial support for Arch Linux, FreeBSD, MacOSX and openSUSE, but you could have problems.

If you have problems with other distributions, use the Podman [method](https://doc.redox-os.org/book/podman-build.html).

### Known Issues

- NetSurf compilation is not working with non-Debian distributions.

To fix this you need to remove the NetSurf recipe from your build configuration file (config/$ARCH/your-config.toml) or read [this](https://doc.redox-os.org/book/developer-faq.html#i-tried-all-methods-of-the-troubleshooting-the-build-page-and-my-recipe-doesnt-build-what-can-i-do) section.
