+++
title = "This Week in Redox 4"
author = "Ticki"
date = "2015-10-30T17:01:00+02:00"
groups = ["news"]
+++

This is the fourth post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- Thanks to [@jackpot51](https://github.com/jackpot51) with the help of others, SDL, dosbox, zlib, libpng, libiconv and freeciv have been ported. Following are either almost ported or partially ported: gcc, newlib and binutils.

- Thanks to [@ticki](https://github.com/ticki) Redox boots 10-20% faster, due to rewriting some parts of the kernel. This speedup mainly comes from rewriting the path parser and the URL parser.

- [@nounoursheureux](https://github.com/nounoursheureux) added an event triggered on programs exiting.

- [@stratact](https://github.com/stratact) greatly improved the file manager. Now the file type is described in a new column, and the way the correct icons are loaded based on the file type was rewritten.

- [@ticki](https://github.com/ticki) made the URL syntax agnostic, so now everything after the `:` is left to the provider.

- [@nobbz](https://github.com/nobbz) has been asked by his professor to give a ten minute talk about Redox.

- Sodium (text editor) has lots of new features. Thanks, [@stratact](https://github.com/stratact), for helping out with the bug fixes.

- [@achanda](https://github.com/achanda), [@stratact](https://github.com/stratact), and [@ticki](https://github.com/ticki) cleaned up the warnings, code style and did some refactoring in the kernel.

- [@lazyoxen](https://github.com/lazyoxen) switched from a four byte array to a Color struct to represent colors in `libredox`.

# What does it look like?

;)

<img class="img-responsive" src="https://github.com/redox-os/assets/raw/master/fun/cellphone.jpg"/>

The start screen:

<img class="img-responsive" src="https://raw.githubusercontent.com/Ticki/redox/master/img/screenshots/start.png"/>

# What's next?

- Port stuff
- Finish x86_64 support (it compiles!).
- Extend Sodium.
- Extend Orbital.
- ZFS scheme and write support

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
- layered-esell
- bheesham
- hauleth
- remram44
- shadowcreator
- n3mes1s
- flashyoshi
- nounoursheureux
