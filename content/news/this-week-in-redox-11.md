+++
title = "This Week in Redox 11"
author = "Ticki"
date = "2016-02-16T19:25:47+01:00"
+++

This is the 11th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, then visit our [Github page](https://github.com/redox-os/redox).

You might wonder why no update on the progress of Redox OS has appeared over the last couple of weeks. The reason is that we all have been busy with ... being lazy. Nah, just kidding. Actually, we have done _a lot_ of stuff on Redox.

*(edited by Ticki)*

# PSA
If you have  questions, ideas, or are curious about Redox, you are recommended to join `#redox` on `irc.mozilla.org`, and chat with us!

# What's new in Redox?
- [@jackpot51](https://github.com/jackpot51) has written a very minimal init system.

- Orbital now runs entirely in userspace, and can be started via a normal executable file, without any assistance from kernel space.

- [@eghiorzi](https://github.com/EGhiorzi) has ported his program, 'RUSThello', to Redox. 'RUSThello' is an highly concurrent AI for Reversi (also known as Othello). This demonstrates Redox's multithreading abilities.

- [@ticki](https://github.com/ticki) has started [binutils](https://github.com/redox-os/binutils). `xxd`, `hexdump`, and `strings` are completed.

- Thanks to [@roxxik](https://github.com/roxxik) has made the kernel run in flat real mode, for i386. This means we are now a little closer to adding x86_64 support.

- [@jackpot51](https://github.com/jackpot51) has fixed several bugs in kernel space.

- We are now a few steps farther on the road to full blown `libstd` compatibility. New things ported includes `std::process`, which is still WIP, ([@jackpot51](https://github.com/jackpot51)) `HashMap` ([@ticki](https://github.com/ticki)), `get_current_dir()` ([@k0pernicus](https://github.com/k0pernicus)), `fs::canonicalize` ([@jackpot51](https://github.com/jackpot51)), and much more.

- [@alicemaz](https://github.com/alicemaz) has written a `wc` (behaving like GNU coreutils' `wc`) utility.

- [@ticki](https://github.com/ticki) has rewritten all the Redox coreutils, for faster and more correct code.

- [Sodium](https://github.com/redox-os/sodium) (text editor) and the Redox launcher (`launcher.bin`), [Orbclient](https://github.com/redox-os/orbclient) (display client) now runs on Linux! Thanks to the awesomness of [@jackpot51](https://github.com/jackpot51) and [@stratact](https://github.com/stratact). `orbclient` uses SDL2 as backend on Linux.

- [@skylerberg](https://github.com/skylerberg) has done several changes to Ion (the shell). These includes: a PEG-based parser, directory stacks (popd, pushd, dirs), fork and job control, glob expansion, `cd -`, and much more!

- Thanks to [@jackpot51](https://github.com/jackpot51), we now got proper schemes in userspace!

- [@gmorenz](https://github.com/gmorenz) has improved the multi-cursor feature of Sodium.

- And lots of small changes.


# What does it look like?

![For anyone wondering this is definitely ~~not~~ fake.](https://raw.githubusercontent.com/redox-os/redox/a898dc852020b0ab3c242e72434a1cffaca41a44/img/fun/tablet.jpg)

Someone from the future send it to me. For anyone wondering this is definitely ~~not~~ fake.

![Debugging is an art.](https://chat.redox-os.org/api/v1/files/get/bxx4kh6hui8oxrkks5tb8uupcr/moin5cozg3ngicr3ogtjkm5auc/bsfh85nppbd58d6cscrehemfmh/redox-on-acid.png?d={%22filename%22%3A%22bsfh85nppbd58d6cscrehemfmh%2Fredox-on-acid.png%22%2C%22time%22%3A%221455645597957%22}&h=%242a%2410%24Gz05tGmkg9bTc6LsECAHYe4UXPei.l8AzQj.Alne.DdAn4RHuEnA2&t=zoa4meoqjbbcdju9ghd7745phe)

This actually happened (believe it or not), while I was hacking on the interrupt handler for x86_64.


# What's next?

- Port SDL2
- Games on Redox
- x86_64

# New contributors

Since the list of contributors are growing too fast, we'll now only list the new contributors. This might change in the future.

Sorted in alphabetical order.

- alicemaz 🎂
- gmorenz 🎂
- grappigpanda 🎂
- llambda 🎂
- roxxik 🎂

Welcome guys and gals!


If I missed something, be free to contact me (Ticki) or send a PR to [Redox website](https://github.com/redox-os/website).
