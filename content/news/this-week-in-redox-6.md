+++
title = "This Week in Redox 6"
author = "Ticki"
date = "2015-11-07T21:01:00+02:00"
groups = ["news"]
+++

This is the sixth post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- [@jackpot51](https://github.com/jackpot51) has done lots of changes in the kernel. The distinction between user and kernel space is now complete. You can read about all this [here](http://dictator.redox-os.org/index.php?controller=post&action=view&id_post=17).

- [@ticki](https://github.com/ticki) has written a new memory manager inspired by jemalloc. It's not merged to master yet. This change makes heap allocation much faster.

- [@ticki](https://github.com/ticki) has begun the work on Osmium which is a Redox's modern archiving format intended for use in Oxide (package manager).

- [@jackpot51](https://github.com/jackpot51) is cleaning up a lot of code in `real_hardware` branch

- [@tedsta](https://github.com/tedsta) is continuing working hard on ZFS support. It looks like we'll soon have ZFS support ;).

- [@k0pernicus](https://github.com/k0pernicus) has added french keyboard layout.

- [@ticki](https://github.com/ticki) have improved the PRNG in the kernel.

- [@k0pernicus](https://github.com/k0pernicus) has improved the terminal by using hashmaps for indexing and adding `help` and `man` commands.


# What does it look like?

;)

<img class="img-responsive" src="https://github.com/redox-os/assets/raw/master/fun/mobile.jpg"/>

<img class="img-responsive" src="https://github.com/redox-os/assets/raw/master/screenshots/File_manager.png"/>


# What's next?

- Merge `real_hardware`
- Get ZFS writable
- Extend the multithreading support
- Make Redox boot properly with the new memory management system

# Contributors

(sorted like `Contributors` section on Github)

- jackpot51
- ticki
- stratact
- tedsta
- k0pernicus
- esell
- lazyoxen
- achanda
- nobbz
- ambaxter
- stryan
- mgattozzi
- bheesham
- nounoursheureux
- hauleth
- layered-esell
- remram44
- n3mes1s
- flashyoshi
- shadowcreator
