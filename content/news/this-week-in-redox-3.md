+++
title = "This Week in Redox 3"
author = "Ticki"
date = "2015-10-22T22:05:00+02:00"
+++

This is the third post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- Thanks to [@jackpot51](https://github.com/jackpot51) et al. x86_64 is almost supported, despite the lack of a naked function attribute in Rust. See the recent PR to Rust and RFC discussions for more information.

- [@stratact](https://github.com/stratact) have upgraded the file manager to include more info about files. This includes file size and number of entries in folder.

- [@ticki](https://github.com/ticki) with the help of [@stratact](https://github.com/stratact), and [@tennix](https://github.com/tennix) has started the development of Redox's own advanced, Vi-like text editor, Sodium (`na` for short). The recent enchancement of the basic text editor (named `Editor`) were rolled back in favor of Sodium. These features will then gradually be added to Sodium.

- [@tedsta](https://github.com/tedsta) is working hard on completing the support for ZFS. Check out the ZFS application for trying it out!

- The graphics module now support Bresenham line drawing natively.

- [@ticki](https://github.com/ticki) has ported `libnum`. This will allow us to port `liboctavo` in the near future, meaning that we can move on with the development of `Oxide`.

- [@jackpot51](https://github.com/jackpot51) moved different crates out of kernel space and into user space. Futhermore the folder containing the kernel code is now called `kernel` instead of `src`.

- Thanks to [@nobbz](https://github.com/nobbz), Redox now builds on Windows.


# What does it look like?

;)

<img class="img-responsive" src="https://github.com/redox-os/assets/raw/master/fun/Old.jpg"/>

The start screen:

<img class="img-responsive" src="https://raw.githubusercontent.com/Ticki/redox/master/img/screenshots/start.png"/>

Sodium is working:

<img class="img-responsive" src="https://raw.githubusercontent.com/Ticki/redox/4d026acf5e7981cd3a3d12a55206dfd20853fcde/img/screenshots/Sodium.png"/>

WIP on ZFS:

<img class="img-responsive" src="https://raw.githubusercontent.com/Ticki/redox/master/img/screenshots/zfs.png"/>

Awesome file manager!

<img class="img-responsive" src="https://raw.githubusercontent.com/Ticki/redox/master/img/screenshots/File_manager_v2.png"/>


# What's next?

- Finish x86_64 support.
- Greatly extend Sodium.
- Do more work on Bohr (the display manager).
- Create an RFC-like system.
- Extend Orbital.
- Create a GUI library (high-level library with Orbital as back-end).
- Port `liboctavo`.
- ZFS scheme and write support

# Contributors

(sorted like `Contributors` section on Github)

- jackpot51
- ticki
- stratact
- tedsta
- esell
- nobbz
- stryan
- ambaxter
- mgattozzi
- lazyoxen
- hauleth
- layered-esell
- shadowcreator
- flashyoshi
- achanda
- remram44
- n3mes1s
