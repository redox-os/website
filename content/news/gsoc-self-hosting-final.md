+++
title = "GSoC Project: Making Redox Self-hosting, Final Summary"
author = "ids1024"
date = "2017-08-22T10:48:27-07:00"
+++

More details of what I've done are listed in the status reports I've written:

- [Status report 1](/news/gsoc-self-hosting-1/)
- [Status report 2](/news/gsoc-self-hosting-2/)
- [Status report 3](/news/gsoc-self-hosting-3/)
- [Status report 4](/news/gsoc-self-hosting-4/)

# Summary of Progress Made

Since cargo does not work on Redox, it is fair to say that Redox is still not self-hosting. However, that shouldn't be hard to fix once a couple kernel features that are currently blocking it are implemented. And I intend to help with that once those blocking issues are addressed.

However, in the mean time, I've found plenty of other things to work on by focusing on C software, such as making autotools builds work. I have succeeded with a basic autootools based build, though automake/autoconf themselves are not quite functional yet and more complicated builds tend to have issues. It was my intention from the beginning to work on various C porting issues once I had gotten the toolchain working. So I can't quite say the project was a complete success, but I think overall enough progress has been made in various things, and real self-hosting should now be possible before too long.

Aside from being nearer to self-hosting, porting C software to Redox should be easier now. I have made many improvements to Redox's C library, and addressed many POSIX incompatibilities. The amount of C software that runs on Redox has increased a fair amount.

# What I Learned

A couple of the bugs I dealt with gave me an appreciation for printing integers in hex rather than decimal; things like byte order and address alignment become obvious. I've also come to realize that largely following POSIX is important for an OS; frankly, some aspects of POSIX don't make sense or are outdated, but if you want to use existing software, it becomes rather important. Of course, not everything need be compliant; and the *implementation* is flexible (POSIX specifies APIs; not the kernel-level interface, or other details like that).

Nothing gives you an appreciation for debuggers like not having one; although that was only relevant to a couple issues I had. I was able to use a convoluted means to connect gdb to qemu and set a breakpoint. At some point Redox needs the ptrace system call or another tracing API; perhaps a scheme, because ptrace has a rather bad API. For debugging Rust, my PR implementing Rust backtraces on Redox should help.

Rust does seem like a suitable language of OS development. Hopefully even if Redox achieves nothing else, it will demonstrate the strength of Rust in this area.

# Further Matters to Address

As mentioned before, interruptible system calls are needed to get cargo working, and there's also an issue with [thread joining](https://github.com/redox-os/redox/issues/1020). Once those are addressed, it should be easy to make progress on cargo builds.

When I patched Rustc, one awkward issue was the lack of dynamic linking on Redox. Various rustc components are built as dynamic libraries (I was able to statically link them) and procedural macros depend on `dlopen` (I added a hack disabling proc macros). So Redox needs a dynamic linker. Redox may use m4b's [dryad](https://github.com/m4b/dryad), which is written in Rust.

Once dynamic linking is possible, it should be possible to upstream Redox patches for rustc. Also, there are various other places where a dynamic linker would help; it would make it possible to load C modules in Python and Perl, for instance. Automake seems to depend on Perl's dynaloader.

I intend to continue being involved in Redox, though I have other projects to work on, and may also want to work on other aspects of Redox.

# Pull Requests

It would be convenient if everything was in one PR or repository, but due to the nature of my project, it touched various repositories. Here is a complete list of the pull requests I have filed related to Redox as part of the GSoC:

## redox-os/newlib
- [Expose nanosleep() and clock_gettime() in time.h header](https://github.com/redox-os/newlib/pull/5)  
- [Override time.h to define nanosleep() and clock_gettime()](https://github.com/redox-os/newlib/pull/6)  
- [Port C code to Rust](https://github.com/redox-os/newlib/pull/7)  
- [Correct _dup() to dup()](https://github.com/redox-os/newlib/pull/8)  
- [Add ftruncate() function](https://github.com/redox-os/newlib/pull/9)  
- [Use SYS_GETCWD syscall in getcwd()](https://github.com/redox-os/newlib/pull/10)  
- [Add getuid() and getgid()](https://github.com/redox-os/newlib/pull/11)  
- [Set environ](https://github.com/redox-os/newlib/pull/12)  
- [Pass -I when building Rust part, so headers are found](https://github.com/redox-os/newlib/pull/13)  
- [Pass third 'envp' argument to main(), expected by some programs](https://github.com/redox-os/newlib/pull/14)  
- [Build with no_std](https://github.com/redox-os/newlib/pull/15)  
- [Make rust_begin_panic() both no_mangle and weakly linked](https://github.com/redox-os/newlib/pull/16)  
- [Use "-C metadata=newlib"](https://github.com/redox-os/newlib/pull/17)  
- [A couple small things](https://github.com/redox-os/newlib/pull/18)  
- [Fix override of time.h header](https://github.com/redox-os/newlib/pull/19)  
- [Expose ftruncate() declaration](https://github.com/redox-os/newlib/pull/20)  
- [Add functions for Redox-specific calls](https://github.com/redox-os/newlib/pull/21)  
- [Correct waitpid()](https://github.com/redox-os/newlib/pull/22)  
- [Fix redox specifc function](https://github.com/redox-os/newlib/pull/23)  
- [A couple improvements](https://github.com/redox-os/newlib/pull/24)  
- [Correct umask](https://github.com/redox-os/newlib/pull/25)  
- [Berkeley sockets API, version 2](https://github.com/redox-os/newlib/pull/26)  
- [Import Box from alloc](https://github.com/redox-os/newlib/pull/27)  
- [Implement realpath()](https://github.com/redox-os/newlib/pull/28)  
- [fsync() and rename()](https://github.com/redox-os/newlib/pull/29)  
- [Run autotools](https://github.com/redox-os/newlib/pull/30)  
- [Use libc crate again](https://github.com/redox-os/newlib/pull/31)  
- [Use libc crate, add a few functions / defines, remove unused placeholder functions](https://github.com/redox-os/newlib/pull/32)  
- [symlink() and readlink()](https://github.com/redox-os/newlib/pull/33)  
- [Implement lstat() using O_NOFOLLOW](https://github.com/redox-os/newlib/pull/34)  
- [Call cargo update](https://github.com/redox-os/newlib/pull/35)  
- [Define PF_ constants](https://github.com/redox-os/newlib/pull/36)  
- [Implement gethostname()](https://github.com/redox-os/newlib/pull/37)  
- [getpwnam() and getpwuid()](https://github.com/redox-os/newlib/pull/38)  
- [utime() utimes() and futimens()](https://github.com/redox-os/newlib/pull/39)  
- [Get fcntl() to work](https://github.com/redox-os/newlib/pull/40)  
- [Use buffer in readdir to reduce number of calls](https://github.com/redox-os/newlib/pull/41)  
- [Fix system()](https://github.com/redox-os/newlib/pull/42)  
- [Use RawFile in more places](https://github.com/redox-os/newlib/pull/43)  
- [Correct tv_nsec in C header](https://github.com/redox-os/newlib/pull/44)  
- [Pass environmental variable on exec](https://github.com/redox-os/newlib/pull/45)  
- [Call syscall::fstat instead of _fstat](https://github.com/redox-os/newlib/pull/46)  
- [\0 terminate in getcwd](https://github.com/redox-os/newlib/pull/47)  
- [Use off_t in lseek](https://github.com/redox-os/newlib/pull/48)  
- [Use ; as PATH separator](https://github.com/redox-os/newlib/pull/49)  
- [Add /dev/null hack and define h_addr](https://github.com/redox-os/newlib/pull/50)  
- [Change values of F_*](https://github.com/redox-os/newlib/pull/51)  
- [Use compiler_builtins from rust source tree](https://github.com/redox-os/newlib/pull/52)  
- [[WIP] [Non-functional] Pthreads, based on pthreads-emb](https://github.com/redox-os/newlib/pull/53)  
- [Do not ignore env argument of execve](https://github.com/redox-os/newlib/pull/54)  
- [fchdir()](https://github.com/redox-os/newlib/pull/55)  
- [Open file without O_WRONLY for utime](https://github.com/redox-os/newlib/pull/59)  
- [Add utime.h (coppied for Linux backend)](https://github.com/redox-os/newlib/pull/60)  
- [Use panic=abort](https://github.com/redox-os/newlib/pull/61)  

## redox-os/syscall
- [Use AsRef<[u8]> for paths, instead of &str](https://github.com/redox-os/syscall/pull/6)  
- [Use repr(C) for structs in data.rs](https://github.com/redox-os/syscall/pull/8)  
- [Add symlink-related flags](https://github.com/redox-os/syscall/pull/9)  
- [SYS_GETPPID and getppid()](https://github.com/redox-os/syscall/pull/10)  
- [Add O_NOFOLLOW flag](https://github.com/redox-os/syscall/pull/11)  
- [[WIP] [POC] Proc macro for handling system call ABI](https://github.com/redox-os/syscall/pull/12)  
- [Add MODE_CHR flag for "character special"](https://github.com/redox-os/syscall/pull/13)  
- [Make sigaction() take Option<_> arguments](https://github.com/redox-os/syscall/pull/14)  
- [Define F_GETFD and F_SETFD](https://github.com/redox-os/syscall/pull/16)  
- [Add flag for fifo](https://github.com/redox-os/syscall/pull/18)  
- [Add F_DUPFD flag](https://github.com/redox-os/syscall/pull/19)  

## redox-os/libc
- [Add build script for GNU make, which compiles (but doesn't work yet)](https://github.com/redox-os/libc/pull/17)  
- [[WIP] [incomplete] LLVM](https://github.com/redox-os/libc/pull/18)  
- [Setup xargo/rustup in setup.sh for newlib](https://github.com/redox-os/libc/pull/19)  
- [Pass --with-ld when building gcc port](https://github.com/redox-os/libc/pull/20)  
- [Use / as prefix instead of /usr for binutils/gcc](https://github.com/redox-os/libc/pull/21)  
- [Add Arch Linux PKGBUILDs for toolchain](https://github.com/redox-os/libc/pull/22)  
- [Tweak dependencies of Arch packages](https://github.com/redox-os/libc/pull/23)  
- [Fix Arch PKGBUILD issues found when building in chroot](https://github.com/redox-os/libc/pull/24)  
- [Hacks for dash to compile; more needs to be done for it to work](https://github.com/redox-os/libc/pull/25)  
- [Initial port of rustc](https://github.com/redox-os/libc/pull/26)  
- [Correct rust install path](https://github.com/redox-os/libc/pull/27)  
- [Add libgit2](https://github.com/redox-os/libc/pull/28)  
- [Make curl build](https://github.com/redox-os/libc/pull/29)  
- [Improve Arch PKGBUILD](https://github.com/redox-os/libc/pull/30)  
- [Correct path in gcc build scripts](https://github.com/redox-os/libc/pull/31)  
- [Update submodules](https://github.com/redox-os/libc/pull/32)  
- [Update readme](https://github.com/redox-os/libc/pull/33)  
- [Fix PKGBUILD for newlib](https://github.com/redox-os/libc/pull/34)  
- [Use -unknown- instead of -elf-, to match Rust and be more standard](https://github.com/redox-os/libc/pull/37)  

## redox-os/cookbook
- [Do not copy .cargo and libc-artifacts](https://github.com/redox-os/cookbook/pull/10)  
- [Recipes for gcc, binutils, newlib](https://github.com/redox-os/cookbook/pull/11)  
- [Make stage call unstage](https://github.com/redox-os/cookbook/pull/15)  
- [Handle patches in prepare](https://github.com/redox-os/cookbook/pull/16)  
- [Add "shopt -s nullglob" to fix patch loop](https://github.com/redox-os/cookbook/pull/17)  
- [Make dash available as /bin/sh](https://github.com/redox-os/cookbook/pull/18)  
- [Strip binaries in gcc and gnu-binutils, for much smaller file size](https://github.com/redox-os/cookbook/pull/21)  
- [Check if recipe has been updated in repo.sh](https://github.com/redox-os/cookbook/pull/22)  
- [Strip only executables, not libraries](https://github.com/redox-os/cookbook/pull/23)  
- [Correction to gcc recipe](https://github.com/redox-os/cookbook/pull/24)  
- [Set $XARGO_HOME to build std et al only once](https://github.com/redox-os/cookbook/pull/25)  
- [Recipe for rust](https://github.com/redox-os/cookbook/pull/26)  
- [Use /bin/sh and /bin/cc ion scripts](https://github.com/redox-os/cookbook/pull/27)  
- [Remove xargo-home in clean.sh](https://github.com/redox-os/cookbook/pull/29)  
- [Initial recipe for cargo](https://github.com/redox-os/cookbook/pull/30)  
- [ca-certificates package; needed by cargo](https://github.com/redox-os/cookbook/pull/31)  
- [Recipe for curl](https://github.com/redox-os/cookbook/pull/32)  
- [Correct prefix for openssl in cargo build](https://github.com/redox-os/cookbook/pull/33)  
- [Correct ca-certificates recipe](https://github.com/redox-os/cookbook/pull/34)  
- [Pass --target to pkg](https://github.com/redox-os/cookbook/pull/35)  
- [Use symlinks](https://github.com/redox-os/cookbook/pull/36)  
- [Initial python recipe](https://github.com/redox-os/cookbook/pull/37)  
- [System for compile-time dependencies; use for openssl](https://github.com/redox-os/cookbook/pull/39)  
- [[WIP] Git recipe](https://github.com/redox-os/cookbook/pull/40)  
- [git: use symlink instead of hard link](https://github.com/redox-os/cookbook/pull/41)  
- [Fix repo.sh call for build depends](https://github.com/redox-os/cookbook/pull/43)  
- [Remove some changes to python that are unneeded now](https://github.com/redox-os/cookbook/pull/45)  
- [Recipe for gawk](https://github.com/redox-os/cookbook/pull/46)  
- [Recipe for sed](https://github.com/redox-os/cookbook/pull/48)  
- [Add recipe for uutils findutils](https://github.com/redox-os/cookbook/pull/49)  
- [Fix pastel recipe; add 'mkdir'](https://github.com/redox-os/cookbook/pull/50)  
- [Override git sha1 implementation](https://github.com/redox-os/cookbook/pull/51)  
- [Recipe for GNU grep](https://github.com/redox-os/cookbook/pull/52)  
- [Hopefully fix grep build](https://github.com/redox-os/cookbook/pull/53)  
- [git: ; as path separator](https://github.com/redox-os/cookbook/pull/54)  
- [Add recipe for diffutils](https://github.com/redox-os/cookbook/pull/55)  
- [Build gcc with C++ support](https://github.com/redox-os/cookbook/pull/57)  
- [Enable 'backtrace' feature in libstd, to allow backtraces](https://github.com/redox-os/cookbook/pull/58)  
- [Use -unknown- instead of -elf-](https://github.com/redox-os/cookbook/pull/59)  
- [Add recipe for bash](https://github.com/redox-os/cookbook/pull/60)  
- [Add recipe for xz](https://github.com/redox-os/cookbook/pull/61)  
- [Make extrautils have xz as a build depend](https://github.com/redox-os/cookbook/pull/62)  
- [Add recipe for patch](https://github.com/redox-os/cookbook/pull/63)  
- [Use system 'pkg' when run on Redox](https://github.com/redox-os/cookbook/pull/64)  
- [Patch patch not to call chown](https://github.com/redox-os/cookbook/pull/65)  
- [Pass -p to cp, to make running autotools unnecessary](https://github.com/redox-os/cookbook/pull/66)  
- [Add symlinks to uutils package](https://github.com/redox-os/cookbook/pull/69)  
- [Simplify git patch a bit](https://github.com/redox-os/cookbook/pull/72)  
- [Add --debug argument to cook.sh to build in debug mode, unstripped](https://github.com/redox-os/cookbook/pull/73)  
- [Use release tarball for curl, with a couple patches](https://github.com/redox-os/cookbook/pull/74)  
- [Bump python version](https://github.com/redox-os/cookbook/pull/76)  
- [Recipe for perl](https://github.com/redox-os/cookbook/pull/78)  
- [A couple fixes for perl, and initial recipes for automake and autoconf](https://github.com/redox-os/cookbook/pull/79)  

## rust-lang/rust
- [Fix building std without backtrace feature, which was broken in ca8b754](https://github.com/rust-lang/rust/pull/42141)  
- [Implement requires_synchronized_create() for Redox](https://github.com/rust-lang/rust/pull/42142)  
- [Redox: Use create() instead of open() when setting env variable](https://github.com/rust-lang/rust/pull/42783)  
- [Set CXX_<target> in bootstrap](https://github.com/rust-lang/rust/pull/42829)  
- [Fix Redox build, broken in ecbb896b9eb2acadefde57be493e4298c1aa04a3](https://github.com/rust-lang/rust/pull/42848)  
- [redox: symlink and readlink](https://github.com/rust-lang/rust/pull/42975)  
- [Fix Redox build, apparently broken by #42687](https://github.com/rust-lang/rust/pull/42976)  
- [Redox: Use O_NOFOLLOW for lstat()](https://github.com/rust-lang/rust/pull/43056)  
- [Redox: Fix Condvar.wait(); do not lock mutex twice](https://github.com/rust-lang/rust/pull/43071)  
- [Redox: Fix Condvar.wait(); do not lock mutex twice](https://github.com/rust-lang/rust/pull/43082)  
- [Redox: add stat methods(); support is_symlink()](https://github.com/rust-lang/rust/pull/43100)  
- [redox: handle multiple paths in PATH](https://github.com/rust-lang/rust/pull/43304)  
- [Implement AsRawFd for Stdin, Stdout, and Stderr](https://github.com/rust-lang/rust/pull/43459)  
- [Make backtraces work on Redox, copying Unix implementation](https://github.com/rust-lang/rust/pull/43635)  
- [Enable unwinding panics on Redox](https://github.com/rust-lang/rust/pull/43917)  
- [Redox: correct is_absolute() and has_root()](https://github.com/rust-lang/rust/pull/43983)  
- [redox: Correct error on exec when file is not found](https://github.com/rust-lang/rust/pull/44000)  

## redox-os/kernel
- [Update for changes in std::ptr::Unique API](https://github.com/redox-os/kernel/pull/21)  
- [Make env: return ENOENT on non-existent; support unlink()](https://github.com/redox-os/kernel/pull/25)  
- [Implement getppid system call](https://github.com/redox-os/kernel/pull/26)  
- [Pass empty second argument to dup() call in clone](https://github.com/redox-os/kernel/pull/27)  
- [Pass empty second argument to dup in exec](https://github.com/redox-os/kernel/pull/28)  
- [pipe: make read() return when write end is closed](https://github.com/redox-os/kernel/pull/29)  
- [Revert "pipe: make read() return when write end is closed"](https://github.com/redox-os/kernel/pull/30)  
- [Implement fstat() for pipe scheme](https://github.com/redox-os/kernel/pull/31)  
- [Strip whitspaces after #!](https://github.com/redox-os/kernel/pull/32)  
- [Pass relative, not canonicalized, path to script](https://github.com/redox-os/kernel/pull/33)  
- [Make dup2() work if second file descriptor doesn't exist](https://github.com/redox-os/kernel/pull/34)  
- [Make dup/dup2 clear cloexec](https://github.com/redox-os/kernel/pull/37)  
- [Make seek on pipe return ESPIPE](https://github.com/redox-os/kernel/pull/38)  
- [sys:uname](https://github.com/redox-os/kernel/pull/39)  
- [Strip extra slashes from path](https://github.com/redox-os/kernel/pull/40)  
- [Use file descriptions, shared between file descriptors](https://github.com/redox-os/kernel/pull/42)  
- [Use fifo flag for pipe](https://github.com/redox-os/kernel/pull/44)  
- [Prevent freezing due to double locking](https://github.com/redox-os/kernel/pull/45)  
- [Implement F_DUPFD](https://github.com/redox-os/kernel/pull/46)  
- [Support arguments in #!](https://github.com/redox-os/kernel/pull/47)  

## japaric/xargo
- [Pass "-Z force-unstable-if-unmarked" to Rustc](https://github.com/japaric/xargo/pull/145)  

## redox-os/redoxfs
- [Initialize fields of Stat struct to 0](https://github.com/redox-os/redoxfs/pull/15)  
- [Use ? instead of try!](https://github.com/redox-os/redoxfs/pull/16)  
- [Allow seek beyond end of file.](https://github.com/redox-os/redoxfs/pull/17)  
- [[WIP] Symlinks](https://github.com/redox-os/redoxfs/pull/18)  
- [Return EINVAL for O_SYMLINK on non-symlink](https://github.com/redox-os/redoxfs/pull/19)  
- [Symlinks in fuse](https://github.com/redox-os/redoxfs/pull/20)  
- [Support unlink() on symlink](https://github.com/redox-os/redoxfs/pull/21)  
- [Follow symlinks on O_STAT, unless O_NOFOLLOW is passed](https://github.com/redox-os/redoxfs/pull/22)  
- [Mtime should be second element](https://github.com/redox-os/redoxfs/pull/23)  
- [Make fcntl not clobber access mode](https://github.com/redox-os/redoxfs/pull/24)  
- [Do not fail due to file permissions on creation](https://github.com/redox-os/redoxfs/pull/25)  
- [Require same uid as owner to unlink, not write permission](https://github.com/redox-os/redoxfs/pull/26)  
- [fuse: Fix readdir when directory does not fit in buffer](https://github.com/redox-os/redoxfs/pull/27)  
- [fuse: allow setting mtime to earlier time](https://github.com/redox-os/redoxfs/pull/28)  
- [Directory symlinks](https://github.com/redox-os/redoxfs/pull/29)  
- [Avoid corrupting free node](https://github.com/redox-os/redoxfs/pull/30)  
- [Remove unneeded uses of 'mut'](https://github.com/redox-os/redoxfs/pull/31)  
- [Make it not an error to open a directory without O_DIRECTORY or O_STAT](https://github.com/redox-os/redoxfs/pull/32)  
- [futimens: do not require O_RWONLY/O_RDWR](https://github.com/redox-os/redoxfs/pull/33)  

## redox-os/coreutils
- [Implement stat command](https://github.com/redox-os/coreutils/pull/153)  
- [Fix copy/paste error](https://github.com/redox-os/coreutils/pull/154)  
- [Add readlink command](https://github.com/redox-os/coreutils/pull/156)  
- [Stat improvements](https://github.com/redox-os/coreutils/pull/157)  
- [Use O_NOFOLLOW in stat](https://github.com/redox-os/coreutils/pull/158)  
- [Use libstd instead of syscall for stat](https://github.com/redox-os/coreutils/pull/160)  
- [stat: format time properly and display user and group name](https://github.com/redox-os/coreutils/pull/161)  
- [Use `filetime` in touch](https://github.com/redox-os/coreutils/pull/162)  
- [rm: -f argument](https://github.com/redox-os/coreutils/pull/164)  
- [dirname command](https://github.com/redox-os/coreutils/pull/166)  
- [rm: fix directory support](https://github.com/redox-os/coreutils/pull/170)  
- [Make 'which' work with multiple directories in PATH](https://github.com/redox-os/coreutils/pull/171)  
- [Add uname utility](https://github.com/redox-os/coreutils/pull/172)  
- [Allow directory as second argument to ln](https://github.com/redox-os/coreutils/pull/173)  
- [tr: octal escape](https://github.com/redox-os/coreutils/pull/174)  
- [Remove chmod, env, and ls, which uutils has better versions of](https://github.com/redox-os/coreutils/pull/175)  

## redox-os/gcc
- [Link against crt* to support C++ global constructor / destructor](https://github.com/redox-os/gcc/pull/2)  
- [Use null: instead of /dev/null](https://github.com/redox-os/gcc/pull/3)  
- [Re-enable stmp-fixinc target](https://github.com/redox-os/gcc/pull/4)  
- [Use ; as path separator on Redox](https://github.com/redox-os/gcc/pull/5)  

## redox-os/redox
- [Increase filesystem size to 1024 MB](https://github.com/redox-os/redox/pull/951)  
- [Make build/filesystem.bin and build/initfs.tag targets .PHONY](https://github.com/redox-os/redox/pull/961)  
- ['user' and 'root' groups](https://github.com/redox-os/redox/pull/988)  
- ["make fetch" target](https://github.com/redox-os/redox/pull/992)  
- [Add uutils to filesystem.toml](https://github.com/redox-os/redox/pull/1027)  
- [Update cookbook submodule](https://github.com/redox-os/redox/pull/1028)  
- [Add scheme to PATH](https://github.com/redox-os/redox/pull/1033)  
- [Symlink /usr to /](https://github.com/redox-os/redox/pull/1034)  

## redox-os/dash
- [Hack to make scripts work](https://github.com/redox-os/dash/pull/1)  
- [Use ; as path separator](https://github.com/redox-os/dash/pull/2)  
- [Do not patch things that are now implemented](https://github.com/redox-os/dash/pull/3)  

## redox-os/netstack
- [Correct fpath() for tcpd](https://github.com/redox-os/netstack/pull/2)  
- [tcpd: fix bug in partial reads that was breaking https in curl](https://github.com/redox-os/netstack/pull/3)  

## rust-lang/cargo
- [Fix typo in comment](https://github.com/rust-lang/cargo/pull/4185)  

## redox-os/randd
- [Implement fstat()](https://github.com/redox-os/randd/pull/1)  
- [Allow fcntl](https://github.com/redox-os/randd/pull/2)  
- [Use syscall::MODE_CHR constant](https://github.com/redox-os/randd/pull/3)  

## redox-os/pkgutils
- [Use pbr crate for progress bar](https://github.com/redox-os/pkgutils/pull/11)  
- [Use BufReader to extract gzip archive](https://github.com/redox-os/pkgutils/pull/12)  
- [Use clap for argument parsing, and allow a --target argument to choose which target to download packages for](https://github.com/redox-os/pkgutils/pull/14)  
- [Determine default target based on LLVM triple at build](https://github.com/redox-os/pkgutils/pull/15)  
- [Do not follow symlinks when creating package](https://github.com/redox-os/pkgutils/pull/16)  
- [Better error handling](https://github.com/redox-os/pkgutils/pull/17)  
- [Add --root argument; print usage on no subcommand](https://github.com/redox-os/pkgutils/pull/18)  
- [Use BufWriter](https://github.com/redox-os/pkgutils/pull/20)  

## a8m/pb
- [Redox OS support](https://github.com/a8m/pb/pull/52)  
- [Do not panic on duration of zero](https://github.com/a8m/pb/pull/54)  

## redox-os/ransid
- [Fix printing \n or \r after printing $COLUMNS characters](https://github.com/redox-os/ransid/pull/2)  
- [README: fix travis badge](https://github.com/redox-os/ransid/pull/3)  

## redox-os/rust
- [Redox: Use create() instead of open() when setting env variable](https://github.com/redox-os/rust/pull/3)  
- [Temporary implementation of rename](https://github.com/redox-os/rust/pull/4)  
- [Symlink and readlink](https://github.com/redox-os/rust/pull/6)  
- [Redox: Use O_NOFOLLOW for lstat()](https://github.com/redox-os/rust/pull/7)  
- [Redox: Fix Condvar.wait(); do not lock mutex twice](https://github.com/redox-os/rust/pull/8)  
- [Correct fix for condvar (hopefully)](https://github.com/redox-os/rust/pull/9)  
- [Redox: add stat methods(); support is_symlink()](https://github.com/redox-os/rust/pull/10)  
- [Redox: Add JoinHandleExt (matching Unix version)](https://github.com/redox-os/rust/pull/11)  
- [redox: handle multiple paths in PATH](https://github.com/redox-os/rust/pull/12)  
- [Remove import](https://github.com/redox-os/rust/pull/13)  

## ruuda/thread-id
- [Redox support](https://github.com/ruuda/thread-id/pull/6)  

## redox-os/orbutils
- [Remove rustls as direct dependency](https://github.com/redox-os/orbutils/pull/27)  

## libgit2/libgit2
- [Convert port with htons() in p_getaddrinfo()](https://github.com/libgit2/libgit2/pull/4280)  

## redox-os/website
- [GSoC Status Report 1](https://github.com/redox-os/website/pull/122)  
- [GSoC Status Report 2](https://github.com/redox-os/website/pull/129)  
- [GSoC Status Report 3](https://github.com/redox-os/website/pull/135)  
- [GSoC Status Report 4](https://github.com/redox-os/website/pull/145)  

## redox-os/netutils
- [Use hyper in httpd](https://github.com/redox-os/netutils/pull/23)  
- [Make wget use -O argument, matching standard behavior](https://github.com/redox-os/netutils/pull/26)  
- [wget: use pbr for progress bar](https://github.com/redox-os/netutils/pull/28)  

## alexcrichton/tar-rs
- [Add option to not follow symlinks](https://github.com/alexcrichton/tar-rs/pull/117)  
- [Fix xattr unit test](https://github.com/alexcrichton/tar-rs/pull/118)  
- [Redox OS support](https://github.com/alexcrichton/tar-rs/pull/120)  

## redox-os/tar-rs
- [Merge upstream](https://github.com/redox-os/tar-rs/pull/2)  

## alexcrichton/filetime
- [Redox OS support](https://github.com/alexcrichton/filetime/pull/8)  
- [redox: fix setting times on readonly file](https://github.com/alexcrichton/filetime/pull/10)  

## redox-os/ptyd
- [Support fstat()](https://github.com/redox-os/ptyd/pull/1)  

## redox-os/installer
- [--list-packages argument](https://github.com/redox-os/installer/pull/4)  
- [Support adding symlinks in configuration](https://github.com/redox-os/installer/pull/5)  

## rust-lang/libc
- [Redox: Use c_long instead of usize for off_t](https://github.com/rust-lang/libc/pull/674)  

## redox-os/arg-parser
- [Do not eat - argument](https://github.com/redox-os/arg-parser/pull/1)  
- [Make get_opt() return None if that option has not been passed](https://github.com/redox-os/arg-parser/pull/2)  

## redox-os/extrautils
- [Add -v argument to grep](https://github.com/redox-os/extrautils/pull/24)  
- [Implement -c flag to grep](https://github.com/redox-os/extrautils/pull/25)  
- [Support gzip and xz extraction; verbose](https://github.com/redox-os/extrautils/pull/26)  
- [Implement --directory and --strip-components for tar](https://github.com/redox-os/extrautils/pull/27)  
- [tar: set file times](https://github.com/redox-os/extrautils/pull/29)  
- [Try to fix travis by installing liblzma](https://github.com/redox-os/extrautils/pull/30)  
- [Install lzma with no-sudo method](https://github.com/redox-os/extrautils/pull/31)  
- [Support bzip2 extraction in tar](https://github.com/redox-os/extrautils/pull/32)  

## uutils/coreutils
- [Make chmod use std where possible instead of libc; compile for Redox](https://github.com/uutils/coreutils/pull/1054)  
- [Fix ordering of ls -t, which was backwards](https://github.com/uutils/coreutils/pull/1057)  
- [Make ls build on Redox](https://github.com/uutils/coreutils/pull/1058)  
- [Correct behavior of cp -r with non-existent dest](https://github.com/uutils/coreutils/pull/1068)  
- [Redox fixes for mktemp and install](https://github.com/uutils/coreutils/pull/1069)  
- [install: Fix verbose mode](https://github.com/uutils/coreutils/pull/1070)  
- [cp: enable setting timestamps](https://github.com/uutils/coreutils/pull/1071)  

## alexcrichton/cmake-rs
- [Define CMAKE_SYSTEM_NAME when compiling for Redox](https://github.com/alexcrichton/cmake-rs/pull/35)  

## banyan/rust-pretty-bytes
- [Use atty crate instead of libc](https://github.com/banyan/rust-pretty-bytes/pull/4)  

## softprops/termsize
- [Redox OS support](https://github.com/softprops/termsize/pull/8)  

## brson/home
- [Redox OS](https://github.com/brson/home/pull/1)  

## softprops/atty
- [Redox OS support](https://github.com/softprops/atty/pull/14)  

## Arcterus/coreutils
- [Fix onig build on appveyor msvc](https://github.com/Arcterus/coreutils/pull/1)  

## redox-os/binutils-gdb
- [Make redox test not depend on compiler vendor](https://github.com/redox-os/binutils-gdb/pull/2)  

## Stebalien/tempfile
- [Add Redox OS backend](https://github.com/Stebalien/tempfile/pull/32)  

## redox-os/uutils
- [Merge upstream, enable some more utilities, add Cargo overrides](https://github.com/redox-os/uutils/pull/1)  

## alexcrichton/bzip2-rs
- [Redox fix](https://github.com/alexcrichton/bzip2-rs/pull/22)  

## redox-os/orbital
- [Add scheme to PATH](https://github.com/redox-os/orbital/pull/15)  
