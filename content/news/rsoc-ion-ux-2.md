---
title: "Rsoc: Improving Ion's UX, week 3"
date: 2019-07-28T18:26:35-04:00
author: "AdminXVII"
---
# Plans for better autocompletion: Shellac
Ion's biggest missing feature at the moment is proper autocompletion support. It's quite annoying that even day-to-day commands like git can't be autocompleted. The problem is that autocompletion takes a lot of time from the community, so ideally autocompletion for commands should be shell-agnostic.
The solution is creating something akin to a language server. That way, you avoid (mostly) the N ⋅M problem, since you can share the definition files with all the other shells. By creating a server that replies over sockets also means you avoid the time necessary to start up the binary, and you allow caching mechanism. That means lower latency, so increased user experience.
It turns out that someone already has worked on the subject. The Oil shell got in touch with multiple shells including ZSH, Closh, Elvish to create what is to be called [Shellac](https://github.com/oilshell/oil/wiki/Shellac-Protocol-Proposal). This is still an early proposal, but this seems quite interesting for the Ion shell.
The improvements seeked are categorized below.

## Faster gathering of definitions
Adding definitions for every binary is a long process. The problem is that if you don't have good autocompletion, you don't get much userbase. This in turn means that your ecosystem is much smaller, so creating completion is much longer. The cycle is quite bad, and sharing completion with all shells should greatly reduce it.
It should also be easier to generate completion files from man pages, so that means small utilities should be able to provide completion to users a lot more quickly and without having to think about each and every shell out there.

## Fast completion
In Bash and ZSH's cases, completion is done via functions. That is in fact quite slow, since the shell need to interpret everything rather than run in bare metal. There is also the fact that shells tend to call binaries where it should be simple to run it directly in Rust/C. In 99% of the cases, static completion is sufficient and native speed should be expected. For the rest, it should be easy to avoid calling executable unless dynamic completion is needed (ex: git branches). Ideally latency should be minimal as to be unnoticeable on a mid-end computer, where now zsh can sometimes take seconds to complete. If shells can agree to run the shellac server as a daemon and communicate with unix domain sockets instead of standard pipes, the startup cost could even be avoided completely, as well as amortizing of buffer allocations. It should also be possible to implement caching facilities to make it real-time.
No actual implementation exists as of today, but this holds great promises for completion speed.

## Avoiding version skew
When new options for binaries are created, it takes a long time for it to reach the end user's completion system. Since completion is generally provided as third party repo, someone must take care of updating the definition for each shell in those completion collection. A shell agnostic completion facility with a formal grammar means distro could in fact pack the definition with the binary, just like it's man page. That means completion would always be up to date! If there exists tools to convert easily a man page to the grammar, that also means upstream maintainers will be more willing to update it than a manual update. No more version skew!

## Shell diversity
Right now it's hard for shells to get started, because of how much they must implement before gaining a day-to-day userbase. A shell-agnostic completion server allows a greater diversity of shells to start being implemented, which can never be bad. It also means Ion can benefit from the user base of ZSH, Fish, Oil, Elvish _et al._ for developing completion in case the proposition is accepted.

# Issues fixed and upgrades done this week in Ion
 - Update the minimal rust version to build Ion to 1.35.0
 - Follow rust's decisions and replace trim_{left,right} with trim_{start,end}
 - Fix the set builtin
 - Rename the calc builtin to math to avoid interfering with GNU's calc
 - Fix a potential panic
 - Make Ion work for Redox
 - Add an integrated help page for the math (previously calc) builtin

