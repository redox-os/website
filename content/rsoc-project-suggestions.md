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

- Port a written-in-Rust web server to Redox. Get Redox to run in a VM (e.g. QEMU) on a cloud server, and enable Redox's website to be self-hosted. Improve the end-to-end performance of the server.
- Improve Redox's automated testing suite and continuous integration testing processes.
- Port a variety of Linux applications to Redox. This involves implementing functions in our libc alternative, "relibc" and possibly porting some GUI functionality. It may require working with Makefiles and C/C++ code as well.
- Create a System Health profiling library, a GUI and a command-line interface to display activity levels for Redox's daemons and drivers.
- Perform a "survivability analysis" of Redox - What tasks can be killed and restarted, and still have Redox able to function? What will the effect on running applications be? What additional work needs to be done to improve survivability? Implement the proposed functionality and tooling.

## Large Projects, Rust-heavy

- Improve Redox's USB/HID support.
- Help improve Redox's performance by developing end-to-end profiling tools and libraries, analyzing bottlenecks and implementing optimizations.
- Implement "io_uring" for Redox's filesystem, RamFS and NVMe driver.
- Implement a user-space process manager that can safely modify process context information shared with the kernel. Implement the Session/Process Group/Process/Thread hierarchy.
- Begin a port of WASM Rustix to Redox's written-in-Rust libc alternative, "relibc". Refactor relibc where needed to support both libc and Rustix interfaces. Implement additional functionality where feasible.
