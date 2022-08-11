+++
title = "RSoC 2021: QEMU on Redox OS - Part 1"
author = "Enygmator"
date = "2021-07-13T09:18:48.520Z"
+++

# Introduction

Hey there! I'm Enygmator.

This is my first time writing on the Redox OS blog! In fact, it's my first time ever writing a blog post and so it might not be one of my finest pieces.

I am one of the **RSoC (Redox Summer of Code) participants (students) this year (2021)**. As part of RSoC, I have been working on **porting QEMU to Redox OS** for the past one month. This is my first post detailing my project in order to give you an insight into it and what the future might hold.

<br/>

### Updates

If I make any updates to this post (which is sometimes helpful for people reading it in the future), I shall make note of it here and st the same time, ~~scratch out~~ older content and replace it with something like "UPDATE1: ...".

- UPDATE1: 10 Jul 2022
- UPDATE2: 18 Jul 2022

## About the project

QEMU (Quick emulator), runs on many OSes from various Linux distributions to macOS and Windows.

<br/>  

_QEMU: It is an emulator that is capable of emulating various hardware (like Intel or ARM processors) within a software environment (your OS) in order to help run software, that runs only on the above-mentioned hardware. It is capable of emulating entire machines, so that you can test your software in the emulator rather than using the actual machine._

<br/>

I am porting it so that it is capable of running on Redox OS. 

<br/>

### "Why?", you ask?

It's because, I feel that every OS developer has the dream of making their OS **"self-host" capable**. What I mean by that is, currently, the Redox OS toolchain uses a number of supported Linux distributions to compile the OS code into a binary, after which it can either be run on QEMU or on one of the supported machines. What you CANNOT do (at the moment), is compile and run Redox OS on QEMU **ON** Redox OS. **UPDATE1: The ability to compile Redox ON Redox seems to be close at hand**  

But making it self-host capable _and usable_ requires the tooling around it to be well designed as well. In fact, tooling around a new software/hardware that makes it easier to work with pretty much decides how successful the software/hardware will be. (as suggested by Linus Torvalds, where he said that he loves `x86` more than `arm` because of the amazing ecosystem around x86 that has been built over the past decades).

So, once QEMU is able to run on Redox OS, it becomes an important tool in the ecosystem for emulator-based-development. And even if it isn't practical, one **could** run Redox OS on QEMU (on Redox). And if we combine that with the future ability to compile Redox OS on Redox OS, then we can theoretically eliminate the need for another operating system, as **development, compilation and testing/running Redox OS can be accomplished on Redox OS itself**.

The process of manipulating the QEMU codebase in order to get to run on another OS/System is called porting.

<br/>
<br/>

# Porting QEMU

This section talks about the attempt to rework the QEMU codebase (and build procedure) to get it to compile and work on Redox OS.

## The basics in Layman's terms

When you write code, it gets built by the build system (i.e. "converted") into a file that contains a specific format of 1s and 0s which is called a **binary** file. The binary generated is different for different OSes, since the features/capabilities and the way the OSes _execute_ your code differs. This also means that the code of complex programs varies from OS to OS, which requires you to write slightly different code (for the same program) for each OS you want to run your program on.

To solve this problem, a **POSIX** standard was introduced, so that binaries can be **ported** easily from one OS to another (without much change in the program code).

Now, QEMU has its own build system based on `MAKEFILES` and a meta-build system based on `meson` that is capable of compiling to Linux, MacOS and Windows targets. **I attempt to create a new target called `Redox OS` (with the relevant code changes to compile to that target)**, so that QEMU can be compiled to a binary that runs on Redox OS. I am going to keep this blog post short by **NOT** going into exact details about each and everything, or this post could well become a university course (I kid you not!).

The advantage here is that, even though Redox OS is **not fully POSIX compatible**, a major chunk of it **IS**, thus making the job of porting QEMU much easier than if it were otherwise. This means that, theoretically, I can just add, remove or duplicate & modify the existing QEMU code in order to get it running on Redox OS.

## A Deep Dive

The thing about QEMU is that it has a **HUGE** number of features that do all sorts of things from emulating peripheral devices to just making the emulated OS run faster. And many of these features heavily depend upon underlying OS support.  
So, my first move is to just get a part of QEMU running on Redox OS. By "part", I mean that I am **not trying to get QEMU running with all its features enabled**, which would require me to heavily modify Redox OS by introducing new features (which might take weeks or months). Instead, I am **disabling all the features that the "core" of QEMU doesn't need** while it's emulating a simple `x86` machine with a `512 byte` bootloader so that I can enable the rest of the features once I get the core running, making sure that **something** is usable at all times, instead of trying to get it all running at once.

<br/>

### The Process

First, I got myself acquainted with the entire Redox OS codebase, since I will not only be working with QEMU source code, but also with `relibc` (Redox OS's `libc` implementation) and potentially even kernel code.

<br/>

_I want to write more about how the entire `Redox OS` code base is organized (in order to help newcomers make sense of it), but I guess it would be more appropriate to make it part of the documentation to be done on a future date. This will encourage more contributors._

<br/>

I first took time to get a `recipe.sh` recipe ready, in order to instruct the Redox OS build system to build QEMU using the QEMU build system, by passing in the required parameters as input (which include all the correct environment variables like those that point to the cross-compiler, as we are compiling FROM Linux to run ON Redox). Currently, the location of the QEMU repo is fixed at the same level as the `redox` folder inside `try-redox` (refer Redox OS documentation).

<br/>

_NOTE: `recipe.sh` is deprecated and will be soon replaced by me with a `recipe.toml`._

<br/>

I am using ~~**QEMU `6.0.0`**~~ **(UPDATE1: QEMU `7.0.0`)** as the base QEMU code which I will be modifying to support Redox OS. I initially thought of just letting a switch called `linux` remain on inside of QEMU's `configure` since `Redox OS` was similar to Linux and though this didn't prove to be a lot of trouble, it soon became evident to me as to the relatively bigger than anticipated feature gap that exist between Linux and Redox. But it isn't surprising as **Redox is NOT a Linux clone**.

So, I went ahead and created a new switch called `redox` which is automatically set to change (disable) many configurations which I won't detail here. I then went through the build system code (`shell` files and `meson` files) and modified all pieces which executed code based on the `Target OS` to execute code that is compatible with `Redox OS`. (`Target OS` also called the `Host OS` - the terminology is a bit ambiguous)

But the QEMU code base is a mammoth and it is difficult to check each and every source file for incompatible code. So, I just decided to go the other way of trying to compile the existing code using the cross compiler and whenever the compiler failed, it would be because of missing dependencies which indicate the absence of that feature on Redox OS. The next step would be to read the code and understand what it does using QEMU documentation and decide if it's a feature that we can afford to disable or if it's a small fix that won't be time consuming. If the feature can't be disabled, then the next step is to look at how to implement that dependency into `Redox OS`. Sometimes, due to the way `Redox OS` is made, we don't have to introduce new code into the OS or `relibc`, rather, `Redox` provides with alternative options/implementations for which slightly different QEMU code must be written. All modifications are done using `#ifdef` compiler directives that check if the compilation process is for Redox OS.

Since I cannot immediately verify the successful execution of the code I modified, I just make a note of the change in the form of a **`WARN` or `TODO` comments**, so that while running QEMU after compiling for the first time, I can verify if all of the code works well. 

> _~~For the list of features that I enabled/disabled or for code that I replaced and removed, **refer [this GitLab Wiki](https://gitlab.redox-os.org/enygmator/qemu/-/wikis/Features-of-QEMU-on-Redox)**. Note that I haven't documented every change; just the major ones.~~ **UPDATE1: this link hasn't fully updated with all the purported info**_

<br/>

### The progress

At the moment, I still haven't run QEMU on Redox as each time I compile, there prop up errors that need to be rectified ~~(which I detailed on the GitLab Wiki)~~(**UPDATE1**) and then I recompile to find some more errors. This may not be the best method, but I feel it's the most efficient one I have in my hand. And since I don't know exactly how many incompatibilities are present, it is difficult to accurately estimate the progress of the project. I am hoping to discover a method that would help me resolve problems faster. (Like using `strict` analysis using `VS Code` that can reveal missing functions beforehand. I have already created a `VS Code` config that uses the `Redox OS` cross-compiler)

<br/>

### Some more technical stuff

1. ~~One of the major missing features in QEMU is KVM as it needs virtualization support on Redox.~~ **UPDATE2: Virtualization support is coming to Redox OS _soon_! The feature is called `revirt` and the project plan and implementation details are documented in the post - ["RSoC 2022: Revirt - Virtualization on Redox OS"](https://redox-os.org/news/rsoc-2022-revirt-1/)**
2. ~~I am not sure about this, but `sdl` seems to be a supported library on `Redox OS`, so I'm guessing QEMU will work just fine with `GUI` as it supports `sdl` rendering~~ **UPDATE1: Redox DOES have static linking with `sdl`, with some known issues that are documented in the post - ["Bochs on Redox OS (and QEMU - Part 2)"](https://redox-os.org/news/bochs-qemu-2/)**.
3. There seem to be many features in QEMU which optimize the execution of `guest` code, I have chosen to disable most of them either due to incompatibility (I guess `membarrier` is one of them) or in order to just make to build simple enough to run without any failures the first time.  

<br/>
<br/>

# P.S. (Post Script)

I began doing this nearly a month ago and I have learnt a lot since then. Since I had to study major parts of how Redox OS works in order to make sense of how I would get QEMU running on Redox OS, I have come to form opinions on how I can try to make the OS, more specifically its build system better. And as much as I would love to do that, I'll have to stay focused on getting this project done!

During the course of this project (which still has so much exciting stuff to be done), I have been learning a lot and having lots of fun. A big factor to the satisfaction is the ability to work WITH a community, by not only writing your own code, but also constantly studying and learning from other code and learning how to deal with different coding styles. To contribute code to huge projects like this one requires oneself to be "disciplined". I want to thank those who have guided me in the `Redox OS mattermost chat` (`omac777`, `a4ldo2` and of course `jackpot51`).

Also, I shall make sure to keep the next blog post **more technical** as I wanted to make this one more introductory, but none the less, if you are still seeking technical information, ~~**refer the Gitlab WIKI link mentioned before**~~ (**UPDATE1**).  

<br/>
<br/>

# Until later!

If you've reached till this point, thank you for reading. I shall be coming back sometime ~~next month~~(UPDATE1) with more exciting updates!

Until then, keep well.  
Bye! 💕💕💕

<br/>

You can find me on:  
- [Redox OS - GitLab](https://gitlab.redox-os.org/enygmator/)  
- Redox OS - Mattermost chat - username: `enygmator`  
- [GitHub](http://github.com/enygmator/)  
- [LinkedIn](https://www.linkedin.com/in/ttarunaditya/)  
- [Twitter](https://twitter.com/Enygmator)  
- [Encrypted chat on Matrix (like _Element chat_)](https://matrix.to/#/@enygmator:matrix.org)  
