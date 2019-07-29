+++
title = "RSoC: Implementing ptrace for Redox OS - part 6"
author = "jD91mZM2"
date = "2019-07-29T07:59:35+02:00"
+++

# Introduction

Hallå världen! We've got yet another week on our hands, and that must
surely mean another status report on ptrace? It does. If you recall
last week, I said my design just *felt* wrong, but I couldn't explain
it? This has been fixed, it now feels more right than ever, let's see
what's changed!

# Ptrace overhaul

After a tough session of brainstorming I rewrote the RFC, you can see
the process
[here](https://gitlab.redox-os.org/redox-os/rfcs/merge_requests/14/commits). This
design changes the dull `PTRACE_SINGLESTEP` to the new awesome
`PTRACE_STOP_SINGLESTEP`, with the new advantage of being a
non-exclusive operation! That's right, you can now set multiple
breakpoints with ptrace, and it will stop on the first one while
reporting which one it reached. How will it report that?

Everything is an event! Especially breakpoints, they now use events to
report which one was reached as well as any arguments that might be
useful. This lets you catch which signal caused `PTRACE_STOP_SIGNAL`
to be returned. The design was largely inspired by Linux' `PTRACE_O_*`
which is a non-exclusive way to stop at more places than just the one
you requested. And yes, this does mean I thoroughly read through
almost the entire `man ptrace` ;)

After a breakpoint is reached you can `read` from the trace file
descriptor to recieve one or more events. This lets you catch both
breakpoint and non-breakpoint events, where the non-breakpoints don't
stop the tracee. If you try to set a new breakpoint without `read`ing
all events, it will refuse to wait for the breakpoint to be set. In
non-blocking mode it won't wait anyway, although you can use
`PTRACE_FLAG_WAIT` to override this behavior.

![Image of a signal breakpoint](https://i.imgur.com/J8XkeW1.png)

Sysemu breakpoints are now more flexible. You don't have to decide
whether to emulate a syscall up-front, but rather once you recieve a
`PTRACE_STOP_PRE_SYSCALL` (the reason for separating pre- and
post-syscalls are described in the RFC) you can choose to add
`PTRACE_FLAG_SYSEMU` *to the next* ptrace operation.

## Bitflags!

Now that ptrace operations use a lot more bits, using a `u8` would be
too small. I increased this to a whooping `u64` which to me sounds
smaller than it is (I *currently* only use 16 bits anyway!). To
convert a 64-bit integer one can use `to_ne_bytes()`... I'm
kidding. You don't have to do that either!

I am experimenting with using the
[bitflags](https://crates.io/crates/bitflags) crate for creating type
wrappers around various flags in the redox_syscall crate, where ptrace
is one of them. This will not only have the benefits of using the type
system to ensure you don't mix and match different flags in an invalid
way, as well as giving a darn useful `Debug` implementation; it will
also have the benefit of letting me implement `Deref` on this struct
which will let you coerce `PtraceFlags` to `&[u8]`!

You can see if you also think the kernel gets cleaner with this change
[in this
commit](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/107/diffs?commit_id=538ca49ee2de79c0f53b29782754778210671a9f). If
not, write to me and complain!

# Strace improvements

Strace has been separated into two possible compilation modes: Simple
and advanced. The simple code is what we had before, code that's easy
to read and understand where everything is synchronous. Advanced mode
is a new and exciting mode that uses the asynchronous interface (not
rust `async`, yet) to support more functions: Such as also tracing
child processes and threads.

[See the commit here](https://gitlab.redox-os.org/redox-os/strace-redox/commit/ab942219d92adcf303a933824b60c0b52924d96b)

# What's next?

Now that we're back to where we were (but with a much more scalable
system on our hands), I can get back to work implementing a way to
override signals and therefore handle `int3`. After that, a lot of the
final concerns and nitpicks I had are completed. Then there's also the
huge problem left of actually allowing the user to inject code...

See you the next week! Until then, make sure to stay hydrated in this
warmth 🍻
