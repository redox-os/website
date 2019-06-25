---
title: "RSoC: Ion as a library, week 3"
date: 2019-06-24T23:33:01-04:00
author: AdminXVII
---

# Keyword of the week: dependencies reorganisation

## Summary of the work done
 - Reorganise the members
    - Don't use the pool where possible
    - Move the builtins member to the builtins folder
    - Crate the types-rs crate for dynamically-typed variable
    - Remove the sys crate and add a sys folder instead
    - Make the redox version use libc instead of redox_syscalls directly to centralize the sys
    - Inline the braces member
    - Inline the lexers in the parser
    - Use std::process::Command rather than accessing the syscalls directly
 - Finish using errors in expansion
    - Tilde expansion quits the script on invalid output
    - Command expansion errors can error using a boxed IonError
    - String & array expansion exits on undefined variables & wrong method usage
    - Expansion now only outputs ExpansionError, rather than an IonError
    - Cover more error case (invalid indexes)
    - Force users to implement the methods in Expander to avoid panics on unimplemented methods
 - Start documenting
    - Document the expansion & shell core errors and methods
 - Fix potential panics & misc
    - Remove a trim that was causing expansion to crash if the path prefix remained unchanged
    - Remove a potential deadlock if fg and fix a typo to check for running processes
    - Fixed the exec builtin calling spawn instead of exec
    - Remove allocator annotations, since they are now the default
    - Bring back escaping of files with spaces in it during completion

## Tendril experiment: not worth checking further
During expansion, strings are more built than parsed. Since tendrils had a small, fixed stack-allocated vector and focused on CoW, the improvement simply was not there. The preliminary test showed a regression of ~17% on string-oriented scripts. The idea was thus put aside, as no benefits where in sight

## Release on crates.io: ownership
Under which users should crates be released on crates.io? The current go-to solution seems to be per-user, but this means that if a user stops working for redox, access and possibility to create new releases are lost. An alternative, and in my opinion the best, would be to add all the crates under the redox-os user and add the maintainers to it. That way, ownership remains to redox, as well as access to the crates for releases after a maintainer leaves. How should the Ion members be released?

## What's left to do
 - Documenting the builtins
 - Adding examples
 - Adding callback
 - Adding default stdin & stdout
 - Release of members to crates.io to make it possible to release ion
