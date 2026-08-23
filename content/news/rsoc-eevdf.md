+++
title = "RSoC 2026: EEVDF for Redox"
author = "Akshit Gaur"
date = "2026-08-22"
[params]
  math = true
+++

First of all, read [this post](https://www.redox-os.org/news/rsoc-dwrr/) to get the background (Redox OS, basic scheduling, Round Robin and Deficit Weighted Round Robin Schedulers).


# TL;DR

Redox OS now uses a EEVDF-based scheduler. The move from DWRR has netted us very significant gains in nearly every measure, a 782x improvement in fairness, a reduction of 82% in context switch time, 2.6x increase in throughput and more!!

A special thanks to Jacob Lorentzon (4lDO2) and Wildan Mubarok for the help and guidance they have provided throughout the journey, I don't think this would have been possible without them or the others in Redox community that have helped me!


## Sobriety in the Bar

Let's see the situation we left our bar in the last post, VIPs are well fed (or well drunk??) with our Interleaved DWRR approach, unfortunately the poor masses are starving (being sober in a free-to-drink bar may be worse than starving)! And although we did not yet implement many complex heuristics like the neighbouring bar called "Linoox" had done many years ago, we would have had to, had we stuck with DWRR, because our bouncer would eventually need complex 'heuristics' (guessing games) to figure out when to cut off the VIPs so the regular folks don't die of thirst. Our bartenders need to think again.

:::note
Although this breaks the flow of the post, I would like to emphasise that I am not criticising Linux here, to avoid any misunderstanding. Linux used CFS for many years which was much more complex (and different) than a simple DWRR. It used complex heuristics to guess the nature of the application, which over the years became bloated. Linux replaced it with EEVDF, and it is after they have proved it, that we are even implementing it!
:::

After much discussion the bartenders come up with a new system based upon a newer Tab system in which the bartenders keep track of the importance of the client and whether they actually deserve a beer at the moment.

The way they figure it out is using lag, they track exactly how many drinks they have poured out to you and how much you actually deserved! If you are owed beer, you have positive lag, if you drank too fast, you have negative lag! They keep track of it as your eligible time, the point in time, where your lag is no longer negative!

Although a poor man will tolerate some time where he does not have any beer in his hand despite being owed some (he is getting free drinks after all!), the more important the client is, the more impatient he will be. So the bartenders calculate the deadline for your next drink! The deadline is equal to your eligible time plus a baseline wait time divided by your importance (wait / w). The more important you are, the tighter the deadline!

What it results in is that the VIPs are not only owed more drinks, they get it as quickly as possible in their hands owing to their tighter deadlines, but the less important clients are not starving either as the introduction of the deadline system ensures they have a drink in their glasses before they become sober!


## A formal introduction

Earliest Eligible Virtual Deadline First Scheduler, as evident by what a mouthful of a name it has, is certainly amongst the "best" schedulers, created by Ion Stoica and Hussein Abdel-Wahab in their 1995 paper ["Earliest Eligible Virtual Deadline First : A Flexible and Accurate Mechanism for Proportional Share Resource Allocation"](https://people.eecs.berkeley.edu/~istoica/papers/eevdf-tr-95.pdf)

I am going to try to explain it!


### Assumptions

a. We can only assign the CPU to a process in a quantum of time, `q`.

b. A process is said to be active if it is competing for resources, passive otherwise. A process active at time `t` belongs to the Active Set, `A(t)`.

c. Each process has an associated weight with it `w`, that determines its share of resources `f`.

$$
   f_i(t) = \frac{w_i}{\sum_{j \in A(t)} w_j}
   $$

d. Due to various reasons, it is not possible for a client to always receive exactly the service time it is entitled to. Thus we assign a value, `lag`, to this difference in time it should receive and it actually receives.

$$
   lag_i(t) = \underbrace{S_i(t_0^i, t)}_{\text{Theor.}} - \underbrace{s_i(t_0^i, t)}_{\text{Actual}}
   $$

where

$$
   \tag{1} S_i(t_1, t_2) = w_i \int_{t_1}^{t_2} \frac{1}{\sum_{j \in A(t)} w_j} d\tau
   $$


### Prelude

A client/process issues a request which specifies the duration of service it needs, `r`. Therefore, in an ideal system we can solve for the deadline `d` before which the request must be serviced, given `r` (service duration) and `t` (time at which the request was made), by solving the equation-

$$
r = S(t, d)
$$

Assuming that the share `f` of our process does not change in the interval,

$$
S(t, d) = f * (d - t)
$$

$$
r = f * (d - t)
$$

$$
d = t + \frac{r}{f}
$$

Instead of clock time, EEVDF uses Virtual Time which is defined as follows-

$$
\tag{2} V(t) = \int_0^t \frac{1}{\sum_{j \in A(t)} w_j} d\tau
$$

One nice property here is that the flow of this virtual time is inversely proportional to the current competition for the resources. When the competition is high, virtual time slows down, when it is low, it speeds up!

From 1 & 2,

$$
S(t_1, t_2) = w_i (V(t_2) - V(t_1))
$$


### Algorithm

The basic idea behind EEVDF is quite simple, you associate two (more) numbers to each request (or client)-

1.  An eligible time `e` is the exact time that a request becomes eligible to be serviced-
    
    $$
       S_i(t_0^i, e) = s_i(t_0^i, t)
       $$

2.  Deadline `d`, chosen such that the service the client receives between `e` and `d` is equal to the service time requested `r`, i.e.,
    
    $$
       S_i(e, d) = r
       $$
    
    In other words, if the client started receiving its fair share exactly at `e`, `d` is the point in time by which its request would be fully served. One thing to keep in mind though is that this is a scheduling deadline rather than a hard real-time guarantee, it determines ordering between eligible requests.

Before we can use them though, we need to convert them to the virtual clock.

$$
V(e) = V(t_0^i) + \frac{s_i(t_0^i, t)}{w_i}
$$

$$
V(d) = V(e) + \frac{r}{w_i}
$$

Now that we have all the values, we can finally define the policy! Quoted from the original paper-

> **EEVDF ALGORITHM**. *A new quantum is allocated to the client that has the eligible request with the earliest virtual deadline.*

Now let us define Virtual Eligible Time and Virtual Deadline at $k^{th}$ request, ${ve}^{(k)}$ & ${vd}^{(k)}$,

$$
ve^{(1)} = V(t_0^i),
$$

$$
vd^{(k)} = ve^{(k)} + \frac{r^{(k)}}{w_i}
$$

$$
ve^{(k + 1)} = vd^{(k)}
$$

If for some reason (eg., early yield or block) the service time it actually received during the $k^{(th)}$ request ($u^{(k)}$) is not equal to $r^{(k)}$, we only need to change the last equation,

$$
ve^{(k + 1)} = ve^{(k)} + \frac{u^{(k)}}{w_i}
$$

If a client does not consume its entire slice, its next $ve$ and $vd$ are brought forward giving it precedence over an identical process that did consume its slice fully.

So to reiterate the policy by which we select the next client to serve, we choose the client with positive (or zero) lag (i.e., S<sub>i</sub> >= s<sub>i</sub>) with the earliest deadline!


## Implementation in Redox

I am going to walk you through the `select_next_context` function that contains the actual scheduling logic. One thing to keep in mind is that we do not explicitly calculate lag (signed variable), instead store the local `V(t)` of the context which is proportional to $s_i$, thus

$$
lag = V_{global} - V_{local}
$$

Keep in mind that this is virtual/normalised lag. If you want absolute lag,

$$
lag_i = w_i * (V_{global} - V_{local})
$$


### Can we still run the previous client?

The first thing we do is check whether we can still run the previous context/client. This helps us if no other context is eligible to run. We also update its `ve` (`vtime` in the code) and `vd` here.

If it yielded early, we apply a penalty (inversely scaled to its weight/priority) to prevent processes from repeatedly yielding early to manipulate their lag and monopolise CPU time.

We also figure out if the `prev_context` is still eligible to run (`vtime` < `V`).


### The walk through the tree

All the runnable/active contexts are stored in a BTreeMap stored per-core. The BTreeMap has (`vd`, `rem_slice` (remaining slice of service time), `ctxt_id`) as its key, which ensures that the map is sorted first with vd and uses the remaining slice (out of `BASE_SLICE`, the amount of time, in terms of context<sub>switch</sub> invocations, a client is allocated CPU time) as a tie breaker, and their id as a last resort. This ensures that amongst two contexts with the same virtual deadline, the one which has already started running and not completed its slice is preferred!

The values of the BTreeMap are (`vtime`, `context_weight` and `context_ref`). Although `vtime` and `context_weight` are accessible after locking `context_ref`, storing them explicitly allows us to quickly see if the context is eligible without locking, which improves the performance at the cost of some minor storage amount.

We walk through this BTreeMap, and as soon as we find an eligible context (`vtime` <= `V`), we break the walk and switch to it!

:::note
The original paper describes an augmented tree for this, which we do not use right now because of its added implementation complexity. I opted to use the standard BTreeMap as it is quite optimised and a standard component. Had I chosen to create an augmented tree myself, there would have been more opportunities for bugs to sneak in while **I** was sleeping. Regardless, most of the time, a simple BTreeMap should perform similarly to the augmented tree. It is only in the worst case scenario (no/minimal eligible contexts) that the augmented tree gets an edge in the time complexity (O(logN) vs O(N)), but given the length of the trees in real-world usage and its cache friendliness, I decided BTreeMap was good enough **for now**.
:::

In case that there is no eligible context present in the tree, we find the context with the minimum `vtime`, and fast-forward our per-core `V` to its value, thus making it eligible to run, this ensures that we do not idly waste the CPU cycles.


### Work Stealing

With the move to per-core residence of our data-structures, it is now possible for one core to have no contexts in its BTreeMap while another core is fully loaded!! To prevent this, we implement work-stealing!

Work Stealing triggers in the following cases-

1.  The BTreeMap of our current core is empty.
2.  Once every `STEAL_INTERVAL` with the added condition that the difference between the number of contexts in our tree and any other core is > `STEAL_THRESHOLD`.

If triggered we calculate the number of contexts to steal from core X as

`Num of Contexts to Steal (N) = min((X.queue.len() - local.queue.len()) / 2, MAX_STEAL)`

We then steal the first `N` (interspersed, i.e., 1st, 3rd, 5th&#x2026;) contexts from the tree of X to our own tree and adjust their `vtimes` using

$$
offset = context.vtime - X.V
$$

$$
context.vtime = max(0, local.V + offset)
$$


### Advancing the virtual clock

When all this is done and dusted, we finally advance our virtual clock!

$$
V_{\text{local}} \mathrel{+}= \frac{\text{elapsed\_ticks}}{\text{total\_weight}}
$$


## Other Optimisations

Apart from changing the scheduler from DWRR to EEVDF, I also did the following optimisations that were significant.


### Moving `RUN_CONTEXTS` from GLOBAL to PerCPU

A global run queue meant that two cores could not context switch at the same time and had to wait for the earlier core to release the lock. This meant that as the number of cores increased, so did the lock contention and thus, the time taken for a context switch. This [MR](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/660) provided each core with its own separate run queue. It also implemented the work stealing made necessary with this change!


### Moving `RUN_CONTEXTS` from VecDeque to a BTreeMap

The initial implementation of EEVDF used a simple VecDeque to store the active contexts. This [MR](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/618) changed that to a BTreeMap dropping the time complexity of the scan from O(N) to O(logN).


### Removing Linear Scan

This is how we handled blocked tasks earlier-

1.  When a context blocked, it was removed from the `RUN_CONTEXTS` and moved to another global list, `IDLE_CONTEXTS`.
2.  On each context switch, we would scan through the `IDLE_CONTEXTS`, and check if any context became runnable, moving them from `IDLE_CONTEXTS` to global `RUN_CONTEXTS`.

These blocked tasks were of two types, timers and non-timers, so it was handled in two passes.

Timers:

We separated the timers and now store them in a BTreeSet which allows us to extract all the timers that will fire at the current instant. (Relevant [MR](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/649)). Thus the time complexity was reduced from O(N) to O(logN).

Non-timers:

Earlier, the unblocking code only switched the flag to mark a context as Runnable, now that code is also responsible for actually placing the context in the run queue, reducing the time complexity from O(N) to O(1)! (Relevant [MR](https://gitlab.redox-os.org/redox-os/kernel/-/merge_requests/656))


## Did it change anything?

Now, lets take a look at the numbers to actually quantify what this change in scheduler resulted in!


### Fairness

Fairness (along with the next section) are the clearest wins for our migration. I spun up 16 identical CPU-bound processes that do nothing except increment their counter, at the end we compare these counters to get an estimate for their CPU-time. Variance is min/max deviation here-

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />

<col  class="org-right" />
</colgroup>
<tbody>
<tr>
<td class="org-left">Setup</td>
<td class="org-right">DWRR Variance</td>
<td class="org-right">EEVDF Variance</td>
</tr>

<tr>
<td class="org-left">16 procs / 4 cores</td>
<td class="org-right">389-617%</td>
<td class="org-right">1.09-1.37%</td>
</tr>

<tr>
<td class="org-left">16 procs / 1 core</td>
<td class="org-right">1940.52%</td>
<td class="org-right">2.48%</td>
</tr>
</tbody>
</table>

A 782x improvement in fairness!!


### Context Switch Times

Not directly from the move to EEVDF, but the associated move of the RunQueue from a Global to per-core state, allowed the time required for a voluntary (`yield_now`) context switch to drop from 2µs down to 350ns (Do note that these values contain some overhead from the testing harness too, so the real numbers are probably less than reported)!!

For blocking context switches, see the table below,

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<tbody>
<tr>
<td class="org-left">&#xa0;</td>
<td class="org-left">Avg. Latency</td>
</tr>

<tr>
<td class="org-left">Linux, Pinned to Core 0, Native Host</td>
<td class="org-left">0.552µs</td>
</tr>

<tr>
<td class="org-left">Redox EEVDF, Single Core, QEMU</td>
<td class="org-left">0.923µs</td>
</tr>

<tr>
<td class="org-left">Redox EEVDF, 4 Cores, QEMU</td>
<td class="org-left">0.931µs</td>
</tr>

<tr>
<td class="org-left">Linux, Unpinned, Native Host</td>
<td class="org-left">1.230µs</td>
</tr>

<tr>
<td class="org-left">Redox DWRR, Single Core, QEMU</td>
<td class="org-left">1.367µs</td>
</tr>

<tr>
<td class="org-left">Redox DWRR, 4 Cores, QEMU</td>
<td class="org-left">4.253µs</td>
</tr>
</tbody>
</table>

The comparision to Linux is not apples-to-apples, as Linux is running natively on the host while Redox is running under QEMU.


### Starvation

If you remember from this [brief announcement](https://www.redox-os.org/news/eevdf/) when EEVDF was merged, the starvation of the lower priority processes made it very difficult to even measure if the priorities were being followed properly, giving us a ratio of 1.4x as compared to the theoretical 86.8x. With EEVDF, we have this ratio at 76.87x, ~89% of the theoretical value. The remaining difference is small and may be attributable to scheduling noise and imperfect starting points.


### Wakeup heavy workloads

For workloads where there are many sleeping threads, the new scheduler pulls out a very significant lead, more due to the various optimisations rather than the mathematical algorithm, but still&#x2026;

I initiated 10,000 sleeping processes and two message passing processes (that block/wake on message sent/received) that force a context switch.

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-right" />
</colgroup>
<tbody>
<tr>
<td class="org-left">&#xa0;</td>
<td class="org-right">Round Trips / sec</td>
</tr>

<tr>
<td class="org-left">DWRR, Single Core</td>
<td class="org-right">2197</td>
</tr>

<tr>
<td class="org-left">DWRR, 4 Cores</td>
<td class="org-right">765</td>
</tr>

<tr>
<td class="org-left">EEVDF, Single Core</td>
<td class="org-right">107945</td>
</tr>

<tr>
<td class="org-left">EEVDF, 4 Cores</td>
<td class="org-right">109386</td>
</tr>
</tbody>
</table>

A Round Trip here is defined as A -> B -> A.

The thing to note here is that not only does EEVDF win, by a large ~143x margin too, but also the timing remains flat under multiple cores too! This improvement is attributable to both EEVDF and the removal of linear scan too!


### Throughput

The raw throughput, running only pixelcannon on a single core, DWRR gives ~1600 fps, which drops down to 150 fps when moving the mouse, the GUI freezes up though so you cannot see the cursor moving. On EEVDF, the base FPS is ~1700 dropping down to ~190 when moving the cursor, yes the cursor as the GUI is still smooth and responsive with EEVDF!

DWRR Single Core-

```
Starting Benchmarks!
  Message Threads: 2
  Worker  Threads: 2
  Runtime        : 30s
  Operations     : 5

===Results===
Runtime: 31.86s
Total operations: 3935
Operations/sec: 123.50

Wakeup Latencies (usec):
   50.0th:    4481024
   90.0th:    4677632
   99.0th:    5054464
   99.9th:    5120000
  min: 11388, max: 5140463
  samples: 3935

Request Latencies (usec):
   50.0th:       2244
   90.0th:       2484
   99.0th:       2556
   99.9th:       2580
  min: 2107, max: 2663
  samples: 3935

```

EEVDF Single Core-

```
Starting Benchmarks!
  Message Threads: 2
  Worker  Threads: 2
  Runtime        : 30s
  Operations     : 5

===Results===
Runtime: 31.09s
Total operations: 10057
Operations/sec: 323.50

Wakeup Latencies (usec):
   50.0th:    1538048
   90.0th:    1755136
   99.0th:    1927168
   99.9th:    2021376
  min: 8178, max: 2051283
  samples: 10057

Request Latencies (usec):
   50.0th:       2148
   90.0th:       2180
   99.0th:       2188
   99.9th:       2196
  min: 2128, max: 2513
  samples: 10057

```

There is a 2.6x improvement in ops/sec, and a significant reduction in wakeup and request latencies!!


## Conclusion

The move to EEVDF was worth it! This concludes my Redox Summer of Code!

This was my first real "internship" and the first time I have worked properly on a codebase that wasn't my own. So I am quite thankful to the entire Redox community and especially Ron Williams!!

You can follow more of my low-level systems deep-dives and follow-up work on my personal blog at [himwant.org](https://himwant.org)!

And my watch is ended `_/\_`

