+++
title = "Virtualized Redox: from Virtio-FS to Cloud Hypervisor, and beyond"
author = "MJ Pooladkhay"
date = "2026-10-31"
+++

<!-- Alternative titles:
- Virtualized Redox: Cloud Hypervisor, agent sandboxes, and a path to hosting VMs
- Virtualized Redox: a microkernel guest for the cloud, and a host in the future
-->

Hello, Reader!

I'm [MJ Pooladkhay](https://pooladkhay.com), and for the past couple of months I have been building a [Virtio-FS](https://virtio-fs.gitlab.io/) driver for Redox OS and, more recently, getting Redox to run on [Cloud Hypervisor](https://www.cloudhypervisor.org/). The driver is merged into the [base repo](https://gitlab.redox-os.org/redox-os/base/-/tree/main/drivers/storage/virtio-fsd), where most Redox drivers and system daemons live. The kernel, bootloader and driver changes that let Redox boot to a shell on Cloud Hypervisor are merged too ([details below](#booting-on-cloud-hypervisor)).

Both are fun pieces of work on their own, but they are really the first steps of a bigger effort with two directions:

- **Redox as a guest**: Redox runs as a cloud server, starting with Cloud Hypervisor, without the legacy PC hardware it used to depend on. Most of this post is about this one.
- **Redox as a host**: Redox runs virtual machines itself. This one is still a proposal, and I'll go over it [at the end of this post](#looking-further-redox-as-a-host).

The guest work is funded by [NGI Zero Commons](https://nlnet.nl/commonsfund/) and [NLnet](https://nlnet.nl/) as part of the [Virtualized Redox](https://nlnet.nl/project/Redox-virtualised-microservices/) grant.

## Why run Redox as a guest?

So far, Redox has been run either on QEMU or on physical hardware. Both need to keep working, but both look like a PC: a pair of 8259 interrupt controllers from the original PC/AT, a programmable interval timer (PIT), a PS/2 keyboard controller, and so on. Hypervisors built for the cloud, such as Cloud Hypervisor and [Firecracker](https://firecracker-microvm.github.io), drop most of that. Cloud Hypervisor gives a guest its CPUs (each with a local APIC), memory, an I/O APIC, a serial port, a real-time clock, a minimal ACPI platform and a handful of virtio devices. Not much else. Fewer emulated devices means less code in the hypervisor for a guest to poke at, and less for the guest OS to probe and set up at boot.

These hypervisors can also skip firmware entirely and jump straight into the kernel (PVH direct boot). Redox doesn't do that yet and still boots through UEFI firmware.

I would say Redox is a very good fit for this. The kernel is small and everything else, drivers included, is a userspace daemon ([microkernel architecture](https://doc.redox-os.org/book/microkernels.html)), so an image only has to carry the pieces it actually uses. A VM that runs a single service doesn't need a USB stack, a sound daemon or a desktop, and on Redox, leaving them out is a matter of not putting them in the image.

## What works today

### Virtio-FS

Virtio-FS lets a VM use a directory that lives on the host. The `virtio-fs` driver talks to [`virtiofsd`](https://gitlab.com/virtio-fs/virtiofsd) on the host using the FUSE protocol, carried over virtqueues. Each shared directory appears as its own scheme, `/scheme/virtio-fs.<tag>`, named after the tag the host gives it, so a share can be put in or left out of a process's namespace like any other scheme. You can share more than one directory at a time.

Under the hood, the driver keeps its own cache of inodes and directory entries, and tells the host to forget the ones it hasn't used in a while (`FUSE_FORGET`, driven by an LRU). The driver works on both QEMU and Cloud Hypervisor, and comes with a selftest suite.

### Booting on Cloud Hypervisor

Getting Redox to a working shell on Cloud Hypervisor was mostly a matter of finding every place where it assumed it was running on a PC, as well as a few other gotchas:

- The bootloader failed to leave UEFI because it passed a stale memory-map key to `ExitBootServices`.
- `virtio-blk` was matched as a legacy virtio device, while Cloud Hypervisor only offers modern (non-transitional) ones, so the root disk never showed up.
- The login prompt appeared but wouldn't accept a single key. Serial output is polled, but input arrives as an interrupt, and that interrupt was aimed at an 8259 that doesn't exist. Legacy interrupts are now routed through the I/O APIC.
- Timed waits never woke up, because there is no PIT or HPET. More on this one below.
- Telling the time needed no changes. Monotonic time already came from `kvmclock`, and `rtcd` sets the wall clock once at boot from the emulated CMOS RTC, after which it advances with the monotonic clock.

QEMU's q35 machine does have an 8259 and an HPET, so Redox keeps using them there exactly as before.

#### A ping that only pinged once

My favorite bug was this one: With networking up, `ping -c 4 1.1.1.1` got a reply in about 15 ms and then... just sat there, until I interrupted it:

```text
ping -c 4 1.1.1.1
PING 1.1.1.1 (1.1.1.1) 40(68) bytes of data.
From 1.1.1.1 icmp_seq=0 time=15.304ms
Interrupted! Exiting gracefully.
--- 1.1.1.1 ping statistics ---
1 packets transmitted, 1 packets received, 0.00% packet loss
```

So the NIC, the route and the NAT on the host were all fine. Then where did the other three packets go?

They were never sent. `ping` sends the first echo right away, then asks the `time` scheme to wake it up one second later. In the kernel, that wakeup is posted by `timeout::trigger`, and the only caller of `timeout::trigger` was the PIT interrupt handler (on QEMU, the HPET drives the same interrupt line). Cloud Hypervisor has neither a PIT nor an HPET, so that handler never ran. Reading the clock still worked, since `kvmclock` converts the CPU's timestamp counter (TSC) to nanoseconds whenever someone asks, which is why the first reply had a sensible round-trip time. But nothing was ticking. Every `ping -i`, and every other wait on the `time` scheme, was waiting for an interrupt that was never going to come, and a `nanosleep` only woke up when something else happened to run the scheduler. The same handler also drives the scheduler's preemption tick, so the system had quietly become cooperative: a process only gave up the CPU when it blocked or yielded.

The fix is to use a timer every x86 CPU already has: its local APIC timer. When there is no HPET, each CPU now arms its own local APIC timer in TSC-deadline mode, where you tell it the TSC value at which the next interrupt should fire. The tick period is converted from nanoseconds to TSC ticks using the same scale `kvmclock` already provides[^1]. The handler then does the PIT handler's old job, posting expired timeouts and driving the scheduler tick. With that in place, `ping -c 4` sends all four packets, one second apart, and Redox is preemptive again!

## Next: a deployable instance

Booting to a shell is nice, but still not in a state you would call "deployable". Here's what's missing:

- **Less guessing about the PC.** One description of which legacy devices the platform actually provides, used by every driver instead of each one probing on its own. Today, for example, `ps2d` still tries to talk to a keyboard controller that isn't there and logs an error on every boot. On QEMU, those devices stay in use.
- **Power off.** Today Redox can't shut down Cloud Hypervisor by itself. Rebooting already works, through the keyboard controller's reset line, which Cloud Hypervisor emulates just for that. `acpid` already has a path to S5 (soft-off), but it writes the classic PM1 control register, and Cloud Hypervisor doesn't power off on that. Cloud Hypervisor is a hardware-reduced ACPI platform, where shutdown is a write to the sleep control register and the power button is a Generic Event Device (GED) interrupt that nobody handles yet. The goal is for shutdown to work both from the host and from inside the guest.
- **First-boot configuration.** A modular, cloud-init-compatible service that sets the hostname and installs an SSH key, read from a NoCloud drive or the HTTP metadata service, so credentials stay out of the image.
- **PVH direct boot.** An entry point that lets the hypervisor load the kernel directly, with no firmware at all, next to the existing UEFI path. This is also what opens the door to Firecracker, which has no UEFI firmware to boot through, and it's when boot-time numbers will start to mean something.
- **More virtio drivers.** `virtio-vsock` for talking to the host without a network, `virtio-balloon` for returning memory to the host, and `virtio-rng` for drawing entropy from it. These join the existing `virtio-blk`, `virtio-net`, `virtio-fs` and `virtio-gpu`.
- **Snapshot and restore**, resuming the disk, network and clock, so an instance can start from a snapshot instead of booting from scratch.
- **A regression test and a deployment guide.** A CI boot test that takes both Cloud Hypervisor and QEMU through a shell, DHCP, a four-packet ping (of course) and an HTTPS download, plus a guide that covers firmware, disks, host networking (tap, DHCP and NAT) and the first-boot config source.

## Where this leads

The most general goal is Redox as a cloud server. You launch it from an image, it picks up its hostname and SSH key on first boot, and you log in and run your services on it, just like any other cloud image. Most of the list above is about getting there.

Once that works, the same pieces also fit more specific uses, such as a single service bundled with only the kernel and the daemons it needs, short-lived instances for CI and testing that start from a snapshot instead of booting from scratch, and sandboxes for AI agents (more on that one below).

Whatever runs inside the VM, Redox can stack three layers of isolation around it:

1. **The VM boundary.** The hypervisor keeps the guest away from the host. With PVH boot and snapshots, a small image can start quickly and be thrown away when its job is done.
2. **Capabilities inside the guest.** This one works today. On Redox, everything a process can touch (files, the network, devices) is reached through [a scheme](https://doc.redox-os.org/book/schemes.html), and each process only sees the schemes in its [namespace](/news/nlnet-cap-nsmgr-cwd/). Give a process the filesystem but not the network, and there is simply no network for it to reach. Its working directory is a capability too, so it can be locked inside one folder with no way to climb out.
3. **WebAssembly.** Tools compiled to WebAssembly can run under [wasmtime](https://wasmtime.dev/), inside a capability-restricted process, inside the VM. WASI is capability-based as well, so a module only sees the directories and sockets it was handed, which maps nicely onto Redox's namespaces. wasmtime is being ported as part of the same grant.

And for talking to the host:

- **Shared directories.** Virtio-FS (also working today) exposes only the host directories you choose, and changes made in the guest show up on the host right away. There are no disk images to copy in or out. The read-only part of the system could even live in InitFS, the in-memory filesystem Redox boots from, with no RedoxFS image at all.
- **A control channel without a network.** `virtio-vsock` lets whatever manages the VM on the host talk to software inside it, with no network interface in the guest.

### A sandbox for AI agents

One potentially interesting use case is sandboxing AI agents, which needs every one of these pieces. Agents run code and tools that nobody has reviewed, and the usual answer is a throwaway VM for each task. On Redox, that VM starts from a small image or a snapshot. The agent's tool runner gets its working folder and nothing else if not needed, and tools compiled to WebAssembly add another layer on top. The agent's workspace is a Virtio-FS share, so its changes land on the host as soon as it makes them, and the orchestrator talks to it over `virtio-vsock`. When the task is done, the VM is thrown away.

## Looking further: Redox as a host

The second direction is running virtual machines on Redox. Redox has explored this before, with [Revirt](/news/revirt-1/) during RSoC 2022, and we've now proposed a new plan for it.

The kernel would gain AMD SVM support, exposed through a `revirt:` kernel scheme, and a small virtual machine monitor (VMM) built on the [rust-vmm](https://github.com/rust-vmm) crates would boot an unmodified Linux guest. The kernel would own only what a guest must never be able to change: the nested page tables, the virtual local APIC and the switch between host and guest. Everything else, from loading the guest kernel to emulating its devices, would live in an ordinary Redox process. It's the same split as KVM and QEMU on Linux, but done the Redox way, through a scheme instead of ioctls.

The work would build up in steps:

1. A guest executes its first instructions under the new scheme, tested with Redox itself running nested under KVM.
2. Timers, interrupts and multiple vCPUs, which is where a guest kernel's patience is usually tested.
3. The VMM boots Linux to a shell on a serial console, with a virtio-blk root disk and networking.
4. IOMMU support (AMD-Vi, then Intel VT-d), which lets a physical PCIe device such as an NVMe drive or a NIC be passed through to a guest. It also gives Redox's own drivers an option for IOMMU-enforced DMA isolation.

Intel VT-x is a separate extension to the plan. The scheme would be split into a vendor-neutral layer and an SVM backend from the start, so a VT-x backend can be added later without a refactor.

And the milestone that would tie both directions together? A Redox guest booting on a Redox host.

## Try it and get involved

See [how to run Redox on Cloud Hypervisor](<>).
<!-- TODO: link to book once published -->

To share a directory from your host with a Redox VM over Virtio-FS, follow [this guide](<>).
<!-- TODO: link to book once published -->

If you want to help, or just follow along, join us on [Matrix](https://matrix.to/#/#redox-join:matrix.org) or take a look at the [issue tracker](https://gitlab.redox-os.org/redox-os/redox/-/issues).

[^1]: The period is computed once, from the `kvmclock` scale at boot. If the VM is migrated to a host with a different TSC frequency, the tick rate changes with it. That one is on my TODO list.
