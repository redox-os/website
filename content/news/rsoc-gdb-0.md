+++
title = "RSoC: GDB for Redox - part 0"
author = "jD91mZM2"
date = "2020-06-22T16:00:22+02:00"
+++

<img class="img-responsive" src="/img/screenshot/gdb-sigsegv.jpg" alt="GDB Crash" />

*We're here. The moment you've all been waiting for, the end of our journey is
at hand.*

No, not really. I'm somewhat exaggerating. What you're seeing in this picture
is actually a crash, and stuff doesn't work at all. Let's back up. How did we
get here?

# Introduction

As you might know, last year I spent the summer implementing a
`ptrace`-alternative for Redox OS. It's a powerful system where the tracing is
done using a file handle. You can read all about the design over at the
[RFC](https://gitlab.redox-os.org/redox-os/rfcs/-/blob/244f27dc26001ef738c3486258082908de1ecd79/text/0004-ptrace.md).
Thanks to this system I also got `strace` working, and then I started working
on a simple `gdbserver` in Rust, for both Linux and Redox, but mainly Linux at
that point, to lay the foundation for debugging on Redox using a Rust-based
program.

This week, I've been using the remnants of last year to work on porting this
debugging server to Redox. To do this, I had to make some more changes to the
kernel side of things.

# Changes to ptrace

## `Write` should not wait

The first change, I did because the `write` system call has been used in the
previous ptrace implementation to wait for an event to happen, only to later be
`read` from an event queue. This lead to some funkiness around the
`PTRACE_FLAG_WAIT` flag - mainly it did multiple things. Now it's deleted all
together :)

Before:

```rust
tracer.write(&[PTRACE_FLAG_WAIT]); // blocks until event

let mut event = Event {};
tracer.read(&mut event); // reads event
```

After:

```rust
let mut event = Event {};
tracer.read(&mut event); // blocks & reads event
```

## Read executable name

The GDB server needed to be able to read a process' executable name, which
wasn't possible in Redox. A process could read its own info using `sys:/exe`,
but it couldn't read another's executable name. I talked to Jeremy Soller (the
BDFL), and we decided that I should implement a virtual file called
`proc:<pid>/exe` (similar to `/proc/<pid>/exe` in Linux) and read from that. So
I did. And it works :D

## Pause on `fexec`

So, this change I'm not actually sure about. But from what I could tell, a
debugger should be able to control the process before it actually starts. So I
implemented a stop breakpoint `PTRACE_STOP_EXEC` to stop on the end of the
`fexec` syscall, with registers of the new executable, right before switching
to it. The implementation was quite difficult because switching to usermode
wasn't done using the traditional interrupt workflow (maybe I should fix
that?), but rather using some assembly code that cleaned all registers and
returned to userspace. This means I had to sort of pretend there was a stack
there before letting ptrace expose the registers to the tracer.

# Current state

With these ptrace changes, I was able to start porting my simple `gdbserver` to
Redox. It went mostly painlessly, but it's still not working great. I can do
basic breakpoint setting and continuing, but it seems like the underlying
process crashes at some points, and I really don't know why. Perhaps I need to
`strace` the gdbserver...

That's this week. See you after the next!
