+++
title = "RSoC: Relibc"
author = "jD91mZM2"
date = "2018-07-24T21:18:54+02:00"
+++

# Introduction

Hello! It's me, the tokio guy! Last blog post was the last interesting news I
had about tokio. The only tokio-related things I've done after that is rebasing
and getting [Unix Sockets on
Redox](https://github.com/rust-lang/rust/pull/51553) merged, which just [got
stabilized](https://github.com/rust-lang/rust/pull/52656). Instead, I've been
working on relibc.

# Relibc

## gcc_complete

Starting off, gcc_complete did not compile. Like usual, Jeremy was super quick
with fixing a few things, but I managed to catch up when we got to scanf being
missing, and told him I could implement that. [My first relibc
PR](https://gitlab.redox-os.org/redox-os/relibc/merge_requests/134)! After
that, I added empty locale functions, copy pasted musl's setjmp assembly code.
Finally, the last few things to get gcc_complete working
[here](https://gitlab.redox-os.org/redox-os/relibc/merge_requests/146)

It turns out we still have some unimplemented functions being used by
gcc_complete. I'm currently trying to phase out those, and after

 - Jeremy: [system](https://gitlab.redox-os.org/redox-os/relibc/commit/c2cdb451f57f18b10be25fa551f654f927eddb84)
 - stratact: [tmpfile](https://gitlab.redox-os.org/redox-os/relibc/merge_requests/154)

 - [localtime](https://gitlab.redox-os.org/redox-os/relibc/commit/b7e11afd2f331c92bed1203ccb14300449eb52e3) and [mktime](https://gitlab.redox-os.org/redox-os/relibc/commit/b7e11afd2f331c92bed1203ccb14300449eb52e3)
 - [getenv and putenv](https://gitlab.redox-os.org/redox-os/relibc/commit/019011f029d7dd0c6a9c3cdd1c22e81cec083dee),
 - [strftime](https://gitlab.redox-os.org/redox-os/relibc/commit/b83d1c7ff0d8bad8c446ec3637d5424171011cb9)
 - [basic signal support](https://gitlab.redox-os.org/redox-os/relibc/commit/ecd8aca6d6b939ba1d77fc4776b9c5b8df4471ad)

we only have tmpfile left, which stratact
[implemented](https://gitlab.redox-os.org/redox-os/relibc/merge_requests/154).

## redox itself

**I had nothing to do with this**, but you need to know something awesome.

Jeremy [got relibc to compile
redox](https://gitlab.redox-os.org/redox-os/relibc/compare/7e6e1b16...919ae09d)!
(which also required some [kernel
changes](https://gitlab.redox-os.org/redox-os/kernel/compare/master...relibc))

I was surprised when he said he'd do this since I thought it was my job, but I
*was* stuck and I'm very impressed to see how it all turned out! I am able to
run orbital and normal pure-rust programs with relibc, although it seems
slower. Openssl does not yet work, which leads us to:

## openssl

I also want to get openssl to compile. For that, we were missing
[sockets](https://gitlab.redox-os.org/redox-os/relibc/commit/d3f6985ee91677380da5d558133e4fbcfade5bbd).
Then, sajattack is working on
[netdb](https://gitlab.redox-os.org/redox-os/relibc/merge_requests/156), which
I'm thankful I don't have to do because it involves dns parsing and everything!
We're probably going to need more signal functions to be implemented, but I
haven't gotten to that stage of compiling yet.

When openssl compiles, we should sooner or later have a relatively complete
version of redox compiling with relibc!
