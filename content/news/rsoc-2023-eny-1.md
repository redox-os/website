+++
title = "RSoC 2023: Apps and Driver support in Redox OS"
author = "Enygmator"
date = "2023-07-15T07:09:07Z"
+++

Hey there everyone! I'm Eny a.k.a enygmator!  

I'm back this year as part of **RSoC (Redox Summer of Code) 2023** to share with you a non-technical post on the **work I'm doing towards improving apps and driver support on Redox OS**!

Feel free to discuss this post on social media. (links are in the Epilogue)

## The idea

The availability of support for various apps and drivers (for various hardware and software) is crucial for the general adoption of any *general purpose operating system* like Redox OS. Some of us developers are working on improving the *core* of Redox OS (like the Kernel), which should create a solid base on which high quality native drivers and apps can be created with ease. Some others are working on porting (and adapting) various open source drivers and apps (written for other OSes) such that they can work with Redox OS. This work is super important and helps Redox OS progress forward.

But in the meanwhile, there's a **potential shortcut to enabling _wide driver and app support_ for Redox OS**, without having to manually port and adapt drivers to Redox OS. (which can be helpful, both today and in the future). The shortcut, in simple words, is to use our Host machine running Redox OS, to run a Virtual Machine with another OS (Linux/Windows) as the guest, and then **cleverly use the drivers and apps that can run on that guest OS to help coverup the missing drivers and apps on Redox OS**. 

Let's look into how we would go about doing that...

## The architecture of the solution and its use cases

### Drivers on various OSes

In a "regular" case, we usually have native drivers running either in kernel-space (like in Linux) or user-space (like in Redox OS), and then there are apps which run on the OS, which utilize these drivers to accomplish tasks. Now, let's look into the following figure, which is an example of **how to use the driver of another OS in order to run your apps**.

  
<center> <img class="img-responsive" src="/img/rsoc-2023-eny/single-driver-vm.svg" alt="A Linux driver being used by app in Redox OS" /> Fig 1. A Linux driver being used by app in Redox OS </center> 
<br/>

In the above figure, you can see that we are running a 3D game which is using a 3D game engine. This game is a userspace app running on Redox OS.  
The audio driver here is an example of a native driver running on Redox OS, which is used by the game engine to generate sounds from the speaker.  

Now let's look at the video Drivers. Assume that we have an Nvidia graphics card that uses the proprietary driver. This makes it hard, if not impossible for us to port it to Redox OS. So, what we do is create a VM running Linux, and then we give control of the GPU to the Linux VM. Now, the Nvidia driver running on Linux can control the GPU for us. All there is left for us to do is make it usable for applications running on Redox OS. This is where **the bridge** comes in. As you can see, the bridge establishes a connection between Redox OS and Linux such that the game engine in Redox OS can use the video driver running in Linux.

<br/>

### Apps on various OSes

Now let's look at another situation, where we would like to run an app that is built for another OS (like Linux or Windows). You might now argue that it is rather straightforward to just run the other OSes' apps inside the VM and the problem is solved. While that is true and is in fact done by most people, the solution I'm proposing here is a more robust attempt at such a thing. Have a look at the figure below


<center> <img class="img-responsive" src="/img/rsoc-2023-eny/single-app-vm.svg" alt="A Redox OS driver being used by an app in Linux" />Fig 2. A Redox OS driver being used by an app in Linux:   </center> 
<br/>

The most simple observation one can make is the fact that there are two devices, a speaker and a display, both of which are controlled by native device drivers running on Redox OS, and there's even an app on Redox OS which is using those two drivers. This is already happening today. 

Now let's look at the VM; we can see that it is running Linux, and there's an app compiled for Linux (like a GTK/Qt app) running on it. While a Virtual Machine Manager (VMM) like QEMU can definitely emulate the speaker and display of the VM, it prevents us from harnessing the full potential of the actual hardware of the Host, as that is being controlled by native (host) drivers. The solution to that is to create **a "bridge" that enables the app to run on Linux as usual, but effectively use the video and audio drivers of the host**, as if the app were running on Redox OS itself. This also enables a seamless experience for the user, as they're unaware of where the app is actually being run.

<br/>

### A matrix of apps and drivers on various OSes

If you look at the above two solutions, you'll notice that there's a "hidden" feature that comes as a side effect of implementing the above solutions - we can use multiple OSes to run various drivers and multiple OSes to run various apps. The immediate idea that comes to mind is that of **security through isolation**. Have a look to the figure below:


<center> <img class="img-responsive" src="/img/rsoc-2023-eny/multi-app-driver-vm.svg" alt="Apps and drivers of various OSes executing in various VMs and interacting with each other seamlessly" />Fig 3. Apps and drivers of various OSes executing in various VMs and interacting with each other seamlessly:   </center> 
<br/>

What you see in the above figure is a system where the "host" is a Hypervisor (known as a Type-1 hypervisor) that only manages virtual machines, their scheduling, permission, security and inter-VM communication. And on top of that, you see a "DOM_P" virtual machine, which is has the privilege required to control the entire system and all the VMs on it, and then there are many other non-privileged VMs, where each VM is either running an app or a driver, where each driver controls some hardware, and each apps uses these drivers to accomplish its task. This is essentially a "matrix" where everything is isolated.

## The implementation

You may have noticed that I didn't go into any highly technical details in here. That's because I wanted to keep this simple and non-technical, so as _most_ technology enthusiasts can get a grasp on what's happening without having to sit through all the technical (and not so interesting) aspects of it.  

But fear not! if you're interested in peeking behind the curtain to have a look at how this is going to be implemented, what techniques are being considered, and wanna keep tabs on the unravelling of a thrilling adventure of creating something cool, then I'll be creating noe or more _**INSIDER's**_ post in the coming weeks, where we get down to the nitty-gritty of things.

<br/>

### Some details about the implementation

I'll make a few important points here:  
- I'd like to point out that this is _not_ a unique solution. It is inspired by other technologies, especially 'Qubes OS' and 'Virtio', which, in some cases, do very similar things.  
- While we'll be implementing things differently in many cases, it will achieve some of the same effects, and we might even utilize Virtio to implement parts of the design, as it may be the perfect way to do this.  
- We're not looking to make something novel; the idea is to simply build something that can solve a problem that we're facing, and to build it well.  
- The implementation of the 'simple' idea outlined above isn't as straightforward as it looks, as it involves a lot of parts coming to work together.
- This design will most definitely have some overhead, as we're having multiple OSes in VM interact with each other to perform a task which is generally supposed to be done completely on one system.
- The feasibility of this design also heavily depends on the ability to implement the various _frontends_ and _backends_ for various drivers and operating systems, which might be difficult to do (and further maintain), thus limiting the scope of how useful this endeavor will turn out to be.

<br/>

### Current status

The implementation of the above idea will require work on the following features:  
1. evolving the revirt interface (which is like the kvm interface)
2. Revirt-U : integrating QEMU with revirt (similar to how QEMU integrates with KVM)
3. creating a flexible framework that can be used to create "bridges" between Redox-host and Linux-guest. (virtio might come in handy)
4. _using_ the above framework to provide support for well-known hardware which have Linux driver support (like the Nvidia proprietary driver) - this is the main goal
5. Revirt-K - the type-1 hypervisor which will provide the ability to create the "matrix" configuration above

The above tasks cannot exactly be completed in a step-by-step manner, as many of the tasks are dependent on the other tasks. So, I have been making progress on various features up to various extents. I keep switching tasks and working on things simultaneously, which can slow me down a bit. These features not only involve coding, but also the design and architecture and the decision on which components to use, which unfortunately takes time. I'll be back with the **INSIDER** post with some demos and details of implementation and progress made.

<br/>

### Expected outcome

I'd like to bring this post to an end by summarizing the key expectations, some of which are more feasible than the others:
- Broader driver and app support for Redox
- Ability to execute drivers and apps in isolation (on VMs, secure, resilient)
- seamless integration of apps and drivers across OSes with "one-click-deploy" of Linux or Windows apps, drivers, etc. with good integration support

A personal deliverable that I want to keep in sight - Redox as a host, running linux (pop-os nvidia version) as a guest on QEMU (with revirt), where apps on Redox that use opengl graphics will be able to use the nvidia graphics card on my machine.

## Epilogue

Thank you for reading. I shall be coming back in a few days with a much more _technical_ news post talking about the various ideas in play (to implement app and driver support), the progress made, a few demos to play with, etc. So for those of you who are interested in that, do follow Redox OS on social media and keep an eye out for that *INSIDER* post!

I'd also like to thank Jeremy and Ribbon (from the Matrix chat) for engaging with me on these topics, providing ideas, suggestions and support, and Jeremy for giving me the opportunity to be an RSoC student. 

Redox OS Summer of Code is funded by monetary contributions from the community. A big thank you to all of our contributors. You can help us through [donations](/donate/).

Thank you. Bye! 💕💕💕

<br/>

### Discuss and Follow

Feel free to discuss this post on social media, and follow Redox OS to keep up with the updates!

**TODO: links to posts need to be added**

- [Patreon](), help us by providing funding!  
- Group chat on Matrix [@redox-general:matrix.org](https://matrix.to/#/#redox-general:matrix.org). For new members, follow the instructions [here](https://doc.redox-os.org/book/ch13-01-chat.html)  
- [Lemmy (Fediverse alternative to Reddit)]()  
- [Mastodon (Fediverse alternative to Twitter)]()  
- [Reddit]()  
- [Twitter]()  

You can follow Redox OS on various social media. Refer the [Community](/community/) page.

<br/>

### Connect or follow Author

You can contact the author and discuss on the following platforms:

- Encrypted chat on [Matrix](https://matrix.org/) using clients like [Element](https://element.io/) : [@enygmator:matrix.org](https://matrix.to/#/@enygmator:matrix.org)  
- Redox OS - GitLab : [enygmator](https://gitlab.redox-os.org/enygmator/)  
- GitHub : [enygmator](http://github.com/enygmator/)  
- LinkedIn : [ttarunaditya](https://www.linkedin.com/in/ttarunaditya/)  
- Twitter : [enygmator](https://twitter.com/Enygmator)  
- Mastodon (Fediverse alternative to Twitter) : [@enygmator@tech.lgbt](https://tech.lgbt/@enygmator)  
- Reddit : [u/enygmator](https://www.reddit.com/user/enygmator)  
- Lemmy (Fediverse alternative to Reddit) : [u/enygmator](https://lemmy.world/u/enygmator)  
