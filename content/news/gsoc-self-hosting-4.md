+++
title = "GSoC Project: Making Redox Self-hosting, Status Report 4"
author = "ids1024"
date = "2017-08-15 18:36:17-07:00"
+++

This is a continuation of [status report 1](/news/gsoc-self-hosting-1/), [status report 2](/news/gsoc-self-hosting-2/), and [status report 3](/news/gsoc-self-hosting-3/).

# Backtraces

I found the lack of Rust backtraces on Redox inconvenient for an issue I was debugging, so I decided to try to get them working. So I fixed them in [Rust PR #43635](https://github.com/rust-lang/rust/pull/43635). It was fairly simple, but I had to figure out various issues. I had to modify Rust to build `libbacktrace` on Redox, and update the `config.sub` in libbacktrace to support Redox (that's an autotools thing). It needed to link against `libgcc` to get the unwinding symbols, and I needed to copy the backtrace code from the Unix backend to the Redox one, and implement `get_executable_filename` using Redox's APIs.

With that, Rust backtraces are now functional on Redox.

# Uutils

[Uutils](https://github.com/uutils/coreutils) is a work in progress Rust implementation of Unix coreutils. Redox has been using it's own coreutils, but some of the uutils ones are better. I've [added uutils to the default Redox install](https://github.com/redox-os/redox/pull/1027), and added symlinks for some of the [utilities](https://github.com/redox-os/cookbook/pull/69), namely `expr`, `install`, and `mktemp`, which Redox did not have, and `chmod`, `env`, and `ls`, which had fewer features than the uutils versions.

My goal here has mainly been to get autotools-based builds working, which requires various coreutils utilities, and the uutils versions have helped.

I've also had to send fixes to uutils: the chmod fix mentioned in my last report, a patch [making ls work on Redox](https://github.com/uutils/coreutils/pull/1058), and [adding Redox support to mktemp and install](https://github.com/uutils/coreutils/pull/1069).

Additionally, I came across a few bugs in uutils, and submitted fixes; [ls -t was backwards](https://github.com/uutils/coreutils/pull/1057), [cp -r was misbehaving](https://github.com/uutils/coreutils/pull/1068), and [verbose mode wasn't working in install](https://github.com/uutils/coreutils/pull/1070).

Those uutils utilities also required Redox patches to [atty](https://github.com/softprops/atty/pull/14), [termsize](https://github.com/softprops/termsize/pull/8), [tempfile](https://github.com/Stebalien/tempfile/pull/32), and [rust-pretty-bytes](https://github.com/banyan/rust-pretty-bytes/pull/4).

# Autotools, and the Cookbook

I have gotten basic autotools builds to work; although it requires `export LD=ld` (the detection code requires an absolute path, and a Redox path starting with `file:` isn't recognized as absolute). Some things fail to build due to other issues, including other issues related to Redox's schemes.

One annoying this with autotools is that `config.guess` needs to have code for the host system. I sent [a patch](https://lists.gnu.org/archive/html/config-patches/2017-08/msg00002.html) upstream, so in the future software should contain the new `config.guess`, but for now we need to override this.

`./configure` scripts triggered a weird bug in redoxfs, where large numbers of unlinks resulted in corruption. That was hard to debug, but eventually I found the cause and [send a PR](https://github.com/redox-os/redoxfs/pull/30).

To get the cookbook to work, I [ported bash](https://github.com/redox-os/cookbook/pull/60), which it currently requires, although it will likely use Ion in the future. I implemented [the `F_DUPFD` flag of `fcntl`](https://github.com/redox-os/kernel/pull/46), which bash and dash use; I had a hack in dash, but that was rather ugly so I implemented it properly.

For the cookbook to be able to extract source tarballs, I [ported xz/liblzma](https://github.com/redox-os/cookbook/pull/61) (there doesn't yet seem to be a pure Rust library that supports `.xz` files), and added [gzip and xz extraction support to `tar`, along with verbose mode](https://github.com/redox-os/extrautils/pull/26); I later added [`--directory` and `--strip-components` support](https://github.com/redox-os/extrautils/pull/27), which `cook.sh` also uses, as well as [bzip2 extraction](https://github.com/redox-os/extrautils/pull/32), which also pulls in C code for the time being. I also made tar [set file times](https://github.com/redox-os/extrautils/pull/29), and ported [patch](https://github.com/redox-os/cookbook/pull/63) to make the cookbook work. And I modified Redox's `wget` utility to [match the standard command line](https://github.com/redox-os/netutils/pull/26).

I have successfully built packages for `lua` and `nasm` (the latter of which uses autotools) using the cookbook from inside Redox, although I'm currently using a couple changes that haven't been merged into uutils yet, and `export LD=ld` is still needed as mentioned above. The native gcc toolchain seems to be working quite nicely, although the scripting around it can be complicated.


<img class="img-responsive" src="/img/screenshot/redox-cookbook-nasm.png"/>

# Other fixes

I fixed [a bug in redoxfs fuse mounts with large directories](https://github.com/redox-os/redoxfs/pull/27), and [made it posible to set mtime to an earlier time in fuse](https://github.com/redox-os/redoxfs/pull/28). I fixed [directory symlinks](https://github.com/redox-os/redoxfs/pull/29), which I somehow forgot about when I originally implemented symlinks. Redox was not matching POSIX behavior for file descriptors; when dup is called, the new fd should still refer to the same "file description", which Redox did not have a concept of. I [modified the kernel](https://github.com/redox-os/kernel/pull/42) to match POSIX behavior.

I changed Redox's target triple (for the gcc toolchain) from `x86_64-elf-redox` to `x86_64-unknown-redox`, with a PR in [libc](https://github.com/redox-os/libc/pull/37) and [the cookbook](https://github.com/redox-os/cookbook/pull/59). The Rust toolchain was already `*-unknown-*`. Frankly it doesn't make much sense (has the person building the toolchain forgotten who they are?), but it is conventional.

# Rustc

I've tried to merge upstream changes into Redox's native rustc, but it seems it is now pulling in `jobserver-rs`, so it has the same issue as cargo. Both should work once interruptible system calls are implemented (i.e. making `read` (and other calls) return `EINTR` early when a signal handler runs).

# Pthreads

Pthreads (the POSIX threads library) is not really related to self-hosting, but quite important for porting C software. I have [started](https://github.com/redox-os/newlib/pull/53) porting threads-emb to Redox; in theory all that's left is implementing semaphores and cancellation, but those are somewhat awkward, and other issues may appear in testing.
