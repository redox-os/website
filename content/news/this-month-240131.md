+++
title = "This Month in Redox - January 2024"
author = "Ron Williams"
date = "2024-01-31"
+++

This is the first in hopefully a regular series of posts about the progress we have made on Redox this month.
We have been remiss in keeping you up to date on our progress, but this is an attempt to improve the situation.

Since the [last news post](/news/rsoc-2023-wrapup) on our progress, there have several major accomplishments and many smaller ones.
Forgive us if a few are left out.

## Request for Donations

With all the exciting accomplishments of our contributors,
it's hard to believe that Redox is getting by on only a few hundred dollars per month in donations.
Our goal for this summer is to find funding for 3 or 4 Redox Summer of Code projects,
which will require as much as $22,000 in new donations.

If you are able to help us out, you can donate on [Patreon](https://www.patreon.com/redox_os) and [Donorbox](https://donorbox.org/redox-os).
Or for more donation options, please contact us at [donate@redox-os.org](mailto:donate@redox-os.org).

## New Board Member

The Redox OS Board of Directors is elected annually, and this month we had our 2024 elections.
We would like to welcome our newest board member, Jacob Schneider.

<a href="/img/board/jacob-schneider.jpg"><img style="width:256px;height:auto" src="/img/board/jacob-schneider.jpg"/></a>

*"Jacob (JCake)'s portfolio stretches back over a Decade. Having begun with Windows Batch of all things, his fascination only grew. In this time, the desire to get to the absolute lowest levels of our modern tech stack has only grown stronger.*

*Jake found his feet in the world of Linux and other OSes a while back, and as his curious nature would have it, drove him to explore even more. Eventually stumbling on Redox, utter fascination to explore every crevice of it entirely took over. Jake now finds himself neck-deep in the most exciting project in the world."*

Bios for the rest of the board are in our [summer announcement](/news/board-meeting-2023-06-21).

## Logo and T-Shirts

We recently refined our logo, which you can see in the screenshot below
and on [our T-Shirts](https://redox-os.creator-spring.com/).
The logo shows up a little pixelated on the Teespring website, but it looks great on the actual shirts.

We also have [new T-Shirt colors](/news/t-shirts-fundraising) this month.
Every purchase contributes approximately $14 towards Redox development and operations.
Your contributions are appreciated.

We will continue updating our website and other graphics to use the new logo over the coming weeks.

<img src="/img/screenshot/redox-logo.png" class="img-responsive" alt="Redox Logo">

## Technical Accomplishments

## Redox Path Format

Redox has a microkernel core, with drivers and other resource providers running as tasks and providing "schemes".
A scheme is the name of a resource provider, and until now,
resources have been accessed using [URI/URL format](https://en.wikipedia.org/wiki/Uniform_Resource_Identifier#Syntax).
For example, files would be accessed as `file:path/to/my_file`, and a TCP connection would be accessed as `tcp:127.0.0.1`.
This format, while forward-looking, has not been very backwards-compatible.

In order to simplify our efforts to port Linux software to Redox, we have decided to change our resource path format to the Linux-compatible
`/scheme/scheme_name/path/to/resource`.
Paths that do not begin with `/scheme` will be assumed to refer to the `file` scheme,
so `/path/to/my_file` is treated by the system as `/scheme/file/path/to/my_file`,
but the application will only see the `/path/to/my_file` portion.
Using this format, normal paths now look just like Linux paths,
while drivers and other resources can still be addressed without breaking software.

The implementation of this change has started, and the kernel and our `relibc` implementation of libc can translate between
formats quite transparently.
Applications and schemes are being updated as we get to them, so you may notice a few warts,
but the essential part of the change has been completed and the system is performing well.

## Raspberry Pi

Redox runs on Raspberry Pi 3 Model B+! Thanks to Ivan Tan, Redox can run our `server-minimal` configuration on the RP3B+.

Ivan has also helped us revamp our build system so it can handle multiple RP models, each with their own hardware configuration.

## Kernel and Driver Improvements

I want to particularly highlight the contributions of Bjorn3.
He has been zipping around fixing stuff like Spock at the end of TOS S3.E11.
Major items include rework of the PCI driver, several fixes and some clean-up in the kernel, and improvements to the build system.

## Relibc

A shoutout to Darley as well, he has has been making major progress on our libc alternative, `relibc`.
He has completed the upgrade of our `malloc` code to a port of `dlmalloc-rs`.
Our previous `malloc` code was written in C, and has now been completely removed.

Darley has also been working hard on Rust implementations of `libm` and `libcrypt`, and has implemented several new `libc` functions,
including some wide-char string functions and some pseudo-terminal handling functions.

## Stable ABI

As we work towards a stable ABI, 4lDO2 continues removing code that directly uses the `redox_syscall` crate.
The new stable interface is `libredox` for Redox-specific Rust code and `relibc` for everyone else.
This allows us to change the implementation of our current system calls, for example, moving functionality into user space,
without changing the API.

Once we have a stable API, we can focus on the next step, which is a stable ABI provided through dynamic linking
against `relibc` and a `libredox` library.
Dynamic linking on Redox is not ready for prime time, but it should only be a matter of finding the time to get it done.

## /dev/tty

With a little bit of `relibc` trickery, we have made it so `/dev/tty` refers to the process's terminal.
That may not sound like a big deal, but since most TUI libraries rely on `/dev/tty` to get the terminal's properties,
it has greatly improved our compatibility with libraries like `crossterm`.
In fact, we are now able to discard our `crossterm` fork and use the upstream version directly.

## Porting

Our ongoing efforts to port Linux software to Redox are starting to pay dividends.
Ribbon has been identifying good candidates to port to Redox, and creating recipes for those apps.
And more and more of them are starting to "just work".
Here are a few of the programs that now run on Redox.

The editors [nano](https://www.nano-editor.org/) and [Helix](https://helix-editor.com/) are now working,
although we have yet to port any of the programming language integrations for Helix.

- [kibi](https://github.com/ilai-deutel/kibi) is a minimalist editor.
- [mdbook](https://github.com/rust-lang/mdBook) `build` is working. `serve` is not yet working.
- [presenterm](https://github.com/mfontanini/presenterm) is a TUI slideshow app.
- [chess-tui](https://github.com/thomas-mauran/chess-tui) is a human-vs-human chess game.
- [hexyl](https://github.com/sharkdp/hexyl) is a hex file viewer.

And many more.

## Cosmic

Jeremy's day job at [System76](https://system76.com/) includes working on various aspects of the [Cosmic Desktop](https://github.com/pop-os/cosmic-epoch).
And when he has time, he is porting some of that work to Redox.
We currently have `cosmic-edit` and `cosmic-files` running on our Orbital Windowing System.

More pieces will be added as Jeremy's time permits.
Special thanks to [winit](https://github.com/rust-windowing/winit/) for its Redox support.

### Cosmic Files

<img src="/img/redox-cosmic/cosmic-files.png" class="img-responsive" alt="Cosmic Files">

### Cosmic Edit

<img src="/img/redox-cosmic/cosmic-edit.png" class="img-responsive" alt="Cosmic Edit">

## Contain

Contain is our sandboxing driver.
In December, a Contain rewrite was completed, giving us much more fine-grained control over what files a user has access to.

Contain allows us to run applications in a modified namespace, where only specific files and directories are accessible.
It currently can only run as root, as namespace modifications require root permission right now.
But it can be used with login to create a restricted user shell,
and we hope to use it with our web server when we have one ready.

## Build System

We've added several new features to the build system, including:

- speeding up cloning Redox
- making it easier to produce either "debug" or "release" versions of Cargo programs
- optionally making errors non-fatal when building large numbers of packages
- making RUST_BACKTRACE more useful

## Documentation

Ribbon continues to add to and improve the [Redox Book](https://doc.redox-os.org/book/), including a [Developer FAQ](https://doc.redox-os.org/book/ch09-07-developer-faq.html) to help guide new contributors,
and a [comparison of Redox features](https://doc.redox-os.org/book/ch04-11-features.html) vs other Unixen.

## Looking Forward

There's still lots to do, but every week Redox feels more like a real system.
We are rounding out areas of work for our summer projects, assuming we can find the funding.
Some key areas of interest for the summer are:

- Redox as a web server
- USB/HID support
- performance profiling and improvement
- more and better automated testing
- more porting of Linux apps and building out relibc and kernel compatibility features

We are super appreciative for all our contributors and the hard work they are putting in.
Consider joining in the fun on our [Matrix Chat](https://doc.redox-os.org/book/ch13-01-chat.html)!