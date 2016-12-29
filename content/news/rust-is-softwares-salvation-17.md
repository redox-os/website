+++
title = "Rust is Software's Salvation"
author = "Jackpot51"
date = "2016-12-29T11:50:00-07:00"
+++

After the post by Steve Klabnik, ["Rust is more than safety"](http://words.steveklabnik.com/rust-is-more-than-safety), and a reply by Graydon Hoare, ["Rust is mostly safety"](http://graydon.livejournal.com/250300.html) - I thought it wise to throw my opinion into the mix, whether warranted or not. This is going to be a long article, which I hope raises some points that will be interesting to you.

## Experience with Rust

First, I would like to clarify my experience with Rust. I first discovered Rust through reddit, in late 2014, version 0.11. What stood out to me immediately was a different focus on software - a focus on being the best language possible.

What I found in Rust was a language that had:

 - Better safety than Ada
 - Better concurrency than C++
 - Better performance than C
 - Better documentation than Python

In other words, it was already best at nearly every point of comparison than other languages. Yet, still, it had not caught on. In those days, there was no rustup. Cargo was not used for hardly anything - many crates had to be compiled from the Rust source. Much of what you would find written in Rust were simple FFI wrappers for C libraries. Although the language was as perfect as any I had ever discovered, it had a problem:

**Very few things were being written in Rust.**

## Reliance on C

To understand why things are this way, we must identify the elephant in the room: C. It is a shade of 40 years of language stagnation, propped up only through code generators and near-omniscient compilers. That, as well as the billions of lines of code that have been written in C.

Everything, everywhere uses C. Go ahead, point at something that uses electricity. Does it have software, firmware? I bet it was written in C. Does it have a circuit board? I bet that board was designed using software written in C, or was manufactured by a machine that was using software written in C. And, no matter what, I bet your power provider uses C at some point in their software stack in order to deliver your electricity.

Most other languages use C. Wrote something in Java? Well, that's nice, it is just a bytecode language for a virtual machine written in C. Using Python? Well, you are probably using either CPython, which is written in C, or PyPy, which is translated from RPython to C, and then compiled. PHP? Implemented in C. Even with assembler, you would have trouble finding an assembler that is not written in C.

And, of course, our favorite language Rust? Well... the only way Rust can exist today is through reliance on LLVM for a compiler backend. Which is, of course, written in C++ - a language that is a superset of C.

However, I want to be clear about this - Rust is a language *perfectly capable* of being used for implementing a Rust compiler - with no dependency on C.

**All it needs is time, and effort.**

## Problems with C

The issue with this massive reliance on C, touching nearly all parts of our lives, is not with what C can do at its best. At its best, C can be formally verified - a huge amount of effort put into a code base to ensure it is free of errors.

However, at its worst - and most of that billions of lines of code is C at its worst - C offers few guarantees about a program's execution.

What does it take to create a vulnerability with C?

 - Maybe you assumed the number of elements in an array
 - Maybe you overflowed the stack, and did not compile with `-fstack-protector`
 - Maybe you forgot to use `snprintf`, or gave it the wrong limit
 - Maybe a bug in `GCC` outputted the wrong machine code
 - Maybe a race condition in `Linux` gave an unprivileged process the ability to tamper with your program
 - Maybe somewhere, in those billions of lines of C code you are interacting with, a single mistake, easily written and difficult to catch, sits waiting for the right time, and there is nothing C will ever do to stop it

**Given the fact that "everything uses C", does this concern you?**

## Reputation of Software

The ease with which bad code can be created, and reused, has given software a bad reputation among disciplines. As something that, at least theoretically, does not degrade, does not operate on its own volition, does only what it is told to do, can be created at no cost, and requires no understanding of science or nature to create - we sure do tolerate a lot of failure!

There are constantly bugs, security vulnerabilities, and quality issues with the software that we use. Most of these are believed to be forgivable human error - oh, well, it is *too hard* to produce secure software, how can we blame OpenSSL for yet another buffer overflow? Or the four hundredth time that our data was stolen from yet another business like Google, Target, Yahoo, or LinkedIn?

Well, I have news. We **can** blame them. We can blame software for being poor quality. We can blame software for having vulnerabilities. We can blame software for crashing. And we can blame companies that use that software for the damage they have done to our privacy, our security, our wellbeing.

**There is a solution now, and if software does not grow up - it deserves to be thrown out on the curb.**

## Software's Salvation

I have a vision of a new world, with new software. A world without data breaches. A world where complete system crashes in software are as rare as car crashes - either by eliminating bugs or by healing a system automatically. A world where Rust fixes all the problems software has had over its history, mostly due to the use of C.

**That vision is what drives my development of Redox.**
