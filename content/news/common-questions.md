+++
title = "Common Questions from Community"
author = "Ribbon"
date = "2026-09-08"
+++

This article answer common questions/doubt from community about Redox, microkernel architecture, POSIX and Linux source compatibility.

### What are all applications, games, emulators, and C/C++ libraries that Redox can run?

See [this](https://static.redox-os.org/pkg/x86_64-unknown-redox/) package list.

You can install them using the command: `sudo pkg install package-name`

If you want a smaller/simpler list of important programs, see [this](https://doc.redox-os.org/book/important-programs.html) page.

### Current Hardware Support

| **Category** | **Items** |
|--------------|-----------|
| CPU | - Intel 64-bit (x86_64) <br>- Intel 32-bit (i586) from Pentium II and after with limitations <br>- AMD 32/64-bit <br>- ARM 64-bit (aarch64) with limitations <br>- RISC-V 64-bit (riscv64gc) with limitations |
| Hardware Interfaces | - ACPI, PCI, USB |
| Storage | - IDE (PATA), SATA (AHCI), NVMe |
| Video | - BIOS VESA, UEFI GOP, Intel GPU (only mode setting) |
| Sound | - Intel and Realtek chipsets |
| Input | - PS/2 keyboards, mouse, and touchpad <br> - USB keyboards, mouse and touchpad |
| Ethernet | - Intel Gigabit and 10 Gigabit ethernet <br>- Realtek ethernet |

### What are the Redox CPU requirements?

The following requirements are mandatory to make Redox work, the most popular non-x86 CPUs have equivalents for them.

- [MMU](https://en.wikipedia.org/wiki/Memory_management_unit) : Introduced by the Intel 8086 CPU line in 1978 and present in all CPUs since then
- [FPU](https://en.wikipedia.org/wiki/Floating-point_unit) : Introduced by the Intel 8087 coprocessor in 1980 for the Intel 8086 CPU line and present in almost all CPUs since then
- `FXSAVE` extension or non-x86 CPU equivalent
- [Page Size Extension](https://en.wikipedia.org/wiki/Page_Size_Extension) or non-x86 CPU equivalent
- Paging global extension or non-x86 CPU equivalent

### I have a low-end computer, would Redox work on it?

A CPU is the most complex machine of the world: even the oldest processors are powerful for some tasks but not for others.

The main problem with old computers is the amount of DRAM memory available (they were sold in a era where RAM chips were expensive) and the lack of SSE/AVX extensions (programs use them to speed up the algorithms). Because of this some modern programs may not work (if a SIMD compatibility layer is not used) or require a lot of RAM to perform complex tasks.

Redox itself will work normally if the CPU architecture is supported by the system, but the performance and stability may vary per application.

### Why choosing i586 as the minimal supported x86 CPU?

- i686 ([Pentium Pro](https://en.wikipedia.org/wiki/Pentium_Pro)) introduced MMX, SSE, and SSE2 [extensions](https://en.wikipedia.org/wiki/P6_(microarchitecture)). Fortunately the kernel and other critical system components don't use them.
- i586 ([Original Pentium](https://en.wikipedia.org/wiki/Pentium_(original))) introduced a more efficient FPU and MMX extension which are critical for programs, also the most minimal CPU architecture supported by [Rust](https://doc.rust-lang.org/beta/rustc/platform-support.html) and perhaps most Rust packages.
- [i486](https://en.wikipedia.org/wiki/I486) introduced FPU and atomic operations, which are used by the kernel and other critical system components. It would be possible to go all the way back to i486, but Redox will run with much less programs.
- [i386](https://en.wikipedia.org/wiki/I386) has no atomics and floating instructions (at all), which makes it not a target for both the kernel and other critical system components.

### Why does Redox do cross-compilation?

[Cross-compilation](https://en.wikipedia.org/wiki/Cross_compiler) is when you build a program or library from one CPU architecture to another CPU architecture or one operating system to another operating system, but it requires more configuration than native compilation.

Read some of the reasons below:

- When developing a new operating system you can't build applications inside of it because the system interfaces are premature. Thus you need to build the applications from your host system to the new OS and transfer the binaries to the filesystem of the new OS.
- Cross-compilation reduces the porting requirements because you don't need to support the compiler of the program's programming language, the program's build system and build tools. You just need to port the programming language standard library (if used), program libraries or the program source code (dependency-free).
- Some developers prefer to develop from other operating systems like Linux, MacOS, FreeBSD or Windows, the same applies for Linux where some developers write code on MacOS and test their kernel builds in a virtual machine (mostly QEMU) or real hardware.

(Interpreted applications and scripts don't need cross-compilation but the programming language's interpreter or possible compiled dependencies needs to be ported and cross-compiled to Redox)

### Why you do X instead of Y?

Redox design decisions are adapted to a fast microkernel architecture with strong Rust capabilities, also to achieve our goal of safety, reliability, correctness, completeness, freedom and pragmatism.

### Why you did X if Y is better?

Redox is still work-in-progress (alpha state) thus we needed and may need to use temporary solutions that are inferior to keep and get things working quickly, which will be done properly as the system design matures.

### Why you prefer X if Y has much more adoption?

Due to our current limitations we may need to prefer X with less compatibility, but best for our current state or performance.

The most asked example is to prefer Orbital over Wayland or create Orbital instead of supporting X11 or Wayland in the beginning of Redox development, Orbital was and is much simpler to support than the APIs needed to make X11 and Wayland work, these APIs require a certain system maturity level and many dependencies.

Our current example is the limitation of Wayland forcing EGL to avoid X11 dependencies, but EGL also force OpenGL usage in the entire screen framebuffer while we don't have GPU drivers with hardware acceleration to reduce resource usage.

By translating OpenGL code on CPU (LLVMPipe) we get less performance than Orbital's native software rendering, thus our plan is to make Orbital support Wayland to reduce the OpenGL usage and greatly improve performance without the giant complexity of GPU drivers.

### What is the criteria of your microkernel design decisions?

We balance stability, security and performance, prefering better stability and security when the performance cost is tolerable.

But some decisions will not change, like separated system component memory address spaces for highest stability and security due to the absurd complexity level of modern operating systems and drivers.

### How Redox ABI compares to Linux/BSD?

The microkernel architecture allows us to break the system ABI (monolithic kernel ABI equivalent in microkernel ABI) without breaking the applications ABI (user-space ABI equivalent on Linux), our POSIX and C Standard Library (relibc) ABI also define the user-space system component ABIs and kernel ABI.

Thus when the system ABI breaks, only `relibc` need to be updated, not user-space applications or libraries.

By doing this we can improve the system faster than monolithic kernels.

### When relibc ABI breaks?

When dynamically linked (most cases) it breaks when:

- A function is renamed
- A function is removed
- Any function with `extern C` have their arguments changed
- The size or alignment of any struct is changed

New functions don't break ABI but are backwards-incompatible (programs compiled to previous relibc API can't use them).

When statically linked, the kernel ABI can't break.

### Why Redox prefer to port software from source instead of binary compatibility?

Ports using POSIX/Linux source compatibility require much less effort, are easier and have less maintenace cost than supporting BSD (BSD libc and kernel ABIs) or Linux (glibc/musl and kernel ABIs) binary compatibility (which would increase API complexity and feature sets and make them mandatory).

- glibc = GNU C Standard Library, with some POSIX APIs
- BSD libc = BSD C Standard Library, with some POSIX APIs

This decision allow us to:

- Avoid behavior from the monolithic-kernel architecture that would reduce the microkernel architecture reliability, security and performance
- Keep the system more simple and improve faster, greatly reducing all kinds of possible bugs
- Easily improve system API by not relying on the behavior of BSD and Linux ABIs, but reimplementing some C Standard Library and kernel APIs that can have a good/acceptable microkernel-based implementation
- Improve the reliability and security of programs when possible
- Greatly reduce porting effort by not needing to support a big feature set in a library or application ABI
- Greatly reduce maintenance cost
- Avoid BSD and Linux ABI complexity
- Avoid porting parts of BSD or Linux kernel APIs that are very complex/hard and may reduce the microkernel architecture reliability, security and performance

We plan to port (when possible) the best and widely-used FOSS programs present in Linux and BSD distributions or use virtualization to not need binary compatibility.

### Why does Redox have unsafe Rust code?

In some cases we must use `unsafe` declarations to allow some low-level tasks, for example at certain parts in the kernel and drivers, these unsafe parts are generally wrapped with a safe interface.

These are the cases where unsafe Rust is mandatory:

- Implementing a foreign function interface (FFI) (for example the relibc API)
- Working with system calls directly (you should use `libredox`, `relibc` or Rust `libstd` library instead of `redox_syscall`)
- Creating or managing processes and threads
- Working with memory mapping and stack allocation
- Working with hardware devices

It is an important goal for Redox to minimize the amount of `unsafe` declared Rust code. If you want to use unsafe Rust code on Redox anywhere other than interfacing with system calls, ask for Jeremy Soller's approval before.

Unsafe Rust still has most of the compiler verification and allows some safe Rust syntax usage, thus it is still more safe than C and C++.

Read the following pages to learn more about Unsafe Rust:

- https://doc.rust-lang.org/book/ch20-01-unsafe-rust.html
- https://doc.rust-lang.org/nomicon/meet-safe-and-unsafe.html

### Why does Redox have C code?

Sometimes C is simpler (for POSIX/C compatibility tests) or the compiler behavior is better for certain things that are still under discussion in Rust upstream.

### Why does Redox have Assembly code?

[Assembly](https://en.wikipedia.org/wiki/Assembly_language) is the core of low-level because it's a CPU-specific programming language and deals with things that aren't possible or feasible to do in high-level languages like Rust.

Sometimes required or preferred for accessing hardware, or for carefully optimized hot spots.

Reasons to use Assembly instead of Rust:

- Deal with low-level things (those that can't be handled by Rust)
- Writing constant time algorithms for cryptography
- Optimizations

Places where Assembly is used:

- `kernel` - Interrupt and system call entry routines, context switching, special CPU instructions and registers
- `drivers` - Port IO need special instructions (x86_64)
- `relibc` - Some parts of the C runtime
