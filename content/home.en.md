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
          <a class="btn btn-primary" href="/quickstart/">Quickstart</a>
          <a class="btn btn-default" href="https://gitlab.redox-os.org/redox-os/redox/">GitLab</a>
          <a class="btn btn-default" href="/news/release-0.9.0/">Release Notes</a>
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
            <li><a href="https://rust-lang.org">Rust</a>-based kernel and drivers</li>
            <li>Quick <a href="https://doc.redox-os.org/book/boot-process.html">System Bootstrap</a></li>
            <li><a href="https://doc.redox-os.org/book/drivers.html">Drivers</a> run in userspace</li>
            <li>Programs interact via <a href="https://doc.redox-os.org/book/schemes-resources.html">Schemes</a></li>
            <li>Intel/AMD, ARM and RISC-V <a href="">chip support</a></li>
            <li>Smaller <a href="https://en.wikipedia.org/wiki/Attack_surface" target="_blank">attack of surface</a>
              compared to Linux</li>
            <li>The minimal image size is under 50 MB</li>
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
            <li>Good virtualization support</li>
            <li>Common <a href="https://doc.redox-os.org/book/hardware-support.html">hardware support</a></li>
            <li><a href="https://doc.redox-os.org/book/redoxfs.html">ZFS-Inspired</a> file system</li>
            <li>Boot with full disk encryption</li>
            <li>Working audio, video, input, disk and network drivers</li>
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
            <li>Integration with forked GCC Tooling</li>
            <li>Many crates supports Redox</li>
            <li>GNU-Like Coreutils Support via <a href="https://github.com/uutils/coreutils/">uutils</a></li>
            <li>GUI management support via <a href="https://github.com/rust-windowing/winit/">Winit</a></li>
            <li>GUI apps support via <a href="">COSMIC Apps</a></li>
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
            <li>Many C-based libraries and programs ported</li>
            <li>Partial <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a> compatibility</li>
            <li>C Library is written in Rust</li>
            <li>Support for Dynamic Linking</li>
            <li>Threading and UDS support</li>
          </ul>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/redox-cosmic/cosmic-edit.png" alt="" height="480" loading="lazy">
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
            <li>Rust-based GUI Compositor</li>
            <li>Support for SDL1, SDL2, GTK3 and Mesa3D</li>
            <li>Support for X11 and X11 programs</li>
            <li>Support for OpenGL 2 via CPU Emulation</li>
            <li>Working media playback with FFplay</li>
            <li>Working web browser with Netsurf</li>
            <li>Many games and demos are ported</li>
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
            <li>We work on self-hosted GitLab</li>
            <li>Hosting RSoC annually since 2018</li>
            <li>Our work are mostly <a href="https://en.wikipedia.org/wiki/MIT_License">MIT</a> Licensed</li>
            <li>Backed via Patreon, Sponsor, Swags, and many more</li>
            <li>Many ways to support and contribute</li>
            <li>See us on Matrix!</li>
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
            <a href="https://nlnet.nl/project/Capability-based-RedoxOS/">Capability-based
              security for Redox</a> and
            <a href="https://nlnet.nl/project/RedoxOS-ringbuffer/">io_uring-like IO for Redox</a>
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
          <li>Port Wayland and GTK 4+</li>
          <li>Capability-based Security</li>
          <li>Self-Hosting OS Development</li>
          <li>Emulated Drivers in VM</li>
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
      <input class="input is-info bg-info is-family-monospace is-size-7  has-text-centered" type="text" readonly
        value="curl -sSL https://gitlab.redox-os.org/redox-os/redox/-/raw/master/podman_bootstrap.sh | bash">
      <p class="mt-5  has-text-centered">
        See our Guide or FAQ and join us on Matrix!
      </p>
    </div>
  </div>
</div>
</div>