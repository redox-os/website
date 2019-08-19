---
title: "Rsoc: Improving Ion's UX, week 5 and 6"
date: 2019-08-18T19:32:13-04:00
author: "AdminXVII"
---
# ShellAC: Autocompleting Git in 500 μs
A demo file for git completion was created as a POC for Shellac's capabilities. It in fact outperforms all my expectations: it is able to autocomplete git (except for branches, which requires to spawn a process) in roughly 500μs, including transmission over sockets! (The computer used to run the tests is a S76's Galago Pro 3 with I7-8565U, balanced mode). This is truly promising to allow as-you-type completion!

## Calling external commands
The Shellac POC now supports calling 3rd party commands, like `git branch` to get completion. It presents the shell with a command to run and a prefix to remove from the output (typically, a user can have typed `Ca` and want `Cargo.toml` and `Cargo.lock`). A preliminary version called commands inside shellac, but this was deemed to put unwanted security implication on shellac, opened the door to weird bugs (what if the PATH is changed inside the Shell?), and negated the possibility of using interactive completion (think FZF for file completion). Since shells should already be well equipped to run executables, this should not be too big of a problem.

## Integration with Ion
A preliminary integration with Ion was successfully tried (see [the related WIP MR](https://gitlab.redox-os.org/redox-os/ion/merge_requests/1157)). This means git can be currently (really basically) autocompleted inside Ion! The support is however quite low and I'd like to improve the features before proposing it as a real MR. For example, aliases are currently not supported, and neither is expansion. Still this is a big step toward achieving command autocompletion in Ion and is super exciting!

## RFC: Subprocess expansion
What should Ion do to autocomplete an argument with a subprocess inside of it. One could run the subprocess and cache the output, but that could cause unwanted side-effects. On the other hand, without knowledge of the subprocess expansion, it is impossible to propose reasonable suggestions in most cases.

A proposed idea would be to treat an ASCII control character specially within Shellac. For example the bell would mean unknown expansion, and the suggestions would match it as a wildcard. This seems however a bit hackish.

# Rustyline
Another experiment conducted this week was to replace Liner with Rustyline. Liner has no more an active maintainer, and still has some unfixed bugs. Switching to Rustyline might have a lower overhead in the long run than to fix the bugs. It also seem to have a bigger feature set, and still growing. All functionalities that Liner had were successfully replicated with Rustyline. A downside is the lack of a circular list completion type currently in Rustyline, but I'm confident it can be implemented pretty straightforwardly. An upside however is the fact that Rustyline checks for color support. Since Ion might want to have syntax highlighted prompt, this could be a noticeable plus for compatibility in some rogue setups.

# Relibc: fixing signals
A critical bug was fixed in relibc ([link][relibc patch]): an invalid memory reference in signal-related functions.

The bug can be simplified as
```rust
fn invalid(value: Option<Value>) {
  let reference = value.map_or(core::ptr::null_mut(), |v| &v as *mut _);
  // some work
}
```

The problem is that when `map_or` is called, value is moved, and the pointer is instantly invalid.Pointers are dangerous!

On the bright side, this means that relibc has now full support for signals!

# Libc: sys/termios.h
Rustyline required termios functions. To make it possible a new [PR][libc patch] was pushed to the libc repo with support for the sys/termios.h functions and constants.

[relibc patch]: https://gitlab.redox-os.org/redox-os/relibc/merge_requests/239
[libc patch]: https://github.com/rust-lang/libc/pull/1471
