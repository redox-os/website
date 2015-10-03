+++
title = "Redox way"
+++

Idealism, ego, and narcissism are often ingredients constructing
the not-so-humble OS developer. A short study of Linus Torvalds' public comments
is one of the recommended curriculum when attempting to divine the true
motivations of someone who would decide to defenestrate other extensively used,
widely documented, and extremely inexpensive Operating Systems in favor
of reinventing the wheel (we need more spokes in userspace!).

All that aside, I realize the importance of a project as large as this to define
some rationale for its existence, and some vision for its future.

To start, perhaps a riddle:

- What is black and blue, but never true?
- What is red and green, but cannot be seen?
- What is orange and yellow, but not so mellow?

I don't actually have an answer to that one, so good luck.

There is a question I do have an answer to, though:

## What is Redox?

**Redox is an operating system.**

**Redox is written mostly in Rust**, with a few x86 assembler files in
the bootloader and protected mode initialization. There is inline assembly
to deal with system calls, port access, and virtual memory, but it is very
succinct.

**Redox embraces Unix philosophy**, where many interfaces are accessible in
the virtual filesystem, the binary interface is lightweight and portable,
and text files are used for configuration.

**Redox prioritizes the User.** Safety is the most important innovation of Rust,
and Redox is attempting to use that innovation to provide a more stable
and secure experience without compromising user experience. Programs and drivers
are sandboxed, and the user is left in the highest privilege position.

This page will be updated to further explain the foundational principles of
Redox, once I have finished writing some code.
