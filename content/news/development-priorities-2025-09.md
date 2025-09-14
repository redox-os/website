+++
title = "Development Priorities for 2025/26"
author = "Ron Williams"
date = "2025-09-12"
+++

Redox has made great strides over the past year, with notable improvements in stability, performance, and compatibility.

To give a big-picture perspective for where Redox development is headed, here is our view of priorities as of September, 2025.
Obviously, we can't finish everything on this list in the next 15 months,
but it would be nice to have people working on as many of these things as possible.

### Redox Variants

- "Hosted Redox" as a Web Services Runtime, in a Virtual Machine
- "Redox Server" for Edge and Cloud
- "Redox Desktop" for your daily driver

### Development Priorities

- Building Redox on Redox
- Compliance and Compatibility
- Programming Language and Build System Support
- Performance
- Security
- Hardware Support
- COSMIC, Wayland, and GPU Acceleration
- Accessibility

## How can you help?

Here are some ways you can help us move Redox closer to our goals.

### Donating

If you would like to support Redox development, please consider donating or buying some merch!
We are currently funding a community support/researcher/documentation person, a part-time build engineer,
and our Redox Summer of Code program for students,
all from donations.

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

### Contributing

If you would like to help with Redox development or documentation, please read the [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md) page and join us on [Redox Chat](https://doc.redox-os.org/book/chat.html).
Try to connect with others who are interested in one of the major areas, create a tracking issue for the work to be done,
and start checking things off.

### Redox is Hiring!

Redox is looking for an experienced kernel/core developer. Check out the job description in the [July report](/news/this-month-250731).
Please contact us if you think you are the right person.

As well, we are frequently applying for grants.
We currently have three students working on grants from [NGI Zero and NLnet](https://nlnet.nl/funding.html).

- [Redox OS Unix-style Signals](https://nlnet.nl/project/RedoxOS-Signals/)
- [io_uring-like IO for Redox](https://nlnet.nl/project/RedoxOS-ringbuffer/)
- [Capability-based security for Redox](https://nlnet.nl/project/Capability-based-RedoxOS/)

If you are a talented Rust developer interested in obtaining a grant to work on Redox,
get in touch with us and we will do our best to help.
You can also apply for grants for "Redox-adjacent" work on your own.

Send an email to president@redox-os.org, cc info@redox-os.org,
with a resume/CV or links to your open source work,
and let us know what you are interested in doing.

# Redox Variants

## Hosted Redox as a Web Services Runtime, in a Virtual Machine

One of the opportunities we would like to pursue is to use Redox as a hosted runtime environment for web services.
The goal is to run your web services in a secure Redox environment,
but to have the hardware compatibility and management tools delegated to a Linux host.
We believe that this is one of the quickest paths to getting Redox into real-world use,
and to help us validate it as a secure platform.

The set up would be something like the following.

- A Linux server
- A QEMU Virtual Machine, with KVM, VirtioFS and a virtualized compute acceleration interface like virglrenderer
- Redox running in QEMU, with some combination of these applications
  - A web server and content manager
  - A database
  - WASM/WASI microservices
  - Custom web services applications of your choice

We will need the following improvements to Redox to make this work.

- A faster network stack, including Ring Buffer I/O
- [virtiofs](https://virtio-fs.gitlab.io/)
- [virglrenderer](https://gitlab.freedesktop.org/virgl/virglrenderer)
- Improvements to our shared memory and IPC
- General compatibility, performance, security and stability testing
- Management tools to simplify the use of the system
- Repeatable builds

It would be nice to experiment with making virtualized devices like the GPU or VirtioFS available as a relibc/Redox-RT service, although that is not a major goal for 2026. This would be a configurable option, where the web service has exclusive use of the virtualized device. To the extent possible, the API should be the same whether the virtualized device is available as a library service or as a scheme-type service.

## Redox Server for Edge and Cloud

The most valuable application for Redox is as a secure host for web services,
initially as a private server or edge server,
and eventually as a multi-tenant cloud server.
Redox can provide lightweight but secure sandboxing of web servers, databases and web service applications.
We plan to provide heavyweight containerization in the longer-term future,
with complete isolation between each tenant in a multi-tenant environment.

This represents a substantial effort, but we plan to tackle it in phases to demonstrate value.
- Phase 1 - Redox running on bare metal in a single tenant server/edge scenario
- Phase 2 - Multi-tenant Redox with lightweight containers for WASM microservices and other supported applications
- Phase 3 - Multi-tenant Redox with heavyweight containers and support for arbitrary applications

## Redox Desktop for your daily driver

Redox Desktop will benefit from all the features of Redox Server,
but it also needs to be usable for everyone.
And Redox security must work in a natural way for the average user.

The [COSMIC Desktop](https://system76.com/cosmic/) is being developed at System76, with Jeremy Soller as principal engineer.
It’s an open source Linux desktop environment that is written almost entirely in Rust.

Redox currently supports several key applications,
including COSMIC Terminal, COSMIC Files, COSMIC Editor, COSMIC Reader, and COSMIC Store.
However, a few important parts of the COSMIC environment are missing due to our lack of Wayland support.

Once Wayland is supported, we will be able to support almost the entire COSMIC Desktop.
We will also be able to add features for accessibility, i18n/l10n,
and other improvements to the desktop experience.

We then plan to experiment with "sandboxing by default",
restricting the access of applications to only the resources that they should normally require.
We would like to create a consistent experience for sandboxed applications,
requesting greater access, and being aware of when you are more-privileged or less-privileged.
There are several initiatives in this area,
and if we can partner with someone to build a sandboxed desktop,
it would be a valuable opportunity for us.

# Development Priorities

## Building Redox on Redox

Although this has been an important goal for a long time,
we are getting closer to supporting development *for* Redox, *on* Redox.
Having the ability to edit, compile and run your code without having to cross-compile
and generate bootable images will make development much faster and more pleasant.

I have done some small-scale development on Redox,
debugging test suites in C and making one-off changes.
It's quite pleasant, although it's currently easier to mirror the changes manually in a host editor
than to move the files back and forth between Redox and the host file system.

### How it will work

In the short/medium-term, Redox developers will be running Redox in
QEMU or VirtualBox on their Linux, Windows or MacOS laptops or desktops.

- Initially, developers will need to use the GitLab server as their trusted storage,
as work in progress might be lost if there is a Redox failure of some sort.
- We hope to add a VirtioFS file system service so Redox can access the host files.
This will greatly improve the developer experience.
- And, hopefully after a few months of use as a "daily driver" for developers,
we will have the confidence that the Redox file system can be used for persistent storage,
and you can push to GitLab when you reach a good stopping point.

For a small number of systems, we will be able to support Redox development on real hardware.
The system will need to have hardware that works well with Redox,
including a wired Ethernet connection.
But we hope to have at least a few people doing development on real hardware before the end of 2026.

### Things to do

Here are some of the challenges we need to address to make Self-Hosting a reality.

- Network performance needs to improve - we have an
[NGI Zero & NLnet funded project to implement Ring Buffers for disk I/O](https://nlnet.nl/project/RedoxOS-ringbuffer/).
We need to implement ring buffers in our network stack as well,
once the disk I/O work stabilizes.
- Move to the upstream Rust compiler - we have mostly solved this, and just need to finish up.
- Rustc and Cargo reliability - due to past performance issues and a few challenging bugs,
we have not had Cargo and the Rust compiler working consistently on Redox.
We could use help fighting through the bugs while we wait for the networking improvements.
- Build system improvements - we have removed a lot of legacy build system code and scripts,
and now we are in a position to optimize our custom build tools.
- Workflow improvements - self-hosting is a different experience from cross-compiling,
and we will need to tweak our package manager and some build tools to make the development cycle more straightforward.
- Redox improvements - self-hosting will be our first opportunity to use Redox as a daily driver,
and we expect to find a few bugs or incomplete features that need polishing,
and probably one or two unexpected performance bottlenecks.

Compilers and build systems are a real torture test for operating systems,
with many processes spawned and lots of files being opened and closed, and lots of small-file reads and writes.
Getting Redox working smoothly for development will also greatly improve its general stability.

### Debugging

Currently, Redox supports limited debugging with `gdb` running on the Linux host.
This works well for debugging the kernel,
but it is more challenging when debugging applications.

We don't have a reasonable self-hosted debugger setup yet,
as Redox's `ptrace` implementation needs to be reworked.
That's a complex enough project that we consider it a secondary goal for 2026.
If someone is up for a real challenge, please let us know.
Or, if you have ideas on how to improve debugging of user space applications and services
using `gdb` on the Linux host, please get in touch.

## Compliance and Compatibility

Redox is not intended to be 100% POSIX compliant, or 100% source compatible with Linux,
but we want to come close where it's practical.
Porting Linux applications to Redox has been the main driver for compatibility,
but we have recently set up some compliance tests.
Using a test-driven approach, rather than just focusing on porting,
will speed up porting, with fewer non-compliance bugs to track down.
There are also some chunks of functionality that are medium-high priority that we would love to have help fixing.

- Controlling Terminal needs a proper implementation
- There are several functions related to timers and alarms that need both POSIX and Linux functionality
- Many other examples will crop up as we do more compliance testing

We would also like to polish our Rust compatibility.
If you would like to set up tests for the Rust `std::` library or other popular crates,
please join us and we can work together to add the tests to our Redox test suites.

## Programming Language and Build Systems Support

Redox intends to support applications developed in any language.
However, there are some tricky bits.
Rust and C/C++ are well-supported,
but we have trouble with languages that come with their own runtime.
We need to add some fairly complex hooks in `relibc` (our `libc` implementation),
or provide a Redox-compatible implementation to support those runtimes,
and then we need to port and test the languages.

We can currently run Python programs using [RustPython](https://github.com/RustPython/RustPython),
but it would be nice if we could support the [official implementation](https://github.com/python/cpython).
We have started porting a couple of JavaScript engines, and
we have work underway to support Go.

If you have some expertise in x86, ARM and RISC-V assembly,
as well as language runtimes,
and would like to get into the details of relibc and Redox's runtime support for applications,
please give us a hand.

We also need to port the build tools, scripting languages, and utilities used in build systems.
We have decent support for shell scripts, GNU Make, and the most common utilities.
But we can use help figuring out if we can get build systems for various libraries and applications working,
and what additional utilities are required.

## Performance

Last year, we made really substantial improvements to Redox's file system performance,
thanks to James Matlik (RedoxFS), Jacob Lorentzon (Kernel) and Jeremy Soller (Disk I/O),
which got us to the point where Redox can be usable in realistic scenarios.
We are continuing to improve performance, as described above,
so much so that by the end of next year,
performance should not be a roadblock for using Redox.

We do want to continue to make Redox go faster,
but that work will be incremental going forward.
Here's a summary of our upcoming performance work (including things mentioned elsewhere).

- [Ring Buffers](https://en.wikipedia.org/wiki/Circular_buffer) for the disk and file system
- Direct process switching (context switching to the target driver with no scheduler intervention) as part of the Ring Buffers work
- Ring Buffers for the network stack
- Scheduler improvements ([EEVDF](https://en.wikipedia.org/wiki/Earliest_eligible_virtual_deadline_first_scheduling), and maybe others)
- Ongoing improvements to RedoxFS
- Hardware-accelerated graphics
- Performance benchmarking - we would like someone to help curate and improve our benchmarking

## Security

Redox is implementing [Capability Based Security](https://nlnet.nl/project/Capability-based-RedoxOS/)
as a fundamental part of how files and resources are accessed.
Over the next 12 months, the underlying representation of file descriptors will be replaced by
[capabilities](https://en.wikipedia.org/wiki/Capability-based_security).

The first stage of this work is

- to implement the machinery to create capabilities and transfer them between processes
- to have file references be relative to some capability
(see [openat(2)](https://pubs.opengroup.org/onlinepubs/9799919799/functions/open.html))
- to have every program running in a resource namespace that can be restricted as appropriate
- to provide POSIX-style paths and file descriptors as a layer on top of capabilities

There will be lots of followup work,
to implement [Capsicum-style security](https://man.freebsd.org/cgi/man.cgi?query=capsicum&sektion=4)
and mechanisms for requesting additional privileges,
and to make security easy to use.

## Hardware Support

To run Redox on real hardware, we need compatible drivers for the full range of system functionality.
Linux has literally hundreds of people working on device drivers of all kinds,
and we don't have that luxury.
So we will be focusing on "recommended" hardware.

For Redox Server, we will have to partner with a small number of server vendors,
and develop drivers for that particular hardware.
Whether it's x86_64/amd64, Aarch64/ARM64, or RISC-V 64,
we will have to find a vendor that will provide either funding or developers (or both)
to create optimized drivers for disk, network, compute acceleration,
as well as for system management and other functions.

For Redox Desktop,
we will support a very small number of desktop and laptop systems for our own development purposes,
focusing on drivers that are likely to be compatible with the maximum number of real-world systems.
For emerging standards and less common devices,
we will look for help from the community to build out a more complete set of drivers.

Here are some of the key efforts that we are hoping to complete by the end of 2026.

### Firmware Support and Hardware Management

We need to rework our ACPI support,
as the implementation we have needs better integration with the drivers and driver management.
As well, Isaac Woods and the Rust-OSDev team have developed an entirely new AML parser,
and improved the design of their [acpi crate](https://github.com/rust-osdev/acpi).
We hope to take full advantage of their implementation.

The goal for 2026 is to ensure we can configure and run the system correctly,
with full system management as stretch goals and future work.

We are designing our boot/init to handle non-APCI firmware,
and we could use help developing drivers for IEEE-1275 and other standards,
as well as getting access to hardware that we can use for testing.

### WiFi

WiFi support is a whole collection of functionality,
and it is not something we have tackled yet.
We would appreciate some help porting an existing written-in-Rust WiFi driver stack, if an appropriate one can be found.
It's a pretty big project.

### USB and I2C Support

Redox has USB drivers for keyboard, mouse, disk, and hub,
but full support for USB on all the varied hardware out there remains a challenge.
We could use help with improving our USB implementation,
seeing if we can collaborate with other written-in-Rust implementations,
adding new devices,
and testing on real hardware.

We don't have an I2C driver,
and would love to collaborate with someone on creating one.

### IOMMU and Virtualization

It is our intent that Redox will use IOMMU and hardware virtualization features
wherever they are available, to protect against rogue hardware and drivers.
However, we have not implemented support for IOMMU yet.
We would like to at least get started on this in 2026.

### Hosted Linux for Driver Support

In order to avoid porting thousands of device drivers,
we would like to port QEMU to Redox,
then run a stripped-down Linux to provide device drivers for less common and older devices.
The interface between Redox and Linux-in-QEMU will be designed to be secure,
so this approach should give us reasonable safety.

This is an experimental approach,
and our goal for 2026 is to determine if it is feasible and useful.
We want to be able to run QEMU on Redox regardless,
so please join us if you want to help out.

## COSMIC, Wayland, and GPU Acceleration

Redox uses the COSMIC Desktop, although we don't currently support the COSMIC Compositor,
so we are unable to use a lot of the COSMIC features.
Porting Wayland will be a big step towards supporting the COSMIC Compositor,
so that's very high on our list of things to do.

The ability to [send file descriptors over our Unix Domain Sockets](https://www.redox-os.org/news/rsoc-2025-uds/)
was implemented in one of our Summer of Code projects (thanks Ibuki!),
which represents a big step forward.

We are [still missing some functionality](https://gitlab.redox-os.org/redox-os/redox/-/issues/1427) in `relibc`,
including [timerfds](https://www.man7.org/linux/man-pages/man2/timerfd_create.2.html) and a few other things,
although most of the underlying machinery exists,
so if you want to help, please join our chat and let us know.

We are also looking for a full D-Bus implementation in Rust
that can be ported to Redox.

For GPU acceleration,
our first goal is to support Virtio graphics acceleration,
probably using [virglrenderer](https://docs.mesa3d.org/drivers/virgl.html).
Then Intel graphics will probably be the easiest next step,
with drivers for AMD and NVIDIA graphics dependent on having access to the right information.

## Accessibility and Internationalization

So far, Redox has not accomplished as much as we would like with either Internalization or Accessibility.
We have gotten a start in the last few months but there's lots to do.

### Internationalization

Our goal with Internationalization ("i18n") is to align with POSIX where possible,
and we encourage ideas that go beyond the POSIX standard.
Redox is UTF-8 natively, but we allow for opening non-UTF-8 file names on non-RedoxFS file systems.

Some of the areas that need work are

- Localization APIs and settings storage
- Non-US keyboard support (started but not complete)
- Non-Latin text display (COSMIC supports this, but Redox does not use it yet)
- Timezones, numeric and currency display, other [LC_* types](https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap08.html#tag_08_02)

Having team members with expertise in i18n/l10n support is
would be a great boost to Redox.

### Accessibility

We have started a discussion group for Accessibility.
One of our contributors, Bendeguz Pisch,
has been working on a [screen reader solution](https://gitlab.redox-os.org/redox-os/redox/-/issues/1710#note_42622) for Redox.
More help would be appreciated.
We would ideally like a written-in-Rust solution with an MIT or other permissive license,
but a good screen reader is not a small undertaking,
and requires expertise in meeting the expectations of users.

There are many other areas of accessibility to address,
and we would like to find contributors that can help us
ensure that Redox meets the needs of as many users as possible.

## Join Us!

There's lots of exciting work ahead,
and a great team already working on it.
If you would like to be part of the team,
or just listen in to the conversation,
please join us on [Redox Chat](https://doc.redox-os.org/book/chat.html). 
