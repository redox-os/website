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
          <a class="btn btn-default my-1" href="/screens/">Gallery</a>
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
      <b>Redox</b> is a <u>Microkernel</u> Operating System <u>written in Rust</u> designed to be lightweight,
      performant, and
      secure, aiming to bring full set of <u>Unix-compatible programs</u> and be a complete alternative to Linux and
      BSD.
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
            <li><a href="/faq/#rust-benefits">Rust-based</a> <a
                href="https://gitlab.redox-os.org/redox-os/kernel">kernel</a> and <a
                href="https://gitlab.redox-os.org/redox-os/drivers">drivers</a></li>
            <li><a href="/faq/#how-redox-was-influenced-by-other-systems">Inspired by</a>  Plan 9, Minix, seL4, BSD and Linux</li>
            <li>Quick <a href="https://doc.redox-os.org/book/boot-process.html">System Bootstrap</a></li>
            <li><a href="https://doc.redox-os.org/book/drivers.html">Drivers</a> run in userspace</li>
            <li>Programs interact via <a href="https://doc.redox-os.org/book/schemes-resources.html">Schemes</a></li>
            <li>Intel/AMD, ARM and RISC-V <a href="">chip support</a></li>
            <li>Smaller <a href="https://en.wikipedia.org/wiki/Attack_surface" target="_blank">attack of surface</a>
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
            <li>Boot from Disk, USB and NVME</li>
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
            <li>GNU-Like Coreutils support via <a href="https://github.com/uutils/coreutils/">uutils</a></li>
            <li>GUI management support via <a href="https://github.com/rust-windowing/winit/">winit</a></li>
            <li>GUI apps support via <a href="/news/this-month-240531">COSMIC Apps</a></li>
            <li>See list of <a href="https://doc.redox-os.org/book/side-projects.html"> Rust side-projects</a></li>
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
            <li>Many UNIX-compliant <a href="/faq/#what-programs-can-redox-run">programs ported</a></li>
            <li>Partial <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a> compatibility</li>
            <li>C Library is <a href="https://gitlab.redox-os.org/redox-os/relibc">written in Rust</a> </li>
            <li>Support for <a href="/news/01_rsoc2024_dynamic_linker"> Dynamic Linker</a></li>
            <li><a href="/news/release-0.5.0#standard-images">Pthreads</a> , <a href="/news/kernel-11">Signals</a> and <a href="/news/rsoc-2025-fdtbl">UDS</a> support</li>
            <li>See <a href="https://doc.redox-os.org/book/features.html">feature comparison </a> between Unix systems</li>
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
            <li>Rust-based <a href="https://gitlab.redox-os.org/redox-os/orbital/">GUI Compositor</a> </li>
            <li>Support for <a href="/news/porting-strategy#games-and-emulators">SDL1, SDL2</a>, <a href="/news/this-month-250531/">GTK3 and Mesa3D</a> </li>
            <li>Support for <a href="/news/this-month-250531/">X11 and X11 programs</a> </li>
            <li>Support for OpenGL 2 via CPU Emulation</li>
            <li>Working  <a href="https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/video">media playback</a> with SDL Player</li>
            <li>Working <a href="https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/web">web browser</a>  with Netsurf</li>
            <li>Many <a href="https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/games">games</a>  and <a href="https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/demos">demos</a> are ported</li>
            <li>See our <a href="/news/porting-strategy/">Software Porting Strategy</a></li>
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
            <li>We work on <a href="https://gitlab.redox-os.org/redox-os/redox/">self-hosted GitLab</a> </li>
            <li>Hosting <a href="/rsoc/">RSoC annually since 2018</a> </li>
            <li>Our work are <a href="https://doc.redox-os.org/book/philosophy.html">predominately MIT Licensed</a></li>
            <li>Backed via <a href="https://www.patreon.com/redox_os">Patreon</a>, Sponsor, <a
                href="https://redox-os.creator-spring.com/">Swags</a>, <a href="/donate/">and many more</a></li>
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
              href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1429">GTK 4+ and Qt5+</a></li>
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