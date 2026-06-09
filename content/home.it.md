+++
title = "Home"
url = "home"
+++
<div class="columns install-row">
  <div class="column is-two-thirds">
    <p class="pitch">
      <b>Redox</b> è un sistema operativo general-purpose <a style="color: inherit;" href="https://en.wikipedia.org/wiki/Unix-like"><b>Unix-like</b></a> basato su un microkernel scritto in <a style="color: inherit;" href="https://www.rust-lang.org/"><b>Rust</b></a>,
      con l'obiettivo di portare le innovazioni di Rust in un microkernel moderno ed in un pacchetto completo di applicazioni e di essere un'alternativa completa a Linux e BSD.
    </p>
  </div>
  <div class="column install-box">
    <br/>
    <a class="btn btn-primary" href="/quickstart/">Guida rapida</a>
    <a class="btn btn-default" href="https://gitlab.redox-os.org/redox-os/redox/">GitLab</a>
  </div>
</div>
<div class="columns features">
  <div class="column">
    <ul class="laundry-list" style="margin-bottom: 0px;">
      <li>Ispirato da <a href="http://9p.io/plan9/index.html">Plan 9</a>, <a href="http://www.minix3.org/">Minix</a>, <a href="https://sel4.systems/">seL4</a>, <a href="https://en.wikipedia.org/wiki/Berkeley_Software_Distribution">BSD</a> e <a href="https://www.kernel.org/">Linux</a></li>
      <li>Implementato in <a href="https://www.rust-lang.org/">Rust</a></li>
      <li>Design a <a href="https://doc.redox-os.org/book/microkernels.html">Microkernel</a></li>
      <li>Include una GUI opzionale - <a href="https://doc.redox-os.org/book/graphics-windowing.html#orbital">Orbital</a></li>
      <li>Compatibilità <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a> parziale</li>
      <li><a href="https://doc.redox-os.org/book/programs-libraries.html">Compatibilità codice sorgente</a> con i programmi Linux/BSD</li>
    </ul>
  </div>
  <div class="column">
    <ul class="laundry-list">
      <li>Sotto licenza <a href="https://en.wikipedia.org/wiki/MIT_License">MIT</a></li>
      <li>Supporta la <a href="https://doc.rust-lang.org/std/">Rust Standard Library</a></li>
      <li>I <a href="https://doc.redox-os.org/book/drivers.html">Driver</a> sono eseguiti nello Userspace</li>
      <li>Include <a href="https://doc.redox-os.org/book/system-tools.html">tool</a> Unix/Linux comuni</li>
      <li><a href="https://en.wikipedia.org/wiki/C_standard_library">Libreria C</a> custom scritta in Rust (<a href="https://gitlab.redox-os.org/redox-os/relibc/">relibc</a>)</li>
      <li>Vedi <a href="/screens/">Redox in azione</a></li>
    </ul>
  </div>
</div>
<div class="columns features">
  <div class="col-sm-12">
    <div style="font-size: 16px; text-align: center;">
      Redox con Orbital
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
<a rel="me" href="https://fosstodon.org/@redox"></a>
