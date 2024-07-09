+++
title = "This Month in Redox - July 2024"
author = "Ribbon and Ron Williams"
date = "2024-07-31"
+++

July was a very exciting month for Redox! Here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Web Servers

We successfully compiled and executed the first web server on Redox!

[Simple HTTP Server](https://github.com/TheWaWaR/simple-http-server) is an advanced HTTP web server written in Rust, the contributor lgh-127001 successfully served a website.

He is also improving the Apache HTTP Server port.

## Relibc Improvements

The contributor Derick Eddington fixed four incorrectness bugs on relibc.

## Driver Improvements

bjorn3 improved the driver development using our recipe system, now developers will have less problems to test their changes inside of Redox.

## Programs

bjorn3 converted the Orbital recipes to TOML, fixing the "desktop-minimal" variant.

Ribbon converted more recipes to TOML to remove obsolete and broken code from our package system.

More exciting Rust programs were packaged as usual.

## Documentation

A list of the Ribbon's improvements this month:

- Now the book recommend the [Gentoo](https://gentoo.org) package documentation for dependency configuration on recipes, it's because the Gentoo package documentation is very rich and advanced on feature flags, dependency classification and cross-compilation.
- The "Weekly Images" section was renamed "Daily Images" on the "Running Redox in a virtual machine" and "Running Redox on real hardware" pages, it was called "weekly" because breaking changes stopped the image update for weeks, but they are configured to be created daily.
- Some sections of the website FAQ were copied to the book, it improved the reading and information distribution (more easy to find).
- The "Scripts" section on the "Build System" page was improved, he added a command to sort in alpahbetical order the output of the include-recipes.sh script, it will save time from packagers adding recipes to the package build server configuration.
- Now the website and book READMEs recommend the [lychee](https://lychee.cli.rs/) tool to verify broken links
- Now the website READMEs has instructions to install [Hugo](https://gohugo.io/)

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).
