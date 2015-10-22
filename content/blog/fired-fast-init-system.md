+++
author = "Łukasz Niemier"
date = "2015-10-06T16:42:56+02:00"
title = "fired - fast init system"
+++

`fired` is brand new init system created for Redox OS. It should provide easy
way to run, manage and supervise all processes inside Redox.

## Design principles

Main design principles are:

- Learn from other init systems what to do:
  + simple and readable configuration files instead of bloated shell scripts (we
    want to use [Toml][toml] as configuration language)
  + keep PID 1 minimal as possible
  + run services in parallel
- Learn from other init systems what not to do
  + be *NIX way, make one thing and do it good
  + depend on kernel only
  + do not bind to "only one true" libc

Most of the features will be possible due to unique Redox design principle that
[everything is an URL][url]. Thanks to that principle logging will be done via
`log://` URL that will be easy readable by any log aggregating tool that one
wants, deaemons will provide their status via `bus://` URL (or similar, design
process is still on the go), etc. On the other hand it will make `fired` much
harder to port to other *NIX platforms, although we will be really happy to see
if there is someone who will help us creating that possible.

## Why not existing one?

- We are writing Redox kernel in Rust, so why we should use C in user space? We
  want all system tooling to be as safe as possible in Rust.
- All existing init systems are write for systems with other design principles.
  In Redox everything is URL so we should use that. Instead of sockets/pipes
  magic we have built in tool that will solve all problems with IPC.
- Nothing what we found is simple enough or modern enough to fit into our needs.

[toml]: https://github.com/toml-lang/toml
[url]: https://github.com/redox-os/redox/wiki/URL
