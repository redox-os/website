---
title: "Rsoc: Improving Ion's UX, week 4"
date: 2019-07-28T18:26:35-04:00
author: "AdminXVII"
---
# Autocompleting under 1ms
Ion's implementation of the shellac server has begun (for more info about Shellac, see [last week's post](https://www.redox-os.org/news/rsoc-ion-ux-2/))! This post will detail the implementation's decision for the POC being written.

## Influences
The implementation is heavily inspired upon linear-time regular expression engines, and more specifically Pike's VM. A great, detailed description about both subjects can be found at https://swtch.com/~rsc/regexp/regexp1.html and https://swtch.com/~rsc/regexp/regexp2.html.
To make it quick, for validating the string, a program is decomposed into a list of 4 types of operation: jump, split, check and match. Jump jumps to another location, split creates a new branch for a possible match, check would, in a regex case, validate if the next character matches the expected one, else it removes the branch from the set of possible match. Match lastly indicates that the string matches. The VM proceed in locksteps, so each check is performed upon the same character at once, in a streaming fashion.

## The implementation
The main difference between a regex engine and the shellac server is that where the regex would match a character, shellac matches a value inside `*argv`. Checks either validate if a given arg matches a regex, or if it is found inside a set of acceptable arguments. The argument to autocomplete is skipped and saved for possible expansion at the end. After every possible branch has been checked and the few possible cases extracted, the argv to autocomplete is checked for potential match and is expanded to all arg values that would make the argv acceptable for the description.

## The problem of argument ordering branching blowup
A common pattern for command line binaries is to have options that are optional and can be placed in any order. In practice, this means the number of potential branches to test blows up. For example, `binary [options] <arg1>` with opt1, opt2 and opt3 that can only appear once each would need to be converted to `<nothing>|opt1|opt2|opt3|opt1 opt2|opt1 opt3|opt2 opt1|opt2 opt3|opt3 opt1|opt3 opt2|...`, and insane amount of branches for a super small binary (Sum\_{k=1..n} n!/k! to be precise). This would trash performance if nothing was done to circumvent the problem.

The solution is to make each thread of the VM carry a set of counters. Each `test` operation has the ability to check and update the thread's counters (this technically means the engine is no longer regular). That way, opt1, opt2 and opt3 can each have their own counter, and the 16 branches can be reduced to (opt1|opt2|opt3)*, only 4 (1 per option + 1 for the loop). No need to say that the more options there is, the better this technique becomes.

## The problem of argument grouping
In the original syntax proposed for shellac, Oliver Kiddle proposed full argument matching. This however does not work well for grouped arguments (like for GNU style binaries, where `-a -b -c` can be shortened to `-abc`). Either it is necessary to test too many cases, or the engine must lose generality.

The proposed solution is to match capture groups. For example, short arguments are defined as /-([a-z])+/ and each and every captured character is checked against the set of valid options. This makes it easy to define grouped arguments without losing generality.

## The work done this week
There is a working engine for matching definitions and suggesting autocompletion. In terms of performances, the engine is able to give propositions in under 1 ms (900 μs on average) on a Galago 3 with turbo disabled. Without being the final picture, this is really promising. The parsing of definition files likely will be relatively fast (> 100μs), so it won't slow down much the process much. On the other hand, no caching mechanism is currently implemented. Since the bulk of the time taken is spent compiling regexes, and that most CLI uses the GNU standard and thus share the regex used for their options, an important speedup is to be expected. Moreover, real-time autocompletion likely would use the same definition files over and over, so using some kind of caching datastructure should make autocompletion even faster. This means as-you-type completion could even be possible on low-end computers with almost no delay visible to users. That's truly encouraging for shellac!

## Request for comment: shell-shellac protocol
Currently the plan laid out by shellac was to use a hand-rolled protocol for requests. This seems fragile because of the variety of shells each going to implement their own parsers with their own assumption. It also seems less resilient to change, backward-compatibility is hard to get right by hand. This will either force the server to be updated in sync with the shell, which is a bit of a hassle, or will stall development of shellac to avoid any kind of change. Lastly this will add more overhead to new shells wanting to switch to shellac, since they'll need to implement their own parsers for the protocol.

A possibility would be to use something like protobuf or cap't'n proto to fix the problems mentioned above. There is a wide variety of languages implementing both, so the cost to get started with shellac should be fairly minimal. Since the protocol is already clearly defined and is well tested, the chances for quirks across parsers should be fairly minimal. Lastly, those are optimized for forward- and backward-compatibility, so version compatibility would be greatly improved.

Performance is also pretty good for cap't'n proto, so the switch to buffer protocols should not be at the expense of the server's communication speed.

# Issues fixed and upgrades done this week in Ion
 - Fix a panic with a buggy SIGPIPE handler that required a stdout/stderr lock
 - Fix a bug where popd would only update the internal directory stack without changing the current directory.

