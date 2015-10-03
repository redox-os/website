+++
date = "2015-09-12T18:11:35+02:00"
title = "And So It Begins…"

+++

Redox development has been a long and arduous process, spanning several months
of breaking things until they are fixed.

On came the compiler errors, which meant the kernel had to be linked as an ELF
file, because the compiler had moved other functions above the entry function,
and SSE had to be disabled to prevent aligned memory operations from being done
on the stack pointer, because the compiler had decided to do that too. Some bugs
went away after completely unrelated lines of code were changed, which led
the compiler to make different optimization decisions. Most compiler
optimizations had to be disabled, and a custom link script used to avoid
compiler errors.

There was the transition to real hardware, and with it the realization that very
few virtualization platforms implement the hardware faithfully, and very few
manufacturer specifications are complete and correct. Sometimes the only
reference for the 'correct' way of doing things is deep in the Linux source
code. Often, device drivers would work on Qemu, but not VirtualBox, or on
VirtualBox, but not real hardware.

Also, there was a discovery of bugs in critical areas, the IDE driver,
the realloc function, the URL object, the list goes on. Discovery of these
requires a complete understanding of the Redox source, and an investigation
of the disassembly of the entire kernel, instruction by instruction. Some bugs
disappeared when debugging output was added, the side effects of debugging only
being different timing of instructions.

This blog is to chart the journey of discovery and rediscovery on my path of
developing Redox, a Rust operating system. Most posts will be about new
progress, some will be old anecdotes. All will be focused on demonstrating
the plight of the not-so-humble operating system developer, who is often too far
buried in principle or ego to discover their mistakes, or to replace them with
sometimes compromising solutions.

In the end, I hope to develop something that proves that Rust can be
a full-stack solution, from operating system to device drivers to user
applications, or fail spectacularly at doing so. What I have made already
supports some of these goals, with an X11-like windowing system, a VFS based
filesystem and network stack, and ELF file loading and virtual memory management
for user programs.

I hope you enjoy this as much as I do,

Jeremy Soller
