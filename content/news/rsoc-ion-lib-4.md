---
title: "Rsoc: Ion as a Library, week 5"
date: 2019-07-07T11:17:42-04:00
author: "AdminXVII"
---
# Wrapping up the Ion as a library project
## What is Ion
Ion is a fast, modern shell. Its powerful yet simple syntax almost eradicates the need for GNU's coreutils, by providing integrated, super-fast _methods_. With the methods providing native speed and modern features like non-forking expansion, Ion beats Dash in terms of performance in a wide variety of scenarios.
Features like exiting with error on command not found, invalid expansion and explicit typing in function signatures, as well as using Rust as its base language means a whole host of user and application errors simply can't happen, which POSIX shells lack.
Ion takes the Rust's promise for fast, simple, secure programming and introduces it to the world of shells.

## The work done as part of this project
It is now possible to embed Ion in any Rust application. Ion takes any Read instance and can execute it (so yes, it is possible to run Ion without ever collecting the script's binary stream). It takes care of expanding the input and managing the running applications in an efficient manner, with a comprehensive set of errors.
Ion is now the rust-based, pipe-oriented liblua alternative.

# This week's progression
## Summary of the work done
 - Create a concrete example of the Ion API with an alternative to GNU's parallel. See section below
 - Refactor the calc builtin's input methods
    - Use liner for interactive input for better control support
    - If stdin is not a tty, don't print the interactive help text & input
 - Improve the shell options
     - Use a more descriptive name for the option to control the tty
     - Remove configuration related only to the interactive shell
 - Give users more control
     - Add callbacks for background pipeline events
     - Add support for default shell redirection
 - Add metadata to prepare for a release to crates.io
 - Reduce blocking forking (see section below)
 - Improve testing
    - Add the cracauer shell test suite for proper error handling
    - Use xargs to run all tests in parallel
    - Only test for the cli parameters in the CI, not with the default test method
 - Misc
    - Improve the interactive completion
    - Generate man pages for the builtins automatically, as well as the builtin page in the Ion Manual

## Performance improvement: non-forking sub-shell expansion
During shell expansion, it is quite common to deal with sub-shells (e.g. `echo $(echo a)`). Dash and Bash's way of doing it is forking the shell and redirecting its output to a pipe. The problem is that forking can be quite time-consuming, and the main process is effectively blocked, making the fork absolutely not useful.
For example, given the subshell expansion for `echo $(echo a)`, this is the two timelines:
Bash:
 main process:   | part of expansion | forking | waiting           | rest of expansion |
 expansion fork:                     | forking | executing builtin |

Ion:
 main process:   | part of expansion | executing builtin | rest of expansion |

Forking is quite cheap on Linux due to copy-on-write paging, yet it is still cheaper to not fork at all.
Another problem is that, in POSIX shells' case, the main process will be periodically woked-up to read partially the expansion's output. Since there is nothing to do with this read until the pipeline exits, this means the process keeps taking CPU time where it should not. Ion in contrast lets the pipe fill up and only read once, at the end of the pipeline execution, leaving your CPU in peace.

With a more down-to-earth approach, this means
```ion
for _ in {0..10000}
  echo $(echo a) > /dev/null
end
```
now executes 25x faster than it did on a Galago Pro 3 with i7-8565U (turbo disabled). It is also 10x faster than the dash equivalent, and 30x faster than bash's.

## Ion as a library's first useful application: Redox's Parallel
The first application based upon Ion as a library has now been created! Redox's Parallel is an alternative to GNU's one, with a more ergonomic and faster shell at its core. It is already usable and released as a beta version. You can check out the code at https://gitlab.redox-os.org/redox-os/parallel (GPL).

## The next steps
 - Once alpha testing phase is done, release to crates.io
 - Improve expansion by reducing allocations
 - Adapt more tests from the cracauer test set, and automate them
 - Create non-forking function execution
 - Explore the possibility for non-forking builtins
 - Adapt the nix crate for redox use, or move away from it
