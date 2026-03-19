+++
title = "Capability-based Security for Redox: Namespace and CWD as capabilities"
author = "Ibuki Omatsu"
date = "2026-03-17"
+++

Hello everyone! I'm Ibuki Omatsu. I'm currently working on the project ["Capability-based security for Redox"](https://nlnet.nl/project/Capability-based-RedoxOS/), graciously funded by [NGI Zero Commons](https://nlnet.nl/commonsfund/) and [NLnet](https://nlnet.nl/).

In this post, I'll explain "Namespace management in Userspace" and "CWD as a Capability".
We'll explore how we reimplemented the namespace that previously was managed by the kernel, and the previously string-based CWD management, using capabilities.

You might want to read about [Capability-based security](https://en.wikipedia.org/wiki/Capability-based_security) if you are unfamiliar with it.
A simplified description is that an open file descriptor is a capability,
because it identifies a resource and the application's access rights for that resource.
Capability-based security expects that all resources will be accessed starting from a capability.

## Introduction: The architecture of Redox OS

In this section, I'll explain two Redox specific concepts, resource provider "Schemes", and our implementation of the C standard library, "relibc".

### Scheme: Resource Provider Services
As you know, Redox OS is a microkernel operating system.
This means most daemons and drivers, such as filesystems and process managers, run as separate programs in userspace.
"Schemes" are the services that these programs provide.

For example, RedoxFS (Redox OS's Filesystem service) provides the `file` scheme, and the process manager provides the `proc` scheme.
All resources are accesssed by a "Scheme-rooted Path" that takes following form: `/scheme/{scheme-name}/{resource-name}`.

Example of Scheme-rooted Paths:
- file: `/home/user/file.txt` -> `/scheme/file/home/user/file.txt`
- tcp: `127.0.0.1:8080` -> `/scheme/tcp/127.0.0.1/8080`

In Redox, the "Namespace" controls the visibility of schemes.
Schemes are registered to namespaces, and a process is only able to access the schemes registered to its own namespace.
This is controlled using Scheme-rooted path.
For example, In a namespace such as `["file", "uds"]`, a process can access files and Unix Domain Sockets, but it cannot access the network stack.

### relibc: The C Standard Library
relibc is a C standard library, that mainly targets Redox OS, but also supports multiple operating systems.

For Linux, it simply calls raw syscalls. However, for Redox, it provides `redox-rt` (the Redox runtime service).
`redox-rt` provides a conversion layer from Redox services to POSIX compliant services, and performs some of the functions typically assigned to the kernel in other Unix systems. It provides some features such as "Conversion of POSIX standard path to Scheme-rooted Path", and "Management of Redox-internal file descriptors".
In Redox OS, threads and processes are managed as fds by `redox-rt`.

## File Access in Redox OS Before Capabilities

Let's look back at how file access worked before the transition to capabilities.
In this previous design, the namespace existed in the kernel, and was bound to the process by an integer ID.

### Absolute Path
1. Application calls `open("/home/user/some_file")`.
2. relibc (`redox-rt`) converts the path to Scheme-rooted Path `/scheme/file/home/user/some_file`, and opens it.
3. The kernel extracts the target scheme name `file`, and looks for it in the caller process's namespace.
4. If the target scheme `file` is registered in the namespace, the kernel routes the syscall request to the scheme.
5. `file` scheme receives the syscall request.

In this design, where the kernel manages both Scheme and Namespace, the kernel has to hold all scheme names as strings and parse the paths to identify the target scheme.

<center>
    <img class="img-responsive" src="/img/nlnet-cap-nsmgr-cwd/before.png" width="50%" height="50%"><br>
    Figure 1: File access flow before capabilities.
</center>

### Relative Path (CWD)
Previously, a relative path was always converted to an absolute path before begin processed.
Because relibc stored the CWD as a string, all relative paths were converted to absolutes path by joining it to the CWD string.

In this previous design, we had to reconstruct an absolute path every time a relative path was provided. This also made it challenging to apply restrictions, such as `O_RESOLVE_BENEATH`, to the CWD.

Our goal is to solve these issues caused by path based management.
The key of this transition is the `openat` syscall.

## Key Concept: `openat(dir_fd, path)`
The `openat` system call opens a file, ralative to a directory fd.
In an unrestricted mode, this is just a convenience.
However, If we limit the paths to be beneath that `dir_fd`, and restrict a program to use only `openat`, the `dir_fd` effectively becomes a Sandbox.
The program cannot see or access anything outside of that directory.

## Namespace Manager in Userspace
Based on `openat`, we have introduced a Namespace Manager (`nsmgr`) in Userspace.
In this new design, `nsmgr` is a userspace scheme-type service, and sits between the application and the other schemes.
The namespace is represented as a file descriptor managed by redox-rt, rather than just an ID bound to the process.
```rust
pub struct DynamicProcInfo {
    pub pgid: u32,
    ...
    pub sgid: u32,
    pub ns_fd: Option<FdGuardUpper>,
}
```
Here is the sequence.
1. An Application calls `open("/home/user/some_file")`.
2. Relibc(`redox-rt`) converts the path to a Scheme-rooted Path (`"/scheme/file/home/user/some_file"` in this case), and then calls `openat` with the process's namespace fd as the `dir_fd`.
3. Nsmgr receives the `openat` request.
4. Nsmgr extracts the target scheme name `file`, and looks for it in the namespace bound to the fd.
5. If the target scheme `file` is registered in the namespace, the nsmgr routes the `openat` request to the scheme.
6. `file` scheme receives the `openat` request, and sends an fd for the file to Nsmgr.
7. Nsmgr forwards the fd to the application. Nsmgr does not need to participate in any future operations on the new fd.

<center>
    <img class="img-responsive" src="/img/nlnet-cap-nsmgr-cwd/after.png" width="50%" height="50%"><br>
    Figure 2: File access flow after capabilities.
</center>

Applications only operate relative to their provided namespace fd.
This allows us to remove complex scheme and namespace managment from the kernel.
Schemes are created anonymously in the kernel, this means the kernel no longer needs to know any scheme names.
The kernel now only needs to dispatch the syscall requests to the schemes, based on the dir_fd, and doesn't need to parse paths.


## CWD as a Capability
Similarly, we updated relibc to handle the CWD as a capaibility.
Now, relibc holds the CWD as an fd, not just a string path.
When an application passes a relative path to `open`, or when an `AT_FDCWD` is passed to the libc `openat` function, relibc simply calls its internal `openat` using the CWD fd.
Due to this transition, we can process relative paths without converting them to absolute paths.
And we become able to support `O_RESOLVE_BENEATH` simply.
When we set the flag on the fd, the scheme will limit the use of `../` to prevent escaping the sandbox.
In addition, we can use CWD fd as a sandbox, by restricting absolute path access via the namespace.

```rust
pub struct Cwd {
    pub path: Box<str>,
    pub fd: FdGuardUpper,
}
```

Note that for `getcwd()`, we still cache the CWD path string.
However, this may change as we implement more sandboxing features.

## Conclusion
By reimplementing these features using capabilities, we made the kernel simpler by moving complex scheme and namespace management out of it. At the same time, we gained a means to support more sandboxing features using the CWD fd.
This project leads the way for future sandboxing support in Redox OS.
As the OS continues to move toward capability-based security, it will be able to provide more modern security features.

Thank you for reading this post, and I hope you found it informative and interesting.
