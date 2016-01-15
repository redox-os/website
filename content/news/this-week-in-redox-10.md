+++
title = "This Week in Redox 10"
author = "Ticki"
date = "2016-01-15T19:34:48+01:00"
+++

This is the 10th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

You might have been wondered why no update on the progress of Redox OS have appeared over the last couple of weeks. The reason is that we all have been busy with the holidays ... but don't worry! We have done _a lot_ of stuff on Redox.

*(edited by Ticki)*

# What's new in Redox?


- We got lots of new concurrent data structures! `mpsc` and `sync_mpsc` ([@ticki](https://github.com/ticki)), `RwLock` and `Mutex` ([@jackpot51](https://github.com/jackpot51))

- [@ticki](https://github.com/ticki) has set up a Mattermost server (alternative to Slack chat), which we are now using instead of Slack. Contact Ticki for invites.

- [@imp](https://github.com/imp) have been working a lot on PCI and PIO.

- [@jackpot51](https://github.com/jackpot51) have been working and fixing bugs in: DSDT, SSDT, OHCI, EHCI, HID, UHCI.

- [@ticki](https://github.com/ticki) have created an ANSI compatible terminal emulator.

- [@stratact](https://github.com/stratact) have removed a lot of `unsafe`s in the kernel.

- [@ticki](https://github.com/ticki) have made the buffering structure of Sodium generic.

- [@jackpot51](https://github.com/jackpot51) is working on a big refactoring of Orbital (WM).

- Linking with name mangling is now working.

- [@ticki](https://github.com/ticki) have made the interrupt handler handle IRQs (controlling systimer, keyboard controller, ACPI etc.) 5-11x faster.

- [@polymetric1](https://github.com/polymetric1) have rustfmt'ed large parts of Redox, making the coding style more uniform.

- [@hauleth](https://github.com/hauleth) is working on Redox's own core-utils.

- [Sodium](https://github.com/redox-os/sodium) (text editor) and [Orbclient](https://github.com/redox-os/orbclient) (display client) are now submodules (seperate repositories)

- [@stratact](https://github.com/stratact) have improved ACPI.

- [@henrikhodne](https://github.com/henrikhodne) have removed magic numbers.

- [@tedsta](https://github.com/henrikhodne) is working on making our ZFS implementation writable.

- And lots of small changes.


# What does it look like?

Changes have not affected the appereance a lot:

![start](https://raw.githubusercontent.com/redox-os/redox/bbe19afced47cd4d84088deb4aa40c64b93f0e73/img/screenshots/start.png)


# What's next?

- Merge the orbital branch into master
- Improve performance
- Add more concurrent data structures
- Port Rayon and Crossbeam
- Add more tests

# Contributors

(sorted like `Contributors` section on Github)

- jackpot51
- ticki
- stratact
- tedsta
- polymetric1
- k0pernicus
- esell
- lazyoxen
- imp 🎂
- domtheporcupine
- achanda
- nobbz
- ambaxter
- stryan
- fischmax
- henrikhodne 🎂
- mgattozzi
- nounoursheureux
- bheesham
- maximilianmeister
- ilundhild 🎂
- hauleth
- skylerberg
- layered-esell
- flosse
- coder543
- n3mes1s
- flashyoshi
- shadowcreator
- remram44
- Santa Claus 🎂
