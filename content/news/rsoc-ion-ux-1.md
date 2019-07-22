---
title: "Rsoc: Ion as a Library, week 5"
date: 2019-07-21T12:12:30-04:00
author: "AdminXVII"
---
# Keyword of the week: plugins
## Summary of the work done this week
 - Converting 36 plugins from the Oh-My-Zsh repo to Ion's syntax. Aliases and functions are provided as one-on-one conversion from the zsh alternative to provide a smoother inboarding experience.
 - Creating a auto-documenting gitlab pages website to help users select plugins and making the experience as straightforward as possible.

## Converting the plugins
Userland plugins are great tools to make the user's workflow faster with a near-zero onboarding involvment. They allow users to have commands tailored to their workflow without much involvement from the shell and without impacting the maintainability of the rest of the system. As such, it is really a must have for a pleasing interactive shell.

Ion has now its own official repo for userland plugins! [Ion-plugins](https://gitlab.redox-os.org/redox-os/ion-plugins) aims to provide a simple, opt-in, centralized set of components to improve Ion's interactive UX. 36 plugins taken from the great [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) repository are already converted to Ion's syntax and more are on the way (since Ion does not currently has command autocompletion, only aliases, functions and startup scripts are converted).

## Auto-documenting plugins
When choosing plugins, users want to know what is provided. They also like to have this info without having to open two webpage to access each plugin's README. On the other side, it's quite a hassle for contributors to have to update the README after each update.
Ion-plugins has the solution! After each commit, the aliases and functions are extracted from the source code of each plugin, along with the top-most comment for describing the plugin. With this info collected, a [global documentation webpage](http://redox-os.pages.redox-os.org/ion-plugins/) is generated, providing users with all the info needed and sparing contributors from the boring work of copying info from the source to the man page.
Lastly, users can select the plugins they want and the configuration needed is automatically generated. This does not mean the configuration is complex, quite the opposite. Everything is based upon a simple sourcing, making the core working of the plugins obvious. Simple, standard means for powerful deeds.
