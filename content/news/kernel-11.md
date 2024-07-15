+++
title = "Towards userspaceification of POSIX - part I: signal handling and IO"
author = "Jacob Lorentzon (4lDO2)"
date = "2024-07-09T00:22:00+02:00"
+++

# Introduction

I'm very exited to announce that Redox has been selected as [one of the 45
projects receiving new NGI Zero
grants](https://nlnet.nl/news/2024/20240618-Call-announcement.html), with me as
primary developer for [Redox's POSIX signals
project](https://nlnet.nl/project/RedoxOS-Signals/)! The goal of this project
it to implement proper POSIX signal handling and process management, and to do
this in userspace to the largest reasonable extent. This grant is obviously
highly beneficial for Redox, and will allow me to dedicate significantly more
time to work on the Redox kernel and related components for one year.

As this announcement came roughly a week after RSoC started, I spent the
first week preparing the kernel for new IPC changes, by investing some time
into changing the scheme packet format, improving both performance and the
possible set of IPC messages.

Since then, I've been working on replacing the current signal implementation
with a mostly userspace-based one, initially keeping the same level of support
without adding new features. This has almost been merged.

## Improved userspace scheme protocol, and stateless IO

TL;DR __As announced in the June report, an improved scheme packet format and
two new syscalls have improved RedoxFS copy performance by 63%!__

The Redox kernel implements IO syscalls, such as SYS_READ, by mapping affected
memory ranges directly into the handler process, and by queueing `Packet`s
containing metadata of those scheme calls. The `Packet` struct has existed, and
had zero changes to the format, since [this commit from
2016](https://gitlab.redox-os.org/redox-os/syscall/-/commit/0e7fec4adf35c9092b8c26c684bcb67ef5145a46). It is defined as follows:

```rust
#[repr(packed)]
struct Packet {
    id: u64, // unique (among in-flight reqs) tag
    pid: usize, // caller context id
    uid: u32, // caller effective uid
    gid: u32, // caller effective gid
    a: usize, // SYS_READ
    b: usize, // fd
    c: usize, // buf.as_mut_ptr()
    d: usize, // buf.len()
    // 56 bytes on 64-bit platforms
}
```

While this struct is sufficient for implementing most syscalls, the obvious
limitation of at most 3 arguments has resulted in accumulated technical debt
among many different Redox components. For example, since `pread` requires at
least 4 args, almost all schemes previously implemented boilerplate roughly of the
form

```rust
fn seek(&mut self, fd: usize, pos: isize, whence: usize) -> Result<isize> {
    let handle = self.handles.get_mut(&fd).ok_or(Error::new(EBADF))?;
    let file = self
        .filesystem
        .files
        .get_mut(&handle.inode)
        .ok_or(Error::new(EBADFD))?;

    let old = handle.offset;
    handle.offset = match whence {
        SEEK_SET => cmp::max(0, pos),
        SEEK_CUR => cmp::max(
            0,
            pos + isize::try_from(handle.offset).or(Err(Error::new(EOVERFLOW)))?,
        ),
        SEEK_END => cmp::max(
            0,
            pos + isize::try_from(file.data.size()).or(Err(Error::new(EOVERFLOW)))?,
        ),
        _ => return Err(Error::new(EINVAL)),
    } as usize;
    Ok(handle.offset as isize) // why isize???
}
```

as well as requiring all schemes to store the file cursor for all handles
(which on GNU Hurd similarly is considered a 'questionable design choice' in
[the
critique](http://walfield.org/papers/200707-walfield-critique-of-the-GNU-Hurd.pdf)).
This cursor unfortunately cannot be stored in userspace without complex
coordination, since POSIX allows file descriptors to be shared by an arbitrary
number of processes, after e.g. forks or SCM_RIGHTS transfers (even though this
use case is most likely very rare, so it's not entirely impossible for this
state to be moved to userspace).

The new format, similar to [io_uring](https://kernel.dk/io_uring.pdf), is now
defined as:

```rust
#[repr(C)]
struct Sqe {
    opcode: u8,
    sqe_flags: SqeFlags,
    _rsvd: u16, // TODO: priority
    tag: u32,
    args: [u64; 6],
    caller: u64,
}
#[repr(C)]
struct Cqe {
    flags: u8, // bits 3:0 are CqeOpcode
    extra_raw: [u8; 3],
    tag: u32,
    result: u64,
}
```

SQEs and CQEs are the Submission/Completion Queue entries, where schemes read
and process SQEs, and respond to the kernel by sending corresponding CQEs.
These new types both nicely fit into 1, and 1/4th of a cache line,
respectively, and some unnecessarily large fields have been shortened.
`SYS_PREAD2` and `SYS_PWRITE2` have been added to the scheme API, that now
allow passing both offsets and per-syscall flags (like `RWF_NONBLOCK`). The
`args` member is opcode-dependent, and for `SYS_PREAD2` for example, is
populated as follows:

```rust
// { ... }
let inner = self.inner.upgrade().ok_or(Error::new(ENODEV))?;
let address = inner.capture_user(buf)?;
let result = inner.call(Opcode::Read, [file as u64, address.base() as u64, address.len() as u64, offset, u64::from(call_flags)]);
address.release()?;
// { ... }
```

The last `args` element currently contains the UID and GID of the caller, but
this will eventually be replaced by a cleaner interface. The kernel currently
emulates these new syscalls as using `lseek` and then regular `read`/`write`
for legacy scheme, but for new schemes `lseek` can be ignored if the
application uses more modern APIs. For instance, in `redoxfs`:

```diff
// This is the disk interface, which groups bytes into logical 4096-blocks.
// The interface doesn't support byte-granular IO size and offset, since the underlying disk drivers don't.

unsafe fn read_at(&mut self, block: u64, buffer: &mut [u8]) -> Result<usize> {
--  try_disk!(self.file.seek(SeekFrom::Start(block * BLOCK_SIZE)));
--  let count = try_disk!(self.file.read(buffer));
--  Ok(count)
++  self.file.read_at(buffer, block * BLOCK_SIZE).or_eio()
}

unsafe fn write_at(&mut self, block: u64, buffer: &[u8]) -> Result<usize> {
--  try_disk!(self.file.seek(SeekFrom::Start(block * BLOCK_SIZE)));
--  let count = try_disk!(self.file.write(buffer));
--  Ok(count)
++  self.file.write_at(buffer, block * BLOCK_SIZE).or_eio()
}
```

Jeremy Soller previously used the file copy utility `dd` as a benchmark when tuning the most efficient block size,
taking into account both context switch and virtual memory overhead. The
throughput for reading a 277 MiB file using `dd` with a `4 MiB` buffer size,
was thus increased from [170 MiB/s](/news/this-month-240229), for the previous optimizations, to 277 MiB/s with the new interface,
roughly a 63% improvement. There is obviously a lot more nuance in how this
would affect performance depending on parameters, but this (low-hanging)
optimization is indeed noticeable!

For comparison, running the same command on Linux, with the same virtual machine configuration,
gives a throughput of roughly 2 GiB/s, which is obviously a significant
difference. Both RedoxFS (which is currently fully sequential) and raw context
switch performance will need to be improved. (Copying disks directly is done at
2 GiB/s on Linux and 0.8 GiB/s on Redox).

### TODO

- There are still many schemes currently using the old packet format. They will need to be converted, allowing the kernel to remove the overhead of supporting the old format.
- The `Event` struct can similarly be improved.
- Both scheme SQEs and events should be accessible to handlers from a ring buffer (like io_uring), rather than the current mechanism where they are read as messages using SYS_READ. And syscall overhead, although strictly faster than context switching, is still noticeable, which is also why io_uring exists in the first place on Linux.

# Signal handling

The internal kernel signal implementation improved [earlier in
March](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/283), to
address the earlier [quite serious
shortcomings](https://gitlab.redox-os.org/redox-os/kernel/-/issues/117).
However, even after the changes, signal support was still very limited, e.g. lacking support
for sigprocmask, sigaltstack, and most of sigaction.

## The problem

Over the past year, I have been working to a large extent on migrating most Redox components away from using `redox_syscall`, our direct system call interface, to [`libredox`](https://gitlab.redox-os.org/redox-os/libredox), a more stable API.
`libredox` provides the common OS interfaces normally part of POSIX, but allows us to place much more of the functionality in userspace, with a written-in-Rust implementation (even this is currently done by `relibc`, which also implements the C standard library).
This migration is now virtually complete.

Normally, monolithic kernels will expose a stable syscall ABI, sometimes guaranteed (e.g. Linux), and otherwise stable in practice (FreeBSD), with the most notable exception being OpenBSD (in the Unix world).
This makes sense on monolithic kernels, since they are large enough to 'afford' compatibility with older interfaces, and also because much of the actual performance-critical stack is fully in kernel mode, avoiding the user/kernel transition cost.
On a microkernel however, the kernel is meant to be as minimal as possible, and because the syscall interface on most successful microkernels differs from monolithic kernels' syscalls, that often match POSIX 1:1, this means our POSIX implementation will need to implement more POSIX logic in userspace.
The primary example is currently the program loader, which along with `fork()` was fully moved to userspace during RSoC 2022.
Along with possibly significant optimization opportunities, this is the rationale behind our [stable ABI policy](/news/development-priorities-2023-09/) introduced last year, where the stable ABI boundary will be present in userspace rather than at the syscall ABI.

The initial architecture will be roughly the following:

<hr />

![Redox ABI diagram](/img/signals-project/abi.svg)

A simple example of what `relibc` defers to userspace is the current working directory (changed during my [RSoC 2022](/news/drivers-and-kernel-7)).
This requires relibc to enter a `sigprocmask` critical section in order to lock the CWD, when implementing async-signal-safe _open(3)_ (in this particular case there are workarounds, but in general such critical sections will be necessary):

```rust
// relibc/src/platform/redox/path.rs
pub fn canonicalize(path: &str) -> Result<String> {
    // calls sigprocmask to disable signals
    let _siglock = SignalMask::lock();
    let cwd = CWD.lock();
    canonicalize_using_cwd(cwd.as_deref(), path).ok_or(Error::new(ENOENT))
    // sigprocmask is called again when _siglock goes out of scope
}
```

If more kernel state is moved to relibc, such as the `O_CLOEXEC` and
`O_CLOFORK` (added in POSIX 2024) bits, or say, some type of file descriptors
were to take shortcuts in relibc (like pipes using ring buffers), the overhead
of two `sigprocmask` syscalls, wrapping each critical section, will make lots of
POSIX APIs unnecessarily slow. Thus, it would be useful if signals could be
disabled quickly in userspace, using memory shared with the kernel.

## Userspace Signals

The currently proposed solution is to implement `sigaction`, `sigprocmask`, and
signal delivery (including `sigreturn`) only using shared atomic memory
accesses. The secret sauce is to use two `AtomicU64` bitsets (even i686
supports that, via `CMPXCHG8B`) stored in the TCB, one for standard signals and
one for realtime signals, where the low 32 bits are the pending bits, and the
high 32 bits are the allowset bits (logical NOT of the signal mask). This
allows, for signals directed at threads, changing the signal mask while
simultaneously checking what the pending bits were at the time, making
`sigprocmask` wait-free (if `fetch_add` is).

Not all technical details have been finalized yet, but there is a
[preliminary
RFC](https://gitlab.redox-os.org/4lDO2/rfcs/-/blob/signals/text/0000-userspace-signals.md).
Signals targeting whole processes is not yet implemented, since [Redox's
kernel does not yet distinguish between processes and
threads](https://gitlab.redox-os.org/redox-os/kernel/-/issues/153). Once that
has been fixed, work will continue to implement `siginfo_t` for both regular
and queued signals, and to add the `sigqueue` API for realtime signals.

This implementation proposal focuses primarily on optimizing the
receive-related signal APIs, as opposed to `kill`/`pthread_kill` and
`sigqueue`, which need exclusive access (which will probably not change), currently
kept in the kernel. A [userspace process
manager](https://gitlab.redox-os.org/redox-os/kernel/-/issues/152) has also
been proposed, where the `kill` and (future) `sigqueue` syscalls can be
converted to IPC calls to that manager. The idea is for all POSIX ambient
authority, such as absolute paths, UID/GID/PID/...s, to be represented using
file descriptors (capabilities). This is one piece of the work that needs to be done to
fully support sandboxing.

# Conclusion

So far, the signals project has been going according to plan, and hopefully,
POSIX support for signals will be mostly complete by the end of summer, with in-kernel improvements to process management. After
that, work on the userspace process manager will begin, possibly including new
kernel performance and/or functionality improvements to facilitate this.

<style>
img[alt="Redox ABI diagram"] { width: 80% }
</style>
