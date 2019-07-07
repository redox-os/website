+++
title = "RSoC: Implementing ptrace for Redox OS - part 3"
author = "jD91mZM2"
date = "2019-07-07T08:46:13+02:00"
+++

Table of Contents:

- [Merged!](#merged)
- [Accessing the memory of another process](#accessing-the-memory-of-another-process)
- [Accessing floating point registers](#accessing-floating-point-registers)
- [So... What's next?](#so-what-s-next)

[Pictures of ptrace :)](https://imgur.com/a/rdoOc7q)

# Merged!

Before I dive in to this week's actions, I am pleased to announce that
all the last weeks' work is merged! However, something went
hilariously wrong with [the
squash](https://gitlab.redox-os.org/redox-os/kernel/commit/effe02bd45c2fe4a058b2606cc50d4bbe2c47ff1#note_16912)
and the merge was [re-merged with a new
message](https://gitlab.redox-os.org/redox-os/kernel/commit/788526a3b3586731023c5ee6b0bf5cdaae746828),
but however, with Jeremy as author. Trying to fix one mistake lead to
another, but at least the commit message now makes sense, so I'm not
complaining :)

This merge means you can now experiment with basic ptrace
functionality using only basic registers and
`PTRACE_SYSCALL`/`PTRACE_SINGLESTEP`. I have already opened the second
PR in the batch: [Ptrace memory reading and floating point registers
support](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/104)
which will supply the "final bits" of the *initial* implementation,
before all the nitpicking of final concerns can start (not to
underestimate the importance and difficulty of these nitpicks - there
are some areas of ptrace that aren't even thought about yet and those
will need tending to)! I will comment on these changes in this blog
post, as there are some interesting things going on!

# Accessing the memory of another process

This is perhaps the most interesting change of all. I had to learn
about how processors handle memory: Each process/context has it's own
"page table" which translates parts (here "pages") of "virtual" memory
(in Linux and Redox, 4096 bytes long) to parts (here "frames") of
real, "physical" memory. This means that the pointer `0x12345` on one
process will point to different data than `0x12345` will for another
process. An exception is kernel memory, but only because all processes
map that memory each syscall to a pre-determined address (the virtual
address is still different from the physical one, so it's not much of
an "exception" really).

This paging memory is often portrayed as particularly complicatied -
and it probably is - but luckily I only had to touch the basics.

My first *successful* approach to this was by attaching to the target
process' page table and somehow save the needed memory, perhaps by
using the stack since kernel memory is hopefully mapped in both
processes. That worked, but because the array was on the stack it
could only transfer a limited set of bytes at a time.

![First successful attempt](https://i.imgur.com/nGZvXdn.png)

Then I talked to Jeremy, who told me the kernel would not support swap
memory for a while, so a better way would be to find out the physical
frame of the virtual page containing the requested address, and map it
to the current process as well, translating all addresses. This was
done
[here](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/104/diffs?commit_id=3df1044a53495750e9934daa9b8f39068f3ca011#1408dd4ba159dbf927129c610817b1faf0e08349_209_226).

# Accessing floating point registers

This was really easy for one reason: Jeremy also said the kernel will
*never* touch the floating point registers of a context. So no new
code had to be written to preserve these registers, they are already
saved in the context switch. Since I also made the `syscall`
floating-point struct memory-compatible with the x86\_64 standard,
[the end
product](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/104/diffs?commit_id=be56c246f6de3a2f0fd66c0abb3a0f7f4c8be295#7b7a526df43a73c91157c2f7c350f3a8b92dbe3b_57_60)
was basically just
```rust
unsafe { *(self.fx as *const FloatRegisters) }
```
with a bit of code to discard all the reserved bits to make sure the
user doesn't modify them.

An interesting bit here, though, is that the processor actually uses
80-bit floats. Therefore I got to have some fun to [interpret these in
the strace library](https://gitlab.redox-os.org/redox-os/strace-redox/blob/1579b98dcdacdec3477857bab1c0c9e64a5b117f/src/f80.rs)

# So... What's next?

First, there are a few concerns I have myself which I will need to
attend to in a later PR:

![TODO](https://i.imgur.com/8eAklUD.png)

Help would be welcome over at the
[RFC](https://gitlab.redox-os.org/redox-os/rfcs/merge_requests/14) (be
warned: Redox GitLab does not seem to send notifications!), or any
other way to contact me: Hoping I won't get spammed to bits, I'll
leave my contact details also (I really need help with these
considerations):

- Email: [me@krake.one](mailto:me@krake.one)
- Discord: jD91mZM2#1033
- IRC (Freenode/Mozilla): jD91mZM2

I've already gotten some help on the RFC which I am very, very happy
about. People with Linux ptrace experience give a lot of valueable
feedback about the shortcomings of the API and how the Redox API can
be designed better. Even though the basic implementation is done, it's
intentionally programmed so the biggest lowest-level bits are separate
from the main interface, which can therefore be replaced. It's not too
late!

Secondly, I'm working on a compatibility layer for ptrace over at the
[ptrace branch of
relibc](https://gitlab.redox-os.org/redox-os/relibc/tree/ptrace).
