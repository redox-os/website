+++
title = "This Month in Redox - June 2024"
author = "Ribbon and Ron Williams"
date = "2024-06-30"
+++

May was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## New Orbital Visual

We changed our default wallpaper, title bar and panel bar colors to make the user experience more pleasant, you can see it below:

![New Orbital Visual](/static/img/screenshot/orbital-visual.png)

(The wallpaper is the "Tarantula Nebula" from NASA, also available on the COSMIC desktop)

## User-Space Debugging From GDB

Thanks to bjorn3 the GNU Debugger can read the Redox user-space now (where most of the system components run).

## PCI Cleanups

bjorn3 cleaned up more PCI code as usual on his series of driver cleanups and simplifications.

## Programs

Ribbon added an ABI separation on the LLVM recipe, it protect programs with a dependency on LLVM from breakage when the LLVM version is updated.

(Like most Linux distributions does)

## Documentation

Ribbon improved the [binary packages explanation](https://doc.redox-os.org/book/ch02-07-configuration-settings.html#binary-packages) and documented the [environment leakage](https://doc.redox-os.org/book/ch08-05-troubleshooting.html#environment-leakage) problem.

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).
