+++
title = "RSoC: Implementing ptrace for Redox OS - part 0"
author = "jD91mZM2"
date = "2019-06-14T17:02:31+02:00"
+++

Poor man's Table of Content:

 - [Introduction](#introduction)
 - [How does one use `ptrace`?](#how-does-one-use-ptrace)
 - [How can this be put into Redox?](#how-can-this-be-put-into-redox)

# Introduction

I got selected for RSoC the second time in a row this year. We
discussed what projects would be suitable to work on, and I suggested
something that lets you run Linux programs on Redox. While that's not
what I'll be doing, it's what I've set in mind as a long-term
goal. You'll see where I'm getting at in a second.

Instead, I'll be working on the `ptrace` system call for Redox. This
is the very syscall that not only User Mode Linux uses to emulate
Linux applications, but also what GDB uses to set breakpoints, as well
as `strace` to list all system calls. I think it's the most meta
system call there is, and it's an honour to get to implement it. Now
you should be able to see how it can aid in the goal which I just set!

---

So how's my progress? *None*. Yes, that's right, it's almost been a
week and I have zero *physical* progress. But I have learned a lot,
part of which I intend to forward onto you later in this
document. This lack of real progress was in no way intentional,
compiling Redox ended up taking forever because it nowadays builds a
modified Rust compiler itself along with the build. If you've ever
tried contributing to Rust before, or packaged it for your favorite
distribution, you'll know that's a *loooong* compilation.

Long story short, I've been compiling the very same thing with
different properties for *days* - no, a *week*. I've been in contact
with our leader Jeremy Soller asking for assistance, but he has not
encountered these issues before but could luckily offer some expert
advice, and I'm compiling one of them right now while I'm writing this.

# How does one use `ptrace`?

Ptrace is a beautiful way to run an binary for your system, but
setting *breakpoints* to stop the program at for inspection. These
breakpoints work just like GDB breakpoints, where the program pauses
and lets you inspect variables and functions, but in assembly (so, raw
registers and
memory). [RINE](https://gitlab.redox-os.org/redox-os/rine/) uses these
breakpoints to stop at every system call, and "translate" a Redox one
into a Linux one. This is precisely why **R**INE **I**s **N**ot an
**E**mulator, but rather a system call translator. It's the very
reason it is so fast. Note that standard WINE does not use ptrace for
translating, as Windows binaries are very different from Linux
binaries.

With `ptrace` one can override each register both before and after a
system call, including overriding the register that holds the system
call number (usually `rax` on x86_64) and arguments. Let's start with
a simple example written with the `libc` crate in Rust, that runs a
program but exits every time you decide to write data to `STDERR`. Why
on earth would you want such a program? you might ask. But I think you
should probably instead ask: Why on earth not?

1\. Create a new child process that we're going to intercept system
calls on:

```rust
use std::{
    io::{Error, Result},
    mem,
    ptr
};

// ptrace() in libc does not specify which pointer type is inputted,
// thus we'll want an easy constant which just uses any old type since
// we'll just set it to NULL anyway. For example: the empty tuple
// type.
const NULL: *mut () = ptr::null_mut();

// Nice macro to return `Result::Err<io::Error>` on failure. This is
// not provided as it is hardly related to ptrace.
macro_rules! t { ... }

fn main() -> Result<()> {
    match unsafe { t!(libc::fork()) } {
        0 => child(),
        pid => Parent::new(pid).run()
    }
}
fn child() -> Result<()> {
    unsafe {
        // Attach the parent process to debug this child process
        t!(libc::ptrace(libc::PTRACE_TRACEME, 0 as libc::pid_t, NULL, NULL));
        // Pause execution by raising SIGSTOP until restarted by parent
        t!(libc::raise(libc::SIGSTOP));
    }
    // Instead of writing the program you want to override here (which
    // isn't very useful), you can use the `execve` syscall to execute
    // an external application. But this is just for demonstration
    // purposes.
    println!("Hello, this is a test");
    println!("So the question is, does using STDERR really terminate the program?");
    println!("That would be pretty sad");
    println!("Let's try:");
    eprintln!("Please let me in?");
    println!("Well fsck.");
    Ok(())
}

// TODO
struct Parent { ... }
```

2\. Create our high-level overview of what we want this to do:

```rust
struct Parent {
    pid: libc::pid_t
}
impl Parent {
    fn new(pid: libc::pid_t) -> Self {
        Self {
            pid
        }
    }
    fn run(&self) -> Result<()> {
        // Wait for the initial raise(SIGSTOP)
        self.wait()?;
        loop {
            match self.step() {
                Err(ref err) if err.raw_os_error() == Some(libc::ESRCH) => {
                    println!("Uncaught child termination.");
                    break;
                },
                Ok(Some(status)) => {
                    println!("Child terminated with error code {}.", status);
                    break;
                },
                other => { other?; }
            }
        }
        Ok(())
    }
    fn step(&self) -> Result<Option<libc::c_int>> {
        // Pre-syscall
        self.next_syscall()?; // Sets breakpoint
        if let Some(status) = self.wait()? { // Waits for next SIGSTOP (or any other signal)
            return Ok(Some(status)); // return if program exited
        }

        let mut regs = self.getregs()?; // Get all assembly registers
        if regs.orig_rax == 1 && regs.rdi == 2 { // Check if the syscall is 1 (write) and first argument is 2 (STDERR)
            // File is STDERR
            regs.orig_rax = 60;
            regs.rdi = 123;
            self.setregs(&regs)?; // Override syscall params with 60 (exit) and 123 (our exit status)
        }

        // Post-syscall
        self.next_syscall()?;
        if let Some(status) = self.wait()? {
            return Ok(Some(status));
        }
        Ok(None)
    }

    // TODO ...
}
```

3\. Fill in the actual low-level bits:

```rust
fn wait(&self) -> Result<Option<libc::c_int>> {
    unsafe {
        let mut status = 0;
        t!(libc::waitpid(self.pid, &mut status, 0));

        // WIFEXITED returns true if the program was closed, see `man waitpid`
        if libc::WIFEXITED(status) {
            Ok(Some(libc::WEXITSTATUS(status)))
        } else {
            Ok(None)
        }
    }
}
fn next_syscall(&self) -> Result<()> {
    unsafe {
        // See `man ptrace`
        t!(libc::ptrace(libc::PTRACE_SYSCALL, self.pid, NULL, NULL));
        Ok(())
    }
}
fn getregs(&self) -> Result<libc::user_regs_struct> {
    unsafe {
        // Both mem::uninitialized() and mem::zeroed() should be safe
        // here, since the struct only contains integers and no
        // references, enums, slices, etc. It's not pretty, but the
        // struct contains no Default implementation, sadly.
        let mut regs: libc::user_regs_struct = mem::uninitialized();
        t!(libc::ptrace(libc::PTRACE_GETREGS, self.pid, NULL, &mut regs as *mut _));
        Ok(regs)
    }
}
fn setregs(&self, regs: &libc::user_regs_struct) -> Result<()> {
    unsafe {
        t!(libc::ptrace(libc::PTRACE_SETREGS, self.pid, NULL, regs as *const _));
        Ok(())
    }
}
```

The final code can be viewed
[here](https://gitlab.redox-os.org/jD91mZM2/ptrace-test/tree/f96d5fec45cb13e3780d1c3bef3e74046b538dcc). If
we run the above program, it will indeed exit when you try to write to
STDERR, as demonstrated:

```
$ cargo run
    Finished dev [unoptimized + debuginfo] target(s) in 0.09s
     Running `target/debug/ptrace-test`
Hello, this is a test
So the question is, does using STDERR really terminate the program?
That would be pretty sad
Let's try:
Child terminated with error code 123.
```

# How can this be put into Redox?

I have created
[RFC](https://gitlab.redox-os.org/redox-os/rfcs/merge_requests/14)
that talks about the design of `ptrace` for Redox. Thanks to
[@zen3ger](https://gitlab.redox-os.org/zen3ger) we have planned an API
that combines ptrace and [the /proc
FS](https://en.wikipedia.org/wiki/Procfs). There are still some
unresolved questions, however, which I'd advice you to go read and
suggest an answer to. For example,

<blockquote style="border-left: 2px solid gray; padding-left: 2em;">
What kind of security should be put in place, apart from<br />
the existing namespacing possibilities?
</blockquote>

I have a plan for how things should work under the hood, and I have
studied some of the kernel code when recompiling, to try to plan for
implementing this. So hopefully, by next week, I'll have something to
showcase. I apologize for the delay.
