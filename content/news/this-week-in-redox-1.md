+++
title = "This Week in Redox 1"
author = "Ticki"
date = "2015-10-06T16:42:56+02:00"
+++

This is the first post in a blog series tracking the development and progress of Redox, the modular and secure OS, written in Rust. So welcome!

*(written by Ticki)*

# What's new in Redox?

- The development of Redox's package manager, Oxide (`ox` for short), has started. The source for Oxide can be found [here](https://github.com/redox-os/oxide).
- [@jackpot51](https://github.com/jackpot51), [@stratact](https://github.com/stratact), and [@tedsta](https://github.com/tedsta) have started implementing support for ZFS, which is planned to be the main file system used in Redox.
- [@ticki](https://github.com/ticki) made an icon for Redox (see screenshots).
- [@hauleth](https://github.com/hauleth) set up a cool website, using [Hugo](https://gohugo.io).
- [@ticki](https://github.com/ticki) cleaned up the style in the whole codebase.
- [@esell](https://github.com/esell) cargoified a lot of crates in the main repository.

- Thanks to [@stryan](https://github.com/stryan) and [@jackpot51](https://github.com/jackpot51), the window manager is moved to libredox, under the name `orbital`.

# What does it look like?

The desktop.
<img class="img-responsive" src="https://github.com/redox-os/assets/raw/master/screenshots/Desktop.png"/>
Yay! Fancy opacity.
<img class="img-responsive" src="https://github.com/redox-os/assets/raw/master/screenshots/Fancy_opacity.png"/>
We have a file manager!
<img class="img-responsive" src="https://github.com/redox-os/assets/raw/master/screenshots/File_manager.png"/>
The boot screen.
<img class="img-responsive" src="https://github.com/redox-os/assets/raw/master/screenshots/Boot.png"/>

# What's next?

- Moving many functions out of the kernel/libredox. For example, we plan to move orbital out of libredox.
- Porting libstd completely. Many of the libstd functionalities are provided by the `common` module right now. However, we would like to port libstd to provide support for other crates.
- Adding signatures, hashes, and other crypto stuff to the Oxide package manager.
- Improving documentation.
- Starting a shell (rash).
- Make Redox support 64-bit system.

And lots of lots of lots of other stuff.

# Contributors

(fetched from `Contributors` section on Github)

- jackpot51
- ticki
- stratact
- esell
- stryan
- tedsta
- layered-esell
- hauleth
