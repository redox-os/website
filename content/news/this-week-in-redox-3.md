+++
title = "This Week in Redox 3"
author = "Ticki"
date = "2015-10-22T21+0200"
+++

This is the third post of a serie of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- Thanks to [@jackpot51](https://github.com/jackpot51) et al. x86 is almost support, despite the issues with the lack of ability to make naked function in Rust. See the recent PR to Rust and RFC discussions for more information.

- [@stratact](https://github.com/stratact) have upgraded the file manager to include more info about files. This includes file sizes and number of entries in folder.

- [@ticki](https://github.com/ticki) with the help of [@stratact](https://github.com/stratact), and [@tennix](https://github.com/tennix) has started the development of Redox's own advanced, Vi-like text editor, Sodium (`na` for short). The recent enchancement of the basic text editor (named `Editor`) were rolled back in favor of Sodium. These features will then gradually be added to Sodium.

- [@tedsta](https://github.com/jackpot51) is working hard on completing the support for ZFS. Check out the ZFS application for trying it out!

- The graphics module now support Bresenham line drawing natively.

- [@ticki](https://github.com/ticki) has ported `libnum`. This makes us able to port `liboctavo` in the near future, meaning that we can move on with the development of `Oxide`.

- [@jackpot51](https://github.com/jackpot51) has moved different crates out of kernel space and into user space. Futhermore the folder containing the kernel code is now called `kernel` instead of `src`.

- Thanks to [@nobbz](https://github.com/nobbz) Redox is now building on Windows.


# What does it look like?

;)

![Old computer](https://raw.githubusercontent.com/redox-os/redox/4c9e2b3df7033966e8f67ded1f619bf257658db3/img/fun/Old.jpg)

The start screen:

![Startscreen](https://raw.githubusercontent.com/Ticki/redox/4d026acf5e7981cd3a3d12a55206dfd20853fcde/img/screenshots/start.png)

Sodium is working:

![Sodium](https://raw.githubusercontent.com/Ticki/redox/4d026acf5e7981cd3a3d12a55206dfd20853fcde/img/screenshots/Sodium.png)

WIP on ZFS:

![ZFS](https://raw.githubusercontent.com/Ticki/redox/4d026acf5e7981cd3a3d12a55206dfd20853fcde/img/screenshots/zfs.png)

Awesome file manager!

![File manager](https://raw.githubusercontent.com/Ticki/redox/4d026acf5e7981cd3a3d12a55206dfd20853fcde/img/screenshots/File_manager_v2.png)


# What's next?

- Finish x86 support.
- Greately extend Sodium.
- Do more work on Bohr (the display manager).
- Create an RFC-like system.
- Extend Orbital.
- Create a GUI library (high-level library with Orbital as back-end).
- Port `liboctavo`.

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
