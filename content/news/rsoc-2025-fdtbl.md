+++
title = "RSoC 2025: Final Report: Unix Domain Sockets, Bulk FD Passing, and Separating File Tables"
author = "Ibuki Omatsu"
date = "2025-08-04"
+++

Hi everyone! I'm Ibuki Omatsu, and as part of my RSoC project, I've worked on implementing Unix Domain Sockets (UDS) in Redox OS.

Following that, I also worked on implementing bulk file descriptor (FD) passing and separating file tables.
In this post, first, I will talk about updates of the UDS implementation, and then I will explain bulk FD passing and the separation of file tables.

# Unix Domain Socket
First, let's talk about Unix Domain Sockets (UDS).

Unix Domain Sockets are a powerful IPC (Inter-Process Communication) mechanism that allows processes on the same host to communicate with each other using a socket interface. They are similar to network sockets but operate entirely within the local machine, providing high performance and low latency.

In Redox OS, UDS is implemented as a special scheme called `uds`, which is managed by the ipcd(Inter-Process Communication Daemon). This scheme allows processes to create and manage UDS sockets, enabling them to communicate efficiently.

Please see my previous post, [RSoC 2025: Implementing Unix Domain Sockets](https://www.redox-os.org/news/rsoc-2025-uds/), for more details about UDS.

## Update on UDS Implementation
Since my last post, I have made several updates to the UDS implementation in Redox OS. The most significant change is `bind` and `connect` integration with RedoxFS, the Redox file system daemon.

In the previous implementation, UDS sockets were created and managed by ipcd, and the `bind` and `connect` operations were handled by only ipcd. However, this approach had a limitation regarding permission checks on the socket file.

In Redox, resources are accessed by Scheme-rooted Path, and the `uds` scheme is no exception. Sockets are created in the `/scheme/uds/` space, and the `bind` operation was not able to check the permission of the socket, which could lead to security issues.

To address this, I have integrated the `bind` and `connect` operations with RedoxFS. Now, when a process attempts to `bind` or `connect` to a UDS socket, the functions communicate not only with ipcd but also with RedoxFS, which performs the necessary permission checks based on the file system's access control mechanisms. This ensures that only authorized processes can create or connect to UDS sockets, enhancing the security of the IPC mechanism.

We may change this strategy as we move forward with capability-based security, but this was the best available approach at this time.

Here is the new process for `bind` and `connect` operations, which now involve both ipcd and RedoxFS:
### Bind Operation Flow
1. The process calls the `bind` function with the socket file path.
2. The `bind` calls `Bind(SYS_CALL)`.
3. ipcd receives the `Bind(SYS_CALL)`, names the socket, generates a permanent token for the socket and maps the socket with it.
4. The `bind` opens the parent directory that the socket file will be created in, using the `open` syscall.
5. The `bind` sends the socket FD to RedoxFS via the parent directory FD, using the `sendfd` syscall.
6. RedoxFS receives the socket FD, creates the socket file in the specified directory, and maps the new file's node to the received socket FD.
>If the operation is failed, the `bind` calls `UnBind(SYS_CALL)` to clean up the socket name in ipcd.
<center>
    <img class="img-responsive" src="/img/rsoc-2025-fdtbl/bind_flow.png" width="50%" height="50%">
    Figure 1: Bind Operation Flow.
</center>

### Connect Operation Flow
1. The process calls the `connect` function with the socket file path.
2. The `connect` opens the socket file using the `open` syscall.
3. RedoxFS receives the `open` syscall request and checks the permission of the socket file.
4. The `connect` calls a `Connect(SYS_CALL)` to RedoxFS via the socket file FD.
5. RedoxFS receives this Connect(SYS_CALL)request. It then calls `GetToken(SYS_CALL)` to retrieve the socket's permanent token from ipcd, using the socket FD.
6. ipcd receives the `GetToken(SYS_CALL)` request and returns the permanent token of the socket.
7. RedoxFS receives the token and returns it to the `connect` call.
8. The `connect` receives the token and call `Connect(SYS_CALL)` via the client socket FD with the token.
9. ipcd receives the `Connect(SYS_CALL)` request and connects the client socket to the server socket mapped to the token.

<center>
    <img class="img-responsive" src="/img/rsoc-2025-fdtbl/connect_flow.png" width="50%" height="50%">
    Figure 2: Connect Operation Flow.
</center>


By this integration, the `bind` and `connect` operations now work with RedoxFS's permission checking, ensuring that only authorized processes can create or connect to UDS sockets. This enhances the security of the IPC mechanism in Redox OS.

### What does UDS lead to?
The implementation of UDS is an item of [Wayland support](https://gitlab.redox-os.org/redox-os/redox/-/issues/1427) tracking issue, which is a graphical protocol for Linux and Unix-like operating systems. Wayland uses UDS for communication between the compositor and clients, making it a crucial component for supporting Wayland in Redox OS.

The UDS implementation in Redox OS is a important step towards achieving Wayland support, but it is not perfect yet.
There are still lacking features, such as the `sendto` and `recvfrom` functions. So, if you are interested in contributing to Redox OS, please consider working on [Missing Unix socket features](https://gitlab.redox-os.org/redox-os/redox/-/issues/1595).

# Implementing Bulk FD Passing and Separating File Tables
After the UDS implementation, I have also worked on implementing bulk FD passing and separating file tables in Redox OS.
Bulk FD passing is a feature that allows processes to send multiple FDs in a single operation, which is particularly useful for applications like UDS that need to share multiple resources efficiently. Separating file tables means that separating the file descriptor number space into upper and POSIX (lower) regions, which enables invisible FDs.

## Bulk FD Passing
The current `sendfd` and `named dup` mechanism in Redox OS allows processes to send a single fd to another process. However, some programs, such as UDS's `sendmsg` and `recvmsg`, need to send multiple FDs. Currently, they have to call `sendfd` multiple times. This is inefficient and can create performance bottlenecks.

To address this, I have implemented bulk FD passing with `SYS_CALL`.
The `SYS_CALL` interface is a powerful mechanism in Redox OS that allows processes to communicate with schemes using a single syscall. It is flexible enough to handle bulk FD passing.

The new `CallFlags::FD` flag allows kernel handles to distinguish between normal data and FDs. When this flag is set, the kernel knows that the request is a bulk FD passing request.
And the generic `CallFlags::WRITE` and `CallFlags::READ` flags are used to indicate whether the request is for writing or reading data.
Combining these flags, we can create a new `CallFlags` that indicates the request is a bulk FD sending or receiving request.
```rust
bitflags! {
    pub struct CallFlags: usize {
        const WRITE = 1 << 9;
        const READ = 1 << 10;

        /// Indicates the request is a bulk fd passing request.
        const FD = 1 << 11;
    }
}
```
Here is a process of bulk FD passing:
1. The sending process prepares a list of FDs to send as the data payload.
2. It calls the `sys_call` function with the `CallFlags::FD | CallFlags::WRITE` flags, passing the list of FDs as the payload.
3. The kernel receives the syscall and checks the flags.
4. If the `CallFlags::FD | CallFlags::WRITE` flag is set, the kernel knows that this is a bulk FD sending request.
5. The kernel removes the FDs from the sending process's FD table and sends them to the scheme.
6. The scheme receives the FDs and queues them for the receiving process.
7. The receiving process calls the `sys_call` function with the `CallFlags::FD | CallFlags::READ` flags.
8. The kernel receives the syscall and checks the flags.
9. If the `CallFlags::FD | CallFlags::READ` flag is set, the kernel knows that this is a bulk FD receiving request.
10. The kernel sends the request to the scheme.
11. The scheme places the FDs into the request buffer and returns them to the kernel.
12. The kernel removes the FDs from the scheme's file table and adds them to the receiving process's FD table.
13. The receiving process receives the FDs and can use them as normal file descriptors.

Here is an example of how to use bulk FD passing in Rust:
the `call_wo` function is a wrapper for the `SYS_CALL` with the `CallFlags::WRITE` flag, and the `call_ro` function is a wrapper for the `SYS_CALL` with the `CallFlags::READ` flag.
```rust
// Send multiple FDs to another process using bulk FD passing.
// Assume `sender_sock` is a file descriptor to a socket,
// and `fds_to_send` is a vector of file descriptors.
let mut payload: Vec<u8> = Vec::with_capacity(fds_to_send.len() * mem::size_of::<usize>());
for &fd in fds_to_send {
    payload.extend_from_slice(&fd.to_ne_bytes());
}
Ok(libredox::call::call_wo(
    sender_sock,
    &payload,
    CallFlags::FD,
    &[],
)?)

// Receive multiple FDs from another process using bulk FD passing.
// Assume `receiver_sock` is a file descriptor to a socket,
// and `dst_fds` is a buffer to store the received file descriptors.
let dst_fds_bytes: &mut [u8] = unsafe {
    core::slice::from_raw_parts_mut(
        dst_fds.as_mut_ptr() as *mut u8,
        dst_fds.len() * mem::size_of::<usize>(),
    )
};
Ok(libredox::call::call_ro(
    receiver_sock,
    dst_fds_bytes,
    CallFlags::FD | flags,
    &[],
)?)
```

### What does Bulk FD Passing lead to?
Bulk FD passing is a powerful feature that enhances the efficiency of IPC in Redox OS. It allows processes to share multiple resources in a single operation, reducing the overhead of multiple syscalls and improving performance.
This feature could be used in various applications, such as UDS, UDS `sendmsg` and `recvmsg` are not currently use bulk FD passing mechanism, but they could be modified to use it in the future.

## Separating File Tables
Separating file tables is another important feature that I have implemented in Redox OS. The current file descriptor table in Redox OS is a single table that contains all FDs, including those for relibc's own purpose.

The separation is very simple, we just need to add a new `FdTbl` struct that contains two vectors of FDs.

The first vector is `posix_fdtbl`, which is a conventional file table that is according to the POSIX requirements. FDs are inserted into the lowest available slot.

The second vector, `upper_fdtbl`, is reserved over `1 << (usize::BITS - 2)` bits and is not according to the POSIX requirements. e.g.) Fds can be insterted contiguously.
```rust
#[derive(Clone, Debug, Default)]
pub struct FdTbl {
    pub posix_fdtbl: Vec<Option<FileDescriptor>>,
    pub upper_fdtbl: Vec<Option<FileDescriptor>>,
    active_count: usize,
}

pub const UPPER_FDTBL_TAG: usize = 1 << (usize::BITS - 2);
```

Currently, the bulk FD passing is supporing the `upper_fdtbl`, so you can receive the FDs to also the `upper_fdtbl` by using the `CallFlags::FD_UPPER`.

### What does Separating File Tables lead to?
Currently separating file tables is not used in Redox OS, but it is a preparation for future features.

For example, we are currently working on the namespace management in Redox OS, which will modify the `open(PATH)` function to a wrapper for `openat(NAMSPACE_FD, PATH)`.

We can use the `upper_fdtbl` to store the namespace FDs, CWD FD, and other file descriptors that are used internally by Redox, but which are invisible to the user programs, and don't overlap with POSIX file descriptors.

## Conclusion
In conclusion, I had the opportunity to participate in many aspects of Redox OS as a Summer of Code student, and I've learned a lot about the Redox OS and microkernel internals.

Participating in RSoC has been a great experience for me, and I am grateful for the opportunity to contribute to Redox.
I will continue to contribute to Redox, and I hope to write a post about the namespace management in Redox OS in the future, so please stay tuned!

I would like to thank the Redox OS community for their support and guidance throughout this project!
Thank you for reading this post, and I hope you found it informative and interesting.
