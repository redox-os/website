+++
title = "RSoC: Porting tokio to redox - week 2"
author = "jD91mZM2"
date = "2018-05-30T12:27:25+02:00"
+++

# Porting tokio, update 2

I honestly never thought I'd be back with another post.
Almost all tokio examples worked, what else was there to do?
So I stopped writing daily updates to later compile to one summary (like this one), and went on with my life.
But programs have strange habits of breaking.

Immediately after my last blog I was asked to try and port hyper.
With a few modifications, it worked!
Then I was asked to port reqwest, and that's where things started breaking.
Apparently the hyper I ported was a pre-release, meanwhile reqwest still used hyper 0.11.9.
And hyper 0.11.9 still used tokio-core.
You would've thought this was the end of it. "Too old tokio, can't continue".
But luckily I happened to have read somewhere that tokio-core is now a wrapper interface around the new tokio
so that old programs still work!

Unlike hyper, reqwest didn't work out of the box. It received EOF too early when reading.
I was almost an hour in when I remembered that I got the same issue earlier!
Apparently tokio-core is not just a wrapper - it has some sort of copies of the tokio code.
What this means is that my old fixes to tokio were not available in tokio-core, so I had to backport those.

Reqwest worked, but during larger transactions it still received EOF too early... randomly.
And it sometimes worked. And it sometimes only worked when I added debug prints...
After a few hours of nonstop cursing at my computer I noticed that because of redox's level-triggering model it
received old events and treated them as new, meaning one readable event could result in two reads,
where the second one reads 0 bytes - which is treated as EOF.
This was fixed by simply clearing another value as well when clearing readiness.

The was still one last issue. Remember the `tokio::spawn` issue from the last blog?
Tokio failed to do multiple things simultaneously.
Last time I fixed that by increasing the number of workers, quickly dismissing it as a tokio bug.
Only one problem: tokio-core doesn't have a threadpool.
I really like this issue actually, it made me go back to an old issue and solve it properly :)
The fix was easy too, I suddenly remembered that calling `accept()` on a non-blocking listener on redox was blocking anyway.
And looking back at tokio's accept code I noticed that I simply forgot to clear readiness (since redox's event model is level-triggering).

## Rounding up

I was really annoyed by the impossible-to-debug random early EOF issue.
But I REALLY liked that the `tokio::spawn` issue wasn't upstream,
so I could go back and solve it properly myself.

One sad thing is that almost all code I wrote will be able to be reverted once
redox changes to an edge-triggering model instead,
[which they most likely will](https://github.com/redox-os/netstack/issues/27).

I've send pull requests to both [pkgutils](https://github.com/redox-os/pkgutils/pull/28) and [netutils](https://github.com/redox-os/netutils/pull/33)
that replaces the outdated hyper with the latest version of reqwest.

I didn't expect to have to go back to my patched tokio code, but I'm happy I did :)
