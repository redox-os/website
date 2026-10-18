+++
title = "Ring Buffers Project Summary"
author = "Ibuki Omatsu, Anhad Singh, Jacob Lorentzon, Ron Williams"
date = "2099-10-17"
+++

Last year, the Redox team [received a grant](https://nlnet.nl/project/RedoxOS-ringbuffer/) to develop io_uring-like Ring Buffer support at the task level,
as a first step towards ring buffer communications between tasks.
The work finished up in September, as the last pieces were put in place.

We want to thank the [NLnet Foundation](https://nlnet.nl/), the NGI Zero Commons Fund, and Horizon Europe for their generous support.
The NGI Zero Commons Fund is reaching its end, but NLnet is now accepting applications for grants from new funds,
[Restack](https://nlnet.nl/restack/) and [Code Supply](https://nlnet.nl/codesupply/),
as well as some [smaller theme funds](https://nlnet.nl/themes/).
[Apply for funding before November 3rd 2026!](https://nlnet.nl/news/2026/20260903-call.html) (and then every two months after that).

The team has done a fantastic job, and I want to congratulate Ibuki, Anhad and Jacob, and thank them for their time and effort.

In addition to implementing the Ring Buffer machinery for our services and drivers that can support it,
an `io_uring` and `liburing`-like API for applications was completed and demonstrated.
There was also substantial work done on support crates, including an async executor for drivers.

And there was some very exciting work on various performance improvements,
to allow much faster switching between tasks.
But I will let the team tell you all the technical details.

-- Ron Williams