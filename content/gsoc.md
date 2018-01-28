+++
title = "Google Summer of Code"
+++

Redox OS is participating in [GSoC 2018](https://summerofcode.withgoogle.com/)
with the [Microkernel devroom](http://gsoc.microkernel.info/). If you would like
to sign up as a GSoC student with Redox OS, please send an email to
[info@redox-os.org](mailto:info@redox-os.org). The following is a list of
project ideas. This list is meant to provide suggestions, as students can
propose working on a project not included below.

- [ARM 64-bit Support](#aarch64)
- [USB HID Input Driver](#usbhid)
- [Intel Graphics Framebuffer Driver](#intelfb)
- [Port Mesa with Software Rendering](#mesa)
- [Port Tokio](#tokio)
- [FAT32 Filesystem Driver](#fat32)

<a id="aarch64"></a>
## ARM 64-bit Support

Port Redox OS to the AArch64 architecture

### Details

...

### Expected Outcome

...

### Skills Preferred

...

### Mentors

Jeremy Soller

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

Jeremy Soller

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

Experience with writing graphics-related code is prefered, but not required. The
student is expected to learn about the Redox OS graphics stack and to research
Intel Graphics during the project.

### Mentors

Jeremy Soller

### Difficulty

Medium

<a id="mesa"></a>
## Port Mesa with Software Rendering

Port Mesa with Software Rendering using the llvmpipe driver

### Details

...

### Expected Outcome

...

### Skills Preferred

...

### Mentors

Jeremy Soller

### Dificulty

Medium

<a id="tokio"></a>
## Port Tokio

Port tokio to support a number of asynchronous Rust programs

### Details

...

### Expected Outcome

...

### Skills Preferred

...

### Mentors

Jeremy Soller

### Dificulty

Easy

<a id="fat32"></a>
## FAT32 Filesystem Driver

Implement a FAT32 filesystem driver for Redox OS

### Details

...

### Expected Outcome

...

### Skills Preferred

...

### Mentors

Jeremy Soller

### Dificulty

Easy
