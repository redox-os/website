+++
title = "This Week in Redox 7"
author = "Ticki"
date = "2015-12-07T01:01:00+02:00"
+++

This is the seventh post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- The `real_hardware` branch which [@jackpot51](https://github.com/jackpot51) have worked on for a while, is now merged. This entails:
    * Better multithreading
    * Cleaning up unidiomatic code
    * Using VecDeques for queues
    * Better support for real hardware
    * and a lot of other stuff

- Thanks to [@ticki](https://github.com/ticki) the new memory manager, inspired by jemalloc, does now allocate, deallocate, and reallocates. However, Orbital (window manager) does not work with the new memory manager yet.

- [@tedsta](https://github.com/tedsta) with help from [@stratact](https://github.com/stratact) is working on the ZFS implementation, which will be the default on Redox.

- `libredox` is now spoofed as `libstd`. This means that we now got a prelude!

- And lots of other small changes.


# What does it look like?

Most of changes are internal:

![start](https://raw.githubusercontent.com/redox-os/redox/master/img/screenshots/screen.png)


# What's next?

- Get Orbital working with the new malloc system.
- Improve multithreading
- Make ZFS multithreaded
- Make performance improvements in the kernel (see Ticki's benchmarks).

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
- stryan
- ambaxter
- mgattozzi
- nounoursheureux
- bheesham
- layered-esell
- skylerberg
- hauleth
- shadowcreator
- remram44
- flashyoshi
- n3mes1s
- flosse
