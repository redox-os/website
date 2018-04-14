+++
title = "Redox Summer of Code"
+++

Redox OS is running its own Summer of Code this year, after the [Microkernel devroom](http://gsoc.microkernel.info/)
did not get accepted into [GSoC 2018](https://summerofcode.withgoogle.com/). We
are looking for both [Students](#students) and [Sponsors](#sponsors) who want to
help Redox OS grow.

<a id="sponsors"></a>
## Becoming a Sponsor

At the moment, Redox OS has $10,800 in donations from various platforms to use
to fund students. This will give us three students working for three months, if
each student requests $1200 per month on average as described in [Payment](#payment).

In order to fund more students, we are looking for sponsors who are willing to
fund RSoC. Donations can be made on the [Donate](https://www.redox-os.org/donate/)
page. All donations will be used to fund Redox OS activities, with about 90% of
those over the past year currently allocated to RSoC.

<a id="students"></a>
## Becoming a Student

If you would like to sign up as a RSoC student with Redox OS, please send an
email to [info@redox-os.org](mailto:info@redox-os.org) with the following
information:

- Your name, or whatever you would like to be referred to

- Your location, ideally identifying which time zone you are in

- Your programming background, with links to source code if available

- Your project idea, please see [Projects](#projects) for examples.

- Your estimated start and end date, ideally from June 1st to August 31st.

- Your desired payment, see [Payment](#payment) for more information.

RSoC provides more freedom than the GSoC program. Any person can participate, on
a schedule of their choosing, for the payment of their choosing.

<a id="payment"></a>
## Payment

Students are free to request any amount, to be paid monthly. A good guideline is
to use this [cost of living index](https://www.expatistan.com/cost-of-living/index)
times $12 per month.

For example, if the index is 100, such as in Prague, the student would be
expected to request $1200 per month, or a total of $3600 for three months.

This matches with the [GSoC stipends](https://developers.google.com/open-source/gsoc/help/student-stipends),
but provides more accuracy than on a per-country measurement.

<a id="projects"></a>
## Projects

The following is a list of project ideas. This list is meant to provide
suggestions, as students can propose working on a project not included below.

- [ARM 64-bit Support](#aarch64)
- [USB HID Input Driver](#usbhid)
- [Intel Graphics Framebuffer Driver](#intelfb)
- [Port Mesa with Software Rendering](#mesa)
- [IP Fragmentation Support](#ip-fragmentation)
- [Port Tokio](#tokio)
- [FAT32 Filesystem Driver](#fat32)

<a id="aarch64"></a>
## ARM 64-bit Support

Port Redox OS to the AArch64 architecture

### Details

The purpose of this project is to port Redox OS to a 64-bit ARM device, such as
the Raspberry Pi. This project will begin with porting the kernel, implementing
memory detection, paging, and security ring support. After userspace binaries
can be launched, the cookbook recipes required to launch a shell on a serial
port should be ported. If the project is finished early, work could begin on
framebuffer support, allowing the graphics stack of Redox to be ported.

### Expected Outcome

The expected outcome of this project is to run Redox OS on a device such as the
Raspberry Pi, with full support for a shell on a serial port.

### Skills Preferred

Experience with ARM devices is preferred. The student is expected to learn about
the Redox OS kernel and to research their device of choice thoroughly during the
project.

### Mentors

[Jeremy Soller](https://github.com/jackpot51/) and
[Robin Randhawa](https://github.com/raw-bin/)

### Difficulty

Hard

<a id="usbhid"></a>
## USB HID Input Driver

Implement a USB HID input driver for Redox OS

### Details

The purpose of this project is to implement a userspace driver for USB HID
devices that correctly provides keyboard and mouse information to the Redox
input stack. This project will begin with working on the USB stack to support
userspace class drivers. After support for class drivers is complete, work can
begin on a HID descriptor parser. After parsing the HID descriptor, input data
can be collected and then passed to the input stack. Any modification necessary
to the input stack to support various HID input should be made to complete this
project. Should this project be finished early, work could begin on supporting
other HID devices, such as game controller input.

### Expected Outcome

The expected outcome of this project is to support multiple off-the-shelf USB
keyboards and mice to be used for input on a computer running Redox OS.

### Skills Preferred

Experience with USB devices is preferred, but not strictly required. The student
is expected to learn about the Redox OS input stack and USB stack during the
project.

### Mentors

[Jeremy Soller](https://github.com/jackpot51/)

### Difficulty

Hard, mainly due to the complexity of the USB HID descriptor

<a id="intelfb"></a>
## Intel Graphics Framebuffer Driver

Implement an Intel Graphics framebuffer driver for Redox OS

### Details

The purpose of this project is to implement a userspace driver for Intel
Graphics devices that allows for setting native display resolutions and provides
a linear framebuffer to the orbital display daemon. First, a PCI driver that
detects and initializes Intel Graphics devices will need to be written. After
the devices can be initialized, the EDID information will need to be retrieved
and parsed. Using the EDID information, the resolution of the primary output
will need to be set to its native resolution, and a linear framebuffer will need
to be acquired. This framebuffer is then provided to orbital, the Redox display
server, using a memory-mapped file. If this project is finished early, work
could begin on implementing multi-display support.

### Expected Outcome

The expected outcome of this project is to support several common Intel Graphics
devices, allowing for EDID information to be read, resolutions to be set, and
a linear framebuffer to be acquired.

### Skills Preferred

Experience with writing graphics-related code is preferred, but not required. The
student is expected to learn about the Redox OS graphics stack and to research
Intel Graphics during the project.

### Mentors

[Jeremy Soller](https://github.com/jackpot51/)

### Difficulty

Medium

<a id="mesa"></a>
## Port Mesa with Software Rendering

Port Mesa with Software Rendering using the llvmpipe driver

### Details

The purpose of this project is to port Mesa and the llvmpipe driver to Redox OS.
This project will begin with making modifications to Mesa so that it compiles
correctly with the Redox cross compiler. After it compiles correctly, a simple
application making use of OSMesa will be written and tested. Modifications will
be made to Mesa, newlib, and other parts of Redox as necessary to fix any test
failures. After OSMesa works correctly, a backend for orbital will be added to
Mesa. Finally, llvmpipe will be ported, utilizing this new backend, and a test
application such as glxgears will be demonstrated.

### Expected Outcome

The expected outcome of this project is to be able to run a simple OpenGL
example, such as glxgears, on Redox OS using llvmpipe as the rendering backend.

### Skills Preferred

Experience with 3D graphics is preferred, especially experience with OpenGL on
Linux. The student is expected to learn about the Redox OS graphics stack during
the project.

### Mentors

[Jeremy Soller](https://github.com/jackpot51/) and
[Ian Douglas Scott](https://github.com/ids1024)

### Dificulty

Medium

<a id="ip-fragmentation"></a>
## IP Fragmentation Support

Add support for IP Fragmentation to the network stack used by RedoxOS

### Details:
The purpose of this project is to add IP fragmentation support to the network
stack used by RedoxOS ([smoltcp]). This project will begin with adding basic support
for correctly processing fragmented IP packets in [smoltcp] as outlined in the upstream
issue [smoltcp#54]. After support is added in [smoltcp], the [netstack] implementation
should be updated to synchronize with any updates to the interface defined in the
upstream repository. If the project is finished early, work could begin on path based
MTU discovery.

### Expected Outcome:
The expected outcome of this project is that fragmented IP packets are able to
be correctly processed by the network stack used by RedoxOS.

### Skills Preferred:
Experience with network stacks and the [IPv4] and [IPv6] RFCs is preferred but
not strictly required.

### Mentors:
[Jeremy Soller](https://github.com/jackpot51/),
[Dan Robertson](https://github.com/dlrobertson/), and
[Egor Karavaev](https://github.com/batonius/)

### Difficulty:
Medium

[IPv4]: https://tools.ietf.org/html/rfc791
[IPv6]: https://tools.ietf.org/html/rfc8200
[netstack]: https://github.com/redox-os/netstack
[smoltcp]: https://github.com/m-labs/smoltcp
[smoltcp#54]: https://github.com/m-labs/smoltcp/issues/52

<a id="tokio"></a>
## Port Tokio

Port tokio to support a number of asynchronous Rust programs

### Details

The purpose of this project is to port mio and tokio to Redox OS. This project
will begin by making modifications to mio and tokio to have them compile
correctly on Redox OS. After they compile, examples of tokio usage
[here](https://github.com/tokio-rs/tokio/tree/master/examples) will be
tested. Test failures will be addressed until a majority of the examples work
on Redox OS. If the project is finished early, work could begin on porting the
net2 crate, and addressing the remaining test failures.

### Expected Outcome

The expected outcome of this project is to support a number of asynchronous Rust
programs on Redox OS, such as the examples
[here](https://github.com/tokio-rs/tokio/tree/master/examples).

### Skills Preferred

Experience with asynchronous I/O is preferred, but not required. The student is
expected to learn about the Redox OS event stack and to research mio and tokio
during the project.

### Mentors

[Jeremy Soller](https://github.com/jackpot51/) and
[Ian Douglas Scott](https://github.com/ids1024)

### Dificulty

Easy

<a id="fat32"></a>
## FAT32 Filesystem Driver

Implement a FAT32 filesystem driver for Redox OS

### Details

The purpose of this project is to implement a driver for FAT32 filesystems on
Redox OS. This project will begin with partition detection using MBR and GPT
partition tables. After partitions can be detected, filesystems will be checked
for known filesystem types. A FAT32 driver will be launched for any detected
FAT32 filesystem. This driver will support both read and write functionality,
using RedoxFS as an example implementation to compare against. If the project
is finished early, work could begin on other filesystem types.

### Expected Outcome

The expected outcome of this project is for Redox OS to automatically launch a
FAT32 driver for all detected FAT32 filesystems, allowing for those filesystems
to be read and modified.

### Skills Preferred

Experience with filesystems is preferred, but not required. The student is
expected to learn about the current Redox OS filesystem and to research FAT32
during the project.

### Mentors

[Jeremy Soller](https://github.com/jackpot51/)

### Dificulty

Easy
