+++
title = "Revirt - Virtualization on Redox OS"
author = "Enygmator"
date = "2022-07-18T04:35:30.295Z"
+++

Hey there everyone! I'm <font color="#fd098f">Eny</font><font color="#a58f01">gma</font><font color="#009ffd">tor</font> and I'm back with some exciting news!

<br/>

### Outline

1. **Prologue** (what to expect)
2. **Intro to Revirt** (The hypervisor for Redox OS)
3. **Virtualization** (a recap of concepts)
4. **Hardware-level Virtualization** (a little in depth understanding)
   * **Paravirtualization** (and how it works with Hardware-level Virtualization)
5. **Revirt** (A detailed overview)
   1. **Revirt-K** (The Type-1 hypervisor for Redox OS)
   2. **Revirt-U** (The Type-2 hypervisor for Redox OS)
      * **Revirter** (The custom VMM for Redox OS that will use the Revirt-U backend)
   3. **Other Uses for Revirt**
6. **The Project Plan**
   1. **Phase-1** (Revirt-U)
   2. **Phase-2** (Revirt-K)
7. **References** (that served as inspiration for Revirt implementation)
8. **Epilogue**
   * **Until Later!**

<br/>

# Prologue

I am one of the **RSoC (Redox Summer of Code) students this year (2022)**.

Last year, as part of RSoC 2021, I was working on porting QEMU to Redox OS ([refer post - RSoC 2021: QEMU on Redox OS - Part 1](https://redox-os.org/news/rsoc-2021-qemu-1/)). You can read the progress update on that in this [post - Bochs on Redox OS (and QEMU - Part 2)](https://redox-os.org/news/bochs-qemu-2/). While the QEMU port is nearing success, it felt prudent that the next step should be to enable **Hardware-Assisted, Hardware-level virtualization** on Redox, in order to be able to run virtual machines faster and more effectively.

So, as part of RSoC 2022, I have been working on introducing **Virtualization on Redox OS**. This feature/technology is called **Revirt** and has wide-ranging consequences for Redox OS as a secure, well-designed, virtualizable and effective operating system. 🎉

**Do note that this document will NOT contain any technical details about the implementation, as I've put all of that in the next post - [RSoC 2022: Revirt-U - Part 1](https://redox-os.org/news/rsoc-2022-revirt-u-1/).**

<br/>

This blog post is meant for those persons interested in virtualization and/or virtualization in Redox. If you know your stuff, you can skip the initial parts, as I kept it "simple and stupid" in order to encourage beginners to read the post and pique their interest.

It starts with definitions and technological explanations in order to help 'beginners' understand what this new feature will bring to Redox OS. The post then goes on to lay out a plan for the future of virtualization on Redox OS, while discussing the various methods of implementation, benefits, etc.

_It's a little like a story, a little like documentation and most assuredly **very exciting**!_

<br/>

### Updates

If I make any updates to this post (which is sometimes helpful for people reading it in the future), I shall make note of it here and st the same time, ~~scratch out~~ older content and replace it with something like "UPDATE1: ...".


## Revirt - A Quick Intro

<center> <img class="img" src="/img/revirt/revirt_symbol.jpg" alt="Revirt" /> </center> 

<br/>

**Revirt** (short for **RE**dox os - **VIRT**ualization technology) is a technology/feature on Redox OS that will provide Redox OS with support for "Hardware-assisted hardware-level virtualization". It will help us achieve many goals - one of which is to run software like QEMU faster, in order to create Virtual Machines in a fashion very similar to Hyper-V on Windows or VirtualBox, VMWare, Xen, etc.. 

<br/>
<br/>

# Virtualization

We'll first take a brief look into the concept of virtualization, in order to gain an understanding of what it is that we are implementing in Redox OS and what may be expected by it's implementation. There are a lot of terminologies for various types of virtualization technology out here; not all of which agree with each other. So, I do my best to describe the terms, as and when I use them, in order to reduce the confusion as to what I'm talking about.

There are 5 generally considered types of virtualization (in order from the highest level, to the lowest level):   
1. **Application level virtualization** - This involves the compilation of application code to an intermediate format (like Java to Java bytecode), and that intermediate format executes in a "VM" (like JVM).  
2. **Library level virtualization** - WINE (used to execute Windows apps on Linux) is a great example/ It involves translation of windows syscalls to Linux.  
3. **OS-level virtualization** - Docker is the best example. Namespaces is a feature on Redox OS that supports this.  
4. **ISA-level virtualization** - This is the emulation of the ISA of one hardware on another, usually by interpretation of the instructions in the binary (executable).  
5. **Hardware Level Virtualization** - This involves executing most of the instructions in a guest binary directly on the host CPU (same ISA). In this level of virtualization the hardware is virtualized/abstracted.  

Revirt enables Redox OS to support _Hardware Level Virtualization_. In this context, virtualization refers to the process of running a *guest OS* (e.g.: Linux), in a virtual machine on a *host OS* (e.g.:Windows), so that you can use the guest OS and host OS simultaneously.  

<br/>
<br/>

# Hardware Level Virtualization

In this level of virtualization the hardware is virtualized/abstracted, so as to present the guest OS with the view of the hardware that you want it to see (emulation). But for most part, the instructions are directly executed on the CPU (_instead_ of being emulated), as the ISA for which the guest OS was compiled and the ISA of the Hardware which is being virtualized are the same.  

There are 2 types of _Hardware Level Virtualization_:  
- One is **similar to ISA-level virtualization** except for the fact that the ISA to which the instructions of the guest OS belong, and the ISA of the hardware on which those instructions are being executed is the same (i.e. `ISA(guest) == ISA(host)`). Consequently, only a subset of instructions are emulated via binary translation (due to privilege levels, control, etc.). Other methods are also used, like: paging in x86 is managed by shadow pagetables.  
   Example: Bochs (which has been partly ported to Redox OS)  
- The other type is **Hardware-assisted virtualization**, where the **instruction set architecture (ISA)** of the hardware being virtualized **includes hardware (hardwire) support for virtualization**, where hardware assistance in silicon is provided for emulation/virtualization (like EPT for virtualized paging support in x86)  
   example: Intel VT-x (KVM, Xen)  

**We'll be focusing on the latter - Hardware-assisted Virtualization, which is what Revirt implements.**

<br/>

### Paravirtualization
It is an implementation detail (feature) that can be used in **all types of hardware virtualization** and **ISA-level virtualization**, to make virtualization faster and better. This is where the guest OS is aware of the fact that it's running in a VM and takes advantage of that by **communicating directly with the host**, increasing performance. This enables virtualization even on non-virtualizable device (ISA-level virtualization). There are 3 generally accepted modes/combinations of para-virtualization and full-virtualization ("the regular one"):

1. **PV**: paravirtualized mode
2. **HVM**: Hardware-based (assisted) virtualized mode
3. **PVH**: Paravirtual + Hardware mode

More on PVH (useful for understanding `revirt`: Guests use CPU hardware support for memory operations and privileged CPU instructions and are able to use native instructions for most other things, requiring only slight modification of the guest OS. Paravirtual IO drivers are used for performance.

<br/>
<br/>

# Revirt (`revirt`) - Hardware-Assisted Hardware-level virtualization on Redox OS

**Please note that the following IS NOT about what has already been implemented. Rather, it seeks to share with the open-source community, what the future plans for Virtualization on Redox OS are. The implementation of this is currently in progress and is talked about in another post - ["RSoC 2022: Revirt-U - Part 1"](https://redox-os.org/news/rsoc-2022-revirt-u-1/)**

<br/>

When I say "Hardware-assisted", I mean that there are certain features in the CPU that a specialized software (like Revirt) can take advantage of, in order to realize "Hardware-Assisted Hardware-level virtualization". Different CPUs have different names for _this_ hardware feature of the CPU. Intel has VT-x, VT-d; AMD has SVM; and so on...

**Hypervisors**, also known as **Virtual Machine Monitors (VMMs)**, are programs that are written in order to support the creation and operation of **virtual machines (VMs)**. They can be made to work with or without hardware-assisted virtualization technology. **Revirt is the software (feature) that enables these VMMs to use hardware-assisted virtualization**.

There are two types of Hypervisors (VMMs), which are explained below. Revirt needs to be implemented differently in order to be able to support the different types. Hence, Revirt itself has two implementations - Revirt-K and Revirt-U.

## Revirt-K (`revirt_k`) - Type-1 hypervisor

This is a feature that will enable Hardware-assisted HAL virtualization - a type 1 hypervisor. A type-1 hypervisor runs at the level of the OS, and is capable of doing everything a "regular OS" can. There is no underlying OS in this case, and it's not possible to execute any user applications. The Type-1 VMM is like an OS that can only create and manage VMs. This could be an alternative to Xen, Hyper-V, KVM, etc.

A simple overview of Revirt-K architecture:  
<center> <img class="img-responsive" src="/img/revirt/revirt_k_arch.svg" alt="Revirt-K Architecture overview" /></center> 

<br/>

Revirt-K (`revirt_k`) is a VMM that can spawn and control VMs. When Redox OS starts up, it will follow the regular startup procedure until the bootloader is done. When in the kernel, at a particular point it will start executing a different software path, where it will enable a few features and run procedures by which Redox OS becomes (behaves like) a type-1 hypervisor.

Because Redox is a microkernel, which leaves out a lot of software stuff to the userspace, Revirt-K seem to be a promising venture. You see, the userspace programs/drivers are **not loaded** at runtime, instead `revirt_k` kicks in (as a type-1 hypervisor) and starts up a main "Control VM" (CVM) in `dom_p` (the privileged domain), which you might be familiar with as a concept called `Dom0` by Xen. 

_In case of `revirt_k`, the CVM **could run a paravirtualized Redox OS**. OR it could also be paravirtualized Linux (esp. useful if `revirt_k`'s interface is similar to that of Xen, in order to "support" Qubes OS)._

CVM is generally useful when you want to isolate the **other VMs** from the effects of components like *device drivers* that run on the Host. So, instead of the Host (Redox OS with Revirt-K) running the *device drivers*, a new VM called a CVM is spawned at the beginning and *another OS* is loaded onto it, which in turn controls the *device drivers* and has direct access to hardware. So, if the device drivers do something stupid and crash the OS, only the CVM stops (and is restarted), while the other VMs aren't generally affected.

Though, it should be noted that Redox OS runs its drivers in the userspace, so crashing them shouldn't generally have the effect of what happens if the crash had happened on Linux. But implementing things this way would certainly allow for the machine to still partly continue to function, even if the Paravirtualized Redox kernel in the CVM crashes for some reason, in order to save state and even attempt to restart CVM.

This means that the CVM is a "supervisor VM" with more privileges than the other VMs, since the CVM is provided direct access to the hardware by the VMM (`revirt_k`) using "device passthrough".

It will be possible to run something like QEMU on CVM in order to provide support for emulated devices, which will kind of blur the line between Type-1 and Type-2, but not too much, as the OS is still absent as the base layer, and is replaced by Revirt-K VMM instead.

<br/>

_Revirt-K is **independent of Redox OS**._ **How?** Revirt-K is a VMM that is a replacement for a traditional OS. This means that it still has to *partly (initially)* boot up *like an OS* (stuff like the bootloader). Therefore the **base code** of Redox OS (bootloader + a part of kernel) is *used in* Revirt-K. 

<br/>

Qubes OS (which currently uses Xen as the type-1 hypervisor) is an interesting project that may find Revirt-K a good option as a type-1 hypervisor, given the security focus of Redox OS and Revirt; but that would certainly take a while to get done. (Thanks to "`brochard`" for bringing Qubes OS to my attention).

## Revirt-U (`revirt_u`) - Type-2 hypervisor

A Type-2 hypervisor is a userspace application that runs on TOP of the OS, and uses the OS kernel as a middle layer to use hardware-accelerated virtualization. The kernel schedules the user threads on which the VM runs the guest OS. I am currently developing a Type 2 hypervisor, that enables any application to function as a VMM, create a VM in its own process space and control it. There can by multiple VMMs on a Type 2 hypervisor (each in their own process), and each VMM can run multiple VMs, each VM with it's own OS.

A simple overview of Revirt-U architecture:  
<center> <img class="img-responsive" src="/img/revirt/revirt_u_arch.svg" alt="Revirt-U Architecture overview" /></center> 

<br/>

The VMM can register handlers for many of the controls, but the kernel retains power of handling stuff that can compromise the OS (and need to run in supervisor mode), which includes the switching to `vmx` mode, handling EPT, creating basic VM fault handlers, etc.

**Revirt-U is not a VMM** on its own, rather it is the *in-kernel backend component* to a VMM in Redox userspace. It is what KVM is to QEMU. The VMM itself runs as a process in userspace (like QEMU). Revirt-U is a Redox OS kernel feature that provides applications with a **"Hardware-Assisted Virtualization API (HAV API)"**, helping the apps act like VMMs.

QEMU can be one such app (a VMM) which can use `revirt_u`'s HAV API to run hardware VMs, along with the plethora of functionality it offers when it comes to emulation.

<br/>

### Revirter

I also intend to create `Revirter`, which will be a light-weight VMM (that uses `revirt_u`'s HAV API) and will be solely made to run effectively on Redox OS. It is like a highly stripped down version of QEMU.

Other VMMs, which are currently using backends like KVM, and which can take advantage of Revirt-U in the near future are Firecracker, CrosVM, Cloud Hypervisor, the latter two using `rust-vmm`.

<br/>

### Implementation

This is where I talk about what I'm currently doing as part of RSoC 😊, but I'll first lay out the project plan, and then talk about how Revirt-U is being currently implemented in another post - ["RSoC 2022: Revirt-U - Part 1"](https://redox-os.org/news/rsoc-2022-revirt-u-1/).


## Other Uses for Revirt

Once we have Revirt (either Revirt-K or Revirt-U) working, there are a lot of things that may be possible:  
1. **Running applications and drivers on Redox, that are supported only on Linux**: Linux drivers can be used to operate peripherals via device passthrough, in order to be able to use unsupported devices on Redox OS. (security needs to be taken into consideration). We'll have to implement certain tweaks in Redox OS, and create a paravirtualization driver to run in the Linux Guest.  
2. **Running applications and drivers on Redox, that are supported only on Windows**: Probably a long shot, but it's still possible, using PV Driver in Windows guest, just like what's proposed for Linux.  

<br/>
<br/>

# The Project Plan

We will implement this project (Revirt) in two phases. Do note that these steps are a very high-level overview and a lot of things can go awry, forcing us to change course. Not all of the things mentioned in "future possibilities" will happen.

## Phase 1 - Revirt-U

1. create the `revirt_u` kernel component  
2. create `revirt_u` HAV API   
3. Create Revirter, a VMM (hypervisor) that uses `revirt_u` HAV API   
4. Provide basic QEMU (VMM) support for Revirt-U  

<br/>

### future possibilities for Revirt-U

1. support interaction from libvirt  
2. ability to use virtio  
3. advanced/complete QEMU support  
4. ability to be manipulated by `rust-vmm`   

`rust-vmm` is an open source project which abstracts away the hypervisor (like KVM) for some very commonly used userspace apps, which can then automatically run on Redox OS.

## Phase 2 - Revirt-K

1. Reuse `revirt-u`'s code to be deployed at kernel launch and test `dom_u` (unprivileged) VMs  
2. Paravirtualize Redox to run as PVM in order to manage hardware devices and control `dom_u` VMs  
3. Provide Linux compatibility to boot as `dom_u` VM  

<br/>

### future possibilities for Revirt-U  

1. Provide Linux compatibility to boot as `dom_p` (privileged) VM  
2. Qubes OS based on Revirt-K  

<br/>
<br/>

# References

I referred to other implementation of hypervisors and Hardware-Assisted virtualization. I only looked into the architecture and high level API, and learnt methods or ways to do things a certain way, but also learnt what NOT to do and how to construct things better.

1. **KVM**: KVM in Linux implements VMs by opening a device on `/dev/kvm`. As pointed out by the AkarOS reference PDF, KVM got a lot of things "incorrectly", as in, things could've been built better. A diagram of KVM's architecture is shown below:   

   <br/>

   <img class="img-responsive" src="/img/revirt/revirt-1_KVM_arch.jpg" alt="Architecture of KVM" />  

   [Image Source](https://forum.huawei.com/enterprise/en/comparison-of-kvm-and-xen-technologies/thread/773247-893?page=2)  

2. **bhyve**: is a Type 2 hypervisor and is built similar to KVM. I didn't look much into it's architecture   
3. **Xen**: It is a type-1 hypervisor, and is a mahor inspiration for the planned architecture of Revirt-K.  
     
   Some useful links are given below:  
   - [info wiki](https://wiki.xenproject.org/wiki/Xen_Project_Software_Overview)  
   - [xen docs](https://xenproject.org/help/documentation/)  
     
   Some important Features:  
   - A type-1 baremetal hypervisor  
   - Has a control domain (Dom0) which has greater privileges and direct access to hardware, and has software to manage `DomU` VMs   
   - Supports `Dom0` disaggregation (moving stuff into `DomU`s)  
   - Device passthroughs  

   A pic of Xen's architecture is given below:

   <img class="img-responsive" src="/img/revirt/revirt-1_Xen_arch.png" alt="Architecture of KVM" />  

   [Image Source](https://wiki.xenproject.org/wiki/Xen_Project_Software_Overview)

4. **Qubes OS**: it's a security focused OS, which internally uses Xen to manage multiple VMs, each running application, so that they are isolated and the security environment can be tightly controlled. You can refer to the architecture of Qubes [here](https://www.qubes-os.org/doc/architecture/).

<br/>
<br/>

# Epilogue

I (and others in the Redox OS community) have various plans and ideas for he future of Revirt and Redox. There were many details not talked about in this post, as they are still being discussed/considered. Do join our mattermost chat and participate in the development of this OS. While researching this topic in order to figure out the best methods for implementation, I learnt a lot about the internals of hardware-virtualization. It still doesn't mean that I would've gotten everything right. There's guaranteed to be stuff in here that I got wrong. I can only hope to learn from that and amend the errors.

Contributing to Redox OS's future is a lot of fun. I want to thank those who engaged with me in the `Redox OS mattermost chat`:  
- `a4ldo2` - we talked extensively about KPT and EPT paging mechanisms, security issues, other features to support   
- `brochard` - brought my attention to Xen and it's relation to Qubes OS, and how Revirt-K could fit in  
- `jackpot51` - helped me figure out Redox OS, coordinate RSoC  

I'm currently implementing some of the features of Revirt-U, that I'm documenting in the next blog post, so check that out! ([RSoC 2022: Revirt-U - Part 1](https://redox-os.org/news/rsoc-2022-revirt-u-1/))


## Until later!

If you've reached till this point, thank you for reading.

Until then, keep well.  
Bye! 💕💕💕

<br/>

You can find me on:  
- [Redox OS - GitLab](https://gitlab.redox-os.org/enygmator/)  
- Redox OS - Mattermost chat - username: `enygmator`  
- [GitHub](http://github.com/enygmator/)  
- [LinkedIn](https://www.linkedin.com/in/ttarunaditya/)  
- [Twitter](https://twitter.com/Enygmator)  
- [Encrypted chat on Matrix (like _Element chat_)](https://matrix.to/#/@enygmator:matrix.org)  
