---
title: "RSoC Project: Ion as a library, week 2"
author: AdminXVII
date: 2019-06-16T11:01:32-04:00
---

# Keyword of the week: Error bubbling

## Summary of the work done
 - Use enum types to represent error rather than strings
 - Use the `err_derive` crate to implement easily the required traits for error types
 - Indicate the cause of errors for easier debugging
 - Exit the script on the first programmer error (wrong function signature, invalid expansion, assignment error), rather than leaving "magic" happen
 - Separate parsing & expansion to make it easier to swap in nom
 - process::exit is no more used in the library to make everything more linear

## Plan: Testing tendrils
### Current state & the small string optimization (SSO)
Ion now uses small::String to store string data types. It's an alternative String types that use SSO to achieve better performance than the std one with typically small strings.

In Ion's real world usage, strings tend to be fairly short (~ under 20 chars). The small string optimization is a technique where a string is a tagged union containing either a pointer to a heap string (like the one provided by the stdlib) or a stack-based array which is typically faster since it's stored with the containing datastructure that's already in a cache line. According to previous benchmarks, the switch to small strings gave Ion a 30% speed bump.

### The alternative: [tendrils](https://github.com/servo/tendril)
Tendril is an alternative "compact string/buffer type, optimized for zero-copy parsing". It combines the small string and copy-on-write optimizations, possibly providing another performance boost.

## What's left to do
 - Finish using error types in expansion
 - Documentation
 - Examples
 - Add background jobs callbacks
 - Add option to provide custom files for default standard pipes
 - Release or remove members to be able to publish on crates.io
