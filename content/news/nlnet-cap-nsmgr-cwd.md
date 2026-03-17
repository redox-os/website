+++
title = "Capability-based Security for Redox: Namespace and CWD as a capability"
author = "Ibuki Omatsu"
date = "2026-03-17"
+++

Hello everyone! I'm Ibuki Omatsu. I'm currently working on the project ["Capability-based security for Redox"](https://nlnet.nl/project/Capability-based-RedoxOS/), that thankfully funded by NLnet.

In this post, I'll explain the "Namespace management in Userspace" and "CWD as a Capability".
We'll explore how we reimplemented the namespace that were managed by the kernel, and string-based CWD management, using capabilities.

## Introduction: The architecture of Redox OS

In thi chapter, I'll explain two Redox specific concept "Scheme" and the C standard library, "relibc".

### Scheme: Resource Provider Services
As you know, Redox OS is a microkernel operating system.
This means most of daemons and drivers, such as filesystems and process managers, run as separated programs in userspace.
"Scheme" are the services that these programs provide.

For example, RedoxFS (The Redox OS's Filesystem) provides the `file` scheme, the process manager provides the `proc` scheme.
All resources are accesssed by "Scheme-rooted Path" that takes following form: `/scheme/{scheme-name}/{resource-name}`.

Example of Scheme-rooted Paths:
- file: `/home/user/file.txt` -> `/scheme/file/home/user/file.txt`
- tcp: `127.0.0.1:8080` -> `/scheme/tcp/127.0.0.1/8080`

In Redox, "Namespace" controls the visibility of schemes.
Schemes are registered to namespaces, and a process only able to access the schemes registered to its own namespace.
This is controlled using Scheme-rooted path.
For example, In a namespace such as `["file", "uds"]`, a process can access files and Unix Domain Sockets, but it cannot access the network stacks.

### relibc: The C Standard Library
relibc is a C standard library, that mainly targets Redox OS, but also supports multiple operating systems.

For Linux, it simply calls raw syscalls. However, for Redox, it provides `redox-rt` (the Redox runtime service).
`redox-rt` absorbs the microkernel charactaritics for enxure POSIX compliance. It provides some features such as "Convertion of POSIX standard path to Scheme-rooted Path", and "Management of Redox-internal file descriptors".
In Redox OS, threads and processes are managed as fds by `redox-rt`.

## File Access in Redox OS Before Capabilities

Let's look back at how file access worked before the transition to capabilities.

### Absolute Path
1. Application calls `open("/home/user/some_file")`.
2. relibc (`redox-rt`) cnverts the path to Scheme-rooted Path `/scheme/file/home/user/some_file`, and open it.
3. The kernel extract the target scheme name `file`, and look for it in the caller process's namespace.
4. If the target scheme `file` is registered in the namespace, the kernel routes the syscall request to the scheme.
5. `file` scheme receives the syscall request.

In this design, where the kernel manages both Scheme and Namespace, the kernel has to hold all scheme names as string and parse the paths for identify the target scheme.

<center>
    <img class="img-responsive" src="/img/nlnet-cap-nsmgr-cwd/before.png" width="50%" height="50%">
    Figure 1: File access flow before capabilities.
</center>

### Relative Path (CWD)
Previously, relative path were always converted to absolute path before begin processed.
Because relibc stored the CWD as a string, all relative paths were converted to absolutes path by joining it to the CWD string.

In this design, we had to reconstruct an absolute path every time a relative path was provided. This also made it challenging to apply some restrictions, such as `O_RESOLVE_BENEATH`, to the CWD.

Our goal is to solve these issues caused by path based management.
The key of this transition is the `openat` syscall.

## Key Concept: `openat(dir_fd, path)`
The `openat` opens a file, ralative to a directory fd.
In an unrestricted mode, this is just a convenience.
However, If we limit the paths to be beneath that `dir_fd`, and restrict a program touse only `openat`, the `dir_fd` effectively becomes a Sandbox.
The program cannot see or access anything outside of that directory.

## Namespace Manager in Userspace
Based on `openat`, we have introduced a Namespace Manager (nsmgr) in Userspace.
In this new design, nsmgr sits between the application and the schems as one of the userspace schemes.
The namespace are represented as a file descriptor managed by redox-rt, rather than just IDs bound to the process.
```rust
pub struct DynamicProcInfo {
    pub pgid: u32,
    ...
    pub sgid: u32,
    pub ns_fd: Option<FdGuardUpper>,
}
```
Here is the follow.
1. An Application calls `open("/home/user/some_file")`.
2. Relibc(`redox-rt`) converts the path to Scheme-rooted Path, and then call `openat` using process's namespace fd.
3. Nsmgr receives the `openat` request.
4. Nsmgr extracts the target scheme name `file`, and look for it from the namespace bound to the fd.
5. If the target scheme `file` is registered in the namespace, the nsmgr routes the syscall request to the scheme.
6. `file` scheme receives the syscall request.

<center>
    <img class="img-responsive" src="/img/nlnet-cap-nsmgr-cwd/after.png" width="50%" height="50%">
    Figure 2: File access flow after capabilities.
</center>

Applications only operate relative to thier provided namespace fd.
This allows us to remove complex scheme and namespace managment from the kernel.
Schemes are created anonymously in the kernel, this means the kernel no longer needs to know any scheme names.
The kernel now work as only dispatches the syscall requests and doesn't need to parse paths.


## CWD as a Capability
Similarly, we updated relibc to handle the CWD as a capaibility.
Now, relibc holds the CWD as an fd, not just a string path.
When a relative path is passed to `open`, or when an `AT_FDCWD` is passed to `openat` function, relibc simply calls `openat` using the CWD fd.
Due to this transition, we can process relative paths without converting them to absolute paths.
And we become able to support `O_RESOLVE_BENEATH` simply. We just set the flag on the fd, and the scheme recognize it.
In addition, we can use CWD fd as a sandbox, by restricting absolute path access via the namespace.

```rust
pub struct Cwd {
    pub path: Box<str>,
    pub fd: FdGuardUpper,
}
```

(For getcwd, we still caches the CWD path string.)

## Conclusion
By reimplementing these features using capabilities, we made the kernel simpler by moving complex scheme and namespace management out of it. At the same time, we gained the way to supports more sandboxing feature on the CWD.
This project leads the way for feture sandboxing supports in Redox OS.
As the OS continues to move toward capability-based security, it will be able to provide more modern security features.

Thank you for reading this post, and I hope you found it informative and interesting.
