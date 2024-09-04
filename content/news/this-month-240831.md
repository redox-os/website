+++
title = "This Month in Redox - August 2024"
author = "Ribbon and Ron Williams"
date = "2024-08-31"
+++

August was pretty exciting for Redox, here's all the latest news.

## Donate to Redox

If you would like to support Redox, please consider donating or buying some merch!

- [Donate](https://www.redox-os.org/donate/)
- [Patreon](https://www.patreon.com/redox_os)
- [Merch](https://redox-os.creator-spring.com/)

## Massive Performance Improvement On Virtual Machines

Thanks to the recent kernel profilling implementation, 4lDO2 discovered that a huge bottleneck in the context switching code, was simply reading the system time. That involves reading hardware registers from the [HPET](https://en.wikipedia.org/wiki/High_Precision_Event_Timer), which although reasonably fast on real hardware, is particularly slow on VMs as it requires expensive VM exits. This cost is now avoided by using the [TSC](https://en.wikipedia.org/wiki/Time_Stamp_Counter) using [KVM's](https://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine) paravirtualized system time API, resulting in a massive speedup.

Thus all system tasks have a much better performance now, from more IO throughput to network speed. We are doing benchmarks to determine the scale of this improvement.

This improvement is unfortunately not applicable for Redox running on real hardware. However, most recent CPUs support an *invariant TSC*, in which case the logic would be very similar to the paravirtualized logic, after the frequency has been determined at boot time by calibration. This will be implemented in the future, but for now, the real HPET is reasonably fast.

Running in a VM, Redox is now becoming slightly faster than Linux at certain synthetic benchmarks, for example the same-core context switch latency when using POSIX pipes (tested with `mitigations=off`). More exciting optimizations are coming, both to reduce context switch overhead further towards the hardware limit, and to reduce unnecessary context switches overall.

## Testing Redox

The past few weeks we have been working on polishing Redox a bit,
tweaking VM performance,
squashing some bugs and ensuring the new signals and process lifecycle code is working smoothly.
First impressions are important, and we continue to do our best to improve the Redox experience.

## System Improvements

bjorn3 updated most system components to use the new scheme path format, as we continue to move towards POSIX-compatible paths. 

## Relibc Improvements

- bjorn3 removed all code using the legacy scheme path format (URL paths)
- 4lDO2 added fixes on the `forkpty` and `dprintf` tests

## VirtualBox

Ribbon documented the instructions to run the Redox image on VirtualBox. See the [instructions in the book](https://doc.redox-os.org/book/ch02-01-running-vm.html#virtualbox-instructions) if you want to try it out.

## Programs

Perl 5 has been ported to Redox (at least partly)! Perl uses a complicated build system, but contributor Bendeguz Pisch (bpisch) managed to conquer it! We still have some challenges with dynamic library support, but basic perl scripting is now possible on Redox.

bpisch also updated our GNU make to 4.4. Another challenging build system overcome!

Ribbon added the `promote` TODO on the packaging convention for working recipes under the WIP category of Cookbook, it will improve the packagers communication. As many of our WIP packages are now ready to go, they need to be moved to the main categories at `cookbook/recipes`.

If you would like to help test and promote recipes, please join our [GitLab](https://gitlab.redox-os.org/redox-os/redox/) and [Matrix](https://matrix.to/#/#redox-join:matrix.org).

More programs were packaged as usual.

## Build System Improvements

Ron Williams fixed the `make f.recipe-name` command, now developers and testers are able to only download the recipe source again.

He reduced the `make rebuild` command cycle time, by reducing the number of times each package is scanned for updates during a rebuild.

He also created scripts requested by Ribbon to improve the porting workflow.

Ribbon fixed a typo on the scripts that disabled the shebangs.

## Documentation Improvements

The [scheme documentation](https://doc.redox-os.org/book/ch05-00-schemes-resources.html) (system API) is finally up-to-date! thanks to Ron Williams.

We dropped the previous scheme path format (`scheme-name:resource-name`) to reduce the effort to port programs, now the schemes use the Unix path format (`/scheme/scheme-name/resource-name`).

(The `/scheme/` before the scheme daemon name is to avoid it to be treated as a file resource from RedoxFS, removing any confusion)

## Other Improvements

- Ribbon migrated the book recipe contents to `/usr`
- Ribbon packaged the HTML files from the website

## Community Improvements

Lots of new contributors have joined this month! We are excited to have so many new people on board.
People are diving in and looking for ways to help make Redox better!

We added a policy to request that developers add their Matrix or Discord usernames on the "About" section of their GitLab profiles, to improve our awareness of who is submitting merge requests and issues.

Now we also request that people creating issues on GitLab to send the issue links on the chat, to help improve visibility of new issues.

## RustConf

Ron Williams will be at [RustConf](https://rustconf.com/) in Montreal September 10-13.
Look for person in the [bright blue Redox hoodie](https://redox-os.creator-spring.com/listing/redox-hoodie?product=227&variation=2665&size=1247).
Ron will give demos of Redox as opportunity allows. Come say hi!

## Join us on Matrix Chat

If you want to contribute, give feedback or just listen in to the conversation,
join us on [Matrix Chat](https://matrix.to/#/#redox-join:matrix.org).

## Discussion

Here are some links to discussion about this news post:

- [Fosstodon @redox](https://fosstodon.org/@redox/113080386969774301)
- [Fosstodon @soller](https://fosstodon.org/@soller/113080386010260292)
- [Patreon](https://www.patreon.com/posts/111421950)
- [Reddit /r/redox](https://www.reddit.com/r/Redox/comments/1f8ynw7/this_month_in_redox_august_2024/)
- [Reddit /r/rust](https://www.reddit.com/r/rust/comments/1f8yoqy/this_month_in_redox_os_august_2024/)
- [X/Twitter @redox_os](https://x.com/redox_os/status/1831378079169577027)
- [X/Twitter @jeremy_soller](https://x.com/jeremy_soller/status/1831377989646406069)
- [Hacker News](https://news.ycombinator.com/item?id=41448078)
