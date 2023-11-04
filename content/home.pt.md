+++
title = "Início"
url = "home"
+++
<div class="row install-row">
  <div class="col-md-8">
    <p class="pitch">
      O <b>Redox</b> é um sistema operacional [Unix-like](https://en.wikipedia.org/wiki/Unix-like) escrito em <a style="color: inherit;" href="https://www.rust-lang.org/"><b>Rust</b></a>,
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
      <li>Inspirado pelo [Plan 9](http://9p.io/plan9/index.html), [Minix](http://www.minix3.org/), [seL4](https://sel4.systems/), [BSD](http://www.bsd.org/) e [Linux](https://www.kernel.org/)</li>
      <li>Implementado em [Rust](https://www.rust-lang.org/)</li>
      <li>Design de [Microkernel](https://doc.redox-os.org/book/ch04-01-microkernels.html)</li>
      <li>Inclui uma GUI opcional - [Orbital](https://doc.redox-os.org/book/ch04-09-graphics-windowing.html#orbital)</li>
      <li>Suporta a [biblioteca padrão da Rust](https://doc.rust-lang.org/std/)</li>
    </ul>
  </div>
  <div class="col-md-6">
    <ul class="laundry-list">
      <li>Licença [MIT](https://en.wikipedia.org/wiki/MIT_License)</li>
      <li>Os [drivers](https://doc.redox-os.org/book/ch04-07-drivers.html) são executados no espaço do usuário</li>
      <li>Inclui as [ferramentas](https://doc.redox-os.org/book/ch06-04-system-tools.html) Unix/Linux mais comuns</li>
      <li>[Compatibilidade de código-fonte](https://doc.redox-os.org/book/ch06-00-programs-libraries.html) com programas do Linux/BSD</li>
      <li>Compatibilidade parcial com a [POSIX](https://en.wikipedia.org/wiki/POSIX)</li>
      <li>[Biblioteca C](https://en.wikipedia.org/wiki/C_standard_library) customizada e escrita em Rust ([relibc](https://gitlab.redox-os.org/redox-os/relibc/))</li>
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
