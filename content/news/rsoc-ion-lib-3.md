---
title: "Rsoc: Ion as a Library, week 4"
date: 2019-07-01T22:19:56-04:00
author: "AdminXVII"
---
# Keyword of the week: Documentation

## Summary of the work done
 - Add a procedural macro to document the builtins
    - Generate a rustdoc comment with the man page and the short description
    - Wrap the functions with check for help pages
    - Move all the builtins to the proc macro
    - Add AUTHORS and BUG sections to the man pages automatically
 - Develop the builtins tooling
    - Make the builtins return a &mut reference for chaining
    - Add a conversion from boolean and add the FALSE and TRUE constants for Status
 - Document the API
    - Document every external type defined for rustdoc
    - Deny adding a public item without documentation
    - Add a man page for the `fn`, `help`, `dir_depth`, `wait` and string-related builtins
 - Add API examples
    - Move the integration tests to the tests folder to make room for examples
    - Add a basic demo of the usage of the Shell API for reactive configuration based on a dummy piston example
 - Safer & cleaner internals
    - Move to nix for safer abstraction over c functions
    - Add generics to avoid mixing pre- and post-expansion pipelines
    - Apply clippy in pedantic mode
    - Move parsing to the FromStr trait rather than custom functions
    - Use generics with range parsing
 - Misc
    - Merge the `type` & `which` builtins
    - Command not found is now an unrecoverable error
    - Add a pre-command callback
    - Make function execution cheaper by avoiding cloning
    - Add support for Ion as a login shell
    - Truncate output files when not appending

## What needs to be done
 - Adding callback for background jobs
 - Adding default stdin & stdout
 - Release of members to crates.io to make it possible to release ion
