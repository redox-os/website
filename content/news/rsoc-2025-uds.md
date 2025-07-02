+++
title = "RSoC 2025: Implementing Unix Domain Sockets"
author = "Ibuki Omatsu"
date = "2025-06-26"
+++

Hello everyone! I'm Ibuki Omatsu, and as part of my RSoC project, I'm currently working on implementing Unix Domain Sockets (UDS) in Redox OS.

UDS are a way for processes on the same machine to communicate with each other. They're similar to network sockets, but instead of using IP addresses and ports, they use the filesystem as their connection addressing. This allows for faster communication between processes, as there is no need to go through the network stack.

But here's the challenge: Redox OS has its own unique design called "**Schemes and Resources**". From files (`/scheme/file/path/to/file`) to network connections (`/scheme/tcp/127.0.0.1/3000`), every resource has its own scheme-rooted paths.

So, my first big question was: how do you fit a classic Unix feature like a socket file into this elegant, Plan 9-like with Unix-style paths world?

In this post, we'll explore how I adapted UDS to the "Redox way" of thinking. Then, we'll take a deep dive into file descriptor (FD) passing, one of the most powerful features of UDS, and see how the `sendmsg` and `recvmsg` functions are implemented using the `SYS_CALL` interface.

## Design Issues: Adapting Unix Domain Sockets to Redox

### Schemes and Resources
*"An essential design choice made for Redox is to refer to resources using scheme-rooted paths"* from [Schemes and Resources](https://doc.redox-os.org/book/schemes-resources.html)
In Redox, resources are accessed by Scheme-rooted Path, for example, a file is accessed by `/scheme/file/path/to/file`, and a network connection is accessed by `/scheme/tcp/127.0.0.1/3000`.

### Question: How to express Socket in Redox?
In Linux, a socket is represented by a socket file, such as `/tmp/mysocket.sock`.

For Redox, we considered two main ideas: representing a socket through the existing `file` scheme or creating a new, dedicated scheme like `uds`.

In the first case, the approach would be very similar to other operating systems: we would need to implement special UDS handling directly within RedoxFS.

In the second case, we implement a new scheme for handling sockets, which is similar to how `tcp` and `udp` schemes work. We create a new special scheme called `uds` and implement special process to handle UDS.

### Decision: Why I Choose a New uds Scheme
I decided to implement a new `uds` scheme and handle it within ipcd (the Inter-Process Communication Daemon).
While using the existing `file` scheme would have been closer to traditional Unix, sockets have a unique lifecycle—`bind`, `listen`, `accept`, `connect`—that is very different from standard file operations. Mixing this special logic into redoxfs (the file system daemon) would complicate its code and violate the clean separation of concerns.

Creating a dedicated `uds` scheme felt more natural.
- **Clarity**: It keeps socket-specific logic contained within a dedicated daemon (ipcd).
- **Maintainability**: redoxfs can focus on being a great file system, and ipcd can focus on being great at IPC.
- **Elegance**: It follows the same pattern as `tcp` and `udp`, creating a consistent and predictable architecture for developers.

This approach truly embraces the Redox philosophy.

## How FD (file descriptor) passing works
With UDS, processes can send FDs over the socket. This allows them to share resources like files or even other sockets. FD passing is a powerful feature used in many applications, such as the [Wayland protocol](https://en.wikipedia.org/wiki/Wayland_(protocol)).

### A Classic Example: The Logging Daemon

Let's imagine a secure logging system with two types of processes:

- A Logging Daemon (Privileged): This process runs with high privileges. It's the only process on the system allowed to open the main log file, for example, `/var/log/app.log`.
- Worker Processes (Unprivileged): These are regular application processes with limited permissions. They should be able to write logs, but they must not be able to read the log file or access any other files in `/var/log/`.

Without FD passing, this is tricky. You might have to make the log file world-writable, which is a huge security risk.

With FD passing, the solution is both elegant and secure:

1. The privileged Logging Daemon starts up and opens `/var/log/app.log`, getting a FD for it.
2. A worker process needs to write a log, connects to the Logging Daemon via a UDS.
3. The daemon uses FD passing to send its FD for the log file over the socket to the worker.
4. The worker process receives a new FD. This new FD doesn't grant access to the original file path, but it points to the same underlying open file.
5. Now, the worker can write to the log file using this received FD, but it still has no permission to directly open `/var/log/app.log` or any other file in that directory.

### How FD Passing is Achieved in Redox
In Redox, FD passing is achieved through the `sendfd` syscall and a special use of the `dup` syscall (the "recvfd" mechanism).
A process can send a FD over a socket managed by a scheme.
The receiving process can then obtain this FD.

The intent of a file descriptor is to act as a reference to a resource that has been opened for use.
An FD is an index into a process's file descriptor table, maintained in the kernel,
and points to a "file description" that identifies the target resource.
An FD only makes sense in the context of the process that owns it,
so simply sending an FD number between processes would not accomplish the goal of passing a reference to a resource.
The kernel must participate in moving the reference between processes.

Here's how it works step-by-step:
1. The sending process calls `sendfd` syscall with the socket and the FD to send.
2. The kernel receives the syscall and removes the FD from the sending process's FD table.
3. The kernel sends a request to the scheme that manages the socket.
4. The scheme handles the request and then uses the request id to obtain the corresponding FD from the kernel.
5. The receiving process calls `dup` on the socket with the "recvfd" argument.
6. The scheme reports to the kernel that it is sending an already open FD.
7. The receiving process gets a new FD from the kernel that points to the same underlying open file as the original FD.

Here's an example of fd sending:
```rust
// Sending process
let fd_to_send = open("/var/log/app.log", O_WRONLY | O_CREAT | O_APPEND);
syscall::sendfd(socket, fd_to_send);

// Receiving process
let received_fd = syscall::dup(socket, "recvfd");
// Now the receiving process can use `received_fd` to write to the log file.
syscall::write(received_fd, b"Log message from worker\n");
syscall::close(received_fd);
```
This way, the receiving process can access the FD without needing to know the original file path.

## sendmsg and recvmsg implementation with SYS_CALL interface

In the previous section, we introduced the concept of FD passing and the low-level `sendfd` mechanism. Now, let's dive deeper into the standard C library functions `sendmsg` and `recvmsg`—which are crucial for this kind of advanced UDS feature—and their implementation. This is where Redox's unique `SYS_CALL` interface comes into play, offering a powerful and efficient solution.

Redox's implementation of the standard C library (libc) is called `relibc`, and it includes functions, such as `sendmsg` and `recvmsg`, that provide the same API as Linux.
But the implementation of those functions is done in a way that makes use of Redox's internal APIs.


The `sendmsg` and `recvmsg` functions allow processes to exchange structured messages containing both a data payload and control information (known as ancillary data). They use the following standard C structures:
```c
// https://man7.org/linux/man-pages/man2/send.2.html
struct msghdr {
    void         *msg_name;       /* Optional address */
    socklen_t     msg_namelen;    /* Size of address */
    struct iovec *msg_iov;        /* Scatter/gather array */
    size_t        msg_iovlen;     /* # elements in msg_iov */
    void         *msg_control;    /* Ancillary data, see below */
    size_t        msg_controllen; /* Ancillary data buffer size */
    int           msg_flags;      /* Flags (unused) */
};
// https://man7.org/linux/man-pages/man3/cmsg.3.html
struct cmsghdr {
    size_t cmsg_len;    /* Data byte count, including header
                           (type is socklen_t in POSIX) */
    int    cmsg_level;  /* Originating protocol */
    int    cmsg_type;   /* Protocol-specific type */
/* followed by
   unsigned char cmsg_data[]; */
};
```
The `msg_control` field is the key here; it's used to carry ancillary data like file descriptors (`SCM_RIGHTS`) and process credentials.

### The SYS_CALL Solution
Redox OS has a small number of syscalls. There are several ways of sending information to or receiving information from schemes. The `read` and `write` syscalls are two of them.

The `write` syscall sends information to a scheme. For the `uds` scheme, a normal `syscall::write(fd, data)` sends the data payload to a socket managed by the scheme.
The `read` syscall receives information from a scheme. For the `uds` scheme, a normal `syscall::read(fd, buf)` receives the data payload from a socket managed by the scheme.

If there is only one type of data to communicate with the scheme, normal `read` and `write` calls are sufficient.
However, that's not always the case. 
With `sendmsg` and `recvmsg`, however, the situation is more complex, as we need to handle not only the message payload but also ancillary data.
We could try to use `read` and `write` for this purpose, but the scheme wouldn't be able to distinguish whether the data is a message payload or ancillary data.

To solve this, we could use a "named dup" approach. We could call `dup` with a special path argument (e.g., `"ancillary"`), and it would issue a new fd for the socket, designated for this special use. If we then write to or read from this new fd, the scheme could recognize that the operation is for ancillary data.
```rust
// Issue a new fd for the ancillary data reading/writing
let fd = syscall::dup(socket, "ancillary");
// Write ancillary data to the socket
syscall::write(fd, ancillary_data);
// Read ancillary data from the socket
syscall::read(fd, buf);
close(fd);
```
While this "named dup" approach works, it's inefficient. It requires at least three separate syscalls (`dup-write/read-close`) just to send one piece of ancillary data, introducing significant overhead.

The `SYS_CALL` interface solves this problem.
Here is a `SYS_CALL` interface definition:
```rust
pub fn sys_call(
    fd: usize,
    payload: &mut [u8],
    flags: CallFlags,
    metadata: &[u64],
) -> Result<usize>;
```
The `sys_call` function allows us to send a payload and metadata in a single syscall. The `payload` is used for sending/receiving the main data. The `metadata` parameter can be used for various kinds of information, such as representing the call type or giving other instructions.

Furthermore, the `SYS_CALL` interface is flexible enough to handle the entire `msghdr` structure. By defining a clear protocol, we can pack the message name, `iovecs`, and control data into a single, efficient syscall that the `uds` scheme can easily parse.

### How sendmsg and recvmsg are implemented
For implementing `sendmsg` and `recvmsg`, I designed a protocol for message-based communication. To see how this all fits together, let's trace the lifecycle of a `sendmsg` and `recvmsg` call that includes file descriptor passing.

Here is the data format for our protocol:
```
msg data format:
[payload_len(usize)][payload_data_buffer]
[ancillary_data_buffer]

cmsg(ancillary) data format:
[level(i32)][type(i32)][data_len(usize)][data]
```
Our implementation of the sendmsg function acts as a serializer. When called, it begins by processing the `msghdr` structure provided by the application.

1. It iterates through the ancillary data (`msg_control`). If it finds a control message of type `SCM_RIGHTS`, it internally calls `syscall::sendfd` for each file descriptor listed in that message. This sends the FDs to the `uds` scheme, where they are queued.
2. It then creates its own byte-stream representation of the message. For `SCM_RIGHTS` data, it doesn't serialize the FDs themselves, but rather the count of FDs that it just sent via `sendfd`.
3. Finally, the entire serialized stream—containing the user's data payload and the structured ancillary data (like the FD count)—is sent to the `uds` scheme in a single `SYS_CALL`.

Conversely, the recvmsg function works as a deserializer:

1. It first makes a `SYS_CALL` to the `uds` scheme to receive the complete message stream.
2. It parses this stream, filling the application's `iovec` buffers with the payload data.
3. When it parses the ancillary data portion and finds an FD count for `SCM_RIGHTS`, it knows how many file descriptors are waiting in the scheme's queue. It then internally calls `syscall::dup(socket, "recvfd")` the specified number of times, and uses Redox's FD sending mechanism to obtain the file descriptors.

This approach encapsulates all the complexity of Redox's file descriptor sending mechanism within the standard C library. The application developer can use `sendmsg` and `recvmsg` in the standard way, without worrying about the underlying `sendfd`, `dup`, and `SYS_CALL` mechanics.
It takes only one syscall to send or receive a message, which is much more efficient than the "named dup" approach.

This `SYS_CALL` eliminates the inefficient `dup-write/read-close` pattern, replacing multiple syscalls with just one.


## Conclusion
Implementing Unix Domain Sockets in Redox OS has been a fascinating journey. By creating a dedicated `uds` scheme, we maintained the elegance and clarity of Redox's architecture while embracing the powerful features of UDS, like FD passing. Furthermore, by leveraging the `SYS_CALL` interface, we successfully implemented complex functions like `sendmsg` and `recvmsg` in a way that is both high-performance and true to the Redox philosophy.

Thank you for reading. I look forward to sharing more exciting work in my next report!

### References
- [Schemes and Resources](https://doc.redox-os.org/book/schemes-resources.html)
- [Wayland Protocol](https://en.wikipedia.org/wiki/Wayland_(protocol))
- [send(2) - Linux manual page](https://man7.org/linux/man-pages/man2/send.2.html)
- [cmsg(3) - Linux manual page](https://man7.org/linux/man-pages/man3/cmsg.3.html)
