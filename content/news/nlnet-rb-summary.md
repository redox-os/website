+++
title = "Ring Buffers Project Summary"
author = "Ibuki Omatsu, Anhad Singh, Jacob Lorentzon, Ron Williams"
date = "2026-10-17"
+++

Last year, the Redox team [received a grant](https://nlnet.nl/project/RedoxOS-ringbuffer/) to develop io_uring-like Ring Buffer support at the system task level,
as a first step towards ring buffer communications between the application and the majority of system services.
The work finished up in September, as the last pieces were put in place.

We want to thank the [NLnet Foundation](https://nlnet.nl/), the NGI Zero Commons Fund, and Horizon Europe for their generous support.
The NGI Zero Commons Fund is reaching its end, but NLnet is now accepting applications for grants from new funds,
[Restack](https://nlnet.nl/restack/) and [Code Supply](https://nlnet.nl/codesupply/),
as well as some [smaller theme funds](https://nlnet.nl/themes/).
[Apply for funding before November 3rd 2026!](https://nlnet.nl/news/2026/20260903-call.html) (and then every two months after that).

The team has done a fantastic job, and I want to congratulate Ibuki, Anhad and Jacob, and thank them for their time and effort.

In addition to implementing the Ring Buffer machinery for our system services and drivers that can support it,
an `io_uring` and `liburing`-like API for applications was completed and demonstrated.
There was also substantial work done on support crates, including an async executor for drivers.

And there was some very exciting work on various performance improvements,
to allow much faster switching between tasks.
But I will let the team tell you all the technical details.

-- Ron Williams

## The "redox-ring API" - Ibuki Omatsu

We've introduced the first ring buffer implementation to Redox OS. Unlike Linux's io_uring, the submission queue (SQ) and completion queue (CQ) are shared exclusively between userspace processes and are never accessed by the kernel.

`redox-rings` is a new crate for ring buffer communication between userspace processes, also providing data structures for FFI use cases. It uses futexes as the main synchronization mechanism, with optional pipe file descriptor support.

Based on its FFI support, we've introduced the "redox-ring API" in relibc, inspired by Linux's liburing.

liburing is a library for Linux's io_uring, providing helpers for setting up and tearing down io_uring instances, as well as a simplified interface for submitting I/O requests.

Similarly, the redox-ring API allows applications to communicate with daemons that support ring buffers using custom protocols.

### Key functions

The API provides functions for managing ring buffers, shared memory, and requests.

- `redox_ring_queue_init_with_path()` initializes a ring buffer connection to a daemon.
- `redox_ring_alloc_buf()` and `redox_ring_alloc_sized()` allocate buffers from the shared memory pool.
- `redox_ring_get_sqe()` obtains a submission queue entry (SQE) for preparing a request.
- `redox_ring_submit()` submits pending requests to the daemon.
- `redox_ring_wait_cqe()` waits for a completion queue entry (CQE), blocking if none is available.
- `redox_ring_cqe_seen()` marks a CQE as processed.

The API also provides functions for registering file descriptors, freeing allocated buffers, and tearing down ring buffer instances.

## Memory Management and Shared Buffers

The `redox-rings` implementation uses shared memory to exchange SQEs, CQEs, and I/O data between applications and daemons.

During initialization, the SQ, CQ, and data buffer pool are mapped into the application's address space using the `fmap` syscall with `MAP_SHARED`. This allows both sides to access the same memory without copying I/O data between processes.

### Buffer allocation

The redox-ring API supports two buffer allocation strategies:

- Fixed-size allocation: Uses a simple allocator that divides the shared memory pool into fixed-size chunks and maintains a list of available offsets.
- Dynamic allocation: Uses the [redox-buffer-pool](https://gitlab.redox-os.org/redox-os/redox-buffer-pool) crate to allocate buffers of varying sizes and alignments. The allocator uses B-trees to manage free and occupied memory regions.

Both allocation strategies return a pointer to the allocated buffer and its offset within the shared memory pool.

Once an operation has completed, the application can release its buffer, allowing the memory to be reused.

## Example: Writing to RamFS

Ring buffer support was added to RamFS and NVMed. We also added tests that communicate with these storage daemons through the redox-ring API.

For example, writing data to RamFS involves the following steps:

1. Open the target file and initialize a ring buffer instance to RamFS using `redox_ring_queue_init_with_path()`.
2. Register the file descriptor so that subsequent requests can reference it by index.
3. Allocate a shared memory buffer and write the data into it.
4. Obtain an SQE and specify the write operation, file index, buffer offset, data length, and file offset.
5. Submit the prepared SQEs using `redox_ring_submit()`. Multiple requests can be submitted in a single batch.
6. Wait for CQEs, check the results, and release the buffers associated with completed requests.

Once all operations have completed, the application tears down the ring buffer connection.

-- Ibuki Omatsu

## Kernel and IPC optimizations - Jacob Lorentzon

While it has substantially improved over the years, IPC is still very slow on Redox, and this is important to optimize as ring buffers can only offset this overhead to a certain extent.

### Infrastructure

The `acid` test suite was expanded to include more targeted benchmarks that measure IPC latency, in particular `acid ipc_latency_simultaneous`, and also `acid heavy_forking`.
Support was also added for repeating measurements and collecting more proper statistics (although still less feature-complete than e.g. `hyperfine`), making it easier to know whether changes in metrics are statistically significant and by how much.

### Misc refactors

Various single-digit speedups were attained from kernel refactors, such as eliminating redundant locking, hashmap lookups, and by adding a lower-overhead call for IPC, similar to seL4's "reply-wait".

### Fast path switching without vector registers

Another source of overhead from the flamegraphs, was found to be `XSAVE` and `XRSTOR`, a few hundred cycles combined (tested on a AMD Ryzen 9 5950X).
These instructions save/restore vector registers, which is ~600 bytes on CPUs with AVX2 (and which only userspace uses).

The optimization made here is that the kernel zeroes the vector registers _if the caller and callee entered the kernel through syscalls_, rather than saving/restoring (using `vzeroall`, `ldmxcsr` etc. as required for correctness).

Context switching can be triggered both by preemption, i.e. timer interrupts, and voluntarily from syscalls.
After Redox destabilized its syscall ABI, instead preferring the `libredox` symbols provided by `relibc`, all syscalls will first go through a function call.
Since the System V ABI clobbers all vector registers _for all function calls_, it is almost zero-cost to also define Redox's syscall ABI to do so.
Luckily, the generated asm for `relibc` was almost identical.

### Direct switching

A major bottleneck during IPC is invoking the scheduler, as can be seen e.g. in flamegraph TODO.
The scheduler needs to access multiple data structures, primarily `BTreeMap` that takes up a large fraction of the overhead, and it also needs to acquire lots of locks, often blocking.

Direct context switching was implemented in TODO, resulting in a TODO% IPC latency reduction.
It separates the _current context_ (reference) into the _scheduled context_ and the _running context_, where the former is the context owning the current timeslice, and the latter is the context whose registers/memory/file table is currently active.
When direct switching has not occurred, these always coincide.
Consequently, a client process calling a scheme (typically using our `SYS_CALL` syscall) can completely bypass the scheduler and switch directly to the scheme, if ready, where the kernel will then prioritize returning to the _scheduled context_ the next time the scheme yields.
This mimics the behavior of monolithic kernels, and should also be more cache-efficient etc.

### Huge pages

The kernel previously only supported 4k pages.
This is still the case on non-x86, and for all userspace cases, but now the kernel physmap will be mapped as 2M when possible.
TLB usage is thus reduced by up to 512x for heavy CoW, whereas the artificially highest speedup obtained from `acid heavy_forking` was TODO.

## Future improvements

IPC roundtrip latency has been reduced from ~5800 cycles to ~2700 cycles, but this is still high compared to fast µkernels like seL4.
Additional optimizations could be to reduce locking, and reduce the syscall entry overhead, but primarily to simplify the IPC primitive and remove possibly unnecessary parts such as request buffers.
While not as applicable for nonlegacy applications, automatic page-borrowing of clients' buffers (in `UserScheme`) is also a major source of overhead and a benchmark similar to `dd bs=4k if=/dev/zero of=/dev/null` is at least ~32k cycles per call.
However, while the existing benchmarks are useful as an approximate lower bound on latency, more investigation will be required to determine the distribution of overheads for more realistic workloads, and when combined with userspace ring buffers.

-- Jacob Lorentzon