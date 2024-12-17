+++
title = "RSoC 2024: Progress Report - Dynamic Linker"
author = "Andy-Python-Programmer"
date = "2024-12-17"
+++

Hello everyone! I am Anhad Singh and I am currently working on Redox’s dynamic
linker and porting programs to be dynamically linked as a part of my RsoC
project.

*At the time of writing this post, all upstream recipes currently are statically
compiled and patches are being gradually rolled out.*

Basically, dynamic linking allows a program to use external symbols, such as
those in shared libraries like libc, without actually including them in the
program's executable. When the program is executed, the dynamic linker resolves
these symbols and loads the necessary libraries into memory. 

In contrast, statically linked programs resolve all symbols during compilation
and include them directly in the final executable. While static linking ensures
self-contained executables, dynamic linked programs are usually more space and
memory efficient.

# So, what was wrong?

Initially the dynamically linked programs were faulting at the following
instruction inside `ld64.so.1`: 

`mov rax, fs:[0x10]`

This was inside `Tcb::current()` which is used to retrieve the TP (Thread
Pointer) which should be pointing to the TCB (Thread Control Block). With the
help of GDB, I found that TP was uninitialized.

This is a problem on Redox, as we need the TCB to be setup in order to do
pretty much anything. For example, the signal handling code is in userspace and
we have to keep track of thread-specfic signal state. This is stored in the
TCB. However, the TCB was being set up only for the executable and not for the
dynamic linker. Resolving this was the first step for getting the dynamic
linker working again.

Next, the dynamic linker also shares code with relibc, which is generally
beneficial. However, many of the relibc functions rely on thread locals like
`errno`, which is a problem as TLS (Thread Local Storage) in the dynamic linker
is not available. These changes were able to get some of the dynamically linked
programs to run.
       
Finally, after fixing and making sure that static TLS for libraries was
correctly sized and that libraries loaded via dlopen(3) also had proper TLS
support. These fixes, along with others (see
<https://gitlab.redox-os.org/redox-os/relibc/-/merge_requests/570> and
<https://gitlab.redox-os.org/redox-os/relibc/-/merge_requests/577> for all of
them), I was able to get the dynamic linker functional again!

# Where are we at now?
The dynamic linker is now in a functional state, though certain features are
still incomplete. For instance, lazy binding (`RTLD_LAZY`) currently behaves
the same as `RTLD_NOW` (PR for the fix should be out soon). Additionally, stuff
like symbol scopes (`RTLD_GLOBAL`/`RTLD_LOCAL`) are still unimplemented.

My current focus is on implementing these missing features and porting existing
applications to be dynamic linked; prioritizing programs that use libraries
widely shared among multiple other programs.

Despite these limitations, we can successfully run dynamically compiled GCC and
execute programs compiled with it on Redox (note that patches for this are
being gradually rolled out). Dynamically linked programs like Bash also work as
expected.

