+++
title = "RSoC: virtio drivers - 1"
author = "Andy-Python-Programmer"
date = "2023-06-28"
+++

## Introduction
Hello everyone, I am [Anhad Singh](https://github.com/Andy-Python-Programmer/) and I am working on `virtio` drivers for 
Redox OS as part of RSoC 2023 :^)

## What is VirtIO?
Briefly, VirtIO is a standardized interface which allows the guest operating system to accesses simplified virtual
devices such as block storage, networking adaptors and graphic cards. The VirtIO devices are minimal since they are 
implemented with the bare necessities to be able to send and recieve data.

<img src="/img/virtio.png" class="img-responsive" alt="virtio overview">

## Why VirtIO?
Full virtualization allows to run any operating system virtualized. However, the hypervisor is 
required to emulate physical devices like graphic cards. This leads to slow performance due to the complexity 
and inefficiency in the emulation process.

Since Redox’s primary development happens by testing and running it in virtual machine, it makes sense to 
efficiently make use of the virtual environment that it is being run in; getting the most out of the development 
time.

## What I have accomplished so far and whats next?
So far into RSoC, I was able to get the `virtio-blk` and `virtio-net` drivers fully working. I continue to work on
those drivers and get them upstreamed by this week. Next week I will start working on `virtio-gpu` to get a taste of 
GPU acceleration on Redox 🙃🚀

See you next week!
