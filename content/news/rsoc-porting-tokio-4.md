+++
title = "RSoC: Porting tokio to redox - week 4"
author = "jD91mZM2"
date = "2018-06-14T16:08:33+02:00"
+++

# Porting tokio, update 4

I was pretty inactive this week, sadly.
I did some unrelated stuff:

 - [Implement scoping for ion](https://gitlab.redox-os.org/redox-os/ion/merge_requests/778)
   (Speaking of ion, they now use a liner fork with a few PRs merged, mine included, so you now get [cooler tab completions](https://github.com/MovingtoMars/liner/pull/87)!)
 - [cargo-patch](https://gitlab.com/jD91mZM2/cargo-patch), a cargo subcommand for automatically downloading sources and patching their Cargo.tomls.
   Pretty useless sadly since normally when doing this kind of thing you want the git version, not the crates.io one.

None with are tokio related, so I wasn't going to make a blog post initially.  

But then today I got to sit down and try some things - and oh man do I have some exciting news!
Last week I mentioned I was thinking about making rust's UnixStream/UnixListener
work with ipcd and slowly try to get tokio-uds working.
... well that "long-term plan" turned out to be done in one day.

 - I made [my first PR to rust](https://github.com/rust-lang/rust/pull/51553) - adding UnixStream and
UnixListener using ipcd!
 - I forked mio-uds, [which you can see here](https://gitlab.redox-os.org/redox-os/mio-uds).
All I had to do was to avoid the socket madness and just use std's UnixStream/UnixListener.
`connect`/`bind` is already nonblocking on redox :)
 - I changed tokio-uds to use mio-uds and expect writable for UnixListener instead of readable
 (this ipcd behavior is there to match netstack's behavior with TcpListeners).
 Then I changed some weird iovec readv implementation to just use mio-uds' existing one
 (I don't know why they didn't use that already, hope I didn't break anything).
 - I converted the mio-uds and tokio-uds tests into examples (so I could run them on redox) - they worked :D

and that turned out to be it!  
To be fair - I haven't yet implemented read/write timeout or datagram support.  
The former could be used today using the `time:` scheme.

So while I didn't really do much in terms of quantity this week, I'm really excited to have done my first rust PR!
If anybody is still reading these blogs, please link me some nice rust application that uses unix sockets
(preferrably tokio) so I can test them :)
