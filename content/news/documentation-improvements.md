+++
title = "Documentation Improvements - FAQ, Book and GitLab"
author = "Ribbon"
date = "2023-07-13"
+++

In February I decided to contribute to Redox after following it since 2016, as an obvious movement I tried to build Redox on my Fedora and had an error with NetSurf recipe compilation (fixed when I installed the Vim package), as I didn't know how to customize the Redox build system, I used Podman and it was very slow for a unknown reason (very boring to my testing workflow).

After some time I learned how to customize the build system, removed the NetSurf recipe and the build finished without an error.

The book was not clear/complete and a FAQ was not available, then I decided to improve this as my first contribution to the Redox project.

Thanks Ron Williams, Jeremy Soller and 4lDO2 for your help with my questions.

## FAQ

Every project should have a FAQ for newcomers, it ease their life a lot and brings more interest to the project as the questions are satisfied.

Redox lacked one for years, probably because the developers were busy with the code, then I decide to create one.

I wrote the FAQ in a way that even Unix/Linux newcomers can understand, it's similar to the BSD system FAQs and wikis.

- [FAQ](https://www.redox-os.org/faq/)

(I maintain the Portuguese translation too)

## Book improvements

(The book cover the high-level documentation and not the code APIs, read [this](https://doc.redox-os.org/book/ch11-02-writing-docs-correctly.html) page to understand)

Some parts of the book were outdated for years because the developers were busy with the code, Ron Williams improved it since the end of 2022 and I continued where he left.

95% of the book was improved and new pages were crated by me to improve the organization, hundreds of hours of work and thousands of lines changed (Me and Ron are deciding how to organize it properly, we both agree that the book must hold cold information while the website hold the hot information).

Like the FAQ, I decided to document the Redox in the most easy way possible with workflows/methods that cover most use cases in the development.

(I'm the current book maintainer)

A non-exaustive list of my improvements:

- Several fixes on formatting
- All global hyperlinks converted to local ones

    - Global hyperlink example

    ```
    [link]

    [link]: link here
    ```

    Global hyperlinks are sensible to typos and more time consuming to organize, thus more error-prone.

    - Local hyperlink example

    ```
    [link](link-here)
    ```

    More simple, less typos.

- Several fixes on Markdown code formatting
- [The build system was completely documented](https://doc.redox-os.org/book/ch08-06-build-system-reference.html)
- [The package manager was documented](https://doc.redox-os.org/book/ch02-08-pkg.html)
- [The Cookbook recipe system was completely documented](https://doc.redox-os.org/book/ch09-03-porting-applications.html)
- [All Cookbook templates documented](https://doc.redox-os.org/book/ch09-03-porting-applications.html#templates)
- [Most Cookbook custom template scripts documented](https://doc.redox-os.org/book/ch09-03-porting-applications.html#custom-template) - more will come.
- More troubleshooting options
- Added a way to update the toolchain
- Software porting process was documented
- Manual configuration of Podman was documented
- [RedoxFS was documented](https://doc.redox-os.org/book/ch04-08-redoxfs.html)
- [The microkernels explanation was improved a lot](https://doc.redox-os.org/book/ch04-01-microkernels.html)
- [A high-level explanation of the kernel was created](https://doc.redox-os.org/book/ch04-02-kernel.html)
- [A high-level explanation of the userspace was created](https://doc.redox-os.org/book/ch04-06-user-space.html)
- [A high-level explanation of the Redox graphics/windowing system was created](https://doc.redox-os.org/book/ch04-09-graphics-windowing.html)
- [A high-level explanation of the Redox security](https://doc.redox-os.org/book/ch04-10-security.html)
- [More side projects were documented](https://doc.redox-os.org/book/ch01-07-side-projects.html)
- [All crates were documented](https://doc.redox-os.org/book/ch08-06-build-system-reference.html#crates)
- [More configuration options were documented](https://doc.redox-os.org/book/ch02-07-configuration-settings.html)
- [Coding and building workflow documentation was improved a lot](https://doc.redox-os.org/book/ch09-02-coding-and-building.html)
- [Bug reporting was improved a lot](https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html)
- [Merge request workflow was improved](https://doc.redox-os.org/book/ch12-04-creating-proper-pull-requests.html)
- [A branch-based workflow was documented](https://doc.redox-os.org/book/ch12-06-branch-workflow.html)
- [The Chat page was improved](https://doc.redox-os.org/book/ch13-01-chat.html)

## GitLab

I improved some documentation of the GitLab repositories too, generally this information is moved from the book or duplicated for easy access.

A non-exaustive list of my improvements:

- [CONTRIBUTING was cleaned/improved a lot](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md) - it was very old.
- [redox README was cleaned/improved a lot](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/README.md)
- [All drivers were documented](https://gitlab.redox-os.org/redox-os/drivers/-/blob/master/README.md)
- [`redoxer` README was improved](https://gitlab.redox-os.org/redox-os/redoxer/-/blob/master/README.md)
- [Added a command to kill all QEMU processes after a kernel panic](https://gitlab.redox-os.org/redox-os/kernel/-/blob/master/README.md#notes)