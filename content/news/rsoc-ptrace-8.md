+++
title = "RSoC: Implementing ptrace for Redox OS - part 8 - The finale"
author = "jD91mZM2"
date = "2019-08-18T16:16:27+02:00"
+++

# Introduction

Bonjour le monde! Another week, another- hold on. It's been two
weeks. Time flies, doesn't it? Last week I was sadly on vacation and
couldn't devote much time to Redox, but this week I've been back!

---

Most of my work this week has been about GDB. I've asked around a
little about porting Redox OS in the #gdb IRC channel on freenode, and
had a poll about which way I should go forward: Port GDB or create my
own GDBserver from scratch in Rust. The votes have been received, and
the answer was:

## Building a GDB server in Rust

[The GDB Remote
Protocol](https://sourceware.org/gdb/onlinedocs/gdb/Remote-Protocol.html)
is incredibly well-documented and a pleasure to work with. GDB is
really compatible with all kinds of targets, using new features only
on the targets that explicitly supports them.

I created the
[gdb-protocol](https://gitlab.redox-os.org/redox-os/gdb-protocol)
library for parsing the main structure over GDB packets and performing
checksum verifications. The actual contents of the packets isn't
interpreted currently. Then I started work on a "gdbserver" program
(in rust, still) that aims to support both x86_64 Linux and Redox OS.

![GDB trying its best to understand the madness that my program
sends](https://i.imgur.com/k0Oj63q.png "GDB trying its best to
understand the madness that my program sends")

## Detect exits

[The RFC now specifies
`PTRACE_STOP_EXIT`](https://gitlab.redox-os.org/redox-os/rfcs/merge_requests/14/diffs?commit_id=f696cc7386e05938becf9745f648bd523118d50f)
and my fork of the kernel implements it. Robert O'Callahan, programmer
at Mozilla who works on the `rr` debugging utility suggested this
idea, as apparently it's very useful to be able to inspect the process
state *before* exit. Huge thanks to him for his input, it's incredibly
valuable. I will send out a merge request for the final changes soon,
and probably get the RFC merged.

## Final round up

My RSoC period will unfortunately end soon, together with the summer
vacation from school. This means I'll be unable to create patches as
rapidly and should spend the final few days to publish everything and
make sure everything is somewhat working. It's been a great summer and
I'm really happy to have gotten this opportunity again. Goodbye for
now, everyone!
