+++
title = "Virtualized Redox: from Virtio-FS to Cloud Hypervisor, and beyond"
author = "MJ Pooladkhay"
date = "2026-11-01"
+++

Hello, Reader!

I'm [MJ Pooladkhay](https://pooladkhay.com), and for the past couple of months I have been building a [Virtio-FS](https://virtio-fs.gitlab.io/) driver for Redox OS and, more recently, getting Redox to run on [Cloud Hypervisor](https://www.cloudhypervisor.org/). The driver is merged into the [base repo](https://gitlab.redox-os.org/redox-os/base/-/tree/main/drivers/storage/virtio-fsd), where most Redox drivers and system daemons live. The kernel, bootloader and driver changes that let Redox boot to a shell on Cloud Hypervisor are merged too ([details below](#booting-on-cloud-hypervisor)).

Both are fun pieces of work on their own, but they are really the first steps of a bigger effort with two directions:

- **Redox as a guest**: Redox runs as a cloud server, starting with Cloud Hypervisor, without the legacy PC hardware it used to depend on. Most of this post is about this one.
- **Redox as a host**: Redox runs virtual machines itself. This one is still a proposal, and I'll go over it [at the end of this post](#looking-further-redox-as-a-host).

The guest work is generously funded by [NGI Zero Commons](https://nlnet.nl/commonsfund/) and [NLnet](https://nlnet.nl/) as part of the [Virtualized Redox](https://nlnet.nl/project/Redox-virtualised-microservices/) grant.

## Why run Redox as a guest?

Most internet-facing software today runs in virtual machines, either in the cloud or on edge servers close to its users. Web servers, databases, API backends and microservices spend all day handling input from strangers, and that is where a memory-safe microkernel has the most to offer:

- **A smaller, safer base.** Redox is written in Rust, and its drivers, filesystems and network stack run as separate userspace processes instead of inside the kernel ([microkernel architecture](https://doc.redox-os.org/book/microkernels.html)). A bug in one of them takes down that process, not the whole system, and the code running with full kernel privileges stays small.
- **Sandboxing built in.** With [capability-based security](/news/nlnet-cap-nsmgr-cwd/), each service can be limited to the files, sockets and devices it actually needs ([more on that below](#putting-the-pieces-together)).
- **Hardware becomes the host's problem.** On bare metal, Redox needs a driver for every disk controller, network card and chipset it meets. Inside a VM, the host deals with the hardware, and Redox only needs a handful of virtio drivers. That makes a VM one of the quickest paths to running Redox in the real world, and real-world use is the best way to prove it as a secure platform.

This is the direction the project set in its [development priorities](/news/development-priorities-2025-09/): Redox as a secure host for web services, first as a private or edge server, and eventually as a multi-tenant cloud server where each tenant is isolated from others.

## Running without a PC

So far, Redox has been run either on QEMU or on physical hardware. On both, it has leaned on devices that date back to the original IBM PC/AT: a pair of [8259 programmable interrupt controllers (PIC)](https://wiki.osdev.org/8259_PIC), the [programmable interval timer (PIT)](https://wiki.osdev.org/Programmable_Interval_Timer), a [PS/2 keyboard controller](https://wiki.osdev.org/I8042_PS/2_Controller), and so on. These are legacy even on real hardware. Modern machines, and OSes such as Linux, route interrupts through the [I/O APIC](https://wiki.osdev.org/IOAPIC) and keep time with each CPU's [local APIC timer](https://wiki.osdev.org/APIC_Timer). Redox kept using the old devices mainly because it didn't support the [ACPI](https://wiki.osdev.org/ACPI) pieces needed to set up their replacements.

Hypervisors built for the cloud, such as Cloud Hypervisor and [Firecracker](https://firecracker-microvm.github.io), drop most of the legacy devices. Cloud Hypervisor gives a guest its CPUs (each with a [local APIC](https://wiki.osdev.org/APIC)), memory, an I/O APIC, a serial port, a [real-time clock (RTC)](https://wiki.osdev.org/RTC), a minimal ACPI platform and a handful of virtio devices. Not much else. Fewer emulated devices means less code in the hypervisor for a guest to poke at, and less for the guest OS to probe and set up at boot.

These hypervisors can also skip firmware entirely and jump straight into the kernel ([PVH](https://xenbits.xen.org/docs/unstable/misc/pvh.html) direct boot). Redox doesn't do that yet and still boots through [UEFI](https://wiki.osdev.org/UEFI) firmware.

I would say Redox is a very good fit for minimal VMs like these. A VM that runs a single service doesn't need a USB stack, a sound daemon or a desktop, and since those are all ordinary userspace daemons on Redox, leaving them out is a matter of not putting them in the image.

What goes into the image, and what runs once it boots, is a short TOML file in the build system. Init services are small TOML files too, so an image can just as well boot straight into a web server, with no one logging in.

The [server demo config](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/config/x86_64/server-demo.toml) is an example of this, with SSH, PHP and the nginx configuration.

## What works today

### Virtio-FS

Virtio-FS lets a VM use a directory that lives on the host. The `virtio-fsd` daemon talks to [`virtiofsd`](https://gitlab.com/virtio-fs/virtiofsd) on the host using the [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace) protocol, carried over [virtqueues](https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-270006). Each shared directory appears as its own scheme, `/scheme/virtio-fs.<tag>`, named after the tag the host gives it, so a share can be put in or left out of a process's namespace like any other scheme. You can share more than one directory at a time.

Under the hood, the driver keeps its own cache of inodes and directory entries, and tells the host to forget the ones it hasn't used in a while (`FUSE_FORGET`, driven by an [LRU cache](https://en.wikipedia.org/wiki/Cache_replacement_policies#Least_Recently_Used_%28LRU%29)). The driver works on both QEMU and Cloud Hypervisor, and comes with a [selftest suite](https://gitlab.redox-os.org/redox-os/base/-/tree/main/selftests/virtio-fsd).

### Booting on Cloud Hypervisor

Getting Redox to a working shell on Cloud Hypervisor was mostly a matter of finding every place where it assumed it was running natively on a PC, as well as a few other gotchas:

- The bootloader failed to leave UEFI because it passed a stale memory-map key to `ExitBootServices` ([bootloader!61](https://gitlab.redox-os.org/redox-os/bootloader/-/merge_requests/61)).
- `virtio-blk` was matched as a [transitional](https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html#x1-60001) virtio device, while Cloud Hypervisor only offers modern (non-transitional) ones, so the root disk never showed up ([base!422](https://gitlab.redox-os.org/redox-os/base/-/merge_requests/422)).
- The login prompt appeared but wouldn't accept a single key. Serial output is polled, but input arrives as an interrupt, and that interrupt was aimed at an 8259 that doesn't exist. Legacy interrupts are now routed through the I/O APIC ([kernel!762](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/762)).
- Timed waits never woke up, because there is no PIT or [HPET](https://wiki.osdev.org/HPET). More on this one below.
- Telling the time needed no changes. Monotonic time already came from [`kvmclock`](https://docs.kernel.org/virt/kvm/x86/msr.html), and [`rtcd`](https://gitlab.redox-os.org/redox-os/base/-/tree/main/drivers/rtcd) sets the wall clock once at boot from the emulated CMOS RTC, after which it advances with the monotonic clock.

QEMU's q35 machine does have an 8259 and an HPET, so Redox keeps using them there exactly as before.

#### A ping that only pinged once

My favorite bug was this one: with networking up, `ping -c 4 1.1.1.1` got a reply in about 15 ms and then... just sat there, until I interrupted it:

```text
ping -c 4 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 40(68) bytes of data.
From 1.1.1.1 icmp_seq=0 time=15.304ms
Interrupted! Exiting gracefully.
--- 1.1.1.1 ping statistics ---
1 packets transmitted, 1 packets received, 0.00% packet loss
```

So the NIC, the route and the NAT on the host were all fine. Then where did the other three packets go?

They were never sent! `ping` sends the first echo right away, then asks the `time` scheme to wake it up one second later. In the kernel, that wakeup is posted by `timeout::trigger`, and the only caller of `timeout::trigger` was the PIT interrupt handler (on QEMU, the HPET drives the same interrupt line). Cloud Hypervisor has neither a PIT nor an HPET, so that handler never ran.

Reading the clock still worked, since `kvmclock` converts the CPU's [timestamp counter (TSC)](https://en.wikipedia.org/wiki/Time_Stamp_Counter) to nanoseconds whenever someone asks, which is why the first reply had a sensible round-trip time. But nothing was ticking. Every `ping -i`, and every other wait on the `time` scheme, was waiting for an interrupt that was never going to come, and a `nanosleep` only woke up when something else happened to run the scheduler. The same handler also drives the scheduler's preemption tick, so the system had quietly become cooperative: a process only gave up the CPU when it blocked or yielded.

[The fix](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/762) is to use a timer every x86 CPU already has: its local APIC timer. When there is no HPET, each CPU now arms its own local APIC timer in TSC-deadline mode, where you tell it the TSC value at which the next interrupt should fire. The tick period is converted from nanoseconds to TSC ticks using the same scale `kvmclock` already provides[^1]. The handler then does the PIT handler's old job, posting expired timeouts and driving the scheduler tick. With that in place, `ping -c 4` sends all four packets, one second apart, and Redox is preemptive again!

## Next: a deployable instance

Booting to a shell is a good start, but it's not yet something you would deploy. Here's a look at the remaining work, which is also covered by the current [NLnet grant](https://nlnet.nl/project/Redox-virtualised-microservices/):

- **Less guessing about the PC.** One description of which legacy devices the platform actually provides, used by every driver instead of each one probing on its own. Today, for example, [`ps2d`](https://gitlab.redox-os.org/redox-os/base/-/tree/main/drivers/input/ps2d) still tries to talk to a keyboard controller that isn't there and logs an error on every boot. On QEMU, those devices stay in use.
- **Power off.** Today Redox can't shut down Cloud Hypervisor by itself. Rebooting already works, through the keyboard controller's reset line, which Cloud Hypervisor emulates just for that. [`acpid`](https://gitlab.redox-os.org/redox-os/base/-/tree/main/drivers/acpid) already has a path to S5 (soft-off), but it writes the classic PM1 control register, and Cloud Hypervisor doesn't power off on that. Cloud Hypervisor is a [hardware-reduced ACPI](https://uefi.org/specs/ACPI/6.5/04_ACPI_Hardware_Specification.html#hardware-reduced-acpi) platform, where shutdown is a write to the sleep control register and the power button is a Generic Event Device (GED) interrupt that nobody handles yet. The goal is for shutdown to work both from the host and from inside the guest.
- **First-boot configuration.** A modular, [cloud-init](https://docs.cloud-init.io/en/latest/)-compatible service that sets the hostname and installs an SSH key, read from a [NoCloud](https://docs.cloud-init.io/en/latest/reference/datasources/nocloud.html) drive or the HTTP metadata service, so credentials stay out of the image.
- **PVH direct boot.** An entry point that lets the hypervisor load the kernel directly, with no firmware at all, next to the existing UEFI path. This is also what opens the door to Firecracker, which has no UEFI firmware to boot through.
- **More virtio drivers.** [`virtio-vsock`](https://man7.org/linux/man-pages/man7/vsock.7.html) for talking to the host without a network, `virtio-balloon` for returning memory to the host, and `virtio-rng` for drawing entropy from it. These join the existing `virtio-{blk, net, fs, gpu}` fleet.
- **[Snapshot and restore](https://github.com/cloud-hypervisor/cloud-hypervisor/blob/main/docs/snapshot_restore.md)**, resuming the disk, network and clock, so an instance can start from a snapshot instead of booting from scratch.
- **A regression test and a deployment guide.** A CI boot test that takes both Cloud Hypervisor and QEMU through a shell, DHCP, a four-packet ping (of course) and an HTTPS download, plus a guide that covers firmware, disks, host networking (tap, DHCP and NAT) and the first-boot config source.

## Putting the pieces together

Once the list above is done, Redox should work like any other cloud image: you launch it, it picks up its hostname and SSH key on first boot, and you log in and run your services.

The same pieces also fit more specific uses, such as short-lived instances for CI and testing, and sandboxes for AI agents (more on that one below).

Whatever runs inside the VM, Redox can stack three layers of isolation around it:

1. **The VM boundary.** The hypervisor keeps the guest away from the host. With PVH boot and snapshots, a small image can start quickly and be thrown away when its job is done.
2. **Capabilities inside the guest.** This one works today. On Redox, everything a process can touch (files, the network, devices) is reached through [a scheme](https://doc.redox-os.org/book/schemes.html), and each process only sees the schemes in its [namespace](/news/nlnet-cap-nsmgr-cwd/). Give a process the filesystem but not the network, and there is simply no network for it to reach. Its working directory is a capability too, so it can be locked inside one folder with no way to climb out.
3. **WebAssembly.** Tools compiled to WebAssembly can run under [wasmtime](https://wasmtime.dev/), inside a capability-restricted process, inside the VM. [WASI](https://wasi.dev/) is capability-based as well, so a module only sees the directories and sockets it was handed, which maps nicely onto Redox's namespaces. wasmtime is being ported as part of the same grant.

To reach the host, a misbehaving tool would have to break through all three.

And for talking to the host:

- **Shared directories.** Virtio-FS (also working today) exposes only the host directories you choose, and changes made in the guest show up on the host right away. There are no disk images to copy in or out.
- **A control channel without a network.** Once `virtio-vsock` lands, whatever manages the VM on the host can talk to software inside it, with no network interface in the guest.

### An immutable image with persistent data

A minimal image and Virtio-FS fit together nicely, because they split a system into the part that never changes and the part that has to survive.

The image holds the kernel, the drivers and the service, and nothing writes to it. Every instance boots from exactly the same bytes, an upgrade becomes just booting a new image, and a rollback is booting the old one. Redox can already run a live image entirely from memory, and the system could eventually live in [InitFS](https://doc.redox-os.org/book/boot-process.html#ramdisk-init), the in-memory filesystem Redox boots from, with no RedoxFS image at all.

Everything that has to outlive the VM, such as databases, uploads and logs, lives on the host and reaches the guest through Virtio-FS. Each share is just a scheme, so the service only gets the shares it needs, and its configuration can come in as a [read-only share](). Throw the VM away, boot a new image, point it at the same shares, and the data is still there.
<!-- link to book for readonly virtio-fs shares -->

The only catch is that Virtio-FS needs [`virtiofsd` daemon](https://gitlab.com/virtio-fs/virtiofsd) running on the host, next to the hypervisor. It's the same mechanism [Kata Containers](https://katacontainers.io/) uses to give its VMs their files. On machines you run yourself (a server, an edge box, a bare-metal cloud instance, or a cloud VM with nested virtualization), setting it up is easy. Regular public cloud VMs and Firecracker don't offer Virtio-FS, so there the persistent part goes on an ordinary attached disk instead, which already works (Redox [boots on Google Cloud](/news/this-month-260930/#redox-on-google-cloud), for example).

### A sandbox for AI agents

One potentially interesting use case is sandboxing AI agents, which needs every one of these pieces. Agents run code and tools that nobody has reviewed, and the usual answer is a throwaway VM for each task. On Redox, that VM starts from a small image or a snapshot. The agent's tool runner gets its working folder and only the other schemes it actually needs, and tools compiled to WebAssembly add another layer on top. The agent's workspace is a Virtio-FS share, so its changes land on the host as soon as it makes them, and the orchestrator talks to it over `virtio-vsock`. When the task is done, the VM is thrown away.

## Looking further: Redox as a host

The second direction flips the picture. As a guest, Redox runs on top of Linux, and Linux's drivers deal with the real hardware.

As a host, it would be the other way around. Redox runs on the hardware and uses its own drivers for the devices it supports, and a small Linux guest takes care of the ones it doesn't (say, a network card with no Redox driver yet). The device is handed to the guest through PCI passthrough ([VFIO](https://docs.kernel.org/driver-api/vfio.html) on the Linux side), and Linux offers it back to Redox through virtio. Instead of all of Linux's drivers or none of them, Redox gets to choose, and each borrowed driver can be replaced by a native one when it's ready. This is the "hosted Linux for driver support" idea from the [development priorities](/news/development-priorities-2025-09/#hosted-linux-for-driver-support), and FreeBSD already does something similar with [bhyve](https://bhyve.org/) and [wifibox](https://github.com/pgj/freebsd-wifibox), where a small Linux VM drives the Wi-Fi card.

Redox has explored hosting VMs before, with [Revirt](/news/revirt-1/) during RSoC 2022, and now we have a solid plan for it:

The kernel would gain [AMD SVM](https://en.wikipedia.org/wiki/X86_virtualization#AMD_virtualization_%28AMD-V%29) support, exposed through a new kernel scheme. It would own only what a guest must never be able to change: SVM enablement, the VMCB (the structure that holds a guest's state), the nested page tables, the virtual local APIC and the switch between host and guest. Everything else would live in an ordinary Redox process, the virtual machine monitor (VMM), which creates the VM, supplies its devices and handles its exits. It's the same split as [KVM](https://linux-kvm.org/page/Main_Page) and QEMU on Linux, but done the Redox way, through a scheme instead of ioctls.

The VMM would be a small program built on the [rust-vmm](https://github.com/rust-vmm) crates (`vm-memory`, `virtio-queue` and `linux-loader`), not a port of Cloud Hypervisor or QEMU, and it wouldn't clone `/dev/kvm` either. Its register and exit records would be KVM-compatible, though, so a Cloud Hypervisor or QEMU backend stays possible later.

The work would build up in steps:

1. A guest runs its first instructions under the new scheme.
2. Timers, interrupts and notifications between the guest and the VMM, which is where a guest kernel's patience is usually tested.
3. The VMM boots Linux.
4. [IOMMU](https://en.wikipedia.org/wiki/Input%E2%80%93output_memory_management_unit) support ([AMD-Vi, then Intel VT-d](https://en.wikipedia.org/wiki/X86_virtualization#I/O_MMU_virtualization_%28AMD-Vi_and_Intel_VT-d%29)), so a passed-through device can only reach the guest's memory. Redox's own drivers can opt in to the same DMA isolation.
5. A real NIC passed through to a Linux guest, and Redox using it for networking, first through a TAP driver, then through a virtio-net backend.

Intel VT-x guests are future work, but VT-d will be implemented.

And what would tie both directions together? A Redox guest booting on a Redox host.

## Try it and get involved

See [how to run Redox on Cloud Hypervisor](<>).
<!-- TODO: link to book once published -->

To share a directory from your host with a Redox VM over Virtio-FS, follow [this guide](<>).
<!-- TODO: link to book once published -->

If you want to help, or just follow along, join us on [Matrix](https://matrix.to/#/#redox-join:matrix.org) and take a look at the [issue tracker](https://gitlab.redox-os.org/redox-os/redox/-/issues).

[^1]: The period is computed once, from the `kvmclock` scale at boot. If the VM is migrated to a host with a different TSC frequency, the tick rate changes with it. That one is on my TODO list.
