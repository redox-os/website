+++
title = "Home"
url = "home"
+++

<section class="hero hero-1">
  <div class="hero-body">
    <div class="columns">
      <div class="column hero-center">
        <p class="title is-size-1 mt-0">
          <b>Redox OS 0.9.0</b>
        </p>
        <div class="subtitle mt-5">
          <a class="btn btn-primary my-1" href="/quickstart/">Quickstart</a>
          <a class="btn btn-default my-1" href="https://gitlab.redox-os.org/redox-os/redox/">GitLab</a>
          <a class="btn btn-default my-1" href="/news/release-0.9.0/">Release Notes</a>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/screenshot/programs1.png" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</section>
<section class="hero hero-2">
  <div class="hero-body">
    <p class="pitch">
      <b>Redox</b> is a <a style="color: inherit;" href="https://en.wikipedia.org/wiki/Unix-like"><b>Unix-like</b></a> general-purpose microkernel-based operating system written in <a style="color: inherit;" href="https://www.rust-lang.org/"><b>Rust</b></a>, aiming to bring the innovations of Rust to a modern microkernel, a full set of programs and be a complete alternative to Linux and BSD.
    </p>
  </div>
</section>
<div class="hero hero-3">
  <div class="hero-body">
    <div class="columns is-flex-direction-row-reverse">
      <div class="column hero-center">
        <p class="title is-size-3 mt-0">
          Operating System and Security
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features mb-0">
            <li><a href="https://doc.redox-os.org/book/microkernels.html">Microkernel</a> design</li>
            <li><a href="/faq/#rust-benefits">Rust-written</a> <a
                href="https://gitlab.redox-os.org/redox-os/kernel">kernel</a> and <a
                href="https://gitlab.redox-os.org/redox-os/drivers">drivers</a></li>
            <li><a href="/faq/#how-redox-was-influenced-by-other-systems">Inspired by</a>  Plan 9, Minix, seL4, BSD and Linux</li>
            <li>Fast <a href="https://doc.redox-os.org/book/boot-process.html">System Bootstrap</a></li>
            <li><a href="https://doc.redox-os.org/book/drivers.html">Drivers</a> run in userspace</li>
            <li>Programs interact via <a href="https://doc.redox-os.org/book/schemes-resources.html">Schemes</a></li>
            <li>Intel/AMD, ARM and RISC-V <a href="">chip support</a></li>
            <li>Much smaller <a href="https://en.wikipedia.org/wiki/Attack_surface" target="_blank">attack of surface</a>
              compared to Linux</li>
            <li>The <a href="https://static.redox-os.org/img/x86_64/">minimal image</a> size is under 50 MB</li>
          </ul>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/screenshot/orbital-riscv64gc.png" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</div>

<div class="hero hero-3">
  <div class="hero-body">
    <div class="columns">
      <div class="column hero-center">
        <p class="title is-size-3 mt-0">
          Drivers and Hardware Support
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features mb-0">
            <li>Good <a href="/faq/#which-virtual-machines-does-redox-have-integration-with">virtualization support</a></li>
            <li>Common <a href="/faq/#which-devices-does-redox-support">hardware support</a></li>
            <li><a href="https://doc.redox-os.org/book/redoxfs.html">ZFS-Inspired</a> file system</li>
            <li>Boot from NVMe, SATA, IDE, and USB</li>
            <li>Boot with <a href="https://doc.redox-os.org/book/installing.html">full disk encryption</a></li>
            <li>See list of <a
                href="https://gitlab.redox-os.org/redox-os/drivers#hardware-interfaces-and-devices">supported
                drivers</a></li>
          </ul>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/release/0.8.0.jpg" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</div>


<div class="hero hero-3">
  <div class="hero-body">
    <div class="columns is-flex-direction-row-reverse">
      <div class="column hero-center">
        <p class="title is-size-3 mt-0">
          Rust Ecosystem
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features mb-0">
            <li>Tier 2 and 3 of <a href="https://doc.rust-lang.org/nightly/rustc/platform-support/redox.html">Rust
                Platform Support</a> </li>
            <li>Support for <a href="https://doc.rust-lang.org/std/">Rust Standard Library</a></li>
            <li>Integration with <a href="https://gitlab.redox-os.org/redox-os/gcc">forked GCC Compiler</a></li>
            <li>Many crates supports Redox</li>
            <li>Linux system tools supported via <a href="https://github.com/uutils/coreutils/">uutils</a></li>
            <li>GUI management support via <a href="https://github.com/rust-windowing/winit/">winit</a></li>
            <li>GUI apps support via <a href="/news/this-month-240531">COSMIC Apps</a></li>
            <li>See list of <a href="https://doc.redox-os.org/book/side-projects.html"> side-projects</a></li>
          </ul>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/screenshot/cosmic-programs.png" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</div>

<div class="hero hero-3">
  <div class="hero-body">
    <div class="columns">
      <div class="column hero-center">
        <p class="title is-size-3 mt-0">
          UNIX Compatibility
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features mb-0">
            <li><a href="https://doc.redox-os.org/book/programs-libraries.html">Source compatibility</a> with Linux/BSD
              programs</li>
            <li>Many Linux <a href="/faq/#what-programs-can-redox-run">programs ported</a></li>
            <li>Partial <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a> compatibility</li>
            <li>Custom C Standard Library is <a href="https://gitlab.redox-os.org/redox-os/relibc">written in Rust</a> </li>
            <li>POSIX Signals/Threads and Unix Domain Sockets support</li>
            <li>See <a href="https://doc.redox-os.org/book/features.html">feature comparison </a> between Unix-like systems</li>
          </ul>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/screenshot/bochs_redox_demo_1.png" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</div>

<div class="hero hero-3">
  <div class="hero-body">
    <div class="columns is-flex-direction-row-reverse">
      <div class="column hero-center">
        <p class="title is-size-3 mt-0">
          GUI Compatibility
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features mb-0">
            <li>Rust-written <a href="https://gitlab.redox-os.org/redox-os/orbital/">windowing system and window manager</a> </li>
            <li>Support for X11, GTK3, Iced, Slint, egui, winit, softbuffer, SDL2, SDL1 and Mesa3D OSMesa</li>
            <li>Support for OpenGL CPU emulation via Mesa3D LLVMPipe</li>
            <li>Working media playback with ffplay and SDL Player</li>
            <li>Working basic web browser with NetSurf</li>
            <li>Many <a href="https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/games">games</a>  and <a href="https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/demos">demos</a> are ported</li>
          </ul>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/screenshot/balatro-redox.png" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</div>

<div class="hero hero-3">
  <div class="hero-body">
    <div class="columns">
      <div class="column hero-center">
        <p class="title is-size-3 mt-0">
          Open Source and Community
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features mb-0">
            <li>Active Community since 2015</li>
            <li> <a href="https://gitlab.redox-os.org/redox-os/redox/">Self-hosted GitLab server</a> </li>
            <li>Hosting the <a href="/rsoc/">Redox Summer Of Code program annually since 2018</a> </li>
            <li>Our work is <a href="https://doc.redox-os.org/book/philosophy.html">predominately MIT Licensed</a></li>
            <li>Backed via [Donorbox](https://donorbox.org/redox-os), [Patreon](https://www.patreon.com/redox_os), [Bitcoin](https://bitcoin.org), [Ethereum](https://ethereum.org), [merch](https://redox-os.creator-spring.com/), [and many more](/donate/) </li>
            <li>Many ways to <a
                href="https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md">support and contribute</a> </li>
            <li>Chat with us on <a
                href="https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md#matrix"> Matrix</a>!</li>
          </ul>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/fans/jason-bowen-coffee-mug.jpg" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</div>

<div class="hero hero-4">
  <div class="hero-body has-text-centered">
    <div class="hero-center">
      <p class="is-size-3 mt-0">
        Active Sponsors
      </p>
      <p class="mt-2">
        We are thankful for these organizations supporting our work
      </p>
      <div class="columns">
        <div class="column">
          <img src="https://nlnet.nl/logo/banner.svg" alt="NGI Zero Commons Fund">
          <p>NGI Zero Commons Fund on 
            <a href="https://nlnet.nl/project/RedoxOS-Signals/">Unix-style Signals</a>,
            <a href="https://nlnet.nl/project/Capability-based-RedoxOS/">Capability-based
              security</a> and
            <a href="https://nlnet.nl/project/RedoxOS-ringbuffer/">io_uring-like IO</a>
          </p>
        </div>
      </div>
      <p class="mt-2 pitch">
        <u><a href="https://www.patreon.com/c/redox_os/home">and our patrons</a></u>
      </p>
    </div>
  </div>
</div>
</div>

<div class="hero hero-5">
  <div class="hero-body">
    <div class="hero-center">
      <p class="is-size-3 mt-0  has-text-centered">
        Lots of exciting roadmap ahead
      </p>
      <div class="subtitle mx-auto  mt-2">
        <ul class="laundry-list features mb-0">
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1427">Wayland</a>, <a
              href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1429">GTK4, Qt5, and Qt6+</a></li>
          <li><a href="https://nlnet.nl/project/Capability-based-RedoxOS/">Capability-based Security</a></li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1412">Smaller kernel code</a> </li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1390">Self-Hosting OS</a></li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1553">Native Linux VM</a> </li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redoxfs/-/merge_requests/95">File system compression</a>
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1710">Accessibility Improvements</a> </li>
          </li>
        </ul>
      </div>
      <p class="mt-2  has-text-centered">
        Contributions to new ideas are always open!
      </p>
    </div>
  </div>
</div>
</div>


<div class="hero hero-6">
  <div class="hero-body has-text-centered">
    <div class="hero-center">
      <p class="is-size-3 mt-0">
        Get the bleeding edge
      </p>
      <input class="input is-info bg-info is-family-monospace is-size-6  has-text-centered mx-auto" type="text" readonly
        value="curl -sSL https://gitlab.redox-os.org/redox-os/redox/-/raw/master/podman_bootstrap.sh | bash">
      <p class="mt-5  has-text-centered">
        See our <a href="https://doc.redox-os.org/book/build-system-reference.html">Build System Guide</a> or <a
          href="/faq">FAQ</a> and
        <a href="https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md#matrix">join us on Matrix!
        </a>
      </p>
    </div>
  </div>
</div>
</div>