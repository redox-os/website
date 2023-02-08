+++
title = "FAQ"
+++

Essa página cobre as perguntas mais comuns.

- [O que é o Redox?](#o-que-%C3%A9-o-redox)
- [Qual o propósito do Redox?](#qual-o-prop%C3%B3sito-do-redox)
- [O que posso fazer com o Redox?](#o-que-posso-fazer-com-o-redox)
- [O que é um sistema Unix-like?](#o-que-%C3%A9-um-sistema-unix-like)
- [Como o Redox é inspirado em outros sistemas?](#como-o-redox-%C3%A9-inspirado-em-outros-sistemas)
- [O que é um microkernel?](#o-que-%C3%A9-um-microkernel)
- [Quais programas o Redox executa?](#quais-programas-o-redox-executa)
- [Quais dispositivos o Redox suporta?](#quais-dispositivos-o-redox-suporta)
- [Quais máquinas virtuais o Redox possui integração?](#quais-m%C3%A1quinas-virtuais-o-redox-possui-integra%C3%A7%C3%A3o)
- [Como compilar o Redox?](#como-compilar-o-redox)
 - [Como atualizar o código-fonte e compilar as mudanças](#como-atualizar-o-c%C3%B3digo-fonte-e-compilar-as-mudan%C3%A7as)
 - [Como abrir o QEMU sem interface gráfica](#como-abrir-o-qemu-sem-interface-gr%C3%A1fica)
 - [Como inserir arquivos no disco rígido do QEMU](#como-inserir-arquivos-dentro-do-disco-r%C3%ADgido-do-qemu)
 - [Como diagnosticar seu Redox em caso de erros](#como-diagnosticar-seu-redox-em-caso-de-erros)
 - [Como reportar bugs para o Redox](#como-reportar-bugs-para-o-redox)
- [Como contribuir para o Redox?](#como-contribuir-para-o-redox)
- [Eu tenho um problema/pergunta para a equipe do Redox](#eu-tenho-um-problemapergunta-para-a-equipe-do-redox)

## O que é o Redox?

O Redox é um sistema operacional baseado em microkernel, completo, funcional, para uso geral com foco em segurança, liberdade, confiabilidade, correção e pragmatismo.

Onde for possível, os componentes do sistema serão escritos em Rust e executam no espaço do usuário.

## Qual o propósito do Redox?

[Nossos Objetivos]

[Nossos Objetivos]: https://doc.redox-os.org/book/ch01-01-our-goals.html

## O que posso fazer com o Redox?

[Casos de Uso]

[Casos de Uso]: https://doc.redox-os.org/book/ch01-04-redox-use-cases.html

## O que é um sistema Unix-like?

Qualquer sistema compátivel com a [Especificação Única do Unix] e [POSIX], tal como uma Shell, o conceito de "Tudo é um arquivo", multitarefa e multiusuário.

O [Unix] foi um sistema operacional de multitarefa muito influente e impactou as decisões de design em diversos sistemas modernos.

- [Artigo da Wikipedia]

[[Especificação Única do Unix]]: https://en.wikipedia.org/wiki/Single_UNIX_Specification
[POSIX]: https://en.wikipedia.org/wiki/POSIX
[Unix]: https://pt.wikipedia.org/wiki/Unix
[Artigo da Wikipedia]: https://pt.wikipedia.org/wiki/Sistema_operacional_tipo_Unix

## Como o Redox é inspirado em outros sistemas?

[Plan 9] - Este sistema da Bell Labs trouxe o conceito de "Tudo é um arquivo" ao seu maior nível, fazendo toda a comunicação do sistema pelo sistemas de arquivos.

Você apenas precisa montar o software em algum local para obter a função desejada, qualquer software pode funcionar dessa forma.

- [Drew DeVault explicando o Plan 9]
- [Como o Redox utiliza o design do Plan 9]

[Plan 9]: http://9p.io/plan9/index.html
[Drew DeVault explicando o Plan 9]: https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html
[Como o Redox utiliza o design do Plan 9]: https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html

[Minix] - o sistema Unix-like com microkernel mais influente, ele possuí funções avançadas tais como modularidade do sistema, resistência a [quebra do kernel], reincarnação de driver, proteção contra drivers ruins e interfaces seguras para a [comunicação dos processos].

O Redox é largamente inspirado pelo Minix, ele tem basicamente as mesmas funções mas escritas em Rust.

[Minix]: https://minix3.org/
[quebra do kernel]: https://en.wikipedia.org/wiki/Kernel_panic
[comunicação dos processos]: https://en.wikipedia.org/wiki/Inter-process_communication
[Como o Redox implementa o design de microkernel do Minix]: https://doc.redox-os.org/book/ch04-01-microkernels.html

[BSD] - Essa [família] de sistemas Unix fez diversas melhorias para os sistemas Unix, a mais notável são os [sockets BSD], eles trazem a comunicação de rede para o sistema de arquivos Unix (antes do Plan 9).

- [Documentação do FreeBSD]

[BSD]: https://www.bsd.org/
[família]: https://en.wikipedia.org/wiki/Research_Unix
[sockets BSD]: https://en.wikipedia.org/wiki/Berkeley_sockets
[Documentação do FreeBSD]: https://docs.freebsd.org/en/books/developers-handbook/sockets/

[Linux] - o kernel monolítico mais avançado do mundo e maior projeto de código-aberto do mundo, ele traz diversas melhorias/otimizações para sistemas Unix-like.

O Redox tenta implementar as melhorias de desempenho do Linux em um design de microkernel.

[Linux]: https://www.kernel.org/

## O que é um microkernel?

- [Explicação do livro Redox]

[Explicação do livro Redox]: https://doc.redox-os.org/book/ch04-01-microkernels.html

## Quais programas o Redox executa?

Programas Unix/POSIX, o Redox é compátivel em código-fonte com o Linux (precisa de compilação).

Some software need porting (recipes), as we don't support X11/Wayland yet, but SDL/Orbital.
Alguns softwares precisam ser portados (recipes), já que não possuímos suporte para X11/Wayland ainda, mas SDL/Orbital.

Alguns softwares importantes que o Redox suporta:

- [Bash]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/bash
- [ffmpeg]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/ffmpeg
- [GCC]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/gcc
- [Git]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/git
- [LLVM]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/llvm
- [Mesa3D]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/mesa
- [OpenSSL]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/openssl
- [Python]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/python
- [SDL]: https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/sdl2

No futuro o microkernel pode agir como um supervisor, similar ao [Xen].

Um [supervisor] é um software the gerencia máquinas virtuais, ele pode ser uma "camada de compatibilidade" para qualquer sistema operacional.

[Xen]: https://xenproject.org/
[supervisor]: https://en.wikipedia.org/wiki/Hypervisor

## Quais dispositivos o Redox suporta?

### CPU

- [x86_64/AMD64] - (Intel/AMD)
- [x86/i686] - (Intel/AMD, incompleto)
- [ARM64] - (incompleto)

[x86_64/AMD64]: https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86_64
[x86/i686]: https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86
[ARM64]: https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/aarch64

### Interfaces do Hardware

- [ACPI]
- [PCI]

(USB soon)

[ACPI]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/acpid
[PCI]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcid

### Internet

- [Intel Gigabit ethernet]
- [Intel 10 Gigabit ethernet]
- [Realtek ethernet]

(Wi-Fi/[Atheros ethernet] em breve)

[Intel Gigabit ethernet]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/e1000d
[Intel 10 Gigabit ethernet]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ixgbed
[Realtek ethernet]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/rtl8168d
[Atheros ethernet]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/alxd

### Som

- [Intel chipsets]
- [Realtek chipsets]
- [PC speaker]

([Sound Blaster] em breve)

[Intel chipsets]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ihdad
[Realtek chipsets]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ac97d
[Sound Blaster]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/sb16d
[PC speaker]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcspkrd

### Video

- [VGA] - (BIOS)
- GOP (UEFI)
- [LLVMpipe] - Renderização de Software

(Intel/AMD e outros no futuro)

[VGA]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vesad
[LLVMpipe]: https://docs.mesa3d.org/drivers/llvmpipe.html

### Storage

- [IDE] - (PATA)
- [AHCI] - (SATA)
- [NVMe]

(USB em breve)

[IDE]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ided
[AHCI]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ahcid
[NVMe]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/nvmed

### Periféricos

- [Teclados PS/2]
- [Mouse PS/2]
- [Touchpad PS/2]

(USB em breve)

[Teclados PS/2]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d
[Mouse PS/2]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d
[Touchpad PS/2]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d

## Quais máquinas virtuais o Redox possui integração?

- [VirtualBox]
- [Bochs]

[VirtualBox]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vboxd
[Bochs]: https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/bgad

## Como compilar o Redox?

Atualmente o Redox tem um script de bootstrap para o Debian/Ubuntu/Pop OS! com suporte não mantido para outras distribuições.

Nós estamos em transição para o Podman como nosso método de compilação principal, atualmente ele é bem maduro e compila como o script normal.

(O Podman evita problemas de ambiente durante a compilação)

- [Guia no Livro do Redox] - (Debian/Ubuntu/Pop OS!)
- [Guia Avançado no Livro do Redox] - (Debian/Ubuntu/Pop OS!)
- [Guia do Podman no Livro do Redox]
- [Guia Avançado do Podman no Livro do Redox]

[Guia no Livro do Redox]: https://doc.redox-os.org/book/ch02-05-building-redox.html
[Guia Avançado no Livro do Redox]: https://doc.redox-os.org/book/ch08-01-advanced-build.html
[Guia do Podman no Livro do Redox]: https://doc.redox-os.org/book/ch02-06-podman-build.html
[Guia Avançado do Podman no Livro do Redox]: https://doc.redox-os.org/book/ch08-02-advanced-podman-build.html

### Como atualizar o código-fonte e compilar as mudanças?

- [Guia de Recompilação no Livro do Redox]

[Guia de Recompilação no Livro do Redox]: https://doc.redox-os.org/book/ch09-02-coding-and-building.html#the-full-rebuild-cycle

### Como abrir o QEMU sem interface gráfica

Execute:

- `make qemu vga=no`

O QEMU ficará semelhante a um container/chroot.

### Como inserir arquivos dentro do disco rígido do QEMU

- [Guia do QEMU no livro do Redox]

[Guia do QEMU no livro do Redox]: https://doc.redox-os.org/book/ch09-02-coding-and-building.html#patch-an-image

### Como diagnosticar seu Redox em caso de erros

- [Guia de Diagnóstico no Livro do Redox]
- [Guia de Diagnóstico no GitLab]

[Guia de Diagnóstico no Livro do Redox]: https://doc.redox-os.org/book/ch08-05-troubleshooting.html
[Guia de Diagnóstico no GitLab]: https://gitlab.redox-os.org/redox-os/redox#help-redox-wont-compile

### Como reportar bugs para o Redox?

- [Guia para Relatório de Bug no Livro do Redox]

[Guia para Relatório de Bug no Livro do Redox]: https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html

## Como contribuir para o Redox?

- [Documentação](/docs/)
- [Guia de Contribuição no Livro do Redox]
- [Como fazer pull requests corretamente]
- [Guia do GitLab]
- [Sala de Desenvolvimento do Redox] - Nos diga o que você planeja fazer.

[Guia de Contribuição no Livro do Redox]: https://doc.redox-os.org/book/ch10-02-low-hanging-fruit.html
[Como fazer pull requests corretamente]: https://doc.redox-os.org/book/ch12-04-creating-proper-pull-requests.html
[Guia do GitLab]: https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md
[Sala de Desenvolvimento do Redox]: https://matrix.to/#/#redox-dev:matrix.org

## Eu tenho um problema/pergunta para a equipe do Redox

- Leia a [Documentação](/docs/).
- Leia todo [livro do Redox] para ver se isso responde suas pergunta/corrige seu problema.
- Se o livro não for suficiente pra você, diga sua pergunta/problema nas salas [Redox Support] ou [Redox Dev] no Matrix.

[livro do Redox]: https://doc.redox-os.org/book/
[Redox Support]: https://matrix.to/#/#redox-support:matrix.org
[Redox Dev]: https://matrix.to/#/#redox-dev:matrix.org
