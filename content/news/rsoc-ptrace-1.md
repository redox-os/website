+++
title = "RSoC: Implementing ptrace for Redox OS - part 1"
author = "jD91mZM2"
date = "2019-06-22T17:51:26+02:00"
+++

Table of Contents:

- [Introduction: Overview of my week](#introduction-overview-of-my-week)
- [Reading process registers](#reading-process-registers)
- [End result](#end-result)

# Introduction: Overview of my week

Another week, another blog post, I would suppose. It's hard to sum up
this week in one sentence, so instead I'll divide it into regions for
this simple overview.

1. I was so tired of never being able to even compile Redox OS, so I
   talked to the BDFL, Jeremy, and ~~asked~~, no, begged for help. I
   quite literally threw all my logs at him and tried to make reason
   with the seemingly insane output. Before he could answer, I noticed
   a strange thing in the logs which ultimately led to being able to
   compile the project. In the end, most of the issues were shamefully
   enough just caused by my local setup.
2. Likely due to my (and several others') problems, Jeremy merged the
   more successful
   [redox-unix](https://github.com/rust-lang/rust/issues/60139) branch
   to master. After this I gathered a [list of build
   issues](https://imgur.com/a/urAzjtO) and after getting permission
   [fixed](https://gitlab.redox-os.org/redox-os/coreutils/commit/850aeed139d442c46687f630c51d47c0b8234342)
   [them](https://gitlab.redox-os.org/redox-os/uutils/commit/fc3fcfd9660da2f847fbbbae7bed5bc912ef7d83).
3. Having Redox OS now successfully building, I started writing kernel
   code while the final few things were still recompiling. Last week I
   had a lot of time to learn about kernels and explore Redox's
   kernel, so this week I felt surprisingly comfortable moving around
   the code.
4. Time to test the patches, right? I tried to install
   [redoxer](https://gitlab.redox-os.org/redox-os/redoxer), but like
   always, I needed some patches for NixOS. Tired of always treating
   NixOS like garbage I constantly need to send PRs to fix, I decided
   to slowly *embrace* the amazing distro by moving all the patches to
   a central
   [redox-nix](https://gitlab.redox-os.org/redox-os/redox-nix)
   repository which I can maintain in the high-speed phase it
   deserves, hopefully leading to an alternative, reproducible, build
   system. Redoxer sadly got some other issues I'm not sure where
   they're coming from, yet, so I ended up using the old ways to
   transfer programs to testing on Redox.
5. I managed to quickly [update the kernel to the 2018
   edition](https://gitlab.redox-os.org/redox-os/kernel/merge_requests/102),
   but after that I kept getting pulled away by life until my last
   day, today, where I finally managed to meet my goal of implementing
   a way to read process registers (which I will describe now!)

# Reading process registers

So, after having a pretty clear goal to meet specified by the
[RFC](https://gitlab.redox-os.org/redox-os/rfcs/merge_requests/14),
time to get things moving. I started with what I *thought* would be
low hanging fruit: Reading the registers of another process. It ended
up being more difficult than I thought, but it ended up being really
interesting and I want to share it with you :)

Quick note: You can follow along in the final commit
[here](https://gitlab.redox-os.org/jD91mZM2/kernel/commit/ccaaf08e8346ae20621d192a4d735b69d9c12b7b),
but don't worry if this is confusing.

I quickly implemented the scaffholding for this feature: A `proc:`
scheme as specified by the RFC. I will not go into details as to how
schemes work, as I published an article on that last year [on
dev.to](https://dev.to/legolord208/programming-for-redox-os-4124). Then
it was time to brainstorm how the actual reading was going to take
place:

---

Perhaps the most obvious idea would be to somehow attach to the
process, read its registers, then detach. There are a lot of holes in
this idea however. For starters, attaching to a process will start
running whatever code the process was stopped at and not my own
code. Also, it's difficult, if not impossible, to store all registers
without modifying any of them considering all compiled code ends up
converting variables to registers.

My second idea was based on somewhat of a misunderstanding how
processes switches work. Basically, the way a kernel runs multiple
programs seemingly in paralell using one single CPU thread is through
"context switches". It stores the state of each process/"context" by
storing all its registers. To run one of these "contexts", it loads
the registers, on x86\_64 this is most notably the RBP and RSP
registers [as seen
here](https://gitlab.redox-os.org/redox-os/kernel/blob/78e79fc4d629069a65c1b7c8f65231953db6c99c/src/context/arch/x86_64.rs#L86).
The RSP controls where in memory the `push`/`pop` assembly
instructions should read/write, and the RBP points to the current
function, and can be used to get function arguments as well as the
address of the parent function which will be returned to with the
`ret` instruction. Before running a process the kernel tells the CPU
to enter "user mode" and therefore discard a bunch of privileges. It
also tells the CPU to send an "interrupt" (sort of like a kernel
event) after a specified duration and switch to another context.

Anyway, as I was saying, my second idea was based on this. I thought I
could just get all registers from the context switching mechanism,
right? Well at the point of each switch, a LOT of kernel code has
probably ran, and many general-purpose registers might have changed
values since of course the kernel is also turned into assembly. But I
wasn't completely off the track: Since system calls aren't supposed to
change any registers other than RAX (the return value), the original
register values must be available *somewhere*, which is when a friend
helped me discover [the interrupt
mechanism](https://gitlab.redox-os.org/redox-os/kernel/blob/78e79fc4d629069a65c1b7c8f65231953db6c99c/src/arch/x86_64/macros.rs#L317). This
code `push`es all the registers to the stack before running an
interrupt, and `pop`s them later. This is to preserve their
values. Now, theoretically, if I were to save this pointer, I could
not only read their saved user-assigned values, but also change the
values they will later restore to! This is what I did.

1\. After timeout and a context switch happens, simply save the
pointer to the structure in stack that contains all our desired
values.

```diff
-interrupt!(pit, {
+interrupt_stack!(pit, stack, {
     // Saves CPU time by not sending IRQ event irq_trigger(0);
 
     const PIT_RATE: u64 = 2_250_286;
@@ -61,7 +62,23 @@ interrupt!(pit, {
     timeout::trigger();
 
     if PIT_TICKS.fetch_add(1, Ordering::SeqCst) >= 10 {
+        {
+            let contexts = crate::context::contexts();
+            if let Some(context) = contexts.current() {
+                let mut context = context.write();
+                // Make all registers available to e.g. the proc:
+                // scheme
+                context.interrupt_stack = Some(Unique::new_unchecked(stack));
+            }
+        }
         let _ = context::switch();
+        {
+            let contexts = crate::context::contexts();
+            if let Some(context) = contexts.current() {
+                let mut context = context.write();
+                context.interrupt_stack = None;
+            }
+        }
     }
 });
```

2\. When a `syscall` happens, do the same. This ended up breaking
EVERYTHING, mostly erroring about "No such process" and stuff.

[Long diff linked
instead](https://gitlab.redox-os.org/jD91mZM2/kernel/commit/ccaaf08e8346ae20621d192a4d735b69d9c12b7b#d0402fe7eee13eb8a4434432c0cd08c473811193_15_17)

3\. I found this suspicious code:

```rust
#[naked]
pub unsafe extern fn clone_ret() {
    asm!("pop rbp
         xor rax, rax"
         : : : : "intel", "volatile");
}
```

Turns out, that through some hackery this is called by the child
process after `clone`, and is responsible for returning 0. My syscall
setup had broken this, so I had to fix it. I'm still not entirely sure
how it works, and I pretty much swear this is the very first thing I
tried, but somehow [using the new stack restoration
system](https://gitlab.redox-os.org/jD91mZM2/kernel/commit/ccaaf08e8346ae20621d192a4d735b69d9c12b7b#8536610954d500485457bb54ddce81b757cf05cf_135_142)
ended up being the thing that worked after a day of work.

# End result

![Final result](https://i.imgur.com/C7WdO28.png)

The `regs` command is a simple test command I wrote:

```rust
fn main() -> Result<()> {
    let mut regs_file = File::open("proc:4/regs/int")?;
    let mut regs = IntRegisters::default();
    regs_file.read(&mut regs)?;
    println!("Regs: {:?}", regs);

    Ok(())
}
```

What I noticed is that both `ion` and `login` were running the system
call `waitpid`, which makes sense. All well-written processes *should*
run some blocking command. I did want to double check another process,
so I checked `nulld`. This is shown in the screenshot. The `rax`
register is holding the value of `read`, which is exactly what I
expected after reading the nulld code :)
