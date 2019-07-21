---
title: "Rsoc: Improving Ion's UX, week 1"
date: 2019-07-015T17:58:24-04:00
author: "AdminXVII"
---
# Adding Nix support for Redox (not yet merged)
The libc crate was updated to use all the latest functionalities from Redox OS & Relibc ([PR](https://github.com/rust-lang/libc/pull/1438)). In the process, a patch was proposed to nix to support Redox OS ([PR](https://github.com/nix-rust/nix/pull/1098)). This means a whole host of applications that used nix will work out of the box on Redox OS! (A dependency upgrade will still be needed)

# Summary of the work done
 - Add a return keyword for exiting functions with a code
 - When disowning a process, redirect stdout & stderr to /dev/null
 - Reduce lock contention on ctrl-c
 - Fix a bug where the command expansion wouldn't reset the default pipes when an expansion error occured. Thanks to aleksator for filing the bug and helping me find the culprit.
 - Bring back compilation on Redox by adding Nix (the crate, not the distro) support for redox

# The next steps
 - Add plugins
 - Add user-defined autocompletion
 - Improve expansion by reducing allocations
 - Adapt more tests from the cracauer test set, and automate them
 - Create non-forking function execution
 - Explore the possibility for non-forking builtins
