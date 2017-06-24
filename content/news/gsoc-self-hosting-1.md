+++
title = "GSoC Project: Making Redox Self-hosting, Status Report 1"
author = "ids1024"
date = "2017-06-24T11:35:00-07:00"
+++

I've been meaning to write a blog post about my progress, so here it finally is. As some know, this summer I have been working on making Redox OS self-hosting. There is still more to do, but I've made reasonable progress already.

# What Does Self-Hosting Mean?

The goal is to port the compiler to run natively under Redox, so Redox can be built from within Redox. This makes it in principle possible to develop Redox without booting another OS, although not necessarily convenient.

# Status

So far, I have ported the following to run under Redox:

- GNU binutils
- GCC
- GNU make
- dash
- curl, with SSL support (used by cargo as a library)
- LLVM and Rustc

As a result, it is possible to compile some C software from inside Redox; I have successfully built Lua that way. And more importantly it is possible to compile Rust code, although only through direct invocation of `rustc` (until Cargo is ported).

<img class="img-responsive" src="/img/screenshot/redox-rustc.png"/>

# Limitations

I had to disable procedural macros to get Rustc to compile, since those rely on `dlopen()` which Redox does not yet provide. I don't think that is an issue for libstd itself, but it will be an issue later on. For instance, Redox uses serde in at least one place.

Porting has required various hacks around functionality or C library functions not (yet) provided by Redox, some of which may cause issues. For instance, I've had to comment out a lot of code involving signals. That should be implemented in Redox at some point though.

# What This Has Involved

Redox already had a cross compiler for C and C++ (and of course Rust). But I've had to make various changes. I've had to add various functions to [Redox's newlib-based libc](https://github.com/redox-os/newlib/tree/redox/newlib/libc/sys/redox); [a basic implementation of the POSIX sockets API](https://github.com/redox-os/newlib/pull/26) is probably the most notable. In the process, I also [ported the Redox OS specific libc code from C to Rust](https://github.com/redox-os/newlib/pull/7).

I've run into bugs, that have variously been caused by issues in newlib, the Redox backend for Rust's libstd, redoxfs, Redox's netstack, and so far one issue in the kernel itself.

Although Redox already had a C/C++ cross compiler, it wasn't too well tested, and had some issues. For instance, `argv` was not null terminated (a small problem, but it took a while to find, since debugging on Redox is still a bit awkward), and C++ global constructors/destructors were not being called.

For debugging, I hacked together code to provide strace-like debugging, via [an ugly kernel patch](https://gist.github.com/ids1024/269a19d8e64c38b33c94bae3ef30094b). At some point a proper `strace` utility should be written, but that will require the `ptrace` system call or some analogous functionality.

GCC is very portable, so it was not really too hard to port, after resolving the argv and constructor issues, and a couple others. LLVM posed a greater challenge, and required [fairly substantial hacks](https://github.com/ids1024/llvm/commits/redox2).

Once LLVM was working, Rustc wasn't too hard. A few patches were needed, but the main issue was getting the build system to link the custom LLVM instead of trying to build it itself, and using the correct C++ compiler ([a bug in Rust's build system](https://github.com/rust-lang/rust/pull/42829) interfered with that). And waiting for the compiler to build, which takes a very long time.

# What is Still to be Done

Cargo is the big thing; but hopefully won't take too much longer. It depends on some C libraries, specifically curl and libgit2. As mentioned above, curl now works. I've gotten cargo to build after patching it and various dependencies, but it isn't working properly; hopefully it won't take too long to fix.

After that, it's a matter of building crates and seeing if anything goes wrong. For a full Redox build, some of the build scripts will probably need to be modified, since they generally assume a Unix system.

Some of the functionally that I've had to hack around should be implemented (some of it is not difficult, some more so), and where possible Redox support should be upstreamed, once no substantial hacks to the code are required.

And if I manage to finish this all before the end of the Google Summer of Code, there is no shortage of things to port and implement.

# When Can I Try This Out?

It should be possible to install and run Rustc and GCC in the next release of Redox; which should happen soon, although there is still an issue or two blocking release.
