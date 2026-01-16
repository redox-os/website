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
        <img src="/img/home/programs1-opt.png" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</section>
<section class="hero hero-2">
  <div class="hero-body">
    <p class="pitch">
      <b>Redox OS<a href="https://gitlab.redox-os.org/redox-os/redox/-/blob/master/TRADEMARK.md"><sup>TM</sup></a></b> is a complete <a href="https://en.wikipedia.org/wiki/Unix-like"><b>Unix-like</b></a>
      microkernel-based operating system written in <a
        href="https://www.rust-lang.org/"><b>Rust</b></a>, with a focus on security, reliability and safety.
      Offering source compatibility and a full set of programs, Redox is intended to be a complete
      alternative to Linux and BSD, in the cloud and on the desktop.
    </p>
  </div>
</section>

<div class="hero-3">

  <div class="hero">
    <div class="hero-body">
      <div class="columns is-flex-direction-row-reverse">
        <div class="column hero-center">
          <p class="title is-size-3 mt-0">
            Stability and Security
          </p>
          <div class="subtitle mt-2">
            <ul class="laundry-list features mb-0">
              <li><a href="https://doc.redox-os.org/book/microkernels.html">Microkernel</a> design</li>
              <li><a href="https://doc.redox-os.org/book/drivers.html">Drivers</a> run in userspace</li>
              <li>OS Services provided via <a href="https://doc.redox-os.org/book/schemes-resources.html">Schemes</a>
              </li>
              <li><a href="/faq/#rust-benefits">Rust-written</a> <a
                  href="https://gitlab.redox-os.org/redox-os/kernel">kernel</a> and <a
                  href="https://gitlab.redox-os.org/redox-os/drivers">drivers</a></li>
              <li><a href="/faq/#how-redox-was-influenced-by-other-systems">Inspired by Plan 9, Minix, seL4, BSD and
                  Linux</a></li>
              <li>Much smaller <a href="https://en.wikipedia.org/wiki/Attack_surface" target="_blank">attack of
                  surface</a>
                compared to Linux</li>
              <li>See our <a href="https://doc.redox-os.org/book/security.html">security features</a></li>
            </ul>
          </div>
        </div>
        <div class="column hero-image" title="Redox with Orbital run on RISC-V">
          <img src="/img/home/orbital-riscv64gc-opt.png" alt="" height="480" loading="lazy">
        </div>
      </div>
    </div>
  </div>

  <div class="hero">
    <div class="hero-body">
      <div class="columns">
        <div class="column hero-center">
          <p class="title is-size-3 mt-0">
            Performance
          </p>
          <div class="subtitle mt-2">
            <ul class="laundry-list features mb-0">
              <li>Fast <a href="https://gitlab.redox-os.org/redox-os/benchmarks#tests">I/O performance</a></li>
              <li>Fast <a href="https://doc.redox-os.org/book/boot-process.html">system boot</a></li>
              <li>Desktop variant using less than 512 MB of RAM</li>
              <li>The <a href="https://static.redox-os.org/img/x86_64/">minimal image</a> occupies less than 50 MB</li>
              <li>Easy customization to save space, using a TOML-format configuration file</li>
            </ul>
          </div>
        </div>
        <div class="column hero-image" title="Redox runs on old Panasonic Toughbook hardware">
          <img src="/img/home/panasonic-toughbook-cf18-opt.png" alt="" height="480" loading="lazy">
        </div>
      </div>
    </div>
  </div>

  <div class="hero">
    <div class="hero-body">
      <div class="columns is-flex-direction-row-reverse">
        <div class="column hero-center">
          <p class="title is-size-3 mt-0">
            Drivers and Hardware Support
          </p>
          <div class="subtitle mt-2">
            <ul class="laundry-list features mb-0">
              <li>Intel/AMD, ARM and RISC-V CPU support</li>
              <li>Good <a href="/faq/#which-virtual-machines-does-redox-have-integration-with">virtualization
                  support</a></li>
              <li>Common <a href="/faq/#which-devices-does-redox-support">hardware support</a></li>
              <li>Support for PS/2 and USB keyboards, mouse and touchpads</li>
              <li><a href="https://doc.redox-os.org/book/redoxfs.html">ZFS-Inspired</a> file system</li>
              <li>Boot from NVMe, SATA, IDE, and USB</li>
              <li>Boot with <a href="https://doc.redox-os.org/book/installing.html">full disk encryption</a></li>
              <li>See list of <a
                  href="https://gitlab.redox-os.org/redox-os/drivers#hardware-interfaces-and-devices">supported
                  drivers</a></li>
            </ul>
          </div>
        </div>
        <div class="column hero-image" title="Redox runs on many laptops">
          <img src="/img/home/many-laptops-opt.jpg" alt="" height="480" loading="lazy">
        </div>
      </div>
    </div>
  </div>

  <div class="hero">
    <div class="hero-body">
      <div class="columns">
        <div class="column hero-center">
          <p class="title is-size-3 mt-0">
            Rust Ecosystem
          </p>
          <div class="subtitle mt-2">
            <ul class="laundry-list features mb-0">
              <li>Tier 2 and 3 of <a href="https://doc.rust-lang.org/nightly/rustc/platform-support/redox.html">Rust
                  Platform Support</a> </li>
              <li>Support for <a href="https://doc.rust-lang.org/std/">Rust Standard Library</a></li>
              <li>GUI tools supported via <a href="https://system76.com/cosmic/">COSMIC programs</a></li>
              <li>Linux system tools supported via <a href="https://github.com/uutils/coreutils/">uutils</a></li>
              <li>Many crates support Redox</li>
              <li>See list of <a href="https://doc.redox-os.org/book/side-projects.html"> side-projects</a></li>
            </ul>
          </div>
        </div>
        <div class="column hero-image" title="Redox runs with COSMIC programs">
          <img src="/img/home/cosmic-programs-opt.png" alt="" height="480" loading="lazy">
        </div>
      </div>
    </div>
  </div>

  <div class="hero">
    <div class="hero-body">
      <div class="columns is-flex-direction-row-reverse">
        <div class="column hero-center">
          <p class="title is-size-3 mt-0">
            UNIX Compatibility
          </p>
          <div class="subtitle mt-2">
            <ul class="laundry-list features mb-0">
              <li><a href="https://doc.redox-os.org/book/programs-libraries.html">Source compatibility</a> with
                Linux/BSD
                programs</li>
              <li>Integration with <a href="https://gitlab.redox-os.org/redox-os/gcc">forked GCC Compiler</a></li>
              <li>Many Linux <a href="/faq/#what-programs-can-redox-run">programs ported</a></li>
              <li>Partial <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a> compatibility</li>
              <li>Custom C Standard Library is <a href="https://gitlab.redox-os.org/redox-os/relibc">written in Rust</a>
              </li>
              <li>POSIX Signals/Threads and Unix Domain Sockets support</li>
              <li>See <a href="https://doc.redox-os.org/book/features.html">feature comparison </a> between Unix-like
                systems</li>
            </ul>
          </div>
        </div>
        <div class="column hero-image" title="Bochs emulator running on Redox">
          <img src="/img/screenshot/bochs_redox_demo_1.png" alt="" height="480" loading="lazy">
        </div>
      </div>
    </div>
  </div>

  <div class="hero">
    <div class="hero-body">
      <div class="columns">
        <div class="column hero-center">
          <p class="title is-size-3 mt-0">
            GUI Compatibility
          </p>
          <div class="subtitle mt-2">
            <ul class="laundry-list features mb-0">
              <li>Rust-written <a href="https://gitlab.redox-os.org/redox-os/orbital/">windowing system and window
                  manager</a> </li>
              <li>Support for X11, GTK3, Iced, Slint, egui, winit, softbuffer, SDL2, SDL1 and Mesa3D OSMesa</li>
              <li>Support for OpenGL CPU emulation via Mesa3D LLVMPipe</li>
              <li>Working media playback with ffplay and SDL Player</li>
              <li>Working basic web browser with NetSurf</li>
              <li>Many <a href="https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/games">games</a> and
                <a href="https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/demos">demos</a> are ported
              </li>
            </ul>
          </div>
        </div>
        <div class="column hero-image" title="Balatro (game) running on Redox">
          <img src="/img/home/balatro-redox-opt.png" alt="" height="480" loading="lazy">
        </div>
      </div>
    </div>
  </div>

  <div class="hero">
    <div class="hero-body">
      <div class="columns is-flex-direction-row-reverse">
        <div class="column hero-center">
          <p class="title is-size-3 mt-0">
            Open Source and Community
          </p>
          <div class="subtitle mt-2">
            <ul class="laundry-list features mb-0">
              <li>Active Community since 2015</li>
              <li> <a href="https://gitlab.redox-os.org/redox-os/redox/">Self-hosted GitLab server</a> </li>
              <li>Hosting the <a href="/rsoc/">Redox Summer Of Code program annually since 2018</a> </li>
              <li>Our work is <a href="https://doc.redox-os.org/book/philosophy.html">predominately MIT Licensed</a>
              </li>
              <li>Backed via
                <a href="https://donorbox.org/redox-os">Donorbox</a>,
                <a href="https://www.patreon.com/redox_os">Patreon</a>,
                <a href="https://bitcoin.org">Bitcoin</a>,
                <a href="https://ethereum.org">Ethereum</a>,
                <a href="https://redox-os.creator-spring.com/">merch</a>, <a href="/donate/">and many more</a>
              </li>
              <li>Many ways to <a
                  href="https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md">support and
                  contribute</a> </li>
              <li>Chat with us on <a
                  href="https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md#matrix"> Matrix</a>!
              </li>
            </ul>
          </div>
        </div>
        <div class="column hero-image" title="Redox's Coffee mug swag">
          <img src="/img/home/jason-bowen-coffee-mug-opt.jpg" alt="" height="480" loading="lazy">
        </div>
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
        <u><a href="/donate">and our patrons</a></u>
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
      <div class="subtitle mt-2">
        <ul class="laundry-list features mb-0">
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1427">Wayland</a>, <a
              href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1429">GTK4, Qt5, and Qt6+</a></li>
          <li><a href="https://nlnet.nl/project/Capability-based-RedoxOS/">Capability-based Security</a></li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1412">Smaller kernel code</a> </li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1390">Self-Hosting OS</a></li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1553">Native Linux VM</a> </li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redoxfs/-/merge_requests/95">File system compression</a></li>
          <li><a href="https://gitlab.redox-os.org/redox-os/redox/-/issues/1710">Accessibility Improvements</a> </li>
          <li>and <a href="https://gitlab.redox-os.org/groups/redox-os/-/issues/?label_name[]=tracking%20issue">more</a> </li>
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
      <div class="field has-addons">
        <p class="control is-flex-grow-1">
          <input class="input is-info bg-info is-family-monospace is-size-6 has-text-centered mx-auto" type="text"
            readonly id="try-input"
            value='bash -ec "$(curl -fsSL https://gitlab.redox-os.org/redox-os/redox/raw/master/podman_bootstrap.sh)"'>
        </p>
        <p class="control">
          <button class="button" id="try-copy">
            <span></span>
            <span class="icon is-small">
              &nbsp;<img src="/img/logos/copy.svg" alt="">
            </span>
            <span></span>
            <span id="try-copy-hint" class="hide">&nbsp;&nbsp;Copied!</span>
          </button>
        </p>
      </div>
      <p class="mt-5 has-text-centered">
        Read the <a href="https://doc.redox-os.org/book/podman-build.html">Building Redox</a>,
        <a href="https://doc.redox-os.org/book/build-system-reference.html">Build System Guide</a>,
        <a href="/faq">General FAQ</a>,
        <a href="https://doc.redox-os.org/book/developer-faq.html">Developer FAQ</a> and
        <a href="https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md#matrix">join us on Matrix!
        </a>
      </p>
    </div>
  </div>
</div>
</div>

{{% partial "home.html" %}}