+++
title = "RSoC: GDB for Redox - part 1"
author = "jD91mZM2"
date = "2020-07-02T12:17:30+02:00"
+++

<img class="img-responsive" src="/img/screenshot/gdb-works.png" alt="Debugging with GDB" />

# Introduction

Yesterday at 15:08 I sent this image excitedly to the Redox chat, along with the
message "Debugging on Redox... We're soon, soon, there."

You might notice how in this image, there are a few changes from the image of
last week. There's no split pane showing output - we only see GDB printing some
mad ascii characters $ and #, as well as what looks like hexadecimal numbers.

# Fixing last week's problems this week

What we see here is actually GDB debugging a program, running on Redox. Both the
`gdbserver` that we've been creating, and GDB itself, is running on Redox. And
they're communicating using what both programs *think* is a "unix socket". It's
actually our IPC scheme `chan:`.

If you remember from last week, the `gdbserver` I ran on Redox managed to crash
the program being debugged. I let my mind take a rest after than, and then
eventually came up with an idea: Why not *use* the gdbserver, to *debug* the
gdbserver? I didn't really do that, as cool as it sounded, I was still
technically debugging the minimal C program that I made.

You see, gdb has some amazing built in tools to view the assembly being
executed: `x/<n>i <address>`. `x` stands for reading memory, and `i` means
format the bytes as assembly instructions. This worked amazingly well, and using
`x/10i $rip` I was quickly able to tell that `$rip` laid in the middle of two
instructions - and according to GDB's debug logs, it laid exactly one byte after
where GDB had placed an `int3` instruction. If you're unfamiliar with what all
this means, just imagine that a compiler started compiling your code in the
middle of a line instead of at the beginning. It would lose context, and throw
*so* many errors! In principle, that's what happened here, the instruction
pointer was pointing in the middle of two instructions, trying to interpret
things that weren't meant to be interpreted.

The reason was that GDB assumed that we used a system like Linux, where a
breakpoint caused the instruction pointer to step back one byte on breakpoint.
Redox didn't do that before, it never even occured to me - now it does, as it
feels like the sanest thing to do: After all, even microkernels work towards
minimizing syscalls, so let's avoid that extra syscall that is 9.999/10 times
going to be following a breakpoint exception.

# Going forward

## From last week

So what then? We had a gdbserver running on Redox, ready for requests coming
from Linux. In theory, GDB should be able to be compiled on Redox as well, and
used to debug. So, to repeat, what should I do now?

Well, clearly, why let that "in theory" be theory, why not get GDB running on
Redox *now*. Turns out, it wasn't as painless as I had hoped. The processes
couldn't talk to each other over the netstack's loopback address, for whatever
reason, and little old me couldn't figure out why! There were also a bunch of
socket-related issues with relibc (I think most of them were caused by, uuh,
let's see here, *me*). So while I obviously tried to fix most of the relibc
stuff, the whole tcp stack is very confusing to me and I felt like we could wait
with that just a liiitle while longer. There has *got* to be an easier way.

Oh lookie, there is, I had just stumbled upon GDB's ability to communicate over
both unix sockets and standard I/O streams! Awesome! I got to work and thanks to
a pointer from Jeremy Soller, who had somehow figured out that fixing the unix
sockets would be easier than using I/O streams (which was true, the I/O streams
used `socketpair` to set up unix sockets behind the scenes anyway), I managed to
get the two processes communicating with a simple hack in GDB's source code.

I also had to fix my target description XML file, apparently it was broken, but
only GDB running on Redox would complain instead of just silently and magically
trying to figure out what I meant. I'm really happy that was caught, but I'm
also confused why GDB on Linux didn't catch it. It turns out GDB wants me to
interpret the `ST(i)` floating point registers as... well, floating point. Not
the 80-bit integers they were. So I created the crate
[f80](https://gitlab.redox-os.org/redox-os/f80) (not yet pushed to crates.io)
for this reason, to let me interpret these bytes using safe rust. I use some
assembly magic there, but unfortunately the new assembly macro is too new of a
Rust version. At that point, since there was already ongoing work to update
Redox, I let all those registers be zero for now and will fix it later.

## From this point

<img src="/img/screenshot/gdb-chat.png" alt="My announcement in chat" style="float: right; width: 50%;" />

Excitedly, I had to tell everyone. GDB was now running on Redox, albiet with a
presumably-broken floating point support. Not like anyone uses real numbers
instead of just limiting themselves to whole numbers, right? *Cough*.

There is still some hackiness required to set up GDB. I use [this
script](https://gitlab.redox-os.org/snippets/1087) to launch Redox with example
binaries and a script that ties gdb and gdbserver together. There's also limited
and potentially confusing process output - I might implement the protocol
queries required to pass output to the host GDB.

But once the final polishing of our initial GDB support is complete, I might
take look at implementing a library for more easily setting up a Redox scheme. I
noticed lots of code is being reused in various places, and also I'm annoyed at
how large and honestly confusing the `chan:` code is, even to me though I wrote
it, for being such a simple thing. I want to fix that.

<div style="clear: right;" />
