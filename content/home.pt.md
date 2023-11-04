+++
title = "Início"
url = "home"
+++
<div class="row install-row">
  <div class="col-md-8">
    <p class="pitch">
      O <b>Redox</b> é um sistema operacional <a style="color: inherit;" href="https://en.wikipedia.org/wiki/Unix-like"><b>Unix-like</b></a> escrito em <a style="color: inherit;" href="https://www.rust-lang.org/"><b>Rust</b></a>,
      que busca trazer as inovações desta linguagem de programação para um microkernel moderno e um conjunto completo de aplicações.
    </p>
  </div>
  <div class="col-md-4 install-box">
    <br/>
    <a class="btn btn-primary" href="/pt/quickstart/">Começo Rápido</a>
    <a class="btn btn-default" href="https://gitlab.redox-os.org/redox-os/redox/">GitLab</a>
  </div>
</div>
<div class="row features">
  <div class="col-md-6">
    <ul class="laundry-list" style="margin-bottom: 0px;">
      <li>Inspirado pelo <a href="http://9p.io/plan9/index.html">Plan 9</a>, <a href="http://www.minix3.org/">Minix</a>, <a href="https://sel4.systems/">seL4</a>, <a href="http://www.bsd.org/">BSD</a> e <a href="https://www.kernel.org/">Linux</a></li>
      <li>Implementado em <a href="https://www.rust-lang.org/">Rust</a></li>
      <li>Design de <a href="https://doc.redox-os.org/book/ch04-01-microkernels.html">Microkernel</a></li>
      <li>Inclui uma GUI opcional - <a href="https://doc.redox-os.org/book/ch04-09-graphics-windowing.html#orbital">Orbital</a></li>
      <li>Suporta a <a href="https://doc.rust-lang.org/std/">biblioteca padrão da Rust</a></li>
    </ul>
  </div>
  <div class="col-md-6">
    <ul class="laundry-list">
      <li>Licença <a href="https://en.wikipedia.org/wiki/MIT_License">MIT</a></li>
      <li>Os <a href="https://doc.redox-os.org/book/ch04-07-drivers.html">Drivers</a> são executados no espaço do usuário</li>
      <li>Inclui as <a href="https://doc.redox-os.org/book/ch06-04-system-tools.html">ferramentas</a> Unix/Linux mais comuns</li>
      <li><a href="https://doc.redox-os.org/book/ch06-00-programs-libraries.html">Compatibilidade de código-fonte</a> com programas do Linux/BSD</li>
      <li>Compatibilidade parcial com a <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a></li>
      <li><a href="https://en.wikipedia.org/wiki/C_standard_library">Biblioteca C</a> customizada e escrita em Rust (<a href="https://gitlab.redox-os.org/redox-os/relibc/">relibc</a>)</li>
      <li>Veja <a href="/pt/screens/">Redox em Ação</a></li>
    </ul>
  </div>
</div>
<div class="row features">
  <div class="col-sm-12">
    <div style="font-size: 16px; text-align: center;">
      Redox executando Orbital
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
