+++
title = "Kezdőlap"
url = "home"
+++
<div class="grid grid-cols-3 gap-4">
  <div class="col-span-3 md:col-span-2">
    <p class="pitch">
      A <b>Redox</b> egy <a href="https://www.rust-lang.org/"><b>Rust</b></a> nyelven írt Unix-szerű operációs rendszer, melynek célja a Rust nyelv innovációinak alkalmazása egy modern mikrokernelre és egy teljes alkalmazáskészletre.
    </p>
  </div>
  <div class="col-span-3 md:col-span-1 install-box">
    <br/>
    <a class="btn btn-primary" href="https://gitlab.redox-os.org/redox-os/redox/-/releases">Kiadások megtekintése</a>
    <a class="btn btn-default" href="https://gitlab.redox-os.org/redox-os/redox/">GitLab</a>
  </div>
</div>
<div class="grid grid-cols-2 features">
  <div class="col-span-2 md:col-span-1">
    <ul class="laundry-list" style="margin-bottom: 0px;">
      <li>Rust nyelven fejlesztett</li>
      <li>Mikrokerneles felépítés</li>
      <li>Opcionális grafikus felület - Orbital</li>
      <li>Támogatja a Rust Standard Könyvtárat</li>
    </ul>
  </div>
  <div class="col-span-2 md:col-span-1">
    <ul class="laundry-list">
      <li>MIT licensz</li>
      <li>Felhasználói szinten futtatott illesztőprogramok</li>
      <li>Tartalmazza a szokásos Unix parancsokat</li>
      <li>Newlib port C nyelven írt programokhoz</li>
    </ul>
  </div>
</div>
<div class="row features">
  <div class="col-sm-12">
    <div style="font-size: 16px; text-align: center;">
      Orbital futtatása Redox alatt
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
