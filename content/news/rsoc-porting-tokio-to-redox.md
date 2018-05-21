+++
title = "RSoC: Porting tokio to redox"
author = "jD91mZM2"
date = "2018-05-21T19:03:54+02:00"
+++

# Porting tokio-rs to redox

Links:

 - https://github.com/redox-os/mio
 - https://github.com/redox-os/tokio

-------------------------

This is the weekly summary for my Redox Summer of Code project: Porting tokio to redox.
Most of the time was spent on one bug, and after that one was figured out and fixed it ended up being relatively easy!
As of now, 11/13 tokio examples seem to work on redox.
The remaining examples are UDP and seem to fail because of something either with the rust standard library or my setup.

Jeremy Soller, creator of Redox, had already started work on net2 and mio.
The first day was spent simply rebasing this work on top of the latest master
and fixing a few minor compilation issues with tokio.
And mainly - setting up qemu to redirect network stuff.
The timer example already worked!!!!
After this, I noticed that no tcp events were coming in.
I thought at first that this could be intended - perhaps tcp streams were instantly writable?
On Day 2 I got tokio to write stuff to the stream by ignoring one readiness check,
this was of course not the right solution, as I noticed later that day.

Turns out the real issue was that event queues were per-thread.
On Day 3 I attempted to make it synchronize fevents.
This made more things almost work, but wasn't perfect. For one, it broke the timer example.
So I made the whole thing live on a separate thread, even the `open` syscall.
If you're feeling brave, here's a [link to that madness](https://github.com/redox-os/mio/blob/old-single-threaded-madness/src/sys/redox/selector.rs).
This was as close to a solution I could get from my side.

On Day 4 I attempted to actually solve this *properly* on my own.
Two completely failed attempts at patching the kernel later I realized that I suck at kernel programming.
This was the worst day of this whole project for me, I felt like giving up.
On Day 5 however, things looked up immediately on the morning!
Overnight Jeremy had worked out a plan for patching the kernel!

-------------------------

Taking a break from that issue, I started debugging another: `tokio::spawn` wasn't working.
Well, it was working, but only when not used at the same time as a TcpListener waited for a connection.
In fact, it wasn't even polled *once*. That's right. What.
To clarify, returning a tokio delay on 1 second in the main loop made it work perfectly.
Once again, if you're brave: [logs (working)](https://gist.github.com/cea1b8d76ea448e3e1a0a0cef9346993).
But then changing the main loop to continue accepting another client immediately made it fail again. [Logs (not working)](https://gist.github.com/be3f4aedfe4ec44f88d73bd5b993bf1e).
I'll be back with the solution for this one later in this blog :-)

-------------------------

I continued with Day 5 trying to modify the kernel a little... again.
Then I finally did what I should have done from the very beginning:
I asked for help. Could somebody please explain how this all works? What does this code do? What does it mean?
And I got help, alright. Not only did Jeremy explain it to me - he also straight up fixed the kernel himself!
Completely opposite of Day 4, this was the *happiest* day of this project so far.
It was almost like he had lifted a huge truck from my shoulders!
Meanwhile he was doing that I sent off a tiny PR to [event](https://github.com/redox-os/event/pull/3)
and prepared my mio code for the new system - which btw worked first try :) - and then sat around and did nothing.

And finally, today! Day 6!
Overnight Jeremy had fixed the kernel and patched all programs using the old system,
and I was back to where I left off Day 3, but now with *much* better - and faster - code!
Now, what was the answer to why `tokio::spawn` wasn't working?
Oh that was simple, my VM only has one CPU and it turns out tokio adjusts the number of worker threads
to the amount of CPUs.
I mean, it probably should be work anyway. Guessing that could be a tokio bug.
For now I just made it use at least two workers.
This and a few other problems were patched, and here we are.
