+++
title = "This Year in Redox"
author = "Ticki"
date = "2016-12-31T14:49:00-07:00"
+++

# This year in Redox

# History

Back in 2009, Jackpot51 wrote SollerOS, which was a tiny operating system which was simply a hobby project of his to learn OS development. It was a tiny kernel written in Assembly, which could print text to the screen.

SollerOS is, in a sense, the precursor to Redox, as it was where the ideas (most of which were never implemented in SollerOS) fundamental to Redox would pop up.

In April 2015, Jackpot51 wrote the first commit of Redox OS.

A lot of time then passed with varying development, and in September 2015, I (Ticki) discovered the project.

The story is a bit odd. I was searching for a name of my project and then found this very neat incomplete OS project. I was instantly hooked with the idea, and I posted it to Reddit.

Only two days after, the project had gained several hundreds of stars and it reached the front-page of /r/programming, Slashdot, and HackerNews.

Quite a few people were interested in contributing, including myself. So we created an IRC channel.

There was quickly several contributors, such as stratact (who is still with us today), tedsta, ambaxter, and many more.

# State of the project

Today, we have a pretty mature project. It contains many core, usable components. It is already usable, but it is still not mature yet to be used as a replacement for Linux (like BSD is), but we're slowly getting there.

The kernel was rewritten, a memory allocator was added, rendering libc out of the dependency chain, several applications were added, a file system were added, a window manager and display server was implemented, and so on.

Today, Redox looks like this:

<a href="https://redox-os.org/img/screenshot.png"><img class="img-responsive" src="https://redox-os.org/img/screenshot.png"/></a>

Basically every component is written in Rust in order to ensure correctness and memory safety of the program (and of course so it's 10x Turing hipster webscale).

## The last few months

The last few months contains several additions:

- The kernel was rewritten entirely.
- The memory allocator's performance was significantly improved.
- There are new programs like games to test the feature of Redox.
- You can access the internet on Redox.

Since the last news blog post, some other things have happened as well:

- [TFS](https://github.com/ticki/tfs) the upcomming default filesystem of Redox is specified and paritally implemented.
- We got a rustc support.
- Jeremy quit his job to work full time on Redox.

## TFS

![Logo](https://rawgit.com/ticki/tfs/master/icon.svg)

So I've been working on TFS. Several new things have been developed since last post.

I created [SeaHash](https://github.com/ticki/tfs/tree/master/seahash), a new non-cryptographic hash function with excellent performance.

I created [MLCR](https://github.com/ticki/tfs/tree/master/mlcr), machine learning based caching.

Futhermore, I implemented ADG dependency write caching.

## Kernel

Jeremy rewrote the kernel with emphasis on correctness. This makes us much better of than previously, where the kernel had major flaws.

The kernel, while not perfect, is looking more complete and robust.

You can read more about the implementation efforts [here](https://redox-os.org/news/this-summer-in-redox-15/).

## Ralloc

I rewrote [Ralloc](https://github.com/redox-os/ralloc/tree/skiplist), the memory allocator, to be based on specialized skip lists, yielding a more performant allocator.

These efforts are still incomplete and they're not enabled by default yet.

## Other fun

Lots of small things have happened as well. These includes full translation of the website, refactoring a lot of things, designing logos etc.

# Funding

As said above, Jeremy quit his job to work full-time on Redox. Therefore, funding is crucial.

Even small amounts of money can do a big difference. Please consider supporting us [on Patreon](https://www.patreon.com/redox_os).

We are also looking into a more long-term solution such as funding from an university or something like Mozilla Research.

# News Coverage

Finally, Redox has been covered in a number of news articles:

- [2015-10-07 - OpenNet - Представлена операционная система Redox, написанная на языке Rust](https://www.opennet.ru/opennews/art.shtml?num=43105)
- [2016-03-19 - OSNews - The Redox operating system](http://www.osnews.com/story/29131/The_Redox_operating_system)
- [2016-03-20 - Phoronix - Redox: A Rust-Written, Microkernel Open-Source OS](https://www.phoronix.com/scan.php?page=news_item&px=Redos-OS-Intro)
- [2016-03-21 - InfoWorld - Rust's Redox OS could show Linux a few new tricks](http://www.infoworld.com/article/3046100/open-source-tools/rusts-redox-os-could-show-linux-a-few-new-tricks.html)
- [2016-03-21 - TuxNews.it - Redox: nasce il sistema operativo (da 26 MB) Unix-like scritto in Rust!](http://tuxnews.it/redox-nasce-il-sistema-operativo-da-26-mb-unix-like-scritto-in-rust/)
- [2016-03-22 - Linux.com - Rust's Redox OS Could Show Linux a Few New Tricks](https://www.linux.com/news/rusts-redox-os-could-show-linux-few-new-tricks)
- [2016-03-22 - Pro-Linux - Betriebssystem Redox in Rust geschrieben](http://www.pro-linux.de/news/1/23383/betriebssystem-redox-in-rust-geschrieben.html)
- [2016-03-22 - SoylentNews - Microkernel, Rust-Programmed Redox OS's Devs Slam Linux, Unix, GPL](https://soylentnews.org/article.pl?sid=16/03/22/0116231) (The title is their choice - not ours)
- [2016-04-06 - LWN.net - Redox: a Rust-based microkernel](https://lwn.net/Articles/682591/)
- [2016-05-04 - formtek - Rust Redox – An Next-Generation Attempt to Plug Linux OS Gaps](http://formtek.com/blog/operating-systems-rust-redox-an-next-generation-attempt-to-plug-linux-os-gaps/)
- [2016-05-24 - Laboratorio Linux - Redox OS el Sistema Operativo de Código Abierto alternativo a Linux](http://laboratoriolinux.es/index.php/-noticias-mundo-linux-/distribuciones/16043-redox-os-el-sistema-operativo-de-codigo-abierto-alternativo-a-linux.html)
- [2016-06-16 - It's F.O.S.S. - REDOX OS: AN OPERATING SYSTEM WRITTEN IN RUST](https://itsfoss.com/redox-os-an-operating-system-written-in-rust/)
- [2016-06-23 - Ubuntu Next - REDOX OS: YOUR NEXT GENERATION OPERATING SYSTEM](http://ubuntunext.com/2016/06/23/redox-os-your-next-generation-operating-system)
- [2016-06-28 - Websetnet - Redox OS: an Operating System Written in Rust](https://websetnet.com/redox-os-operating-system-written-rust/)
- [2016-11-01 - OSNews - A complete rewrite of the Redox kernel](http://www.osnews.com/story/29463/A_complete_rewrite_of_the_Redox_kernel)
- [2016-12-09 - Golem.de - REDOX OS: Wer nicht rustet, rostet](http://www.golem.de/news/redox-os-wer-nicht-rustet-rostet-1612-124867.html)

If you know of others, please create an issue at [our website repo](https://github.com/redox-os/website).

Here is a composite image:
<a href="http://i.imgur.com/dwNevsk.jpg"><img class="img-responsive" src="http://i.imgur.com/dwNevsk.jpg"/></a>
