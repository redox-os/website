+++
title = "Bochs on Redox OS (and QEMU - Part 2)"
author = "Enygmator"
date = "2022-07-10T04:35:30.295Z"
+++

# Prologue

Hey there everyone! I'm <font color="#9a39bc">Eny</font><font color="#3e3e3e">gma</font><font color="#a58f01">tor</font> and I'm back!

_TLDR; The technical stuff starts from the **Emulators on Redox** section._

<br/>

For those of you who don't know me (or my role in Redox), I'd like to introduce myself as the **RSoC (Redox Summer of Code) 2021 student** who worked on **porting QEMU to Redox OS**. 

This post brings you some updates on the progress I've made on that front (QEMU on Redox) and another juicy undertaking of mine - **It's BOCHS on Redox y'all!** 😀

I'm writing this post as an UPDATE to my previous post (at [this link](https://redox-os.org/news/rsoc-2021-qemu-1/)) that I wrote last year, as part of RSoC 2021, where I promised an update (which is long due). This post is going to be more straightforward and technical than the last one, so if you aren't fully aware of QEMU, OSes, emulators, userspace program porting, etc, you should definitely read that post. I explain _from the basic_ in simple language, before getting more technical.  
You should also read it if you're interested in how I started out porting QEMU to Redox OS.

It has been one heck of a year and despite my preoccupation with my undergraduate degree (BTech - CSE, 2023), I was able to put in some amount of time after the duration of RSoC 2021, to further develop the project I was working on (QEMU, and later Bochs). I worked on the stuff mentioned in this post a while back, but am writing this post only now (procrastination). This post is not a part of either RSoC 2021 or RSoC 2022, just an update to spice things up.

BTW, I'm currently working on █████████████ as part of RSoC 2022. (I'll first write the post and then reveal what I'm working on, because it's fancy-shmancy 😉).

<br/>

### Updates

If I make any updates to this post (which is sometimes helpful for people reading it in the future), I shall make note of it here and st the same time, ~~scratch out~~ older content and replace it with something like "UPDATE1: ...".

<br/>

# Emulators on Redox

Emulators are applications that provide ISA-level virtualization (one among other types of virtualization). Having emulators like QEMU and Bochs successfully run on Redox OS, helps realize the support (tooling and ecosystem) required for self-hosting, and at the same time enabling support for specific use cases for Redox OS.

Self-hosting isn't a long way off on Redox, and tooling around a new software/hardware that makes it easier to work with pretty much decides how successful the software/hardware will be. (as suggested by Linux Torvalds, where he said that he loves `x86` more than `arm` because of the amazing ecosystem around x86 that has been built over the past decades).

While I was attempting to port QEMU, I thought of looking into porting Bochs too, given that its codebase looked much simpler (given that it _only_ emulates x86 and some peripherals). Here, I write about both those attempts of mine (and their results).

## QEMU

You can find all the work I did at [this GitLab Repo - `qemu_for_redox` branch](https://gitlab.redox-os.org/enygmator/qemu/-/tree/qemu_for_redox).

QEMU has its own build system based on `MAKEFILES` and a meta-build system based on `meson` that is capable of compiling to Linux, MacOS and Windows targets. I created a new target called `redox`, which disables all features of QEMU by default and also the `tests` in `meson.build`. Then I manually enable only a subset of the features (for `qemu-system-x86_64`) to run.  

Using preprocessor checks like `#if defined(__redox__)`, some of the alternative code was written.

Build, make and install scripts were configured in `recipe.sh`. It also had to be modified to recursively link the dependencies of each dependency statically (using `LD_FLAGS`).  
TODO: I need to figure out a way to make that happen automatically based on `pkg-config` info.

<br/>

### Result

With a required number of features enabled (only to successfully build the emulator for `x86_64-softmmu`), QEMU is **successfully compiling for Redox OS** (including the static dependencies).

TODO: But it fails to execute - most likely because I may have written some incorrect placeholder code causing it to go into an infinite loop. Fixing this should be easier now that I have spent time understanding the kernel internals better and can use debuggers to track code execution.

I'll have an update on QEMU when `qemu-system-x86_64` runs for the first time.

<br/>

### TLDR; Working on the code

The `recipe.sh` file is [here - on the `qemu_on_redox` branch of `cookbook` repo in MY GitLab](https://gitlab.redox-os.org/enygmator/cookbook/-/blob/qemu_on_redox/recipes/qemu/recipe.sh).

Feature configuration is done in the `recipe.sh` file, which is used to build the QEMU package for Redox, which can later be installed on Redox. The `recipe.sh` file currently depends on the QEMU source being located at `try_redox/redox_apps/qemu-7.0.0` (where the Redox OS repo is located at `try_redox/redox`). This is used to run the VPATH build (done by commands in `recipe.sh`).

If you want complete instructions on compiling `qemu-7.0.0` on Redox OS, you'll find them in the `README.md`, [here](https://gitlab.redox-os.org/enygmator/cookbook/-/tree/qemu_on_redox/recipes/qemu). DO contact me if you have questions, suggestions or face issues. I may be able to help. (or you can file an issue in one of MY repo links - `cookbook` or `qemu`)


## Bochs

[Bochs 2.7](https://bochs.sourceforge.io/) seemed like a good emulator to port, as it is so much more lighter than QEMU, due to the fact that it only emulates x86 ISA with a certain number of peripherals, and doesn't support KVM either. So, I started to work on porting it [in this repo](https://gitlab.redox-os.org/enygmator/bochs/-/tree/bochs_on_redox).

Bochs uses `Makefile` for it's build system, and similar to QEMU, it uses the VPATH build method (which ensures that all build files are worked on in a separate directory that you can manually specify, so that the source repo isn't touched in any manner at all).

My experience with porting QEMU (incompletely) came in very handy, as within 6 hours I actually was able to get Bochs to statically compile! albeit with some 'extra' features turned off. There were some `#include` changes with respect to the `SDL` and `SDL2` libraries and some 'tricky' method to force bochs to compile statically (since it's build system was not doing it correctly). You can view the changes in the repo link above.

I then configured the `make` procedure and `install` sections of the `recipe` and booted into Redox and ran bochs with a super minimal "bootloader + kernel" that I had written back in 2020 (my first "OS project" ☺️) loaded onto a 'hard drive file' and configured bochs emulator using a `bochs.src` _bochs configuration file_.... and it ran! You can see "stage 2" of my kernel in the below image:

<img class="img-responsive" src="/img/screenshot/bochs_redox_demo_1.png" alt="Bochs GUI running on Redox" />

<br/>

At a later point, I'll enable and work on more features to make bochs work better. Though, the priority will always be QEMU as it is **so much more** important in terms of common/industrial usage and the functionality it offers, and a priority for emulation and ██████████████.

<br/>

### Known Issues

1. There seems to be some problem in the framebuffer mapping when the SDL2 window resizes, causing things to look "skewed". (I fixed it in the image above by manually changing the mapping 😅)
2. Bochs also crashes when the window size in increased by a huge amount.

<br/>

### TLDR; Working on the code

The `recipe.sh` file is [here - on the `bochs_on_redox` branch of `cookbook` repo in MY GitLab](https://gitlab.redox-os.org/enygmator/cookbook/-/blob/bochs_on_redox/recipes/bochs/recipe.sh).

Feature configuration is done in the `recipe.sh` file, which is used to build the Bochs package for Redox, which can later be installed on Redox. The `recipe.sh` file currently depends on the Bochs source being located at `try_redox/redox_apps/bochs` (where the Redox OS repo is located at `try_redox/redox`). This is used to run the VPATH build (done by commands in `recipe.sh`).

If you want complete instructions on compiling `bochs` on Redox OS, you'll find them in the `README.md`, [here](https://gitlab.redox-os.org/enygmator/bochs/-/blob/bochs_on_redox/README.md). DO contact me if you have questions, suggestions or face issues. I may be able to help. (or you can file an issue in one of MY repo links - `cookbook` or `bochs`)


<br/>

# Epilogue

While writing this post, I made some updates to the previous post. While reading that, I cringed many times looking at some glaring errors I had made in understanding a few concepts (that I now understand much better) or the method by which I did something. But I guess that's what learning and growth are about - every time you look back at your previous work, you think "I sure was an amateur back then! 😣". Some day, I'll look at this post and realize the same thing.

Contributing to Redox OS's future is a lot of fun. I learnt about the different ways in which build systems are configured/constructed (and am already using them in my projects 🙂) in addition to cross-compilation and lots of other tid-bits. I want to thank those who have guided me in the `Redox OS mattermost chat` during RSoC 2021 and later (`omac777`, `a4ldo2` and of course `jackpot51`).

I shall soon write my next post (as an RSoC 2022 student), so hang on tight people!

## Until later!

If you've reached till this point, thank you for reading. I shall be coming back another time with more exciting updates on this undertaking.

Until then, do keep safe, hale and hearty.  
Bye! ❤❤❤

You can find me on:
- [Redox OS - GitLab](https://gitlab.redox-os.org/enygmator/) 
- Redox OS - Mattermost chat - username: `enygmator`
- [GitHub](http://github.com/enygmator/)
- [LinkedIn](https://www.linkedin.com/in/ttarunaditya/)
- [Twitter](https://twitter.com/Enygmator)
- [Encrypted chat on Matrix (like _Element chat_)](https://matrix.to/#/@enygmator:matrix.org)
