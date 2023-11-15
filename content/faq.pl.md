+++
title = "FAQ"
+++

Na tej stronie znajdują się pytania/odpowiedzi dla nowicjuszy i użytkowników końcowych.

- [Co to jest Redox?](#Co-to-jest-Redox)
- [Co znaczy Redox?](#Co-znaczy-Redox)
- [Jakie funkcje ma Redox?](#Jakie-funkcje-ma-Redox)
    - [Microkernel benefits](#microkernel-benefits)
    - [Rust benefits](#rust-benefits)
- [Jaki jest cel Redox?](#Jaki-jest-cel-Redox)
- [Co mogę zrobić z Redox?](#Co-mogę-zrobić-z-Redox)
- [Co to jest system operacyjny typu Unix?](#Co-to-jest-system-operacyjny-typu-Unix)
- [Jak Redox inspiruje się innymi systemami?](#Jak-Redox-inspiruje-się-innymi-systemami)
    - [Plan 9](#plan-9)
    - [Minix](#minix)
    - [seL4](#sel4)
    - [BSD](#bsd)
    - [Linux](#linux)
- [Co to jest microkernel?](#Co-to-jest-microkernel)
- [Jakie programy może uruchomić Redox?](#Jakie-programy-może-uruchomić-Redox)
- [Jak zainstalować programy na Redox?](#Jak-zainstalować-programy-na-Redox)
- [Jakie są warianty Redox?](#Jakie-są-warianty-Redox)
- [Które urządzenia obsługuje Redox?](#Które-urządzenia-obsługuje-Redox)
- [Mam komputer z niższej półki, czy Redox będzie na nim działał?](#Mam-komputer-z-niższej-półki-czy-Redox-będzie-na-nim-działał)
- [Z jakimi maszynami wirtualnymi Redox ma integrację?](#Z-jakimi-maszynami-wirtualnymi-Redox-ma-integrację)
- [Jak skompilować Redox OS?](#Jak-skompilować-Redox-OS)
 - [Jak uruchomić QEMU bez GUI](#Jak-uruchomić-QEMU-bez-GUI)
 - [Jak rozwiązywać problemy z kompilacją w przypadku błędów](#Jak-rozwiązywać-problemy-z-kompilacją-w-przypadku-błędów)
 - [Jak zgłaszać błędy w Redox](#Jak-zgłaszać-błędy-w-Redox)
- [Jak mogę przyczynić się do rozwoju projektu Redox?](#Jak-mogę-przyczynić-się-do-rozwoju-projektu-Redox)
- [Mam problem/pytanie do zespołu Redox](#Mam-problem/pytanie-do-zespołu-Redox)

## Co to jest Redox?

Redox to system operacyjny oparty na mikrojądrze, kompletny, w pełni funkcjonalny system operacyjny ogólnego przeznaczenia, skupiający się na bezpieczeństwie, wolności, niezawodności, poprawności i pragmatyzmie.

Tam, gdzie to możliwe, komponenty systemu są pisane w języku Rust i uruchamiane w przestrzeni użytkownika.

### Aktualny stan

Redox to oprogramowanie o jakości alfa/beta, ponieważ wdrażamy nowe funkcje i naprawiamy błędy.

Dlatego nie jest jeszcze gotowy do codziennego użytku, możesz przetestować system do jego dojrzałości i **nie przechowuj wrażliwych danych bez odpowiedniej kopii zapasowej.**

Wersja 1.0 zostanie wydana, gdy wszystkie API systemu zostaną uznane za stabilne.

## Co znaczy Redox?

[Redox](https://en.wikipedia.org/wiki/Redox) ito reakcja chemiczna (redukcja-utlenianie), w wyniku której powstaje rdza, ponieważ Redox jest systemem operacyjnym napisanym w języku Rust, ma to sens.

To też brzmi jak Minix/Linux.

## Jakie funkcje ma Redox?

### Microkernel benefits

#### Prawdziwa modułowość

Możesz modyfikować/zmieniać wiele komponentów systemu bez ponownego uruchamiania systemu.[livepatching](https://en.wikipedia.org/wiki/Kpatch).

#### Izolacja błędów

Większość komponentów systemu działa w przestrzeni użytkownika w systemie mikrojądra, błąd w komponencie innym niż jądro nie spowoduje awarii systemu/jądra. Wiecej infromacji: [crash the system/kernel](https://en.wikipedia.org/wiki/Kernel_panic).

#### No-reboot design

W dobrze zaprojektowanych i napisanych Microkernelach naprawianie błędów wystepuje bardzo rzadko, więc nie będziesz musiał zbyt często restartować systemu, aby go zaktualizować.

Ponieważ większość komponentów systemu znajduje się w przestrzeni użytkownika, można je wymieniać na bieżąco (co skraca czas przestoju administratorów serwerów).

#### Łatwy w rozwoju i debugowaniu

Większość komponentów systemu działa w przestrzeni użytkownika, co upraszcza testowanie/debugowanie.

### Rust benefits

#### Mniej prawdopodobne, że będą zawierały błędy

Restrykcyjna składnia jezyka Rust i sugestie kompilatora znacznie zmniejszają prawdopodobieństwo wystąpienia błędów.

#### Nie ma potrzeby stosowania zabezpieczeń przed exploitami C/C++

Konstrukcja mikrojądra napisana w Rust chroni przed defektami pamięci C/C++.

Izolując komponenty systemu od jądra, [powierzchnia ataku](https://en.wikipedia.org/wiki/Attack_surface) jest bardzo ograniczona.

#### Większe bezpieczeństwo i niezawodność bez znaczącego wpływu na wydajność

Ponieważ jądro jest małe, zużywa mniej pamięci do wykonywania swojej pracy, a ograniczony rozmiar kodu jądra pomaga utrzymać status prawie wolny od błędów ([Zasada KISS](https://en.wikipedia.org/wiki/KISS_principle)).

Bezpieczny i szybki projekt języka Rusta, w połączeniu z małym rozmiarem kodu jądra, pomaga zapewnić niezawodny, wydajny i łatwy w utrzymaniu rdzeń systemu.

#### Bezpieczeństwo wątków

Obsługa bezpieczeństwa wątków w języku C/C++ jest dość delikatna i bardzo łatwo jest napisać program, który wygląda na bezpieczny do działania w wielu wątkach, ale który wprowadza subtelne błędy lub luki w zabezpieczeniach. Jeśli jeden wątek uzyskuje dostęp do fragmentu stanu w tym samym czasie, gdy inny wątek go zmienia, w całym programie mogą pojawić się naprawdę mylące i dziwaczne błędy.

Ale w Rust tego rodzaju błędów można łatwo uniknąć, ten sam system typów, który powstrzymuje nas przed zapisywaniem zagrożeń w pamięci, uniemożliwia nam zapisywanie niebezpiecznych wzorców współbieżnego dostępu

#### Sterowniki pisane w Rust

Sterowniki pisane w Rust zawieraja mniej błedów ze względu na rygorystyczne sprawdzanie typów i wycieków pamięci juz w trakcie kompilacji co zwieksza prawdopodobieństwo mniejszej ilości możliwych błedów w samym kodzie i dlatego są bezpieczniejsze w użytkowaniu.
- [Lista aktualnie obsługiwanych urządzeń](#which-devices-does-redox-support)

#### System plików inspirowany ZFS

Redox używa RedoxFS jako domyślnego systemu plików, obsługuje podobne funkcje jak [ZFS](https://docs.freebsd.org/en/books/handbook/zfs/) z implementacją napisaną w Rust.

Oczekuj wysokiej wydajności i bezpieczeństwa danych jak (kopiowanie przy zapisie, integralność danych, woluminy, migawki, zabezpieczenie przed utratą danych itd.).

## Jaki jest cel Redox?

Głównym celem Redox jest bycie systemem operacyjnym ogólnego przeznaczenia, przy jednoczesnym zachowaniu bezpieczeństwa, niezawodności i poprawności.

Redox ma być alternatywą dla istniejących systemów uniksowych (Linux/BSD), z możliwością uruchamiania większości programów uniksowych jedynie po rekompilacji lub minimalnych modyfikacjach.

- [Nasze cele](https://doc.redox-os.org/book/ch01-01-our-goals.html)

## Co mogę zrobić z Redox?

Jako system operacyjny ogólnego przeznaczenia będziesz w stanie wykonać prawie każde zadanie na większości urządzeń przy wysokiej wydajności/bezpieczeństwie.

Redox jest wciąż w fazie rozwoju, więc lista obsługiwanych aplikacji jest obecnie ograniczona, ale stale dodajemy nowe aplikacje i ich lista stale rośnie.

- [Przypadki użycia](https://doc.redox-os.org/book/ch01-04-redox-use-cases.html)

## Co to jest system operacyjny typu Unix?

Dowolny system operacyjny zgodny ze [Single Unix Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) i [POSIX](https://en.wikipedia.org/wiki/POSIX), oczekuj [shell](https://en.wikipedia.org/wiki/Unix_shell), "[koncepcja wszytsko jest plikiem](https://en.wikipedia.org/wiki/Everything_is_a_file)" , wielozadaniowość i wielu użytkowników.

[Unix](https://en.wikipedia.org/wiki/Unix) był bardzo wpływowym systemem wielozadaniowym i miał wpływ na wybory projektowe większości nowoczesnych systemów.

- [Artykuł na Wikipedia](https://en.wikipedia.org/wiki/Unix-like)

## Jak Redox inspiruje się innymi systemami?

### [Plan 9](http://9p.io/plan9/index.html)

Ten system operacyjny Bell Labs przenosi koncepcję „wszystko jest plikiem” na najwyższy poziom, realizując całą komunikację systemową z systemu plików.

- [Drew DeVault wyjaśnia Plan 9](https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html)
- [Wpływ Planu 9 na Redox](https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html)

### [Minix](https://minix3.org/)

Najbardziej wpływowy system uniksowy z mikrojądrem, posiadający zaawansowane funkcje, takie jak modułowość systemu, [kernel panic](https://en.wikipedia.org/wiki/Kernel_panic) rodporność, reinkarnacja sterowników, ochrona przed złymi sterownikami i bezpieczeństwo interfejsy do [komunikacji procesowej](https://en.wikipedia.org/wiki/Inter-process_communication).

Redox jest w dużej mierze inspirowany Minixem, ma podobną architekturę i zestaw funkcji napisany w Rust.

- [Jak Minix wpłynął na projekt Redox](https://doc.redox-os.org/book/ch04-01-microkernels.html)

### [seL4](https://sel4.systems/)

Najszybszy i najprostszy mikrokernel na świecie, ma na celu wydajność i prostotę.

Redox kieruje się tą samą zasadą, starając się maksymalnie zmniejszyć przestrzeń jądra (przenosząc komponenty do przestrzeni użytkownika i zmniejszając liczbę wywołań systemowych, przekazując złożoność do przestrzeni użytkownika) i utrzymując dobrą wydajność.

### [BSD](https://www.bsd.org/)

Ta [rodzina](https://en.wikipedia.org/wiki/Research_Unix) Uniksa zawierała kilka ulepszeń systemów uniksowych, a warianty BSD o otwartym kodzie źródłowym, które dodały wiele ulepszeń do oryginalnego systemu (podobnie jak Linux).

[FreeBSD](https://www.freebsd.org/) jest najbardziej godnym uwagi przykładem, z którego Redox czerpał inspirację [Capsicum](https://man.freebsd.org/cgi/man.cgi?capsicum(4)) (system oparty na możliwościach) i [jails](https://en.wikipedia.org/wiki/Freebsd_jail) (technologia sandbox) do implementacji przestrzeni nazw.

### [Linux](https://www.kernel.org/)

Najbardziej zaawansowane monolityczne jądro i największy na świecie projekt open source, wprowadziło kilka ulepszeń i optymalizacji do świata Uniksa.

Redox próbuje wdrożyć ulepszenia wydajności Linuksa w projekcie mikrojądra.

## Co to jest microkernel?

Mikrojądro to niemal minimalna ilość oprogramowania, która może zapewnić mechanizmy potrzebne do wdrożenia systemu operacyjnego działającego na najwyższych uprawnieniach procesora.

Takie podejście do projektowania systemu operacyjnego zapewnia większą stabilność i bezpieczeństwo przy niewielkim koszcie wydajności.

- [Wiecej informacji w ksiażce Redox](https://doc.redox-os.org/book/ch04-01-microkernels.html)

## Jakie programy może uruchomić Redox?

Redox został zaprojektowany tak, aby był kompatybilny ze źródłami z większości aplikacji zgodnych z Unixem, Linuxem i POSIX, wymagając jedynie kompilacji.

Obecnie większość aplikacji GUI wymaga przeniesienia, ponieważ nie obsługujemy jeszcze X11 ani Wayland.

Niektóre ważne oprogramowanie obsługiwane przez Redox:
- [Bash](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/bash)
- [ffmpeg](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/ffmpeg)
- [GCC](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/gcc)
- [Git](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/git)
- [LLVM](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/llvm)
- [Mesa3D](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/mesa)
- [OpenSSL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/openssl)
- [SDL2](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/sdl2)

Możesz zobaczyć wszystkie przeniesione programy/komponenty do Redox [tutaj](https://static.redox-os.org/pkg/x86_64-unknown-redox/).

## Jak zainstalować programy na Redox?

Redox ma menedżera pakietów podobnego do `apt` (Debian) i `pkg` (FreeBSD), możesz zobaczyć, jak go używać na tej stronie:

- [Redox manager pakietów](https://doc.redox-os.org/book/ch02-08-pkg.html)

## Jakie są warianty Redox?

Redox OS ma kilka wariantów dla różnych zastosowań, pełna lista zastosowań i wersji poniżej:

- `server-minimal` - Najbardziej minimalny wariant z podstawowym systemem, przeznaczony dla urządzeń wbudowanych, bardzo starych komputerów i programistów.

- `desktop-minimal` - Najbardziej minimalny wariant z dołączonym środowiskiem graficznym Orbital, przeznaczony dla urządzeń wbudowanych, bardzo starych komputerów i programistów.

- `server` - Wariant serwerowy z kompletnym systemem i narzędziami sieciowymi, przeznaczony dla administratorów serwerów, urządzeń wbudowanych, komputerów z niższej półki i programistów.

- `desktop` - Wariant standardowy z kompletnym systemem, środowiskiem graficznym Orbital i przydatnymi narzędziami, przeznaczony do codziennego użytku, producentów, programistów i graczy.

- `dev` - Wariant deweloperski z kompletnym systemem i narzędziami programistycznymi, przeznaczony dla programistów.

- `demo` - Wariant demo z kompletnym systemem, narzędziami, grami, przeznaczony dla testerów, graczy i programistów.

## Które urządzenia obsługuje Redox?

Na świecie istnieją miliardy urządzeń z setkami modeli/architektur, staramy się pisać sterowniki dla najczęściej używanych urządzeń, aby obsługiwać więcej osób, niektóre sterowniki są specyficzne dla urządzenia, a inne są specyficzne dla architektury.

Zajrzyj do [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) aby zobaczyć wszystkie przetestowane komputery.

### CPU

- Intel - 64-bit (x86_64) and 32-bit (i686) z rodziny Pentium II i nowszych z ograniczeniami.
- AMD - 64-bit (AMD64) i 32-bit.
- ARM - 64-bit (Aarch64) z ograniczeniami.

### Hardware Interfaces

- [ACPI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/acpid)
- [PCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcid)

(USB wkrótce)

### Video

- [VGA](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vesad) - (BIOS)
- GOP (UEFI)
- [LLVMpipe](https://docs.mesa3d.org/drivers/llvmpipe.html) - Renderowanie oprogramowania

(Intel/AMD i inne w przyszłości)

### Dzwięk

- [Intel chipsets](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ihdad)
- [Realtek chipsets](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ac97d)
- [PC speaker](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcspkrd)

([Sound Blaster](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/sb16d) wkrótce)

### Przestrzeń dyskowa

- [IDE](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ided) - (PATA)
- [AHCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ahcid) - (SATA)
- [NVMe](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/nvmed)

(USB wkrótce)

### Wejście

- [PS/2 keyboards](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [PS/2 mouse](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [PS/2 touchpad](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)

(USB wkrótce)

### Internet

- [Intel Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/e1000d)
- [Intel 10 Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ixgbed)
- [Realtek ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/rtl8168d)

(Wi-Fi/[Atheros ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/alxd) wkrótce)

## Mam komputer z niższej półki czy Redox będzie na nim działał?

Procesor komputera to najbardziej złożona maszyna na świecie, nawet najstarsze procesory są w stanie wykonać niektóre zawansowana obliczenia ale zależy to też od konkretnego zadania.

Głównym problemem starych komputerów jest ilość dostępnej pamięci RAM (sprzedawane były w czasach, gdy kości RAM były drogie) i brak rozszerzeń SSE/AVX (programy wykorzystują je do przyspieszania algorytmów), przez co niektóre nowoczesne programy mogą nie działać lub wymagają dużej ilości pamięci RAM do wykonywania złożonych zadań.

Redox będzie działał normalnie (jeśli system obsługuje architekturę procesora), ale konieczne będzie przetestowanie każdego programu.

## Z jakimi maszynami wirtualnymi Redox ma integrację?

- [QEMU](https://www.qemu.org/)
- [VirtualBox](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vboxd)

W przyszłości mikrokernel mógłby pełnić funkcję hypervisora, podobnie jak [Xen](https://xenproject.org/).

A [hypervisor](https://en.wikipedia.org/wiki/Hypervisor) to oprogramowanie umożliwiające jednoczesne uruchomienie wielu izolowanych instancji systemu operacyjnego.

## Jak skompilować Redox OS?

Obecnie Redox posiada skrypt startowy dla Pop OS!, Ubuntu, Debian, Fedora, Arch Linux, openSUSE i FreeBSD z nieutrzymywaną obsługą innych dystrybucji.

Oferujemy również Podman jako naszą uniwersalną metodę kompilacji. Jest to zalecany proces kompilacji dla systemów innych niż Debian, ponieważ pozwala uniknąć problemów środowiskowych w procesie kompilacji.

- [Redox przewodnik](https://doc.redox-os.org/book/ch02-05-building-redox.html) - (Pop OS!, Ubuntu, Debian, Fedora, Arch Linux, openSUSE and FreeBSD)
- [Redox Podman przewodnk](https://doc.redox-os.org/book/ch02-06-podman-build.html)

### Jak uruchomić QEMU bez GUI

Uruchom:

- `make qemu vga=no`

### Jak rozwiązywać problemy z kompilacją w przypadku błędów

Przeczytaj [tą](https://doc.redox-os.org/book/ch08-05-troubleshooting.html) stronę lub dołącz do nas na [Redox Chat](https://doc.redox-os.org/book/ch13-01-chat.html).

### Jak zgłaszać błędy w Redox

Najpierw sprawdź Problemy na GitLabie, aby sprawdzić, czy Twój problem jest już znany.

- [Redox przewodnik jak zgłaszać błedy](https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html)

## Jak mogę przyczynić się do rozwoju projektu Redox?

Możesz przyczynić się na wiele sposobów do rozwoju Redox OS, wiecej informacji [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md).

## Mam problem/pytanie do zespołu Redox

- Spójrz na stronę [Dokumentacja](/docs/), aby uzyskać więcej szczegółów na temat elementów wewnętrznych Redox.
- Spójrz na [Redox Book](https://doc.redox-os.org/book/) aby sprawdzić, czy odpowiada na Twoje pytania/rozwiązuje problem.
- Jeśli książka nie zawiera odpowiedzi na Twoje pytanie, zadaj pytanie/przedstaw swój problem na stronie [Chat](https://doc.redox-os.org/book/ch13-01-chat.html).
