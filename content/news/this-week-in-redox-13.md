+++
title = "This Week in Redox 13"
author = "Ticki"
date = "2016-03-29T13:43:11+01:00"
+++

This is the 12th post of a series of blog posts tracking the development and progress of Redox, the Rust operating system. If you want to know more about Redox in general, visit our [Github page](https://github.com/redox-os/redox).

*(edited by Ticki)*

# PSA
If you have any questions, ideas, or are curious about Redox, we recommend joining `#redox` on `irc.mozilla.org` or [our Discourse forum](https://discourse.redox-os.org/)!

# What's new in Redox?

- We've been featured on [InfoWorld](http://www.infoworld.com/article/3046100/open-source-tools/rusts-redox-os-could-show-linux-a-few-new-tricks.html) ("Rust's Redox OS Could Show Linux a Few New Tricks"), [Linux.com](https://www.linux.com/news/software/applications/894311-rusts-redox-os-could-show-linux-a-few-new-tricks), [Phoronix](https://www.phoronix.com/scan.php?page=news_item&px=Redos-OS-Intro), [OSNews](http://www.osnews.com/story/29131/The_Redox_operating_system), and probably more.

- [@ticki](https://github.com/ticki) has has started [libmalloc](https://github.com/redox-os/libmalloc), an efficient userspace memory allocator for Redox.

- [@skylerberg](https://github.com/skylerberg) has added tilde expansion for Ion.

- Thanks to the awesome rust-lang team, [we finally got naked function](https://github.com/rust-lang/rust/pull/32410). :tada: :tada: :tada:. For an explanation of this, see [this comment](https://github.com/rust-lang/rfcs/pull/1201#issuecomment-198505381).

- [@ticki](https://github.com/ticki) has ported his [termion](https://github.com/ticki/termion) to Redox, and as a result started [games-for-redox](https://github.com/redox-os/games-for-redox), a collection of text-based games (see pictures):
  - [@eghiorzi](https://github.com/eghiorzi) added reversi.
  - [@paezao](https://github.com/paezao) added snake.
  - [@ticki](https://github.com/ticki) added minesweeper.
  - [@ticki](https://github.com/ticki) added ice (ice sliding puzzle).
  - [@jhod0](https://github.com/jhod0) added flappy bird.
  - [@ticki](https://github.com/ticki) added h4xx3r, for hacking like 4chan.

- [@ticki](https://github.com/ticki) has started [@magnet](https://github.com/redox-os/magnet), the package manager of Redox. It is still very much work-in-progress.

- [@jackpot51](https://github.com/jackpot51) made a GUI version of [@lazyoxen's](https://github.com/lazyoxen) `calc`.

- [@ticki](https://github.com/ticki) has made [libextra](https://github.com/redox-os/libextra), containing [everything libstd lacks of](https://github.com/redox-os/libextra/tree/master/src).

- [@jackpot51](https://github.com/jackpot51) has improved the real hardware support (specifically, the PS/2 driver is fixed).

- [@ticki](https://github.com/ticki) has fixed [a serious bug](https://github.com/redox-os/libextra/commit/dd01a09283df73e8e62a6fa59ede41897459dcbd) in `GetSlice`, potentially resulting in kernel panics.

- [@ca1ek](https://github.com/ca1ek) has been working on [Tetrahedrane](https://github.com/ca1ek/tetrahedrane), a software 3D renderer for Redox.

- [@jackpot51](https://github.com/jackpot51) added a Redox [screenfetch-like utility](https://github.com/redox-os/redox/commit/a0fca80a46d79187cbc4a003a9759ab0b3464465).

- [@hgrecco](https://github.com/hgrecco) [has added](https://github.com/redox-os/coreutils/pull/45) `cut` to [coreutils](https://github.com/redox-os/coreutils).

- The SYSALLOC syscall is removed in favor of the userspace allocator.

- [@pythoneer](https://github.com/pythoneer) has been working on [pixelcannon](https://github.com/pythoneer/pixelcannon), another 3D software rendering engine for Redox.

- We finally reached [3,500 stargazers](https://github.com/redox-os/redox).

- [@ticki](https://github.com/ticki) has added a [Code of Conduct](http://www.redox-os.org/coc/). It is based on Rust's with some slight modifications.

- [@jackpot51](https://github.com/jackpot51) has been working on IO from userspace.


- [@jackpot51](https://github.com/jackpot51) has improved the performance of the terminal redraws.

- [@nounoursheureux](https://github.com/nounoursheureux) has added [an initial implementation of `fs::copy` and `fs::rename`](https://github.com/redox-os/redox/pull/574).

- [@jackpot51](https://github.com/jackpot51) has exposed the `async` orbclient flag, enabling non-blocking GUIs.

- [@ticki](https://github.com/ticki), [@jackpot51](https://github.com/jackpot51), and [@stratact](https://github.com/stratact) has improved [the book](https://doc.redox-os.org/book/) in a number of ways:
  - "drawbacks of microkernels" chapter.
  - Improved wording.
  - Explanation of what programs fits into the upstream distribution.
  - Various improvements based on people's feedback.

- [@jackpot51](https://github.com/jackpot51) has [fixed many bugs](https://github.com/redox-os/redox/pull/594) with the management of the memory.

- [@ticki](https://github.com/ticki) introduced [the Red Ox](https://github.com/redox-os/redox/pull/595), our mascot!
   ![](https://raw.githubusercontent.com/Ticki/redox/master/img/RedOx.png)

- [@jackpot51](https://github.com/jackpot51) has improved the device detection.

- [@ticki](https://github.com/ticki) has added [PR and issue templates](https://github.com/redox-os/redox/pull/567)

- [@guillaum1](https://github.com/guillaum1) has been working on porting his [Jainja](https://sourceforge.net/projects/jainja/), a Java-to-C transpiler + VM for Java (supports Java 1.5 features). This means that Redox can run basic Java programs now!

- [@stratact](https://github.com/stratact) has refactored `wc` for more clean and consistent code.

- [@jackpot51](https://github.com/jackpot51) has added message of the day.

# Pictures

Pythoneer's Pixelcannon in action:

![pixelcannon in action](https://camo.githubusercontent.com/5e0deef97dbe9f0087b3c911d2b66707bccf474c/687474703a2f2f692e696d6775722e636f6d2f683248626658532e676966)

Redox running on Thinkpad T-420:

![](http://www.redox-os.org/img/hardware/thinkpad-t420.png)

Redox running on ASUS eeePC 900:

![](http://www.redox-os.org/img/hardware/asus-eepc-900.png)

Redox running on Panasonic Toughbook CF-18:

![](http://www.redox-os.org/img/hardware/panasonic-toughbook-cf18.png)

RustType running on Redox:

![](https://chat.redox-os.org/api/v1/files/get/aduzjsjphirwtj6togzspotzko/6izutbttt3fhmqxrbihouu6i1c/kh7nscwy7idfprqii5pts55gcr/droid_sans.png?d={%22filename%22%3A%22kh7nscwy7idfprqii5pts55gcr%2Fdroid_sans.png%22}&h=%242a%2410%24d84ouSdW.p3TIyH4oIaN3uufpHOVKz5UA.bfMTQnyHR%2F9TA%2Fsg9pK&t=zoa4meoqjbbcdju9ghd7745phe)

ca1ek's tetrahedrane on Redox:

![](https://i.imgur.com/vB9LZH2.png)

Redox once, Redox forever:

![](https://chat.redox-os.org/api/v1/files/get/aduzjsjphirwtj6togzspotzko/x8qa6a4zsjfrjykim4xs6q798r/q43xsnsxyfypimqohr5shdr66c/redox_on_everything.JPG?d={%22filename%22%3A%22q43xsnsxyfypimqohr5shdr66c%2Fredox_on_everything.JPG%22}&h=%242a%2410%24gVmZOSmbPAP.aR2ROkOlf.GwlEFD13q5cqM72ZqVDhYseA4Q0Bb2u&t=zoa4meoqjbbcdju9ghd7745phe)

Hacking in progress:

![](/img/screenshot/hacking.png)

Minesweeper

![](https://raw.githubusercontent.com/Ticki/termion/master/image.png)

The above pictures are all real.

# Handy links

1. [The Glorious Book](http://www.redox-os.org/book/book/)
2. [The Holiest Forum](https://discourse.redox-os.org/)
3. [The Shiny ISOs](https://static.redox-os.org/)
4. [Redocs](https://doc.redox-os.org/kernel/)
5. [Fancy GitHub organization](https://github.com/redox-os)
6. [Our Holy Grail of a Website](http://www.redox-os.org/)
7. [Our Nice Code of Conduct](https://redox-os.org/coc)
8. [The Extreme Screenshots](http://www.redox-os.org/screens/)

# What's next?

- Extend the book.
- Improve the performance of libmalloc.
- Writable ZFS.
- More games (relatively easy target for newbies)

# New contributors

Since the list of contributors are growing too fast, we'll now only list the new contributors. This might change in the future.

Sorted in alphabetical order.

- genodeftest 🎂
- tnias 🎂
- ca1ek 🎂
- movingtomars 🎂
- bon-chi 🎂
- samanthadoran 🎂
- zdeljkic 🎂
- paezao 🎂
- ogryzek 🎂
- nop0x0f 🎂
- lukeyeager 🎂

If I missed something, feel free to contact me (Ticki) or send a PR to [Redox website](https://github.com/redox-os/website).
