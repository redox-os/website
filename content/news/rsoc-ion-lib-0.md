---
title: "GSoC Project: Ion as a library, week 1"
author: AdminXVII
date: 2019-06-01T21:26:25-04:00
---

# Keyword of the week: Reorganisation

## Summary of the work done
 - Keep only what's related to the library in the lib directory
   - Move the interactive binary-specific code out of the library
   - Move the scopes data structure into a sub-crate
 - Change the visibility of structures
   - Make sure all builtins can be reproduced without special access
   - Use wrappers instead of direct access to the fields
   - Use an internal trait for the expander methods to forbid direct access to the internals
   - Deny access to the sys crate, the background jobs and the pids
 - More security
   - Remove panics in the bool builtin
   - Remove unsafe from the liner completer
 - New liner API

## What's left to do
 - Use errors instead of logging to stderr directly
 - More documentation
 - Exit on error should break the flow, not exit the executable
 - Provide examples

## Idea to explore: non-forking builtins

Since builtins should not be threat actors, it should be safe to share file descriptors and memory with them. A builtin could thus simply read & write directly from a provided file descriptor, instead of the standard input, output and error. This would first allow to keep the normal level of safety guarantee provided by rust by removing unsafe forking. Second, the usage of threads (and maybe even green threads?) would provide a important speed boost. Feedback on the idea and potential roadblocks would be appreciated.
