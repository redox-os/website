+++
title = "RSoC: Implementing ptrace for Redox OS - part 4"
author = "jD91mZM2"
date = "2019-07-13T11:07:22+02:00"
+++

Table of Contents:

- [Merged (again)!](#merged-again)
- [redox-nix update](#redox-nix-update)
- [Relibc: ptrace compatibility](#relibc-ptrace-compatibility)
  - [Issue #1](#issue-1-the-waitpid-interaction-with-ptrace-is-vastly-different-on-redox)
  - [Issue #2](#issue-2-tracemes-are-not-implemented)

# Merged (again)!

Once again, [last weeks
action](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/104)
was merged, which means the full ptrace feature was merged, and it's
time to start tackling the final issues which I have delayed for so
long. But, before that, I decided to try to get some basic [ptrace
compatibility in
relibc](https://gitlab.redox-os.org/redox-os/relibc/tree/78b4e992a01f9bd14d4f00e3d8fb253abb0f7a0e),
so we could see just how far away software like gdb is from being
ported, and what concerns I haven't thought about yet.

# redox-nix update

That said, I took a little break from the madness, to instead lay my
focus on another interesting problem: Newer
[redoxer](https://gitlab.redox-os.org/redox-os/redoxer) couldn't be
compiled using [carnix](https://nest.pijul.com/pmeunier/carnix),
because of some dependency that used a cargo feature carnix didn't
support. Let me first explain what carnix is, and why this is a
problem:

The [Nix](https://nixos.org/nix/) package manager, in all it's glory,
is all about reproducibility. This means one should not have any
compilation cache that may make compilation work for one person but
not for another. This aspect is not dissimilar from the Redox package
manager, as it first downloads the source in `source/`, and then
copies it to `build/` before each build. (I'll not dive into details
in whether Redox will eventually get a more interesting package
manager, but the answer is yes, hopefully!)

Consider this: You are building a crate that requires the `openssl`
crate. You install the openssl C dependency and forget about it. Later
you decide to build a package for this crate. If you have compilation
cache, you might not have to rebuild the openssl crate, even if you
use sandboxing or otherwise uninstall the openssl C dependency just to
see whether it's required or not. Therefore you may forget to add that
as a C dependency, and break reproducibility.

Of course you don't *actually* want to rebuild everything on each tiny
change or update, though... That's why `carnix` throws cargo in the
trash can and rolls it's own solution: Create a package for each
dependency crate, and manually compile them with `rustc`. Throwing
cargo in the trash can, along with not being great for the environment
(one should really recycle things), also throws all the cool
cargo-specific there as well and leaves `carnix` to constantly
re-implement each feature, which of course breaks a lot of things.

This problem is why I started "yacna", Yet Another Cargo->Nix
Alternative. It aims to use `cargo` as a library to generate all the
needed commands using the completely standard way, and then modify the
commands only as little as possible to make things work. It's not
pretty, but locally I have managed to compile a simple crate with like
one dependency. And it supports feature flags and everything out of
the box, thanks to re-using Cargo. This is what I've spent much of the
week on, and thus I won't have too much to give that is Redox-related.

# Relibc: ptrace compatibility

The relibc `ptrace` implementation will always be a best-effort one,
as due to the nature of Redox's vastly different (read: superior)
ptrace API (which is more similar to the `/proc` filesystem almost
every experienced ptrace user keeps talking about), it'll always be a
hellish compatibility layer which keeps track of most things in
userspace. Note that Redox will, at least as long as I get anything to
say about it, never implement useless or otherwise ptrace "features"
for compatibility with Linux in the kernel. That's why it'll be very
difficult to get this to work in relibc.

The first things I did was to [implement a ptrace wrapper for
Linux](https://gitlab.redox-os.org/redox-os/relibc/commit/1b5e986f785b2ad6d0938f8ee98de67cc2257e94),
which was of course easy when the function and the syscall map 1:1.

Next, I had some fun and implemented the
[Once&lt;T&gt;](https://gitlab.redox-os.org/redox-os/relibc/commit/2333e45292d63b0cfa49509cc773a70a05bae646)
synchronization primitive. It's interesting to implement something
which is so important you get right, as locks could be attempted
simultaneously and the whole goal is to handle that gracefully. I
spent some time to unify the Mutex and the Once code, as they are
surprisingly similar in a way.

Next up: Stop doing other things, although needed, and get to work!

## Issue #1: The waitpid interaction with ptrace is vastly different on Redox!

This had to be worked around by adding a specific ptrace handler, as
shown
[here](https://gitlab.redox-os.org/redox-os/relibc/commit/78b4e992a01f9bd14d4f00e3d8fb253abb0f7a0e#e88b1136081fe48ebfae4583076018da4e05e85c_912_914):

```rust
// First, allow ptrace to handle waitpid
let state = ptrace::init_state();
let sessions = state.sessions.lock();
if let Some(session) = sessions.get(&pid) {
    if options & sys_wait::WNOHANG != sys_wait::WNOHANG {
        let _ = (&mut &session.tracer).write(&[syscall::PTRACE_WAIT]);
        res = Some(e(syscall::waitpid(pid as usize, &mut status, (options | sys_wait::WNOHANG) as usize)));
        if res == Some(0) {
            // WNOHANG, just pretend ptrace SIGSTOP:ped this
            status = (syscall::SIGSTOP << 8) | 0x7f;
            res = Some(pid as usize);
        }
    }
}
```

ptrace should also add `WUNTRACED` when in a session, but that is a
problem because of the below issue.

## Issue #2: Tracemes are not implemented

Tracemes are, in my opinion, useless. The parent could just attach to
the child using its process ID. It's just problematic:
`PTRACE_TRACEME` can be called from a child process so that the
parent, without help from the kernel or the process itself, can't
really know it's in a session. And the memory is not shared in
`fork`s. So somehow, here it needs to detect that, perhaps using
[IPC](https://gitlab.redox-os.org/redox-os/ipcd). Of course though, it
can't issue a blocking `read` and/or `write` in a nonblocking `ptrace`
call, and ugh. Another alternative is using shared memory, but that
means you need to tell one single `BTreeSet` to use a different
allocator, that also somehow dynamically allocates things in a fixed
view of memory.

For now, `PTRACE_TRACEME` is a no-op, and most ptrace operations
automatically attach to the child process it's trying to operate
on. Works great, except now `waitpid` can't add `WUNTRACED`
automagically before any ptrace operation is issued on the parent. So
having it a no-op is sadly not a solution. I am almost tempted to
implement the ptrace compatibility function as a specialized scheme
daemon which by taking care of all ptrace-related calls can share
memory and therefore implement this stuff easier. But while
`PTRACE_TRACEME` is the only issue, I think I'll try sticking to a
less overkill solution.

---------------

![Image of ptrace running on Redox](https://i.imgur.com/YWwEmxM.png)
