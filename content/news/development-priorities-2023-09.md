+++
title = "Development Priorities for 2023/24"
author = "Jeremy Soller and Ron Williams"
date = "2023-09-30"
+++

We've made great progress this summer, as all the pieces of Redox continue to come together to create a complete operating system.

To give a big-picture perspective for where Redox development is headed, here is our view of priorities as of September, 2023.

## Redox ABI

Before Redox can reach Release 1.0 status, we need to establish a stable ABI. This means that application binaries will be able to run on future versions of Redox without having to be recompiled.
Our approach is to make our C library, `relibc`, the interface for the stable ABI, and to make `relibc` a dynamic library.
This will allow us to make changes at the system call level without impacting the Redox ABI. Applications will just load the latest `relibc` at run time.

Work needs to be done on our dynamic library support, as well as to continue to extend `relibc` functionality.
We will also need to change programs that are currently using Redox system calls directly to use `relibc` instead.

## Redox Server

We want to develop a Server version of Redox.
This is a higher priority than desktop because it is presumed to be a smaller scope.
We have some work to do on optimizing drivers, especially network drivers.
The foundation is very much there and porting common server programs is an important step to take - things like Apache, Nginx, etc.

### Self-Hosting the Redox Website

We would like to host the Redox website on Redox running in a virtual machine.
The Redox Summer of Code projects have been filling in some of the gaps we have had for virtual machines.
Having drivers like the ones Andy worked on for VirtIO will enable much lower latency and higher performance virtual machines running Redox.
It gets us to the point where we might be able to run Redox on a cloud machine, like EC2 or DigitalOcean.

### Virtual Machine Support

There is a lot of work to be done on virtual machine support, device virtualization and Redox as a hypervisor.
Some of the Summer of Code work was in this area, and we are hoping to see this work continue.

## Self-Hosting the Build System

We want to self host the build system.
This has been a very long term goal that we have been working on over the entire course of Redox, and a very important one.
We have been able to port GCC, Binutils and other aspects of the build system to Redox, but the one remaining issue is that `rustc` itself doesn’t work very well on Redox.
The work we have to fix that is pretty involved, it’s at all places in the stack.

- We have to continue porting functions to `relibc`, and we have to continue porting Rust crates that that need Redox-specific changes.
- We have to continue implementing more driver and kernel support.
- Importantly, we have to implement more POSIX process and job management system calls and C library functions. This is one area that has been particularly difficult and 4lDO2 has been working really hard on it. So we hope to have some progress made within the next year. 

### Developer Tools

We need to work on porting developer tools to Redox.
That involves identifying the tools we want to port and ensuring that they are running properly. We have a lot of the basic things there, like the ability to compile C programs, Python and Lua and some other scripting languages that have been partially ported.

But the big one is still `rustc`, and then after that, porting other popular languages. Elixir and Go, for example, have their own runtime and are therefore more difficult than C and C++.

We also still have a lot of work to fully support C and C++, because of missing aspects of `relibc` that need to be fleshed out, e.g. wide string support.

## Performance

We need to start giving more attention to performance and responsiveness, and making Desktop and Demo go faster is an important part of that.

A majority of how people will interact with the system is to download our ISO and try it out on real hardware.
That’s a common thing for Linux distributions and we should assume that people will be trying to do with Redox.
Right now we have some issues that are stopping us in that direction.
The support for virtual machines is far better than for real hardware.
Our device drivers try to target common hardware, but they don't always work well.
For example, the high definition audio driver may work on one machine but hang on another machine.
Preventing hangs like that across the entire set of drivers that we have is a very important part to getting people to be able to see our demo image running on real hardware at native performance.

Then there is optimization.
4lDO2 has been working on various optimizations, like on demand paging.
Jeremy likes to port a lot of games, emulators and things like that, because it’s another way to see the performance.
When you can make a game run properly at very high speeds and very low latency, then you know the rest of the stack is basically good.
It becomes an easy benchmark to compare as you make changes.

## Cosmic Desktop

The Cosmic Desktop is something being worked on at System 76, where Jeremy works.
It’s an open source Linux desktop environment that is written mostly in Rust, and that aligns it with the goals of Redox.
There are some things we need to work on to have Cosmic Desktop on Redox.

- First, we need to port some of the applications that are going into Cosmic.
For example, the text editor that Jeremy is working on for Cosmic can be ported to run on top of Orbital, which is our current window manager for Redox.
- The second stage will be to port Wayland and the Cosmic compositor.
That will allow us gain all the applications on Cosmic and the other elements of the shell by having an actual Wayland compositor.
That will also enable us to easily port GTK, Qt, and other app frameworks like Electron.
A large list of applications that run on Linux are able to be ported to any Wayland environment, and should require minimal patching to run on Redox.