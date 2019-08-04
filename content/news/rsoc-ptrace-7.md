+++
title = "RSoC: Implementing ptrace for Redox OS - part 7"
author = "jD91mZM2"
date = "2019-08-04T10:11:27+02:00"
+++

# Introduction

Hallo Welt! Have you ever written a project and when it's done you
just think "Now what"? The project you've been working on for days,
weeks, maybe months I don't know, is just suddenly... without
direction?

I'm not trying to say my work here is done, but I do feel like we're
close... and that's frightening. In fact, this week has been all about
finishing things off (whenever I had time - life kept getting in the
way an annoying lot)

# Features of the week

The PR of both last week and this one was merged, so as I'm writing
this the features are actually available on Redox OS. All you have to
do is update your version!

## Ignoring signals

In [kernel commit
ad5f3814](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/107/diffs?commit_id=ad5f3814fa665fe1c7123b02a91feeec80b0d50d)
I made it possible to ignore signals and therefore stop signal
handlers from being invoked in the tracee, and handle it yourself
instead. A typical use for this could be a debugger that wants
`SIGINT` to just stop the tracee instead of quitting it.

I was about to add another flag, `PTRACE_FLAG_SIGIGNORE`, which would
when set just ignore any started signal. But when I thought about it
long and hard, I realized we already have something similar: sysemu!
Recent changes have already made sysemu work so you can activate it
after a pre-syscall event and it will just return with your own set
registers instead of handling the system call in the kernel. So it's
an awful lot like ignoring the system call... Aha. The flags were
merged, and [RFC commit
6d8bd4f1](https://gitlab.redox-os.org/redox-os/rfcs/merge_requests/14/diffs?commit_id=6d8bd4f15d98cc5b20b3fef856434b2cef0a5744)
now has the flag `PTRACE_FLAG_IGNORE` which will handle both signals
and system calls, and is scalable.

## Handling int3

Turns out, however, that signal handlers can not actually handle
`int3`. The internal kernel function doesn't signal the process but
rather calls `exit` directly. Whether this behavior is desired or not
is something I should first ask you guys and then the project leader
Jeremy Soller. Would a process really benefit from being able to
register a signal handler to catch their own `int3`?

Until then, I made [kernel commit
40449d32](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/107/diffs?commit_id=40449d32b569aa174a631d839a8ce6bbeb573dbe)
use a new flag as specified by [RFC commit
92dfb55e](https://gitlab.redox-os.org/redox-os/rfcs/merge_requests/14/diffs?commit_id=92dfb55e2ffdb2d9c6a841b4e723494c3de749f5):
`PTRACE_STOP_BREAKPOINT`. Similar to `PTRACE_STOP_SIGNAL`, this will
let the tracer inspect the stopped tracee, and choose whether or not
to set `PTRACE_FLAG_IGNORE` for the next call and therefore not
perform the default behavior - exiting with `SIGTRAP`. Told you the
overhaul and `PTRACE_FLAG_IGNORE` designs were scalable!

# What now?

One big thing I thought I'd have to do is make memory maps readable,
like Linux' `/proc/<pid>/maps`. Turns out, unless I'm mistaken, that
most programs that wish to inject code into a tracee doesn't actually
use this but rather just writes directly to `rip` before running it,
reversing it, and resetting `rip` back again. This means I don't have
to let the user read memory maps, which is good because I don't know
if all the needed information is even available in Redox yet. And if a
user wants to inject a looot of code, they can just inject a syscall
that allocates a huge region and then write their code and jump to
there.

I still have some things on my to-do list, but most are just testing
things or thinking through some implementation details. For example,
yesterday I resolved [an old
concern](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/104#note_17542)
about catching the rsp of same-ring interrupts. This is unlikely to
ever be needed, but as I can't prove it will *never* happen I should
probably make sure it behaves correctly. A few other things I did was
[researching if modifying the CS register could be
bad](https://gitlab.redox-os.org/jD91mZM2/kernel/commit/266d7817e222acade8f809e47d3ab05b58c91898)
as well as remove a TODO comment [about the safety of the memory
implementation](https://gitlab.redox-os.org/jD91mZM2/kernel/commit/9a59ef9416ec6b5f436519b8dfc9a1769dcfd85c)
(which Jeremy had already gave [a thumbs up
on](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/104#note_17085)).

Then I suppose I should go back to investigating if GDB can be
ported. I'm also debating whether it'd be worth it to "just" write a
debugger from scratch in rust that keeps both Linux and Redox's vastly
different systems in mind from the start. Pros would be using Rust and
that it'd be easier for me to make something basic than investigate
something as huge as GDB. Cons are that GDB is huge and I'd hardly be
able to re-implement the entirety of it. Input from anybody working on
GDB or a competitor would be absolutely great!
