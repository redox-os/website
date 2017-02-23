+++
title = "Visual Refresh"
author = "Jackpot51"
date = "2017-02-22T20:16:00-07:00"
+++

This is the 19th post of a series of blog posts tracking the development and progress of Redox.

If you would like to learn more, please follow us on Twitter, [@redox_os](https://twitter.com/redox_os) and [@jeremy_soller](https://twitter.com/jeremy_soller).
Also, please support development like this on my [Patreon page](https://patreon.com/redox_os).

All development takes place on our [Github repository](https://github.com/redox-os/redox). For a list of repositories we maintain,
see our [Github organization](https://github.com/redox-os)

## NVMe and USB 3 support

On the driver side, I have been working on NVMe and XHCI support. I hope to have the ability to run Redox
from NVMe SSDs in a few weeks. For XHCI, I have focused on support for a library like `libusb`
so that userspace drivers from Linux can be ported easily. Wireless networking, specifically for
Atheros and Intel Wi-Fi chipsets is my priority for USB support.

## Theme Support

Inspired by the Arc theme, I have rewritten OrbTK, Orbutils, and Orbital to improve upon their aesthetics.
Currently, it attempts to match the Arc theme as closely as possible. The goal is to have all of the
changes required contained where it is easy for other themes to override them.

The login screen has been completely overhauled, as well as the title bars and OrbTK color scheme.
I will work to improve the other applications - in the order of launcher, file manager, and terminal.

**Without further ado, here are the before and after images!**

<a href="http://imgur.com/xvT3eA1.png">
## Login Before &amp; After:
<img class="img-responsive" src="http://imgur.com/xvT3eA1.png"/>
</a>

<a href="http://imgur.com/XUsQ82U.png">
## Apps Before &amp; After:
<img class="img-responsive" src="http://imgur.com/XUsQ82U.png"/>
</a>
