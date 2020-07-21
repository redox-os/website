+++
title = "Cross-compiling to Redox using Nix"
author = "Aaron Janse"
date = "2020-07-20T12:00:00+05:00"
+++

<img class="img-responsive" src="/img/screenshot/nix-build-hexyl.png" alt="Cross-compiling a package to Redox using Nix" />

# Introduction

Nixpkgs recently merged [PR #93568](https://github.com/NixOS/nixpkgs/pull/93568), allowing the Nix package manager to cross-compile packages to Redox.

As expected, few of Nixpkgs's 60,000 packages cross-compile to Redox without failing. I've created [redoxpkgs](https://github.com/aaronjanse/redoxpkgs), a wrapper around Nixpkgs to fix broken packages, with the hope that some patches will eventually be adapted upstream.

Nix has several properties that make cross-compiling to Redox pleasant. First, Nix reproducibly compiles packages, meaning that if a build works on my system, it should work on yours, too. Second, Nix allows porting packages en mass. A single change to a toolchain package could make a large number of packages suddenly compatible with Redox. Or, if needed, a patch could be automatically applied to the build process of every package of a given language being cross-compiled to Redox.

To get started, after installing Nix, simply checkout the Redox overlay (linked above) then run `nix-build`, specifying [which package](https://nixos.org/nixos/packages.html?channel=nixpkgs-unstable) you want to cross-compile:

```bash
$ git clone https://github.com/aaronjanse/redoxpkgs
$ cd redoxpkgs
$ nix-build . -A hexyl
```

At the time of writing, few packages have been ported, but I hope to change that over time.

I plan to eventually setup a small Nix package cache for Redox. In the meantime, expect your first build to take a long time as Nix builds the Redox toolchain from source.

# Going Forward

The future of Nix and Redox depends mostly on reception by the respective communities and how well the two systems work together long-term. It would be cool to port Nix to run on Redox itself so that packages can be built and installed on Redox rather than cross-compiled then copied from a Linux machine.

In theory, if enough packages are ported, the Redox ISOs themselves could be declaratively compiled using Nix. In the meantime, though, I plan to focus my efforts elsewhere, dogfooding my Nix toolchain as I continue to contribute to Redox.

