+++
title = "Home"
url = "home"
+++
<div class="row install-row">
  <div class="col-md-8">
    <p class="pitch">
      <b>Redox</b> is a <a style="color: inherit;" href="https://en.wikipedia.org/wiki/Unix-like"><b>Unix-like</b></a> Operating System written in <a style="color: inherit;" href="https://www.rust-lang.org/"><b>Rust</b></a>,
      aiming to bring the innovations of Rust to a modern microkernel and full set of applications.
    </p>
  </div>
  <div class="col-md-4 install-box">
    <br/>
    <a class="btn btn-primary" href="/quickstart/">Quickstart</a>
    <a class="btn btn-default" href="https://gitlab.redox-os.org/redox-os/redox/">GitLab</a>
  </div>
</div>
<div class="row features">
  <div class="col-md-6">
    <ul class="laundry-list" style="margin-bottom: 0px;">
      <li>Inspired by <a href="http://9p.io/plan9/index.html">Plan 9</a>, <a href="http://www.minix3.org/">Minix</a>, <a href="https://sel4.systems/">seL4</a>, <a href="http://www.bsd.org/">BSD</a> and <a href="https://www.kernel.org/">Linux</a></li>
      <li>Implemented in <a href="https://www.rust-lang.org/">Rust</a></li>
      <li><a href="https://doc.redox-os.org/book/ch04-01-microkernels.html">Microkernel</a> Design</li>
      <li>Includes optional GUI - <a href="https://doc.redox-os.org/book/ch04-09-graphics-windowing.html#orbital">Orbital</a></li>
      <li>Supports <a href="https://doc.rust-lang.org/std/">Rust Standard Library</a></li>
    </ul>
  </div>
  <div class="col-md-6">
    <ul class="laundry-list">
      <li><a href="https://en.wikipedia.org/wiki/MIT_License">MIT</a> Licensed</li>
      <li><a href="https://doc.redox-os.org/book/ch04-07-drivers.html">Drivers</a> run in Userspace</li>
      <li>Includes common Unix/Linux <a href="https://doc.redox-os.org/book/ch06-04-system-tools.html">tools</a></li>
      <li><a href="https://doc.redox-os.org/book/ch06-00-programs-libraries.html">Source compatibility</a> with Linux/BSD programs</li>
      <li>Partial <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a> compatibility</li>
      <li>Custom <a href="https://en.wikipedia.org/wiki/C_standard_library">C library</a> written in Rust (<a href="https://gitlab.redox-os.org/redox-os/relibc/">relibc</a>)</li>
      <li>See <a href="/screens/">Redox in Action</a></li>
    </ul>
  </div>
</div>
<div class="row features">
  <div class="col-sm-12">
    <div style="font-size: 16px; text-align: center;">
      Redox running Orbital
    </div>
    <a href="/img/redox-orbital/large.png">
      <picture>
        <source media="(min-width: 1300px)" srcset="/img/redox-orbital/large.webp" type="image/webp">
        <source media="(min-width: 640px)" srcset="/img/redox-orbital/medium.webp" type="image/webp">
        <source media="(min-width: 320px)" srcset="/img/redox-orbital/medium.webp" type="image/webp">
        <source media="(min-width: 1300px)" srcset="/img/redox-orbital/large.png" type="image/png">
        <source media="(min-width: 640px)" srcset="/img/redox-orbital/medium.png" type="image/png">
        <source media="(min-width: 320px)" srcset="/img/redox-orbital/small.png" type="image/png">
        <img src="/img/redox-orbital/medium.png" class="img-responsive" alt="Redox and Orbital">
      </picture>
    </a>
  </div>
</div>
<a rel="me" href="https://fosstodon.org/@redox"></a>
