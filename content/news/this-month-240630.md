+++
title = "This Month in Redox - June 2024"
author = "Ribbon and Ron Williams"
date = "2024-06-30"
+++

June was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Funding!

### NLnet NGI Zero Core

We are very excited to announce that the [NGI Zero Core](https://nlnet.nl/thema/NGIZeroCore.html) program
from the [NLnet Foundation](https://nlnet.nl/)
will be funding our project [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/).

Redox currently has a basic implementation of Signals, but this project will allow us to move most of signals code
out of the kernel into user-space, and bring us much closer to POSIX compliance.

The project also includes a Process Manager Daemon in user-space,
to manage the session/process group/process/thread hierarchy, especially with respect to signals,
and to help support [sigqueue](https://pubs.opengroup.org/onlinepubs/009695399/functions/sigqueue.html).

4lDO2 will do the heavy lifting on this project,
with the Redox team creating a test suite for the work and acting as backup for bug fixes.

### Radworks

[Radworks](https://radworks.org/) has very generously provided a donation of $13,000 USD in USDC and Rad tokens
using the [Drips Network](https://drips.network/), to support Redox's [termion](https://gitlab.redox-os.org/redox-os/termion) library.

The [Radicle](https://radicle.xyz/) project is funded by Radworks.
"Radicle is a sovereign peer-to-peer network for code collaboration, built on top of Git."

The `termion` library, a Redox sub-project, is a terminal manipulation library used for writing text-based user interfaces (TUI),
written in Rust, and supporting Linux, Redox, BSD, and Mac OS X.
`termion` is a dependency of Radicle.

## New Orbital Visual

We changed our default wallpaper, title bar and panel bar colors to make the user experience more pleasant, you can see it below:

<a href="/img/screenshot/orbital-visual.png"><img class="img-responsive" alt="New Orbital Visual" src="/img/screenshot/orbital-visual.png"/></a>

The wallpaper is the [Tarantula Nebula](https://webbtelescope.org/contents/media/images/2022/041/01GA76MYFN0FMKNRHGCAGGYCVQ) from NASA, also available on the COSMIC desktop.

## Software Showcase 1

We have uploaded our first software showcase to our [YouTube channel](https://www.youtube.com/@RedoxOS)!
This is just a small part of the software that works on Redox.
We will be uploading more showcases in the near future.
Like, Subscribe, and Comment to help bring more attention to Redox!

<iframe width="800" height="640" src="https://www.youtube.com/embed/s-gxAsBTPxA?si=EbIRLwIrnuiwfvYZ" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

## Performance Improvements

4lDO2 doubled the RedoxFS performance by reducing the number of context switch roundtrips per block read and write.

He also applied this improvement on the SATA, NVMe, USB SCSI and VirtIO Block drivers.

## Relibc Improvements

The `pread()` and `pwrite()` functions are now implemented using the proper syscalls (rather than seek-based emulation) in relibc.
This is part of an effort to improve the handling of file offsets across Redox.

## Scheme Improvements

4lDO2 improved the `redox-scheme` crate and the scheme protocol to provide a cleaner API for drivers and daemons.

He updated `bootstrap` and `initfs` to use the new scheme interface.

## User-Space Debugging From GDB

Thanks to bjorn3, the GNU Debugger, running outside the VM,
can read the Redox user-space tasks when the `gdbserver` is not available.
This is helpful if you are debugging, for example, drivers during startup, but is not for general use.

## USB Improvements

bjorn3 added a 2ms sleep on the poll loop of the xHCI driver to reduce the CPU usage a lot,
while we await the implementation of xHCI interrupts.

Quoting his MR description:

"This significantly reduces cpu usage. On my laptop before this change a
single core would be fully loaded while running at 3-4GHz. With this
change it would only be loaded for about 50% while running at 1-2GHz.
This improves battery lifetime while also preventing the fan from
spinning up to a distracting level.

This shouldn't noticably affect latency given that most keyboards and
mice don't support polling at 500Hz anyway."

## PCI Improvements and Cleanup

Continuing his work on driver cleanup and improvement,
bjorn3 did a wide-ranging cleanup of the PCI/PCIe driver, refactoring, removing unneeded code,
and generally improving the clarity and maintainability of the code.

## VirtIO Improvements

bjorn3 implemented the Modern transport for our x86 VirtIO drivers.
The original implementation was using the Legacy transport,
which is not commonly used.

## Recoverable Components

4lDO2 adapted the `lived` system component to use the new offset-based read/write scheme protocol!

On microkernel-based operating systems, it is desirable to have most system components able to be restarted in case of a crash,
without needing a system reboot.
Using the offset-based read/write protocol allows us to remove file position tracking from the driver,
bringing us one step closer to having the ability to restart drivers.

## Programs

Ribbon added an ABI separation on the LLVM recipe, to protect programs with a dependency on LLVM from breakage when the LLVM version is updated.

(Like most Linux distributions does)

He also fixed many recipe scripts, many Rust programs built successfully for the first time!

Many Rust libraries were fixed with the recent changes on Redox, Ribbon is checking the TODOs of each program.

Many WIP software ports were missing cross-compilation scripts for CMake, Ribbon fixed this.

These CMake scripts may be incomplete but it saves a lot of time from packagers trying to complete our cross-compilation scripts.

## Build System Improvements

Contributor grnmeira discovered that our "server-minimal" variant lacked network support and created confusion about the name.

Based on 4lDO2's suggestion for the new variant name, Ribbon renamed the "server-minimal" configuration to "minimal".

He also created the "minimal-net" configuration for network support.

Now the most minimal OS image is called "minimal"

We have not yet attempted to make the "minimal" system suitable for a truly minimal computer,
but we have several ideas for future improvement.

Ribbon added the "Development Tools" package group from Fedora to our setup script `bootstrap.sh`, to avoid missing any development packages and reduce the number of items to be installed for the Fedora target in the script.

## USB Support Status

When we announced the support for USB input devices on the [April report](https://www.redox-os.org/news/this-month-240430/) we neglected to update the documentation to change the USB status.

We recently added support for USB input devices, and this support is being improved,
but it is to be expected that some devices are not working.

Our nightly images have been frozen since May 30, so if you tested after that date you would not have received the latest improvements for USB.

If you want to test the latest USB improvements we recommend that you download the build system and build the Redox image, you can learn how to that on [this](https://doc.redox-os.org/book/ch02-05-building-redox.html) page.

## Documentation

Ribbon updated the book to say that USB input devices are supported, improved the [binary packages explanation](https://doc.redox-os.org/book/ch02-07-configuration-settings.html#binary-packages) and documented the [environment leakage](https://doc.redox-os.org/book/ch08-05-troubleshooting.html#environment-leakage) problem.

He also documented how Redox took inspiration from OpenBSD on the "BSD" part of [this](https://www.redox-os.org/faq/#how-redox-is-inspired-by-other-systems) section of the website FAQ.

Quoting the section:

- [OpenBSD](https://www.openbsd.org/) - Redox took inspiration from the [system call](https://man.openbsd.org/pledge.2), [filesystem](https://man.openbsd.org/unveil.2), [display server](https://www.xenocara.org/) and [audio server](https://man.openbsd.org/sndiod.8) sandbox and [others](https://www.openbsd.org/innovations.html).

## Website

Ribbon improved our FAQ as always, he improved some benefits of Redox and the image variants information.

He also updated the FAQ to report that we support USB HID devices, improved the Community page to recommend Fractal instead of Nheko as a Matrix client alternative for Element, because it's written in Rust, better maintained and has advanced features.

## Discord Server

We now have a Discord server! It's for people that don't want to use Matrix, and hopefully it will be more convenient.

The messages from Matrix are sent to Discord and the messages from Discord are sent to Matrix througn a Matrix bridge bot.

Once you join the server, request to be a member on the #join-requests room.

You can open the invite [here](https://discord.gg/JfggvrHGDY).

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).
