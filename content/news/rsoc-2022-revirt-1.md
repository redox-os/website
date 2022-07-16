+++
#title = "RSoC 2022: Revirt - Virtualization on Redox OS"
title = "RSoC 2022: DO NOT PUBLISH THIS!!!!"
author = "Enygmator"
date = "2022-07-13T04:35:30.295Z"
+++

Hey everybody, this blog post is meant for anybody interested in virtualization and/or virtualization in redox. It tries to start with definitions to help thse who only know what VMs are ata  basic level, and goes pretty deep into how we are implementing it. It's a little like a story, a little like documentation, a little like a project progress report and most assuredly **very exciting**!

WRITE MORE HERE in INTRO!!!!!!!!!

# Long term Project Plan
We will implement this project in two phases. Do note that these steps are a very hig-level overview and a lot of things can go awry, forcing us to change course.

> NOTE: The terminologies used are explained later on....

## Phase 1 - Revirt-U
This is Type 2 virtualization
1. create the `revirt_u` kernel component (Imitate AkarOS)
2. create `revirt_u` HAV API 
3. Create Revirter - VMM that uses `revirt_u` HAV API 
4. Provide basic QEMU (VMM) support for Revirt-U

### future possibilities for Revirt-U
1. libvirt
2. virtio
3. advanced/complete QEMU
4. rust-vmm

## Phase 2 - Revirt-K
This is Type 1 virtualization
1. Reuse `revirt-u`'s code to be deployed at kernel launch and test `dom_u` (unprivileged) VMs
2. Paravirtualize Redox to run as PVM in order to manage hardware devices and control `dom_u` VMs
3. Provide Linux compatibility to boot as `dom_u` VM

### future possibilities for Revirt-U
1. Provide Linux compatibility to boot as `dom_p` (privileged) VM
2. Qubes OS based on Revirt-K

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

# Details explaining the long term project plan

# Virtualization in Redox
There are a lot of terminologies for various types of virtualization technology out here; not all of which agree with each other. So, I do my best to describe the terms, as and when I use them.

## Hardware Level Virtualization
This is where the hardware is virtualized/abstracted, so as to present the guest OS with the view of the hardware that you want to see, but the instructions for most part are directely executed on the CPU, as the ISA for which the guest OS was compiled and the ISA of the Hardware which is being virtualizaed are the same.

There are 2 types:
- One is **similar to ISA-level virtualization** except that instructions are executed on the same ISA, and only a subset of instructions are emulated via binary translation (due to privilege levels, control, etc.). Other methods are also used. like: paging in x86 is managed by shadow pagetables.
   Example: Bochs (KIND OF COMPLETED)
- The other type is **Hardware-assisted virtualization**, where the **instruction set architecture (ISA)** of the hardware being virtualized **includes hardware support for virtualization**, where hardware assitance is provided for emulation (like EPT for virtualized paging support in x86)
   example: Intel VT-x (KVM, Xen)

> **Paravirtualization**: 
> It is an implementation detail (feature) that can be used in *all types of hardware virtualization* and *ISA-level virtualization*, to make virtualization faster and better.
> 
> This is where the guest OS is aware of the fact that it's running in a VM and takes advantage of that by communicating with the host, increasing performance. This enables virtualization even on non-virtualizable device (ISA-level virtualization).
> 
> **PV**: paravirtualized mode
> **HVM**: Hardware-based (assisted) virtualized mode
> **PVH**: Paravirtual + Hardware mode
> 
> **PVH**: Guests use CPU hardware support for memory operations and privileged CPU instructions and are able to use native instructions for most other things, requiring only slight modification of the guest OS. Paravirtual IO drivers are used for performance.


### Hardware-Assisted virtualization (Revirt)
For specific implementation details of type-1 and type-2 hypervisors, scroll down.

#### Revirt-K : Type-1 hypervisor
This is a feature that enables Hardware-assisted HAL virtualization - a type 1 hypervisor. This could be an alternative to Xen, Hyper-V, KVM, etc.

Revirt-K (`revirt_k`) is a VMM that can spawn and control VMs. At Redox OS kernel startup, it will enable a few features and run procedures by which Redox OS automatically becomes a type-1 hypervisor. 

This is a possibility and a "good" one at that because Redox is a microkernel, which leaves out all of the userspace stuff to the userspace. Therefore the userspace programs/drivers are **not loaded** at runtime, instead `revirt_k` kicks in (as a type-1 hypervisor (VMM)) and starts up a main "Control VM" (CVM) in `dom_p` (the privileged domain), which you might be familiar with as a concept called `Dom0` by Xen. 

In case of `revirt_k`, the CVM **could run** a *paravirtualized Redox OS*. OR it could also be paravirtualized Linux (esp. useful if `revirt_k`'s interface is similar to that of Xen).

CVM is generally useful when you want to isolate the **other VMs** from the effects of components like *device drivers* that run on the Host. So, instead of the Host (Redox OS) running the *device drivers*, a new VM called a CVM is spawned at the beginning and *another OS* is loaded onto it, which in turn controls the *device drivers*. So, if the device drivers do something stupid and crash the OS, only the CVM stops (and is restarted), while the other VMs aren't generally affected.

> Though, it should be noted that Redox OS runs its drivers in the userspace, so crashing them shouldn't generally have the effect of what happens if the crash had happened on Linux.
> But implementing things this way would certainly allow for the machine to still partly continue to function, even if the Paravirtualized Redox kernel in the CVM crashes for some reason, in order to save state and even attempt to restart CVM.

This means that the CVM is a "supervisor VM" with more privileges than the other VMs, since the CVM is provided direct access to the hardware by the VMM (`revirt_k`) using device passthrough.

It will be possible to run something like QEMU on CVM in order to provide support for emulated devices, which will kind of blur the line between Type-1 and Type-2, but not too much, as the OS is still absent as the base layer, and is replaced by `Revirt-K` VMM instead.

> There can only be one VMM in this case, and it is the software that startsup first (like an OS) and controls the hardware directly, and schedules the VMs directly onto the hardware, as there is no middleware (OS), because the VMM itself is like mini-base OS *just for running and managing VMs - aka the VMM (hypervisor)*.

> Revirt-K is **independent of Redox OS**. 
> **How?** Revirt-K is a VMM that is a replacement for a traditional OS. This means that it still has to *partly (initially)* boot up *like an OS* (stuff like the bootloader). Therefore the **base code** of Redox OS (bootloader + a part of kernel) is *used in* Revirt-K. 

So, potential users of Revirt-K technology - Qubes OS (which currently uses Xen as the type-1 hypervisor)


#### Revirt-U : Type-2 hypervisor
We currently intend to develop a Type 2 hypervisor, that enables any application to function as a VMM, create a VM in its own process space and control it. Running a VM as a process in the userspace (at the same level as other userspcace applications) on an OS, makes it a type-2 (aka hosted) VMM (aka hypervisor).

> There can by multiple VMMs on a Type 2 hypervisor, and each VMM can run multiple VMs, each VM with it's own OS.

The VMM can register handlers for many of the controls, but the kernel retains power of handling stuff that can compromise the OS, which includes the switching to `vmx` mode, handling EPT, creating basic VM fault handlers, etc.

So, `revirt_u` is not a VMM on its own, rather it is the *in-kernel backend component* to the VMM (like what KVM is to QEMU). The VMM itself runs as a process in userspace (like QEMU). Revirt-U is a Redox OS kernel feature that provides applications with a "Hardware-Assisted Virtualization API (HAV API)", helping the apps act like VMMs.

QEMU can be one such app (a VMM) which can use `revirt_u`'s HAV API to run hardware VMs, along with the plethora of functionality it offers when it comes to emulation.

We also intend to create `Revirter`, which will be a light-weight VMM (that uses `revirt_u`'s HAV API) solely made for Redox OS.

Other VMMs which can take advantage of Revirt-U are Firecracker, CrosVM, Cloud Hypervisor, the latter two using `rust-vmm`

##### Implementation
> we usually need system calls to transfer data between VM's memory and the VMM's memory. We aim to solve that problem here by following an implementation similar to that of AkarOS.

THIS WILL NOT MAKE TOO MUCH SENSE WITHOUT A FIGURE. Refer AkarOS here: [The VMM presentation + explanation (PDF)](http://akaros.org/papers_and_talks/ron_RISCV_VMMCP.pdf)

We want direct access to VM pages from VMM for faster emulated device communication (via shared memory). This requires mapping the VM's pages into the process's via the VMM process's page table.

> This mapping can be done on-demand, but it will be messy unless the whole "sharing pages" is implemented in the kernel; which isn't an option given the security risks (and also because Redox is a microkernel). Having it in userspace, we'll have to have a system call and involve EPT walk algorithms, etc.

We first map vmpages (EPT) to the VMM process address space (KPT). This creates the issue of syncing KPT and EPT. This is where the concept of "single fault handler" comes in. When we need to grant a page to be used at a particular GPA (HVA) we just put the HPA of the page in the KPT corresponding to that GPA, and just below it we can find the EPT and do the same insertion in a different format (EPT format).

> This ensures that we shouldn't ever have to traverse the EPT, though we still have to create the entries in it (from KPT's page fault handler)

#### General features of Revirt
##### virtio
This is a specification that needs to be implemented

##### Support for `rust-vmm`
>Support for both Revirt-K and Revirt-U

This will make Revirt usable by firecracker, cloud-hypervisor

##### Libvirt
CHECK THIS:
Libvirt like applications can then control other VMs on VMMs on the device. The VMM can register schemes, which libvirt like apps can then register handlers on???

##### QEMU
QEMU support for this is required. (probably via a parameter `-revirt`)



# REFERENCES

## KVM
### Implementation
KVM in Linux implements VMs by opening a device on `/dev`.

## bhyve
- Type 2 hypervisor
- similar to KVM

## Xen
### Resources
- [info wiki](https://wiki.xenproject.org/wiki/Xen_Project_Software_Overview)
- [xen docs](https://xenproject.org/help/documentation/)
- 

> "info wiki" also contains architecture information. This page has a lot of useful information on type 1 #hypervisor architectural options!

Features:
- A type-1 baremetal hypervisor
- Has a control domain
- Supports `Dom0` disaggregation (moving stuff into `DomU`s)
- Device passthroughs

### `Dom0`
Dom0 is essentially a virtual machine running ontop of the bare metal hypervisor, it runs with higher privileges for management purposes. Other domains run under the hypervisor coexisting with dom0, not ontop of it.

It is worth noting that the `Dom0` and `DomU` features will be really useful for Redox.

Xen seems to run `Dom0` as a real VM, which provides driver support. We'll have to see if Linux can be used as a PV guest OS for Dom0.


### Qubes OS
[Xen + qubes](archhttps://www.qubes-os.org/doc/architecture/)

1. [KVM vs Xen (architecture figures)](https://forum.huawei.com/enterprise/en/comparison-of-kvm-and-xen-technologies/thread/773247-893?page=2)











