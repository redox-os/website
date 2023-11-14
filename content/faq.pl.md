+++
title = "FAQ"
+++

Na tej stronie znajdują się pytania/odpowiedzi dla nowicjuszy i użytkowników końcowych.

- [Co to jest Redox?](#Co-to-jest-Redox)
- [Co znaczy Redox?](#Co-znaczy-Redox)
- [Jakie funkcje ma Redox?](#what-features-does-redox-have)
    - [Microkernel benefits](#microkernel-benefits)
    - [Rust benefits](#rust-benefits)
- [Jaki jest cel Redox?](#what-is-the-purpose-of-redox)
- [Co mogę zrobić z Redoxem?](#what-i-can-do-with-redox)
- [Co to jest system operacyjny typu Unix?](#what-is-a-unix-like-os)
- [Jak Redox inspiruje się innymi systemami?](#how-redox-is-inspired-by-other-systems)
    - [Plan 9](#plan-9)
    - [Minix](#minix)
    - [seL4](#sel4)
    - [BSD](#bsd)
    - [Linux](#linux)
- [Co to jest microkernel?](#what-is-a-microkernel)
- [Jakie programy może uruchomić Redox?](#what-programs-can-redox-run)
- [Jak zainstalować programy na Redox?](#how-to-install-programs-on-redox)
- [Jakie są warianty Redox?](#which-are-the-redox-variants)
- [Które urządzenia obsługuje Redox?](#which-devices-does-redox-support)
- [Mam komputer z niższej półki, czy Redox będzie na nim działał?](#i-have-a-low-end-computer-would-redox-work-on-it)
- [Z jakimi maszynami wirtualnymi Redox ma integrację?](#which-virtual-machines-does-redox-have-integration-with)
- [Jak skompilować Redox OS?](#how-do-i-build-redox)
 - [Jak uruchomić QEMU bez GUI](#how-to-launch-qemu-without-gui)
 - [Jak rozwiązywać problemy z kompilacją w przypadku błędów](#how-to-troubleshoot-your-build-in-case-of-errors)
 - [Jak zgłaszać błędy w Redox](#how-to-report-bugs-on-redox)
- [Jak mogę przyczynić się do rozwoju projektu Redox?](#how-do-i-contribute-to-redox)
- [Mam problem/pytanie do zespołu Redox](#i-have-a-problemquestion-for-redox-team)

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

## What features does Redox have?

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

## Jaki jest cel Redoxu?

Głównym celem Redox jest bycie systemem operacyjnym ogólnego przeznaczenia, przy jednoczesnym zachowaniu bezpieczeństwa, niezawodności i poprawności.

Redox ma być alternatywą dla istniejących systemów uniksowych (Linux/BSD), z możliwością uruchamiania większości programów uniksowych jedynie po rekompilacji lub minimalnych modyfikacjach.

- [Nasze cele](https://doc.redox-os.org/book/ch01-01-our-goals.html)

## Co mogę zrobić z Redoxem?

Jako system operacyjny ogólnego przeznaczenia będziesz w stanie wykonać prawie każde zadanie na większości urządzeń przy wysokiej wydajności/bezpieczeństwie.

Redox jest wciąż w fazie rozwoju, więc lista obsługiwanych aplikacji jest obecnie ograniczona, ale stale dodajemy nowe aplikacje i ich lista stale rośnie.

- [Przypadki użycia](https://doc.redox-os.org/book/ch01-04-redox-use-cases.html)

## What is a Unix-like OS?

Dowolny system operacyjny zgodny ze [Single Unix Specification](https://en.wikipedia.org/wiki/Single_UNIX_Specification) i [POSIX](https://en.wikipedia.org/wiki/POSIX), oczekuj [shell](https://en.wikipedia.org/wiki/Unix_shell), "[koncepcja wszytsko jest plikiem](https://en.wikipedia.org/wiki/Everything_is_a_file)" , wielozadaniowość i wielu użytkowników.

[Unix](https://en.wikipedia.org/wiki/Unix) był bardzo wpływowym systemem wielozadaniowym i miał wpływ na wybory projektowe większości nowoczesnych systemów.

- [Artykuł na Wikipedia](https://en.wikipedia.org/wiki/Unix-like)

## How Redox is inspired by other systems?

### [Plan 9](http://9p.io/plan9/index.html)

This Bell Labs OS brings the concept of "everything is a file" to the highest level, doing all the system communication from the filesystem.

- [Drew DeVault explains the Plan 9](https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html)
- [Plan 9's influence on Redox](https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html)

### [Minix](https://minix3.org/)

The most influential Unix-like system with a microkernel, it has advanced features such as system modularity, [kernel panic](https://en.wikipedia.org/wiki/Kernel_panic) resistence, driver reincarnation, protection against bad drivers and secure interfaces for [process comunication](https://en.wikipedia.org/wiki/Inter-process_communication).

Redox is largely inspired by Minix, it has a similar architecture and feature set written in Rust.

- [How Minix influenced the Redox design](https://doc.redox-os.org/book/ch04-01-microkernels.html)

### [seL4](https://sel4.systems/)

The most fast and simple microkernel of the world, it aims for performance and simplicity.

Redox follow the same principle, trying to make the kernel-space small as possible (moving components to user-space and reducing the number of system calls, passing the complexity to user-space) and keeping the overall performance good (reducing the context switch cost).

### [BSD](https://www.bsd.org/)

This Unix [family](https://en.wikipedia.org/wiki/Research_Unix) included several improvements on Unix systems, the open-source variants of BSD added many improvements to the original system (like Linux did).

[FreeBSD](https://www.freebsd.org/) is the most notable example, Redox took inspiration from [Capsicum](https://man.freebsd.org/cgi/man.cgi?capsicum(4)) (a capability-based system) and [jails](https://en.wikipedia.org/wiki/Freebsd_jail) (a sandbox technology) for the namespaces implementation.

### [Linux](https://www.kernel.org/)

The most advanced monolithic kernel and biggest open-source project of the world, it brought several improvements and optimizations to the Unix-like world.

Redox tries to implement the Linux performance improvements in a microkernel design.

## What is a microkernel?

A microkernel is the near-minimum amount of software that can provide the mechanisms needed to implement an operating system, which runs on the highest privilege of the processor.

This approach to OS design brings more stability and security, with a small cost on performance.

- [Redox Book explanation](https://doc.redox-os.org/book/ch04-01-microkernels.html)

## What programs can Redox run?

Redox is designed to be source-compatible with most Unix, Linux and POSIX-compilant applications, only requiring compilation.

Currently, most GUI applications require porting, as we don't support X11 or Wayland yet.

Some important software that Redox supports:

- [Bash](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/bash)
- [ffmpeg](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/ffmpeg)
- [GCC](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/gcc)
- [Git](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/git)
- [LLVM](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/llvm)
- [Mesa3D](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/mesa)
- [OpenSSL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/openssl)
- [SDL2](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/sdl2)

You can see all Redox components/ported programs [here](https://static.redox-os.org/pkg/x86_64-unknown-redox/).

## How to install programs on Redox?

Redox has a package manager similar to `apt` (Debian) and `pkg` (FreeBSD), you can see how to use it on this page:

- [Redox package manager](https://doc.redox-os.org/book/ch02-08-pkg.html)

## Which are  the Redox variants?

Redox has some variants for each task, take a look on them below:

- `server-minimal` - The most minimal variant with a basic system, aimed for embedded devices, very old computers and developers.

- `desktop-minimal` - The most minimal variant with the Orbital desktop environment included, aimed for embedded devices, very old computers and developers.

- `server` - The server variant with a complete system and network tools, aimed for server administrators, embedded devices, low-end computers and developers.

- `desktop` - The standard variant with a complete system, Orbital desktop environment and useful tools, aimed for daily usage, producers, developers and gamers.

- `dev` - The development variant with a complete system and development tools, aimed for developers.

- `demo` - The demo variant with a complete system, tools, players and games, aimed for testers, gamers and developers.

## Which devices does Redox support?

There are billions of devices with hundreds of models/architectures in the world, we try to write drivers for the most used devices to support more people, some drivers are device-specific and others are architecture-specific.

Have a look at [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) to see all tested computers.

### CPU

- Intel - 64-bit (x86_64) and 32-bit (i686) from Pentium II and after with limitations.
- AMD - 64-bit (AMD64) and 32-bit.
- ARM - 64-bit (Aarch64) with limitations.

### Hardware Interfaces

- [ACPI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/acpid)
- [PCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcid)

(USB soon)

### Video

- [VGA](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vesad) - (BIOS)
- GOP (UEFI)
- [LLVMpipe](https://docs.mesa3d.org/drivers/llvmpipe.html) - Software Rendering

(Intel/AMD and others in the future)

### Sound

- [Intel chipsets](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ihdad)
- [Realtek chipsets](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ac97d)
- [PC speaker](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcspkrd)

([Sound Blaster](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/sb16d) soon)

### Storage

- [IDE](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ided) - (PATA)
- [AHCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ahcid) - (SATA)
- [NVMe](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/nvmed)

(USB soon)

### Input

- [PS/2 keyboards](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [PS/2 mouse](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [PS/2 touchpad](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)

(USB soon)

### Internet

- [Intel Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/e1000d)
- [Intel 10 Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ixgbed)
- [Realtek ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/rtl8168d)

(Wi-Fi/[Atheros ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/alxd) soon)

## I have a low-end computer, would Redox work on it?

A computer processor is the most complex machine of the world, even the most old processors are powerful for some tasks, it depends on the task.

The main problem with old computers is the amount of RAM available (they were sold in a epoch where RAM chips were expensive) and lack of SSE/AVX extensions (programs use them to speed up the algorithms), thus some modern programs may not work or require a lot of RAM to perform complex tasks.

Redox will work normally (if the processor architecture is supported by the system) but you will need to test each program.

## Which virtual machines does Redox have integration with?

- [QEMU](https://www.qemu.org/)
- [VirtualBox](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vboxd)

In the future the microkernel could act as a hypervisor, similar to [Xen](https://xenproject.org/).

A [hypervisor](https://en.wikipedia.org/wiki/Hypervisor) is software providing the ability to run multiple isolated operating system instances simultaneously.

## How do I build Redox?

Currently Redox has a bootstrap script for Pop OS!, Ubuntu, Debian, Fedora, Arch Linux, openSUSE and FreeBSD with unmaintained support for other distributions.

We also offer Podman as our universal compilation method, it is the recommended build process for non-Debian systems because it avoids environment problems on the build process.

- [Redox Book Guide](https://doc.redox-os.org/book/ch02-05-building-redox.html) - (Pop OS!, Ubuntu, Debian, Fedora, Arch Linux, openSUSE and FreeBSD)
- [Redox Book Podman Guide](https://doc.redox-os.org/book/ch02-06-podman-build.html)

### How to launch QEMU without GUI

Run:

- `make qemu vga=no`

### How to troubleshoot your build in case of errors

Read [this](https://doc.redox-os.org/book/ch08-05-troubleshooting.html) page or join us on [Redox Chat](https://doc.redox-os.org/book/ch13-01-chat.html).

### How to report bugs on Redox

Check GitLab Issues first to see if your problem is already known.

- [Redox Book Bug Report Guide](https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html)

## How do I contribute to Redox?

You can contribute to Redox in many ways, you can see them on [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md).

## I have a problem/question for Redox team

- Have a look at the [Documentation](/docs/) page for more details of Redox internals.
- Have a look at the [Redox Book](https://doc.redox-os.org/book/) to see if it answers your questions/fixes your problem.
- If the book does not answer your question, ask your question/say your problem on the [Chat](https://doc.redox-os.org/book/ch13-01-chat.html).
