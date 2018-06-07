+++
title = "RSoC: Porting tokio to redox - week 3"
author = "jD91mZM2"
date = "2018-06-06T19:56:42+02:00"
+++

# Porting tokio, update 3

We're back! Last week I ended off stating that the redox netstack might soon switch to an edge-triggered model.
Well, I ended up feeling bad about the idea of letting others do my work and
decided to stop being lazy and just do it myself :)  
[PR to netstack](https://github.com/redox-os/netstack/pull/28)  
This change allowed me to get rid of 82 (mostly repeated) lines of tokio workarounds ([diff](https://github.com/redox-os/tokio/commit/1900180a6c5075f8f271bca45af6cf0121fedd82))!
Applications that don't immediately handle read/write events should now be more efficient since the selector
is now blocking instead of returning any existing event over and over.

This was the start towards the goal of making everything edge-triggered.
I was bored and decided to [rewrite telnetd to use tokio](https://github.com/redox-os/netutils/pull/34),
when I discovered that PTYs were not yet edge-triggered.  
[PR to ptyd](https://github.com/redox-os/ptyd/pull/3)  
(This broke [userutils](https://github.com/redox-os/userutils/pull/38) and [orbterm](https://github.com/redox-os/orbterm/pull/12),
which I fixed :))

## Thrussh

[SamwiseFilmore](https://github.com/MggMuggins) did some efforts towards testing thrussh!
He wrote a [recipe for libsodium](https://github.com/redox-os/cookbook/pull/161),
[ported cryptovec](https://github.com/redox-os/cryptovec), and made a [fork of thrussh](https://github.com/redox-os/thrussh)
with all dependencies updated to use their respective redox forks.
I [sent off a PR](https://github.com/redox-os/thrussh/pull/1) to fix compilation errors with the latest tokio,
and [patched libsodium](https://github.com/redox-os/cookbook/pull/163).  
The thrussh example I tried was buggy and only worked 1% of the time even on linux.
But *once*, I managed to get this:
![Screenshot of thrussh client on redox](https://i.imgur.com/4S4lGNd.png)  
![Screenshot of thrussh server on linux](https://i.imgur.com/GBKLr8w.png)  

## Unix sockets

I was going to see if I could make unix sockets edge-triggered, but redox didn't have unix sockets.
[So I created an alternative](https://github.com/redox-os/ipcd)
(following [an existing RFC](https://github.com/redox-os/rfcs/pull/8)) ;)
Mostly because creating a scheme from scratch was really fun and exciting!
It feels so magical to then actually use it!
Seriously, I ended up spending a looong time on tests just because it felt so unreal that they actually passed.
I love redox schemes <3

## More stuff...

Being bored again I asked for more tasks and was told to make orbital and vesad edge-triggered as well.
So I did:
 - [redox-os/drivers#30](https://github.com/redox-os/drivers/pull/30)
 - [redox-os/orbital#25](https://github.com/redox-os/orbital/pull/25)

This somewhat broke orbclient when making too fast movements, [which I fixed](https://github.com/redox-os/orbclient/pull/52).

I was also recommended to update smoltcp version in netstack, but I got a weird issue with https.
I *think* this is upstream's fault, see [m-labs/smoltcp#226](https://github.com/m-labs/smoltcp/issues/226).

## Epilogue

The amount of links in this blog makes it look like I did a lot of work this week.
Truth is, this week was actually really fun!
First week was more frustrating because most time was spent tracking down issues,
but this week it was all about fixing them :)

Upstreaming this project is going really slowly.
We FINALLY got [libc bumped](https://github.com/rust-lang/libc/pull/1012) and [socket2-rs merged](https://github.com/alexcrichton/socket2-rs/pull/25).
... Eeeeexcept I accidentally broke socket2-rs, and [the fix](https://github.com/alexcrichton/socket2-rs/pull/26)
is not yet merged.

What's next? No idea!
Currently I'm thinking about making rust's UnixStream and UnixListener work with ipcd, and slowly
try to get tokio-uds working. But that's long-term and probably won't happen any time soon.
