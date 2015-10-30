+++
title = "This Week in Redox 4"
author = "Ticki"
date = "2015-10-30T17+01:00+02:00"
+++

This is the fourth post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

*(written by Ticki)*

# What's new in Redox?

- Thanks to [@jackpot51](https://github.com/jackpot51) with the help of others SDL, dosbox, zlib, libpng, libiconv and freeciv is ported. Following are either almost ported or partially ported: gcc, newlib and binutils.

- Thanks to [@ticki](https://github.com/ticki) Redox boots 10-20% faster, due to rewriting of parts in the kernel. This speedup mainly comes from rewriting the path parser and the URL parser.

- [@nounoursheureux](https://github.com/nounoursheureux) have added a event triggered on quits of programs.

- [@ticki](https://github.com/ticki) has maked the URLs syntax agnostic, so now everything after the `:` is left to the provider.

- [@nobbz](https://github.com/nobbz) have been asked by his professor to give a ten minute talk about Redox.

- Sodium (text editor) has lots of new features. Thanks, [@stratact](https://github.com/stratact), for helping out with the bug fixes.

- [@achanda](https://github.com/achanda), [@stratact](https://github.com/stratact), and [@ticki](https://github.com/ticki) have cleaned up the warnings, codestyle and done some refactoring in the kernel.

- [@lazyoxen](https://github.com/lazyoxen) has switched from using a four byte array to represent colors to a Color struct in `libredox`.



# What does it look like?

;)

![Cellphone](https://raw.githubusercontent.com/redox-os/redox/master/img/fun/cellphone.jpg)

The start screen:

![Startscreen](https://raw.githubusercontent.com/Ticki/redox/master/img/screenshots/start.png)

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
