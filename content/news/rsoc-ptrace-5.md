+++
title = "RSoC: Implementing ptrace for Redox OS - part 5"
author = "jD91mZM2"
date = "2019-07-13T11:07:22+02:00"
+++

# Introduction

This week I've decided to skip trying to get GDB working *for now*
(there are so many issues it'll take forever to solve them), and
instead decided to finally give focus to the final concerns I had
about ptrace. Most changes this week was related to getting decent
behavior of child processes, although the design feels... suboptimal,
somehow (not sure why), so I feel I must be able to improve it better
later.

Another change was security: Tracers running as a non-root user can
now in addition to only tracing processes running as the same user,
only trace processes that are directly or indirectly children of the
tracer. In the future this can easily be allowed with some kind of
capability, but currently in Redox there isn't a capability-like
system other than the simple (but really powerful) namespacing system
which sadly I don't think can be used for this.

## Catching child processes with ptrace

The first and most pressing issue was that there needed to be a way to
catch child processes (also threads, Redox makes no distinction) from
ptrace. It should be possible to both stop the child process, or let
it keep running uninterupted.

My design revolves around an event system: When a child process is
created it sends an event with the PID, as well as pauses the child
until we've determined if we want to trace it. Events interrupt any
wait, but returns `Ok(0)` to signify that the breakpoint may not have
been reached yet. Then one can `read` from the `proc:<pid>/trace` file
handle to obtain a few events at a time, which will also clear
them. Setting a breakpoint while an event is not yet read, will not
wait for that breakpoint to be reached, but rather return `Ok(0)`
immediately.

With this design, you will be able to write code like this:

```rust
let mut written = tracer.write(&[PTRACE_SYSCALL])?;
while written == 0 {
    let mut event = PtraceEvent::default();
    // Assert we read exactly one event, as we know there must be at
    // least one because of `written == 0`, and we only have storage
    // for one event (room for optimization: you *can* read more at
    // once)
    assert_eq!(tracer.read(&mut event)?, mem::size_of::<PtraceEvent>());

    // TODO: Handle event

    // Retry the wait, the tracer is still running at this point and
    // may or may not have reached the breakpoint we set.
    written = tracer.write(&[PTRACE_WAIT])?
}
```

---

The implementation was actually quite simple, which was actually
somewhat of a goal for this design! (Redox is a microkernel,
remember?)

Events are sent to a `VecDeque` that handles them. If the queue was
previously empty, send a `EVENT_READ` notification to the `event:`
scheme. Either way, notify the tracer file handle waiting for a
breakpoint to be reached.

I love the `WaitCondition` structure, it makes blocking and notifying
so easy :)

[Here you can see the
code](https://gitlab.redox-os.org/jD91mZM2/kernel/commit/be867ae5f13e0b72a9ebd0eae32b5f9e0509e175#1408dd4ba159dbf927129c610817b1faf0e08349_24_124)

## Catching signals

Another change I made was related to signals. It's tricky to come up
with a design that just *feels* right, and I didn't really succeed
here. Let's start with the critera though. I'm not very used to ptrace
so I am far from an expert in even the simple task of giving criteria,
but I'll start with the most basic: The design has to be able to trace
system calls and instructions ran in signal handlers. The design also
has to be able to obtain the actual signal number, as well as run the
program normally up to a signal.

My design is requires 2 new constants:

- `PTRACE_EVENT_SIGNAL` is an event similar to the child-process event
  above, but on each signal we only send the signal number.
- `PTRACE_SIGNAL` for running the program until any signal is reached,
  which in case it stops *before* the signal handler is invoked. So if
  the child sends a signal to itself, it will be somewhere inside the
  `SYS_KILL` syscall.

---

Turns out these simple criteria are still pretty tricky to meet for
two reasons

Firstly, as a signal may happen inside a syscall, they will break the
unwritten rule that each syscall will raise 2 breakpoints in order. If
we take the example above about a program killing itself, we'll see
the following behavior

```
(pre-)syscall: SYS_KILL
(pre-)syscall: <inside the signal handler>
(post-)syscall: <inside the signal handler>
...
(pre-)syscall: SYS_SIGRETURN
(post-)syscall: SYS_KILL
```

This is annoying mostly because the program can't actually detect
whether it's the event is pre or post syscall. So it'll have to make
an intelligent guess using the signal event, which I guess could
work. But this is suboptimal and I have yet to solve this somehow.

Secondly, it is ~~possible~~, nay, *probable* that a signal is handled
using either `SIG_DFL` or `SIG_IGN`. Both of these are handled in the
kernel, and should probably not let you control. Plus, even I wanted
to allow this, the current way of setting breakpoints only works on
user-triggered syscalls (which is probably for the best). So no signal
breakpoint will be caused then, only a signal event. And you can't
abort the signal.

[Related code for signal handling
(simple!)](https://gitlab.redox-os.org/jD91mZM2/kernel/blob/a7da393cf569416314fd1c9e016cece352537929/src/context/signal.rs#L103)

---

I think something to set as a goal with signals is to hit two birds
with one stone and use them for handling the `int3` instruction which
is used by debuggers to set breakpoints. That instruction causes a
`SIGTRAP` signal, something which I think could be used. Somehow there
has to be a way to inject code into a program (on Linux you search
memory maps for free space and inject machine code there, see [this
awesome article](https://www.linuxjournal.com/article/6210))

Once again, I'd be extremely thankful for any kind of feedback, even
negative. I'll go read the Linux man page on ptrace a few times now -
we're at that point.

[RFC
changes](https://gitlab.redox-os.org/redox-os/rfcs/merge_requests/14/diffs?diff_id=5320&start_sha=5290757f9b0ec3fd5ab28d9abb1e7cd7332053f9)
