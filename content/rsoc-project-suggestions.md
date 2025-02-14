+++
title = "Summer of Code Project Suggestions"
+++

The Redox Summer of Code is now open for applications.

Redox supports students, recent graduates and other open source contributors through our Summer of Code programs,
including our own **Redox Summer of Code** (RSoC) and programs sponsored by other organizations.

Please read the [RSoC](/rsoc) announcement and the [RSoC Proposal Guide](/rsoc-proposal-how-to) and follow our instructions there.

These are some of our priorities, but if you have your own ideas, join us on Chat and let us know what you are thinking.

Projects in the **Rust-heavy** category require you to have demonstrated strong Rust expertise on real-world projects.
Projects in the **good Rust knowledge** category require you to have completed several projects in Rust and/or to have contributed to an open source written-in-Rust project, where we can review your work.

Choose a project you are confident you can complete successfully.
All of these projects provide substantial value to Redox,
don't feel like you need to pick the hardest one.

The scalable projects can be adjusted to fit a part-time or full-time 12-week schedule, but you must let us know how much time you plan to contribute as part of your proposal.
The large projects require full-time participation, and you must indicate your commitment to that level of effort.

## Medium-to-Large Scalable Projects, good Rust knowledge

- Improve Redox's automated testing suite and continuous integration testing processes.
- Port a variety of Linux applications to Redox. This involves implementing functions in our libc alternative, "relibc" and possibly porting some GUI functionality. It may require working with Makefiles and C/C++ code as well.
- Integrate the System Health profiling library, currently under development as a student project, to manage the restart of a variety of drivers. Extend the command line interface and GUI to provide a complete System Services Manager.
- Perform a "survivability analysis" of Redox - What system services can be killed and restarted, and still have Redox able to function? What will the effect on running applications be? What additional work needs to be done to improve survivability? Implement the proposed functionality and tooling.
- Improve Redox's ACPI support, including porting the Rust-OSDev ACPI crate, and completing the AML parser.
- Begin a port of WASM Rustix to Redox's written-in-Rust libc alternative, "relibc". Refactor relibc where needed to support both libc and Rustix interfaces. Implement additional functionality where feasible.
- Port one or more major web servers to Redox, such as nginx or Apache HTTP Server. (Requires knowledge of C)
- Port a major JavaScript/web engine to Redox, such as SpiderMonkey or [WebView](https://github.com/webview/webview). (Requires knowledge of C, C++)

## Large Projects, Rust-heavy

- Improve the USB input and USB storage support.
- Help improve Redox's performance by developing end-to-end profiling tools and libraries, analyzing bottlenecks and implementing optimizations.
- Implement "io_uring" for Redox's filesystem, RamFS and NVMe driver.
- Implement various scheduling algorithms for Redox process scheduler, including prioritized round-robin, EEVDF, and context-aware scheduling.
- Port QEMU to Redox, and implement Linux in a VM on Redox.
