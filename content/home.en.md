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
          <ul class="laundry-list features" style="margin-bottom: 0px;">
            <li><a href="https://doc.redox-os.org/book/microkernels.html">Microkernel</a> design</li>
            <li>Implemented in <a href="https://rust-lang.org">Rust</a></li>
            <li>Quick <a href="https://doc.redox-os.org/book/boot-process.html">System Bootstrap</a></li>
            <li><a href="https://doc.redox-os.org/book/drivers.html">Drivers</a> run in userspace</li>
            <li>Programs interact via <a href="https://doc.redox-os.org/book/schemes-resources.html">Schemes</a></li>
            <li>Smaller <a href="https://en.wikipedia.org/wiki/Attack_surface" target="_blank">attack of surface</a>
              compared to Linux</li>
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
          <ul class="laundry-list features" style="margin-bottom: 0px;">
            <li>Drivers are <a href="https://gitlab.redox-os.org/redox-os/drivers">fully implemented in Rust</a></li>
            <li>Implements custom filesystem <a href="https://doc.redox-os.org/book/microkernels.html">RedoxFS</a></li>
            <li>Audio, Video, OpenGL Emulation</li>
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
          Rust Ecosystem and GUI
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features" style="margin-bottom: 0px;">
            <li>Includes optional GUI - <a
                href="https://doc.redox-os.org/book/graphics-windowing.html#orbital">Orbital</a></li>
            <li>Supports <a href="https://doc.rust-lang.org/std/">Rust Standard Library</a></li>
            <li>COSMIC</li>
            <li>Winit</li>
            <li>Libredox</li>
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
          Programs and POSIX Compability
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features" style="margin-bottom: 0px;">
            <li><a href="https://doc.redox-os.org/book/programs-libraries.html">Source compatibility</a> with Linux/BSD
              programs</li>
            <li>Partial <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a> compatibility</li>
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
          Desktop and Gaming Compability
        </p>
        <div class="subtitle mt-2">
          <ul class="laundry-list features" style="margin-bottom: 0px;">
            <li>X11</li>
            <li>OpenGL Emulation</li>
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
          <ul class="laundry-list features" style="margin-bottom: 0px;">
            <li><a href="https://en.wikipedia.org/wiki/MIT_License">MIT</a> Licensed</li>
            <li>Lorem Ipsum</li>
          </ul>
        </div>
      </div>
      <div class="column hero-image">
        <img src="/img/fans/jason-bowen-coffee-mug.jpg" alt="" height="480" loading="lazy">
      </div>
    </div>
  </div>
</div>

<a rel="me" href="https://floss.social/@redox"></a>