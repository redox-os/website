+++
title = "POSIX Conformance Testing for the Redox Signals Project"
author = "Ron Williams"
date = "2024-12-11"
+++

The Redox team has received a grant from [NLnet](https://nlnet.nl/)
to develop [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/),
moving the bulk of signal management to userspace,
and making signals more consistent with the POSIX concepts
of signaling for processes and threads.
It also includes Process Lifecycle and Process Management aspects.
As a part of that project,
we are developing tests to verify that the new functionality
is in reasonable compliance with the POSIX.1-2024 standard.

This report describes the state of POSIX conformance testing,
specifically in the context of Signals.
This is based on my experience only, your mileage may vary.
If you want to offer any suggestions or corrections,
please join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

## The Highlights

- For Signals, POSIX.1-2024 has eliminated some interfaces and constants that were previously deprecated
but has not added much that is new.
See [Sortix's POSIX blog post](https://sortix.org/blog/posix-2024/) for a broader analysis.
- The only true POSIX conformance tests are the ones provided by
[The Open Group](https://posix.opengroup.org/docs/testsuites.html),
but they don't have generally available tests for POSIX.1-2024 yet,
and the new tests will likely require a fee for any long-term use.
- [Sortix](https://sortix.org/os-test/) has tests that check for compliance
with the 2024 standard for specific areas of functionality,
and has recently added tests covering Signals.
- The tests that Redox developed under our NLnet grant have similar coverage
to the new Signals tests from Sortix,
but due to unfortunate timing, we did not collaborate.
- Better support for cross-compilation, separate from test execution,
is an important requirement that is
not very well addressed by existing conformance tests.

## About NLnet and NGI Zero Core

The [NLnet Foundation](https://nlnet.nl/) is a great organization to work with.
They fund internet-related projects of various kinds,
and they have [several funds](https://nlnet.nl/themes/) running concurrently,
each with a different scope and set of goals.

The Redox Signals project is funded under [NGI Zero Core](https://nlnet.nl/core/),
which is no longer accepting applications,
but [NGI Zero Commons](https://nlnet.nl/commonsfund/) is open for applications,
and it has a broader scope and more total funds available than Zero Core.
If your open source project has a "European dimension",
and fits within the scope of one of their funds, consider applying.

## Project Overview

For the Redox Signals project, we are re-working our implementation of
[Signals](https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/signal.h.html),
used by [`kill()`](https://pubs.opengroup.org/onlinepubs/9799919799/functions/kill.html)
among other things, to more closely align with Unix behavior.
We are also reducing the kernel footprint for supporting Signals,
moving such things as stack manipulation into userspace.
Some of the objectives for the project include:
- Move signal handling (sigprocmask and sigaction) to userspace,
with basic ability to catch, ignore,
suspend, restart or terminate processes
- Implement signal queuing (real-time-style signals), initially in the kernel,
and implement all remaining signal-related POSIX APIs
- Move process tracking into a userspace daemon,
with session/group/process/thread hierarchy awareness
- Implement support for kill, sigqueue, and waitpid syscalls with process/group/all processes targets
in the Process Manager
- Pass a suite of process and signal compliance tests

Redox, and the work for this project in particular, is MIT-licensed.
(Some elements such as the COSMIC Desktop applications are under other licenses.)

## All About POSIX Testing

### POSIX.1-2024

The [POSIX](https://en.wikipedia.org/wiki/POSIX) standard, also referred to as IEEE std 1003.1,
describes many aspects of a Unix system,
including APIs, commands and shell behavior, and so on,
to try to improve software portability.
It does not describe "system calls" or other things that might determine a particular implementation.
The POSIX standard has existed since 1988, and has evolved, with half a dozen or so versions,
with (more recently) each new version including
a suffix for the year the standard was approved.
The most recent version is POSIX.1-2024.
The standard is broken into sections,
and systems may be compliant with one section of the standard but might not implement another section.

The standard is maintained by the [Austin Group](https://www.opengroup.org/austin/),
and is administered jointly by [The Open Group](https://www.opengroup.org/)
and the [IEEE](https://www.ieee.org/).
The Open Group is responsible for certification of POSIX systems.

POSIX.1-2024 was released in June of this year.
In general, as the standard evolves, some APIs, structs and constant definitions
are first deprecated in one release of the standard,
and then eventually removed in a subsequent release.
POSIX.1-2024 has added new functionality in some areas,
and made some extensions mandatory,
but most of the changes to Signals have been deletion of obsolete and previously deprecated items.

### The Open Group Tests

The Open Group is the definitive source for POSIX conformance testing.
If you want to obtain POSIX certification, you must pass the tests provided by The Open Group.

The Open Group charges a fee for certification,
and the tests are provided as part of that certification process.
What fees apply and when is a bit confusing, but it is in the small number of thousands of dollars
to get access to the tests, possibly with a 12 month no-fee period for open source projects.

There are several older test suites that are available for download without a fee.
These are mostly related to the POSIX.1-2003 standard,
plus a variety of other Unix standards.
The Open Group tests use a test framework called
[VSXgen](http://www.opengroup.org/testing/testsuites/VSXgen.htm),
based on the [Test Environment Toolkit](https://tetworks.opengroup.org/) (TET).

For these older test suites, the pages are in some cases unmaintained,
and links are frequently broken.
Assembling all the necessary bits and pieces required a fair bit of googling
and mixing and matching.
After about two days of work,
I had very little confidence that I had an actual usable conformance test suite.
And as it wasn't an up to date set of tests, I decided to stop trying.

However, my biggest concern, by far, was that for Redox's purposes,
the ability to build the tests on one machine and run the tests on another
is a critical requirement for us right now.
VSXgen has a complex configuration and management system,
and we are not quite up to using VSXgen on Redox,
or compiling the many tests natively.

### Linux Standard Base Tests

The [Linux Standard Base](https://wiki.linuxfoundation.org/lsb/start) (LSB) 
is an attempt to create a binary compatibility standard for Linux systems,
while POSIX is explicitly not a binary compatibility standard.
LSB is not POSIX - there are some significant divergences from POSIX.

LSB has a set of conformance tests,
derived from the same origin as The Open Group's POSIX tests,
with changes to align with the LSB definition.
The LSB Tests are not maintained, as far as I know,
and were again not to the POSIX.1-2024 standard.
I attempted to run the LSB tests on Pop!_OS,
but after struggling with configuration for a day or so,
I decided to stop.
It's quite possible that I would have been more successful had I found
some good documentation about configuration, but I did not.
Since the LSB tests use the same basic VSXgen/TET framework for building and running the tests,
my concerns about support for cross-compilation, separate from running the tests,
apply here as well.

There is some commentary about LSB, and questions about its future,
which you can read on the
[LSB Wikipedia Page](https://en.wikipedia.org/wiki/Linux_Standard_Base#Quality_of_compliance_test_suites).

### Open POSIX Test Suite

The [Open POSIX Test Suite](https://posixtest.sourceforge.net/) was an effort
to create a set of POSIX tests that was available without fees.
It is licensed under GPL-2.

Based on the copyright notices in the files,
it appears that Intel and Qualcomm both contributed to the effort.
It was maintained until 2005 or 2006, and tested for conformance to the POSIX.1-2001 standard.
It includes a decent set of tests, and test management appears to be much less complex
than the above test suites.
The [Emscripten team](https://github.com/emscripten-core/posixtestsuite)
has done some work to test with this set of tests.

However, as the Open POSIX Test Suite is GPL-2, and Redox wants to provide MIT-licensed tests,
we are not able to modify their tests for inclusion directly in our work.

Going forward, we will attempt to leverage their tests as a separable component.
We will create a fork and disable those tests that are not supported in POSIX.1-2024.
We may do some work to update to POSIX.1-2024 in areas of interest to us,
but we are not in a position to commit to a specific amount of work on updating the tests.
The outcome of any changes to the suite will of course be GPL-2 licensed.
I am also not certain if we will be able to upstream the changes,
as I do not know if the work is being maintained or if it has a designated owner.

There are a variety of test types in the Open POSIX Test Suite;
it is not limited to just poking the API.
Quoting from their overview:

> The test suite divides tests into several categories: Conformance, Functional, Stress, Performance, and Speculative.
>- Conformance tests involve closely reading the POSIX spec and recording assertions about correct behavior. Each test case is associated with a particular assertion.
>- Functional tests try to use the interfaces in real-world scenarios, and cover behavior that is reasonably expected, if not specifically called out, in the POSIX spec.
>- Stress tests put the interfaces through the paces by using large numbers of system objects, or large amounts of data, or under external conditions such as low memory or high CPU utilization.
>- Performance tests attempt to benchmark the performance of interfaces or sets of interfaces for comparison of implementations.
>- Speculative tests arise when the POSIX spec is unclear about a certain behavior where differences in implementations can affect the application. These tests attempt to expose differences in implementations so that they can be tracked and the behaviors can be compared for consistency across revisions.

### libc-test from musl

[musl](https://musl.libc.org/) is a very popular "from scratch" implementation of the C standard library,
[libc](https://en.wikipedia.org/wiki/C_standard_library).
It uses a permissive MIT license.

Quoting from their website,
> **musl** is *lightweight, fast, simple, free,* and strives to be *correct* in the sense of standards-conformance and safety.

libc, like Unix, is governed by standards.
There is an ISO standard for libc, and a POSIX standard for libc, and they are not the same.
musl conforms to a combination of the ISO and the POSIX standards,
and adds some common extensions.

musl has a set of tests called [libc-test](https://wiki.musl-libc.org/libc-test).
These tests are also MIT licensed.
The tests cover definitions, functionality, and some regression tests.
They are primarily a test of the library,
and have only limited testing of runtime services
(on Linux, these would be system calls).
They use custom macros to reduce boilerplate code,
but it makes the tests less obvious to someone unfamiliar with the macros.

libc-test has not been updated for POSIX.1-2024 yet.
At some point, musl will need to work with POSIX.1-2024,
and I expect that the tests will be updated.
I hope that they can benefit from some of the work on runtime service testing described below,
which has compatible licensing and coverage of areas not already covered by libc-test.

### os-test from Sortix

[Sortix](https://sortix.org/) is a from-scratch implementation of a POSIX operating system.
The principal developer is Jonas 'Sortie' Termansen.
As part of the effort,
Jonas has developed a collection of POSIX.1-2024 conformance tests called
[os-test](https://sortix.org/os-test/),
with coverage for `io`, `malloc`, `signal` and `udp`.
`os-test` uses the permissive ISC license,
which is compatible with the MIT license.

The tests are nice and straightforward, with no fancy configuration or macros,
and the tests can be run from the Makefile.
There is support for cross-compiling separately from executing the tests,
but we found it a bit easier to write our own test execution script.
It was simple and painless.

Interestingly, Jonas has arranged for executing his POSIX test suite
across numerous operating systems, and provides a comparison matrix
for how each OS performs on each test.
He even spends time interpreting the POSIX specification,
looking for places where the spec might be imprecise or misleading,
and writing tests to determine how each OS interprets the spec.

The tests for `signal` were added on November 13 this year,
so the Redox team had already completed
the bulk of coding our tests when that work became available.
I have been in touch with Jonas, and we're hoping that we can collaborate in future.

### What Redox is doing

Redox has its own implementation of `libc`, called `relibc`.
Relibc is written primarily in Rust,
and has a Linux implementation and a Redox implementation.
For the Redox implementation, a lot of Redox's runtime services,
including fork, exec and signal handling,
are either fully or partly implemented within Relibc,
"under the hood".
So what on Linux would be a function call that leads directly to a system call,
on Redox might have a whole (or partial) implementation behind the scenes,
manipulating Redox-specific resources.

We have developed our own test suite for Relibc,
which is integrated into the Relibc build system.
The Signal tests that are being developed for this project
are part of that test suite.

The Signal tests follow the patterns used in the other Relibc tests,
and use some macros to reduce boilerplate and provide some context to errors.
The macros are defined in our
[test_helpers.h](https://gitlab.redox-os.org/redox-os/relibc/-/blob/master/tests/test_helpers.h?ref_type=heads).
The tests can be built on a development machine, normally Linux, 
and then run on Redox in an emulator or natively.

The new Signals tests are more detailed than the tests that I have seen in other suites,
checking each possible signal in a variety of conditions.

## Summary

The Open Group's for-a-fee test suite has not yet been updated for POSIX.1-2024.
It has a complex configuration and test management system.

The Open POSIX Test Suite was a sincere and useful attempt to create
freely available GPL-2 licensed tests for POSIX conformance.
However, it does not appear to have been maintained since 2006.

Sortix has up-to-date tests for POSIX.1-2024, but only in specific areas.
Their Signals tests overlap with our work,
but were not available in time for us to leverage them.

As a result, we have developed our own tests to confirm POSIX.1-2024 conformance,
using the same style and macros as the rest of the tests in our Relibc test suite.

## Opinion

I include here my own thoughts, which do not necessarily reflect the opinions
of the Redox team, NLnet, or NGI.

I am extremely disappointed that The Open Group does not provide an open source,
free-to-use set of up to date tests.
I think this is a major error on their part, and the fact that there was
a concerted effort by organizations such as Intel and Qualcomm
to develop an alternative test suite indicates that this is a serious problem.
I appeal to The Open Group to make the POSIX.1-2024 tests free-to-use,
open source, and open to community contributions.

Many, many years ago, my first full-time job after graduating from university
was porting Unix to new processors and systems.
Back then, the term
["Test Driven Development"](https://en.wikipedia.org/wiki/Test-driven_development)
did not exist, but that's exactly how we did our work -
build the system incrementally, focusing on one conformance test at a time,
then clean up the code as you pass each test.
When you can pass all the tests, you are done.
We had a complete set of official Unix conformance tests,
and in fact the contract for the work was written with milestones based on
passing the tests.

When you use a Test Driven approach, the set of tests you work from
has a significant impact on your software design.
If your tests are a good reflection of how the system will actually be used,
the system's design should support the required functionality well.
But if the tests do not accurately reflect the requirements,
it's not certain if the system will do its job.
Getting the system to correctly execute a new set of conformance tests
at the end of the process can cause significant and expensive rework,
and potentially create code filled with bandaid fixes specifically to pass
"afterthought" test cases.

I have no issue at all with The Open Group charging for POSIX certification.
But having paywalled tests with a twelve month clock for open source projects
that want to be POSIX compliant is harmful to both the open source projects
and to the POSIX standard itself.

With the growth of new processors and systems,
like RISC-V and ARM servers for cloud-based AI,
new wearables, hand-helds and IoT devices,
and new OSes written in modern languages,
the need for test-driven OS development is again reaching a peak.
Making the tests freely available, and allowing community contributions,
would get us a test suite that is up to date much sooner,
and would encourage the kind of Test Driven Development that
will help produce more correct, more POSIX conformant,
and more maintainable operating systems.
