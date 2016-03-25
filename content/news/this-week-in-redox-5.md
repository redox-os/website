+++
title = "This Week in Redox 5"
author = "Ticki"
date = "2015-11-07T17:01:00+02:00"
+++

This is the fifth post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- [@jackpot51](https://github.com/jackpot51) and [@ticki](https://github.com/ticki) are currently cleaning up the kernel, moving lots of things which does not belong to kernel space, into userspace.

- [@ticki](https://github.com/ticki) has added lots of new features to Sodium (text editor), such as auto indentation, prompt, configuration, syntax highlighting, scrolling, delete motions and so on.

- [@jackpot51](https://github.com/jackpot51) has made the kernel space file system (used upon boot) writable.

- [@tedsta](https://github.com/tedsta) is continuing working on ZFS support.

- Thanks to [nounoursheureux](https://github.com/nounoursheureux), we now got both `cd` and `pwd` commands in the console.

- [@ticki](https://github.com/ticki) has added support for relative paths in the path parser.

- [@jackpot51](https://github.com/jackpot51) is adding support for multithreading.

- [@stratact](https://github.com/stratact) have added a .get_slice() method for the kernel, and begin removing calls for panicable methods in the kernel (to prevent kernel panics).

- [@stratact](https://github.com/stratact) has cleaned up a bunch of code for following the Rust conventions.

- Thanks to [@jackpot51](https://github.com/jackpot51) Redox with x86_64 support now compiles (!), but does not boot properly yet.

- And lots of small stuff...


# What does it look like?

;)

<img class="img-responsive" src="https://raw.githubusercontent.com/redox-os/redox/master/img/fun/fancy.png"/>

Since the changes are mostly internal, we don't got a lot of new fancy screenshots except for Sodium:

Sodium has syntax highlighting and a lot of new features:

<img class="img-responsive" src="https://raw.githubusercontent.com/redox-os/redox/master/img/screenshots/Sodium_v1.png"/>


# What's next?

- Get the `correctness` branch compiling and booting.
- Extend `sodium`
- Optimize things
- Get ZFS writable
- Extend the multithreading support
- Cleanup code style

# Contributors

(sorted like `Contributors` section on Github)

- jackpot51
- ticki
- stratact
- tedsta
- esell
- achanda
- nobbz
- lazyoxen
- ambaxter
- stryan
- mgattozzi
- nounoursheureux
- hauleth
- bheesham
- layered-esell
- remram44
- flashyoshi
- shadowcreator
- n3mes1s
