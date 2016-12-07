+++
title = "This Week in Redox 8"
author = "Ticki"
date = "2015-12-12T12:01:00+02:00"
groups = ["news"]
+++

This is the 8th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- [@jackpot51](https://github.com/jackpot51) has done lots of bug fixes, which fixes the page faults some have experienced with Orbital toghether with a large amount of other bugs some which even caused crashes.

- [@polymetric1](https://github.com/polymetric1) have written a great guide for contributing to Redox. It contains tips, guidelines, best practices, and other stuff that's good to know. It can be found [here](https://github.com/redox-os/redox/blob/master/CONTRIBUTING.md).

- [@jackpot51](https://github.com/jackpot51) (branch `bug_fixes`) and [@ticki](https://github.com/ticki) (branch `abstraction`) are improving the usage of abstraction in the kernel to make the codebase more rustastic.

- [@lazyoxen](https://github.com/LazyOxen) has fixed a bug with overlapping windows in Orbital.

- [@ticki](https://github.com/ticki) have refactored Sodium into a better module structure.

- [@ticki](https://github.com/ticki) with help from [@jackpot51](https://github.com/jackpot51) have fixed bugs in the new buddy memory manager.

- [@jackpot51](https://github.com/jackpot51) have improved multithreading support and the syslog.

- And lots of other small changes.


# What does it look like?

Changes have not affected the appereance a lot:

<img class="img-responsive" src="https://raw.githubusercontent.com/redox-os/redox/bbe19afced47cd4d84088deb4aa40c64b93f0e73/img/screenshots/start.png"/>


# What's next?

- Improve multithreading
- Get Orbital working with the new malloc system.
- Make ZFS writable
- Improve apperance and customizability in Orbital.

# Contributors

(sorted like `Contributors` section on Github)

- jackpot51
- ticki
- stratact
- tedsta
- k0pernicus
- polymetric1
- esell
- lazyoxen
- achanda
- nobbz
- ambaxter
- stryan
- mgattozzi
- bheesham
- MaximilianMeister
- nounoursheureux
- hauleth
- skylerberg
- layered-esell
- flosse
- coder543
- n3mes1s
- flashyoshi
- shadowcreator
- remram44
