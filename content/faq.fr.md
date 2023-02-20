+++
title = "FAQ"
+++

Cette page couvre les questions les plus courantes.

- [Qu'est-ce que Redox?](#quest-ce-que-redox)
- [Quelles fonctionnalités a Redox?](#quelles-fonctionnalités-a-redox)
- [Quelle est l'utilité de Redox?](#quelle-est-lutilité-de-redox)
- [Que peut-on faire avec Redox?](#que-peut-on-faire-avec-redox)
- [Qu'est-ce qu'un système d'exploitation de type Unix?](#quest-ce-quun-système-dexploitation-de-type-unix)
- [Comment Redox s'inspire d'autres systèmes d'exploitation?](#comment-redox-sinspire-dautres-systèmes-dexploitation)
- [Qu'est-ce qu'un micro noyau?](#quest-ce-quun-micro-noyau)
- [Quels programmes peuvent tourner sur Redox?](#quels-programmes-peuvent-tourner-sur-redox)
- [Quels appareils sont supportés par Redox?](#quels-appareils-sont-supportés-par-redox)
- [Avec quelles machines virtuelles Redox s'intègre-t-il?](#avec-quelles-machines-virtuelles-redox-sintègre-t-il)
- [Comment compiler Redox?](#comment-compiler-redox)
 - [Comment lancer QEMU sans interface graphique?](#comment-lancer-qemu-sans-interface-graphique)
 - [Comment dépanner un build en cas d'erreur?](#comment-dépanner-un-build-en-cas-derreur)
 - [Comment rapporter des bugs de Redox?](#comment-rapporter-des-bugs-de-redox)
- [Comment contribuer à Redox?](#comment-contribuer-à-redox)
- [J'ai un problème ou des questions pour l'équipe de Redox](#jai-un-problème-ou-des-questions-pour-léquipe-de-redox)

## Qu'est-ce que Redox?

Redox est un système d'exploitation en micro noyau, il est complet, entièrement fonctionnel, a un usage général et est axé sur la sécurité, la liberté, la fiabilité, l'exactitude et le pragmatisme.

Dans la mesure du possible, les composants du système sont écrits en Rust et exécutés dans l'espace utilisateur.

## Quelles fonctionnalités a Redox?

### Les bénéfices du micro noyau

#### Vraie modularité

Vous pouvez modifier/changer de nombreux composants du système sans redémarrage du système, similaire mais plus sûr que le [patch en direct](https://en.wikipedia.org/wiki/Kpatch).

#### Isolation des bugs

La plupart des composants système s'exécutent dans l'espace utilisateur sur un système de micro-noyau, un bogue dans un composant non-noyau ne [plantera pas le système/noyau](https://en.wikipedia.org/wiki/Kernel_panic).

#### Conception sans redémarrage

Le noyau change très peu (correction de bugs), vous n'aurez donc pas besoin de redémarrer votre système très souvent pour mettre à jour le système.

Étant donné que la plupart des composants du système se trouvent dans l'espace utilisateur, ils peuvent être remplacés à la volée (ce qui réduit les temps d'arrêt pour les administrateurs de serveur).

#### Facile à développer et à déboguer

La plupart des composants du système s'exécutent dans l'espace utilisateur, ce qui simplifie les tests/débogages.

### Les avantages de Rust

#### Pas besoin de mesures d'atténuation des exploits

La conception du micro-noyau écrite en Rust protège contre les défauts de mémoire C/C++.

En isolant les composants du système du noyau, [la surface d'attaque](https://en.wikipedia.org/wiki/Attack_surface) est très limitée.

#### Sécurité et fiabilité améliorées sans impact significatif sur les performances

Comme le noyau est petit, il utilise moins de mémoire pour faire son travail et le code limité du noyau l'aide à rester proche de l'objectif ([KISS](https://en.wikipedia.org/wiki/KISS_principle) sans bugs).

La conception de langage sûre et rapide de Rust, combinée à la petite taille de la base de code du noyau, contribue à garantir un noyau fiable, performant et facile à entretenir.

#### Pilotes écrits en Rust

Les pilotes écrits en Rust sont susceptibles d'avoir moins de bogues et une meilleure sécurité.

- [Appareils actuellement pris en charge](/fr/faq/#quels-appareils-sont-supportés-par-redox)

#### Système de fichiers inspiré de ZFS

Redox utilise RedoxFS comme système de fichiers par défaut, il prend en charge des fonctionnalités similaires à [ZFS](https://docs.freebsd.org/en/books/handbook/zfs/) avec une implémentation écrite en Rust.

Attendez-vous à des performances élevées et à la sécurité des données (copie sur écriture, intégrité des données, volumes, instantanés, protection contre la perte de données).

## Quelle est l'utilité de Redox?

L'objectif principal de Redox est d'être un système d'exploitation à usage général, tout en maintenant la sécurité, la fiabilité et l'exactitude.

Redox vise à être une alternative aux systèmes Unix existants (Linux/BSD), avec la possibilité d'exécuter la plupart des programmes Unix avec seulement une recompilation ou des modifications minimales.

- [Nos objectifs](https://doc.redox-os.org/book/ch01-01-our-goals.html)

## Que peut-on faire avec Redox?

En tant que système d'exploitation à usage général, vous pourrez faire presque n'importe quoi sur la plupart des appareils avec des performances/sécurité élevées.

Redox est toujours en cours de développement, donc notre liste d'applications prises en charge est actuellement limitée, mais en croissance.

- [Cas d'utilisation](https://doc.redox-os.org/book/ch01-04-redox-use-cases.html)

## Qu'est-ce qu'un système d'exploitation de type Unix?

Tout système d'exploitation compatible avec [la spécification unique Unix](https://en.wikipedia.org/wiki/Single_UNIX_Specification) et [POSIX](https://en.wikipedia.org/wiki/POSIX), s'attend à un [shell](https://en.wikipedia.org/wiki/Unix_shell), le concept "[tout est un fichier](https://en.wikipedia.org/wiki/Everything_is_a_file)", multitâche et multi-utilisateur.

[Unix](https://en.wikipedia.org/wiki/Unix) était un système multitâche très influent et a eu un impact sur les choix de conception de la plupart des systèmes modernes.

- [Article Wikipedia](https://en.wikipedia.org/wiki/Unix-like)

## Comment Redox s'inspire d'autres systèmes d'exploitation?

[Plan 9](http://9p.io/plan9/index.html) - Ce système d'exploitation Bell Labs amène le concept de "tout est un fichier" au plus haut niveau, en effectuant toutes les communications système à partir du système de fichiers.

- [Explication de Drew DeVault de Plan 9](https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html)
- [L'influence de Plan 9's sur Redox](https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html)

[Minix](https://minix3.org/) - Le système de type Unix le plus influent avec un micro-noyau, il possède des fonctionnalités avancées telles que la modularité du système, la résistance à la [panique du noyau](https://fr.wikipedia.org/wiki/Panique_du_noyau), réincarnation du pilote, protection contre les mauvais pilotes et interfaces sécurisées pour la [communication des processus](https://en.wikipedia.org/wiki/Inter-process_communication).

Redox est largement inspiré de Minix, il a une architecture et un ensemble de fonctionnalités similaires écrits en Rust.

- [Comment Minix a influence la conception de Redox](https://doc.redox-os.org/book/ch04-01-microkernels.html)

[BSD](https://www.bsd.org/) - Cette [famille](https://en.wikipedia.org/wiki/Research_Unix) de systèmes d'exploitation Unix comprend plusieurs améliorations sur les systèmes Unix, la plus notable étant [les sockets BSD](https://en.wikipedia.org/wiki/Berkeley_sockets), qui apporte une communication réseau avec un fonctionnement de type fichier (avant Plan 9).

- [Documentation de FreeBSD](https://docs.freebsd.org/en/books/developers-handbook/sockets/)

[Linux](https://www.kernel.org/) - le noyau monolithique le plus avancé au monde et le plus grand projet open-source au monde, il apporte plusieurs améliorations/optimisations aux systèmes de type Unix.

Redox essaie d'implémenter les améliorations de performances Linux dans une conception de micro-noyau.

## Qu'est-ce qu'un micro noyau?

Un micro-noyau est la quantité quasi minimale de logiciels pouvant fournir les mécanismes nécessaires à la mise en œuvre d'un système d'exploitation, qui s'exécute sur le privilège le plus élevé du processeur.

Cette approche de la conception du système d'exploitation apporte plus de stabilité et de sécurité, avec un faible coût sur les performances.

- [Explications du livre de Redox](https://doc.redox-os.org/book/ch04-01-microkernels.html)

## Quels programmes peuvent tourner sur Redox?

Redox est conçu pour être compatible avec la plupart des applications compatibles Unix, Linux et POSIX, ne nécessitant qu'une compilation.

Actuellement, la plupart des applications GUI nécessitent un portage, car nous ne prenons pas encore en charge X11 ou Wayland.

Certains logiciels importants pris en charge par Redox :

- [Bash](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/bash)
- [ffmpeg](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/ffmpeg)
- [GCC](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/gcc)
- [Git](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/git)
- [LLVM](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/llvm)
- [Mesa3D](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/mesa)
- [OpenSSL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/openssl)
- [Python](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/python)
- [SDL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/sdl2)

Vous pouvez voir tous les composants/programmes portés sur Redox [ici](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes).

## Quels appareils sont supportés par Redox?

Il existe des milliards d'appareils avec des centaines de modèles/architectures dans le monde, nous essayons d'écrire des pilotes pour les appareils les plus utilisés afin de prendre en charge plus de personnes, certains pilotes sont spécifiques à l'appareil et d'autres sont spécifiques à l'architecture.

Jettes un coup d'oeil à [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) pour voir tous les ordinateurs testés.

### CPU

- [x86_64/AMD64](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86_64) - (Intel/AMD)
- [x86/i686](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86) - (Intel/AMD de Pentium II et après pris en charge avec des limitations)
- [ARM64](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/aarch64) - (pris en charge avec des limitations)

### Les interfaces matérielles

- [ACPI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/acpid)
- [PCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcid)

(bientôt l'USB)

### Vidéo

- [VGA](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vesad) - (BIOS)
- GOP (UEFI)
- [LLVMpipe](https://docs.mesa3d.org/drivers/llvmpipe.html) - Rendu matériel

(Intel/AMD et autres à l'avenir)

### Son

- [Puces Intel](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ihdad)
- [Puces Realtek](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ac97d)
- [Haut-parleur d'ordinateur](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcspkrd)

([Sound Blaster](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/sb16d) soon)

### Stockage

- [IDE](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ided) - (PATA)
- [AHCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ahcid) - (SATA)
- [NVMe](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/nvmed)

(bientôt l'USB)

### Entrées

- [Clavier PS/2](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [Souris PS/2](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [Pavé tactile PS/2](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)

(bientôt l'USB)

### Internet

- [Intel Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/e1000d)
- [Intel 10 Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ixgbed)
- [Realtek ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/rtl8168d)

(Wi-Fi/[Atheros ethernet]((https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/alxd)) bientôt)

## Avec quelles machines virtuelles Redox s'intègre-t-il?

- [QEMU](https://www.qemu.org/)
- [VirtualBox](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vboxd)

À l'avenir, le micro-noyau pourrait agir comme un hyperviseur, similaire à [Xen](https://xenproject.org/).

Un [hyperviseur](https://en.wikipedia.org/wiki/Hypervisor) est un logiciel permettant d'exécuter simultanément plusieurs instances de système d'exploitation isolées.

## Comment compiler Redox?

Actuellement, Redox a un script d'amorçage pour Debian/Ubuntu/Pop OS ! avec un support non maintenu pour les autres distributions.

Nous allons utiliser Podman comme méthode de compilation principale, c'est le processus de construction recommandé pour les systèmes non-Debian car il évite les problèmes d'environnement lors de la compilation.

- [Guide de compilation du livre Redox](https://doc.redox-os.org/book/ch02-05-building-redox.html) - (Debian/Ubuntu/Pop OS!)
- [Guide Podman du livre Redox](https://doc.redox-os.org/book/ch02-06-podman-build.html)

### Comment lancer QEMU sans interface graphique?

Exécutez:

- `make qemu vga=no`

### Comment dépanner un build en cas d'erreur?

Reportez-vous au livre Redox pour voir si le problème vient de votre configuration de compilation ou de votre chaîne d'outils, si vous rencontrez toujours des problèmes, consultez ce qui suit ou rejoignez-nous sur le [Chat Redox](https://doc.redox-os.org/book/ch13-01-chat.html).

- [Guide de dépannage du livre Redox](https://doc.redox-os.org/book/ch08-05-troubleshooting.html)
- [Guide de dépannage GitLab](https://gitlab.redox-os.org/redox-os/redox#help-redox-wont-compile)

### Comment rapporter des bugs de Redox?

Vérifiez d'abord les problèmes de GitLab pour voir si votre problème est déjà connu.

- [CONTRIBUER](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/CONTRIBUTING.md)
- [Guide de rapport de bogue de livre Redox](https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html)

## Comment contribuer à Redox?

Vous pouvez contribuer à Redox de plusieurs manières, en voici quelques-unes :

- [CONTRIBUER](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md)
- [Guide de contribution du livre Redox](https://doc.redox-os.org/book/ch10-02-low-hanging-fruit.html)
- [How to make pull requests properly](https://doc.redox-os.org/book/ch12-04-creating-proper-pull-requests.html)
- [Documentation](/docs/)
- [Salle de discussion du développement Redox](https://matrix.to/#/#redox-dev:matrix.org)

## J'ai un problème ou des questions pour l'équipe de Redox

- Jetez un oeil à la page de  [Documentation](/docs/) pour plus de détails internes de Redox.
- Jetez un oeil au [livre Redox](https://doc.redox-os.org/book/) pour voir s'il répond à vos questions/résout votre problème.
- Si le livre ne répond pas à votre question, posez votre question/dites votre problème dans le salon [Support de Redox](https://matrix.to/#/#redox-support:matrix.org) ou le salon de [Développement de Redox](https://matrix.to/#/#redox-dev:matrix.org
) sur Matrix.

