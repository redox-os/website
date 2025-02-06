+++
title = "RSoC 2024: Dynamic Linking - Part 2"
author = "Anhad Singh"
date = "2025-02-06"
+++

I am sure you would have wondered what exactly happens when you execute a program like grep or COSMIC Terminal. How exactly does the system load and execute that program?
How does Redox differ from Linux in how programs are loaded?
For my Redox Summer of Code project, my task was to fix and improve the Redox's dynamic linker, add dynamic linking support to the Redox's build system and port several packages to be dynamically linked!

When a command is run, the current process image gets replaced by that of the new program via the `exec()` family of functions. `exec()` functions such as `execl`, `execlp`, `execle`, `execv`, `execvp`, and `execvpe` are built on top of the `execve(2)` system call on Linux, whereas on Redox the it is handled within the libc in userspace.

Let’s see this in action on Linux using `strace`, which lets us peek into the system calls being made:

```bash
$ strace -e execve /usr/bin/echo arg1 arg2
execve("/usr/bin/echo", ["/usr/bin/echo", "arg1", "arg2"], 0x7ffccfbfef80 /* 50 vars */) = 0
arg1 arg2
+++ exited with 0 +++
```

In this output, we can observe that the `execve` syscall is called with three arguments: the path to the program (`/usr/bin/echo`), the argument list (`["/usr/bin/echo", "arg1", "arg2"]`), and the environment variables.

This function never returns because the new program takes over, and the original process no longer exists in memory. In Linux, the loading of the program happens in the kernel, while on Redox, as a microkernel OS, it is performed within the libc in userspace. Despite this, both set up the memory address space and jump to the entry point (the main function) in similar fashion.

## How does the program loader work?
To grasp how exec operates and how a program is loaded, it's important to understand the basic layout of an executable file. Both Redox and Linux use the **Executable and Linkable Format** (ELF) for executables and linkables.

<center>
    <img class="img-responsive" src="/img/rsoc-2024-dynamic-linking/elf_layout.png" width="50%" height="50%">
    Figure 1: ELF File Layout. <a href="https://en.wikipedia.org/wiki/Executable_and_Linkable_Format#/media/File:Elf-layout--en.svg">Source</a>
</center>

An ELF file starts with an ELF header containing essential details like the entry point, target machine, and version. Immediately following is the program header table, which lists segments that instruct the loader on how to load the executable. Before parsing these segments, the loader first creates a new memory address space for the process. One of the key segments for the loader is of the type `PT_LOAD`, which tells the loader to:
* Allocate memory in the new memory address space for that segment based on its specified size.
* Copy data from the executable file into memory, up to that segment's file size.
* If that segment's memory size is larger than its file size, zero-fill it's memory that is beyond it's file size.

After the ELF file has been loaded into memory, the loader switches to the newly allocated address space, dropping the old one. Execution then jumps to the program's entry point, which was specified in the ELF's header.

## But wait, what happens if the program is dynamically linked?

At build-time, the developer chooses whether to use static or dynamic linking.
Statically linked programs include all the needed code from libraries (for example, `libc.a`) directly into the executable file,
but dynamically linked programs use shared libraries (for example, `libc.so`) so that each executable does not need a copy of the library code.
The steps described earlier applied to statically linked programs.

As dynamic linked programs can make use of external symbols, such as those in shared libraries without actually including them in the program’s executable, additional work is required to resolve these symbols and load the necessary libraries into memory. 

When a dynamically linked program is executed, it relies on a dynamic linker (also known as the interpreter) to resolve these symbols and load the necessary libraries into memory. The `exec()` ELF loader loads both the program and its dynamic linker. 

As mentioned earlier, ELF files use segments to guide the loader on how to load the file. In addition to `PT_LOAD`, another crucial segment is `PT_INTERP`, which specifies the path of the dynamic linker. For example, on Redox you can check the dynamic linker path for GNU Bash (assuming not statically linked) with:

```bash
$ patchelf --print-interpreter /bin/bash
/lib/ld64.so.1
```

The interpreter is loaded just like the program and after it has been loaded, the `exec()` ELF loader jumps to its entry point (as defined in https://gitlab.redox-os.org/redox-os/relibc/-/blob/7edc231f313714bd44c3967d30d56ffb44b33fb1/ld_so/src/lib.rs) rather than the program's entry point.

## What happens in the dynamic linker?

After jumping to the dynamic linker’s entry point, the linker resolves the main program and its dependencies in a breadth-first order, loading them in three main steps for each dynamic shared object (DSO):
* Loading the ELF: The DSO is read and loaded into memory similar to the `exec()` loader. Note that only one copy of the DSO file is loaded, and it is shared among all processes that depend on it. On the other hand, statically linked programs embed libraries, which can result in multiple unshared instances of the DSO file; making it less memory and storage efficient.
* Applying Relocations [^1]
* Running init functions

Once everything is resolved, the dynamic linker jumps to the program's entry point (as specified inside the ELF header), just like the `exec()` loader!

Note that the interpreter remains in the memory address space *even after the program starts running*. This allows the program to instruct the dynamic linker to load additional shared libraries when needed, enabling features such as plugins/extensions and hot swapping of components.

<hr>
<center>
    <img class="img-responsive" src="/img/rsoc-2024-dynamic-linking/flowchart.png">
    Figure 2: Summary of the ELF loading process
</center>

## My work on the dynamic linker

Interestingly, Redox already had a dynamic linker (ld.so), written in mostly Rust, but it was broken and also lacked a lot of features. In addition, dynamic linking was also missing proper toolchain and build system support. With Redox's libc supporting both Linux and Redox, the linker used to segfault before even finding the necessary dependencies to load on both platforms.

Initially, it was challenging to hunt down the early segfaults. One factor was that relibc and the dynamic linker share codebases, and with the dynamic linker being a stale project, the code for it seemed incongruous from the rest of relibc. However, as the dynamic linker matured and I became more familiar with the codebase, debugging became smoother. I’ve explained the initial bug here: [RSoC 2024: Progress Report - Dynamic Linker](./01_rsoc2024_dynamic_linker.md).

After the dynamic linker was in a functional state, I was able to add support for lazy binding! Essentially, this means that symbol resolution isn’t performed when the DSO loads but only when the symbol is first used. Since the relocation and symbol resolution processes are quite expensive, this change defers the cost to resolve the function to when/if it is called. Furthermore, I also added support for symbol scopes (`RTLD_LOCAL`/`RTLD_LOCAL`), paving the way for more programs to be dynamically linked as our dynamic linker matures :)

Other improvements include significant performance gains (~tenfold) by optimizing how DSOs are read, parsed, and stored in memory, along with using GNU and Unix System V hash tables for faster symbol lookups. Additionally, features like `DT_RELR` and various other enhancements and features were added!

You can find the source code for the dynamic linker at: https://gitlab.redox-os.org/redox-os/relibc/-/tree/master/ld_so?ref_type=heads

## Making packages dynamically linked

I successfully dynamically linked numerous packages for Redox, including GNU Make, LLVM, GCC, GNU Binutils, cURL, GNU Bash, COSMIC Terminal, and many more!

If you want to make a dynamically linked package, check out the following section:

- https://doc.redox-os.org/book/porting-applications.html#dynamically-linked-programs

While porting these packages, I had to configure different build systems (e.g. GNU Autotools, CMake, Meson, ...) to recognize that Redox supports dynamic linking. One of the key build tools involved was GNU/libtool, which had to be ported to Redox. [libtool](https://www.gnu.org/software/libtool/) is a script that abstracts away platform-specific complexities of shared library creation.

Previously, our C and C++ toolchains did not support dynamic linking for our targets. I also added the necessary support to enable it :)

## Future work
More packages need to be ported. The dynamic linker is now at a stage where it should be able to run any standard package - we just need to port them. However, we currently cannot upstream a package recipe unless all its dependents support dynamic linking; otherwise, it would break those packages. Compiling both static and dynamic versions isn’t a viable solution either, as it would significantly increase package size.

<hr>
Working on this project was an incredible experience - I gained insight on the dynamic linking process, navigated various build systems, and honed my debugging skills. You can check out my work by running any of the dynamically linked packages on the latest Redox image!

<center>
    <img class="img-responsive" src="/img/rsoc-2024-dynamic-linking/cosmic_files_dynamically_linked.png">
    Figure 3: Dynamically linked Cosmic Files and Ion running on Redox!
</center>

## Resources
If you're interested in learning more about the dynamic linking process, here are some incredible resources:

1. Drepper, U 2005, ELF Handling For Thread-Local Storage, Version 0.20, Red Hat Inc, <https://www.uclibc.org/docs/tls.pdf>
2. Drepper, U 2011, How To Write Shared Libraries, <https://www.akkadia.org/drepper/dsohowto.pdf>.
3. Tool Interface Standard (TIS) Executable and Linking Format (ELF) Specification Version 1.2 1995, <https://refspecs.linuxfoundation.org/elf/elf.pdf>

[^1]: https://wiki.osdev.org/ELF_Tutorial#Relocation%20Sections

