+++
title = "RSoC: Relibc - Wrap up"
author = "jD91mZM2"
date = "2018-08-11T07:35:26+02:00"
+++

# \o

Well, it is nearing my RSoC project end date! Time for me to pack up and never
ever contribute to Redox ever again... Just kidding. This isn't goodbye, you
can't get rid of me that easily I'm afraid. I'll definitely want to contribute
more, can't however say with certainty how much time I'll get, for school is
approaching, quickly :(

Most importantly I'll want to continue rebasing mio and tokio and therefor
breaking the redox build process with missing git references in the Cargo.lock,
until [they are upstreamed](https://github.com/carllerche/mio/pull/844), and
after that I might still need to maintain it because of the policy for adding
new platforms. I am a little sad that it's taking so long to get things merged,
but it *is* a big change and stuff has to be considered.

## Actual relibc news

Continuing off from last time, we have a few goals completed:

 - gcc_complete now compiles without any `unimplemented!()`s. We still have
   some unimplemented functions due to missing system calls, but these are now
   acknowledged by printing them out to stderr instead of panicking.
   Everything is implemented on linux.
 - redox itself also compiles without any `unimplemented!()`s
 - openssl compiles with [sajattack's WIP
   netdb](https://gitlab.redox-os.org/redox-os/relibc/merge_requests/156)
   changes. Have yet to test runtime, but I expect a lot of things will
   ultimately fail.
 - dash and bash both compile and work! This is a pretty exciting goal because
   that means we are actually testing programs that people use in practice.
   Compiling bash requires some changes to the autotools configs, which for
   some reason doesn't detect that we have all the features. See [this cookbook
   branch](https://gitlab.redox-os.org/jD91mZM2/cookbook/tree/relibc)
 - ffmpeg compiles and works! This is not too surprising considering it
   shouldn't be too platform-specific, but it's always a good test! Didn't have
   png support initially, but I'm not sure it did that on newlib either. [It
   does now!](https://gitlab.redox-os.org/redox-os/cookbook/merge_requests/171)

## Epilogue

I'll need to come back and fix openssl after the project is over, but I'm happy
that we got so many things compiling! It shows that relibc isn't as far off of a
reality than I thought. Before I began this project I honestly didn't think it'd
take off anywhere, and definitely not compile redox. But now it does compile
redox and even bash inside it!

I'm a little annoyed by relibc' use of cbindgen, even though it's nice having
the headers be automatically generated, it's a little backwards since we should
write functions that adapt to them, not the other way around. It also forces us
to make one sub-crate per header, which leads to a lot of noise, and even worse,
causes a large pile of issues with recursive dependencies that are worked around
by linking in an old C fashion.

More-over, it's not clear what relibc's safety story is. Some relibc functions
are implemented safely. Some use safe Rust things, like slices, but in an unsafe
way. Some just use unsafe things like raw pointers directly. I lean towards the
latter when writing personally, because it is faster to be unsafe and don't look
up the length first. But I'd very much like to see one day where the only
unsafety in relibc is wrappers around inner, safe, functions. This unfortunately
doesn't make a lot of sense for platform-specific functions because Linux does
require pointers and stuff, so having a safety wrapper is just redundant. It
also requires us to restructure it a lot if we want to keep things clean.
