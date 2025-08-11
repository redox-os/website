+++
title = "Home"
url = "home"
+++
<div class="columns install-row">
  <div class="column is-two-thirds">
    <p class="pitch">
      <b>Redox</b> is a <a style="color: inherit;" href="https://en.wikipedia.org/wiki/Unix-like"><b>Unix-like</b></a> general-purpose microkernel-based operating system written in <a style="color: inherit;" href="https://www.rust-lang.org/"><b>Rust</b></a>,
      aiming to bring the innovations of Rust to a modern microkernel, a full set of programs and be a complete alternative to Linux and BSD.
    </p>
  </div>
  <div class="column install-box">
    <br/>
    <a class="btn btn-primary" href="/quickstart/">Quickstart</a>
    <a class="btn btn-default" href="https://gitlab.redox-os.org/redox-os/redox/">GitLab</a>
  </div>
</div>
<div class="columns features">
  <div class="column">
    <ul class="laundry-list" style="margin-bottom: 0px;">
      <li>Inspired by <a href="http://9p.io/plan9/index.html">Plan 9</a>, <a href="http://www.minix3.org/">Minix</a>, <a href="https://sel4.systems/">seL4</a>, <a href="https://en.wikipedia.org/wiki/Berkeley_Software_Distribution">BSD</a> and <a href="https://www.kernel.org/">Linux</a></li>
      <li>Implemented in <a href="https://www.rust-lang.org/">Rust</a></li>
      <li><a href="https://doc.redox-os.org/book/microkernels.html">Microkernel</a> Design</li>
      <li>Includes optional GUI - <a href="https://doc.redox-os.org/book/graphics-windowing.html#orbital">Orbital</a></li>
      <li>Partial <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a> compatibility</li>
      <li><a href="https://doc.redox-os.org/book/programs-libraries.html">Source compatibility</a> with Linux/BSD programs</li>
    </ul>
  </div>
  <div class="column">
    <ul class="laundry-list">
      <li><a href="https://en.wikipedia.org/wiki/MIT_License">MIT</a> Licensed</li>
      <li>Supports <a href="https://doc.rust-lang.org/std/">Rust Standard Library</a></li>
      <li><a href="https://doc.redox-os.org/book/drivers.html">Drivers</a> run in Userspace</li>
      <li>Includes common Unix/Linux <a href="https://doc.redox-os.org/book/system-tools.html">tools</a></li>
      <li>Custom <a href="https://en.wikipedia.org/wiki/C_standard_library">C library</a> written in Rust (<a href="https://gitlab.redox-os.org/redox-os/relibc/">relibc</a>)</li>
      <li>See <a href="/screens/">Redox in Action</a></li>
    </ul>
  </div>
</div>
<div class="columns features">
  <div class="col-sm-12">
    <div style="font-size: 16px; text-align: center;">
      Redox running Orbital
    </div>
    <a href="/img/redox-orbital/large.png">
      <picture>
        <source media="(min-width: 640px)" srcset="/img/redox-orbital/large.webp" type="image/webp">
        <source media="(min-width: 320px)" srcset="/img/redox-orbital/medium.webp" type="image/webp">
        <source srcset="/img/redox-orbital/small.webp" type="image/webp">
        <source media="(min-width: 640px)" srcset="/img/redox-orbital/large.png" type="image/png">
        <source media="(min-width: 320px)" srcset="/img/redox-orbital/medium.png" type="image/png">
        <source srcset="/img/redox-orbital/small.png" type="image/png">
        <img src="/img/redox-orbital/large.png" class="img-responsive" alt="Redox and Orbital">
      </picture>
    </a>
  </div>
</div>
<a rel="me" href="https://floss.social/@redox"></a>
