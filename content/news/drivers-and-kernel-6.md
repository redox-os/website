+++
title = "RSoC: improving drivers and kernel - part 6"
author = "4lDO2"
date = "2022-07-08T13:37:00+02:00"
+++

# Introduction

So far it's been two weeks since my third RSoC, where so far I have mainly
worked on moving large parts of kernel code, which deal with process
management, to userspace. In this blog post I will try summarizing what has
been accomplished so far, and exciting things I have started but not finished.

## `userspace_fexec` (and later `userspace_clone`)

(This feature is not yet merged, but available on my respective
`userspace_fexec` branches in `kernel`, `syscall` and `relibc`.)

Currently, the kernel has many syscalls related to process management as would
be expected in a Unix-like system, such as `fexec`, `clone`, `kill`, `waitpid`,
`exit`. Of the first two, `fexec` inherently is not as general as it could be,
and while the reasons to allow other binfmts than ELF in the kernel may be few,
moving it to userspace simplifies the kernel and if implemented correctly does
not impair performance or functionality. `clone` is not as complex as `fexec`,
but still calls `fmap` to re-obtain grants from the kernel.

The new implementation is in (my fork of) relibc, in `execve`, `fork` (does
what clone without `CLONE_VM` used to do) and `pte_clone` (for threads, and
does what clone with `CLONE_VM` used to do). The `execve` implementation is
shared with `escalated` (a daemon run as root which is used to implement
setuid/setgid) and uses interfaces from the `proc:` scheme (also used by
ptrace) to change e.g. the process name, signal stack, address space, and file
table in the case of `clone`.

If the kernel no longer understands ELF (well, it still uses `goblin` for
resolving symbols when printing backtraces within the kernel), then it must
obviously somehow load `init`. The way I implemented it was to add a new
binary, named `bootstrap`, which starts extremely simple. The kernel simply
loads `initfs:bin/bootstrap` as read+write+execute into address 0x0 and jumps
to a fixed offset. A tiny stub is written in assembly, which sets up an
environment for relibc and calls the normal `_start` entry point it provides.
As soon as it relibc calls back into `main()`, it runs the userspace
implementation `execve("initfs:bin/init", empty_args, kernel_envs)`, and `init`
continues as usual.

While `syscall::process` has shrunk by approximately 1500 lines, `scheme::proc`
has gotten more powerful interfaces, including the ability to switch processes'
address spaces (used by `fork` and `execve`), switching file tables (used by
`fork`), transferring grants between address spaces (used by `fork`), and
setting uid/gid if you're root (used by `escalated`). The page table handling
code has also been partially refactored so that threads now share the entire
address space, and not simply what was previously the grant area. Some syscalls
may also be replaced by the `proc:` scheme, for example `chdir` and `getcwd`.

# TODO

Just because there is no longer `io_uring` in the title does not mean it has
been abandoned! However, last summer, optimization of the nvmed driver using
io_uring turned out to be harder than expected, pointing out that there is room
for many other optimizations in the kernel, and perhaps that
userspace-to-userspace as I mentioned in the io_uring RFC might be preferable
for such situations, more than a syscall-multiplexing kernel would be (it could
also have something to do with how it was benchmarked). And, user threads for
any given process [have temporarily been placed all on the same hardware
thread](https://gitlab.redox-os.org/redox-os/kernel/-/commit/4f259e358915fc192785595f05889d29105f3a64).
Meanwhile, I have also during the year been working a bit on a runqueue-based
[O(1)
scheduler](https://gitlab.redox-os.org/4lDO2/kernel/-/tree/improved-scheduling)
(O(n) with respect to the number of timers though).

That said, with the introduction of [file descriptor
forwarding](https://gitlab.redox-os.org/4lDO2/rfcs/-/blob/scheme-forward-fds/text/0000-scheme-forward-fds.md),
and the possibilities for sandboxing that follows, the current syscall
interface may soon be reworked. For example, `openat` may allow opening new
files from existing files even for processes in the null namespace, and there
is an existing limitation that syscalls handled by schemes can only use up to 4
arguments. For that, the kernel-to-userspace io_urings, also mentioned before,
can replace the current packet-based API with a ring-buffer interface (probably
the same as is already implemented in `io_uring`) that would offer lower
latency. In that case, a potential syscall-multiplexing (as I halfway
implemented it last summer) kernel would also reduce complexity from 2x2
(syscalls initiated either from io_uring or blocking, and handled either by
packets or io_uring) to 2x1 (client is blocking/io_uring, scheme only uses
io_uring for handling requests).

The most exciting thing the new `AddrSpace` refactor will simplify, is
implementing on-demand paging. First, page tables are now always locked upon
access, and, all userspace virtual memory allocations now occur via `Grant`. In
the best-case scenario, and if I don't prioritize drivers/io_uring/scheduler
instead, I'll be able to implement on-demand paging before the end of this summer.

And of course, while both the userspace replacements of `fexec` and `clone`, as
I implemented them now, are capable of making the OS boot all the way to
desktop (and even [implements setuid/setgid securely (in
theory)](https://gitlab.redox-os.org/redox-os/escalated)), there are some
things which still need to be finished. `PTRACE_EVENT_CLONE` is no longer
generated (but could be, since creating a process via `proc:new` still
(currently) copies e.g. uid from the caller (due to the lack of an interface to
set uid for other processes unless you're root). `vfork` is no longer supported
either (in clone and exec, but remains in exit), but could be implemented in
userspace as well and requires no complex kernel interface. And, there is
memory corruption (only) in `orblogin` and `background`, but (1) it may be
unrelated given that the new Grant "allocator" now reuses addresses more often
than before, which debugging suggests has something to do with it, and (2) it
was not present before userspace clone, which should make it easier to debug.

The kernel initfs implementation, which very recently was rewritten to use a
proper filesystem format (as opposed to a source-level hack that required
recompilation every time initfs had to be changed), can also be moved to
userspace, if the kernel loads the raw initfs slice rather than loading
`initfs:bin/bootstrap`.
