+++
title = "Accueil"
url = "home"
+++
<div class="columns install-row">
  <div class="column is-two-thirds">
    <p class="pitch">
      <b>Redox</b> est un système d'exploitation dans
      le <a style="color: inherit;" href="https://en.wikipedia.org/wiki/Unix-like"><b>style Unix</b></a>, écrit en <a style="color: inherit;"
      href="https://www.rust-lang.org/fr/"><b>Rust</b></a>, visant
      à exploiter les innovations de ce langage dans un micro-noyau
      moderne et une suite logicielle complète.
    </p>
  </div>
  <div class="column install-box">
    <br/>
    <a class="btn btn-primary" href="/fr/quickstart/">Débuter</a>
    <a class="btn btn-default" href="https://gitlab.redox-os.org/redox-os/redox/">GitLab</a>
  </div>
</div>
<div class="columns features">
  <div class="column">
    <ul class="laundry-list" style="margin-bottom: 0px;">
      <li>Inspiré de <a href="http://9p.io/plan9/index.html">Plan 9</a>, <a href="http://www.minix3.org/">Minix</a>, <a href="https://sel4.systems/">seL4</a>, <a href="http://www.bsd.org/">BSD</a> et <a href="https://www.kernel.org/">Linux</a></li>
      <li>Écrit en <a href="https://www.rust-lang.org/">Rust</a></li>
      <li>Architecture en <a href="https://doc.redox-os.org/book/microkernels.html">Micro-Noyau</a></li>
      <li>Interface graphique optionnelle incluse - <a href="https://doc.redox-os.org/book/graphics-windowing.html#orbital">Orbital</a></li>
      <li>Compatible avec la <a href="https://doc.rust-lang.org/std/">bibliothèque standard de Rust</a></li>
    </ul>
  </div>
  <div class="column">
    <ul class="laundry-list">
      <li>Licence <a href="https://en.wikipedia.org/wiki/MIT_License">MIT</a></li>
      <li>Les <a href="https://doc.redox-os.org/book/drivers.html">Pilotes</a> s'exécutent en mode utilisateur</li>
      <li>Les <a href="https://doc.redox-os.org/book/system-tools.html">Outils</a> courants d'Unix sont disponibles</li>
      <li><a href="https://doc.redox-os.org/book/programs-libraries.html">Compatibilité avec le code source</a> de programmes Linux/BSD</li>
      <li>Compatibilité partielle avec <a href="https://en.wikipedia.org/wiki/POSIX">POSIX</a></li>
      <li>Une implémentation de la <a href="https://en.wikipedia.org/wiki/C_standard_library">bibliothèque C</a> écrit en Rust (<a href="https://gitlab.redox-os.org/redox-os/relibc/">relibc</a>)</li>
      <li>Voir <a href="/fr/screens/">Redox en fonctionnement</a></li>
    </ul>
  </div>
</div>
<div class="columns features">
  <div class="col-sm-12">
    <div style="font-size: 16px; text-align: center;">
      Redox avec Orbital
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
