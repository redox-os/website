+++
title = "Home"
url = "home"
+++
<div class="row install-row">
  <div class="col-md-8">
    <p class="pitch">
      <b>Redox</b> is a [Unix-like](https://en.wikipedia.org/wiki/Unix-like) Operating System written in <a style="color: inherit;" href="https://www.rust-lang.org/"><b>Rust</b></a>,
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
      <li>Inspired by [Plan 9](http://9p.io/plan9/index.html), [Minix](http://www.minix3.org/), [seL4](https://sel4.systems/), [BSD](http://www.bsd.org/) and [Linux](https://www.kernel.org/)</li>
      <li>Implemented in [Rust](https://www.rust-lang.org/)</li>
      <li>[Microkernel](https://doc.redox-os.org/book/ch04-01-microkernels.html) Design</li>
      <li>Includes optional GUI - [Orbital](https://doc.redox-os.org/book/ch04-09-graphics-windowing.html#orbital)</li>
      <li>Supports [Rust Standard Library](https://doc.rust-lang.org/std/)</li>
    </ul>
  </div>
  <div class="col-md-6">
    <ul class="laundry-list">
      <li>[MIT](https://en.wikipedia.org/wiki/MIT_License) Licensed</li>
      <li>[Drivers](https://doc.redox-os.org/book/ch04-07-drivers.html) run in Userspace</li>
      <li>Includes common Unix/Linux [tools](https://doc.redox-os.org/book/ch06-04-system-tools.html)</li>
      <li>[Source compatibility](https://doc.redox-os.org/book/ch06-00-programs-libraries.html) with Linux/BSD programs</li>
      <li>Partial [POSIX](https://en.wikipedia.org/wiki/POSIX) compatibility</li>
      <li>Custom [C library](https://en.wikipedia.org/wiki/C_standard_library) written in Rust ([relibc](https://gitlab.redox-os.org/redox-os/relibc/))</li>
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
