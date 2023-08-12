+++
title = "FAQ"
+++

Essa página contém perguntas/respostas para iniciantes e usuários comuns.

- [O que é o Redox?](#o-que-%C3%A9-o-redox)
- [O que Redox significa?](#o-que-redox-significa)
- [Quais funções o Redox possui?](#quais-fun%C3%A7%C3%B5es-o-redox-possui)
- [Qual o propósito do Redox?](#qual-o-prop%C3%B3sito-do-redox)
- [O que posso fazer com o Redox?](#o-que-posso-fazer-com-o-redox)
- [O que é um sistema Unix-like?](#o-que-%C3%A9-um-sistema-unix-like)
- [Como o Redox é inspirado em outros sistemas?](#como-o-redox-%C3%A9-inspirado-em-outros-sistemas)
- [O que é um microkernel?](#o-que-%C3%A9-um-microkernel)
- [Quais programas o Redox executa?](#quais-programas-o-redox-executa)
- [Como instalar programas no Redox?](#como-instalar-programas-no-redox)
- [Quais são as variantes do Redox?](#quais-são-as-variantes-do-redox)
- [Quais dispositivos o Redox suporta?](#quais-dispositivos-o-redox-suporta)
- [Quais máquinas virtuais o Redox possui integração?](#quais-m%C3%A1quinas-virtuais-o-redox-possui-integra%C3%A7%C3%A3o)
- [Como compilar o Redox?](#como-compilar-o-redox)
 - [Como abrir o QEMU sem interface gráfica](#como-abrir-o-qemu-sem-interface-gr%C3%A1fica)
 - [Como diagnosticar seu Redox em caso de erros](#como-diagnosticar-seu-redox-em-caso-de-erros)
 - [Como reportar bugs para o Redox](#como-reportar-bugs-para-o-redox)
- [Como contribuir para o Redox?](#como-contribuir-para-o-redox)
- [Eu tenho um problema/pergunta para a equipe do Redox](#eu-tenho-um-problemapergunta-para-a-equipe-do-redox)

## O que é o Redox?

Redox é um sistema operacional baseado em microkernel, completo, funcional, para uso geral com foco em segurança, liberdade, confiabilidade, correção e pragmatismo.

Onde for possível, os componentes do sistema serão escritos em Rust e executam no espaço do usuário.

### Estado atual

O Redox está em qualidade alpha/beta, pois implementamos novas funções enquanto corrigimos bugs.

Portanto, ele não está pronto para uso diário, sinta-se livre para testar o sistema até sua maturidade e **não armazene arquivos sensíveis sem o devido backup.**

A versão 1.0 será lançada quando todas as APIs do sistema forem consideradas estáveis.

## O que Redox significa?

[Redox](https://en.wikipedia.org/wiki/Redox) é a reação química (redução-oxidação) que cria a ferrugem, já que o Redox é um sistema operacional escrito em Rust, faz sentido.

Ele soa similar com Minix/Linux também.

## Quais funções o Redox possui?

### Benefícios do Microkernel

#### Modularidade real

Você pode modificar/trocar a maioria dos componentes do sistema sem reiniciar o sistema, similar ao [livepatching](https://en.wikipedia.org/wiki/Kpatch) porém mais seguro).

#### Isolamento de bugs

A maioria dos componentes do sistema executam no espaço do usuário em um sistema com microkernel, um bug em componentes do sistema fora do kernel não pode [quebrar o kernel](https://en.wikipedia.org/wiki/Kernel_panic).

#### Design de não-reinicialização

O kernel é pequeno e muda muito pouco (correção de bugs), portanto você não precisa reiniciar seu sistema com frequência para atualizar, já que a maioria dos serviços do sistema estão no espaço do usuário, eles podem ser trocados/atualizados durante a execução (reduzindo o tempo offline de servidores).

### Benefícios da Rust

#### Sem necessidade para mitigações de exploit das linguagens C e C++

O design de um microkernel escrito em Rust protege contra as falhas de memória das linguagens C e C++, isolando o sistema do kernel a superfície de ataque é muito limitada.

#### Sistema de arquivos inspirado no ZFS

O Redox utiliza o RedoxFS como sistema de arquivos padrão, ele suporta funções parecidas com as do [ZFS](https://docs.freebsd.org/en/books/handbook/zfs/) com uma implementação escrita em Rust.

Espere alto desempenho e segurança dos dados (copy-on-write, integridade de arquivos, volumes, snapshots, endurecido contra a perda de arquivos).

#### Melhorias de segurança/confiabilidade sem impacto significante no desempenho

Como o kernel é pequeno, ele usa menos memória para fazer suas funções e o código limitado no kernel torna ele quase livre de bugs (objetivo do príncipio [KISS](https://en.wikipedia.org/wiki/KISS_principle)).

O design seguro e veloz da linguagem Rust, combinado com a pequena quantidade de código no kernel, ajudam a garantir um núcleo fácil, confiável e veloz de manter.

#### Drivers escritos em Rust

Drivers escritos em Rust possuem incentivos para ter menos bugs e portanto melhor segurança.

- [Dispositivos suportados atualmente](#quais-dispositivos-o-redox-suporta)

#### Fácil de desenvolver e depurar

A maioria dos componentes do sistema estão no espaço do usuário, simplificando a depuração.

## Qual o propósito do Redox?

O objetivo principal do Redox é ser um sistema de propósito geral com foco em segurança, confiabilidade e correção.

O Redox pretende ser uma alternativa aos sistemas Unix (Linux/BSD) existentes também, podendo executar programas Unix com apenas compilação ou modificações mínimas.

- [Nossos Objetivos](https://doc.redox-os.org/book/ch01-01-our-goals.html)

## O que posso fazer com o Redox?

Como um sistema de propósito geral, você é capaz de realizar praticamente qualquer tarefa na maioria dos dispositivos com alto desempenho/segurança.

O Redox está em desenvolvimento, portanto nossa lista de aplicações suportada é limitada atualmente, mas crescente.

- [Casos de Uso](https://doc.redox-os.org/book/ch01-04-redox-use-cases.html)

## O que é um sistema Unix-like?

Qualquer sistema compátivel com a [Especificação Única do Unix](https://en.wikipedia.org/wiki/Single_UNIX_Specification) e [POSIX](https://en.wikipedia.org/wiki/POSIX), portanto com uma [Shell](https://en.wikipedia.org/wiki/Unix_shell), o conceito de "[Tudo é um arquivo](https://en.wikipedia.org/wiki/Everything_is_a_file)", multitarefa e multiusuário.

[Unix](https://pt.wikipedia.org/wiki/Unix) foi um sistema operacional de multitarefa muito influente e impactou as decisões de design em diversos sistemas modernos.

- [Artigo da Wikipedia](https://pt.wikipedia.org/wiki/Sistema_operacional_tipo_Unix)

## Como o Redox é inspirado em outros sistemas?

[Plan 9](http://9p.io/plan9/index.html) - Este sistema da Bell Labs trouxe o conceito de "Tudo é um arquivo" ao seu maior nível, fazendo toda a comunicação do sistema pelo sistemas de arquivos.

Você apenas precisa montar o software em algum local para obter a função desejada, qualquer software pode funcionar dessa forma.

- [Drew DeVault explicando o Plan 9](https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html)
- [Como o Redox foi influenciado pelo Plan 9](https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html)

[Minix](https://minix3.org/) - o sistema Unix-like com microkernel mais influente, ele possuí funções avançadas tais como modularidade do sistema, resistência a [quebra do kernel](https://en.wikipedia.org/wiki/Kernel_panic), reincarnação de driver, proteção contra drivers ruins e interfaces seguras para a [comunicação dos processos](https://en.wikipedia.org/wiki/Inter-process_communication).

O Redox é largamente inspirado pelo Minix, ele tem funções e arquitetura similar escrita em Rust.

- [Como o Redox foi influenciado pelo Minix](https://doc.redox-os.org/book/ch04-01-microkernels.html)

[BSD](https://www.bsd.org/) - Essa [família](https://en.wikipedia.org/wiki/Research_Unix) de sistemas Unix fez diversas melhorias para os sistemas Unix, a mais notável são os [sockets BSD](https://en.wikipedia.org/wiki/Berkeley_sockets), eles trazem a comunicação de rede com operação de arquivos (antes do Plan 9).

- [Documentação do FreeBSD](https://docs.freebsd.org/en/books/developers-handbook/sockets/)

[Linux](https://www.kernel.org/) - o kernel monolítico mais avançado do mundo e maior projeto de código-aberto do mundo, ele traz diversas melhorias/otimizações para sistemas Unix-like.

O Redox tenta implementar as melhorias de desempenho do Linux em um design de microkernel.

## O que é um microkernel?

Um microkernel é um modelo para núcleo de sistema operacional com uma pequena quantidade de código executando no maior privilégio do processador, este modelo melhora a estabilidade e segurança, com um pequeno custo de desempenho.

- [Explicação do livro Redox](https://doc.redox-os.org/book/ch04-01-microkernels.html)

## Quais programas o Redox executa?

O Redox é desenhado para ser compátivel-em-código com a maioria dos sistemas Unix, Linux e programas POSIX, necessitando apenas de compilação.

Atualmente, a maioria das aplicações com interface gráfica requer um port, já que não suportamos X11 ou Wayland ainda.

Softwares importantes que o Redox suporta:

- [Bash](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/bash)
- [ffmpeg](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/ffmpeg)
- [GCC](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/gcc)
- [Git](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/git)
- [LLVM](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/llvm)
- [Mesa3D](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/mesa)
- [OpenSSL](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/openssl)
- [SDL2](https://gitlab.redox-os.org/redox-os/cookbook/-/tree/master/recipes/sdl2)

Você pode ver todos os componentes do Redox/programas portados [aqui](https://static.redox-os.org/pkg/x86_64-unknown-redox/)

## Como instalar programs no Redox?

O Redox tem um gerenciador de pacotes similar ao `apt` (Debian) e `pkg` (FreeBSD), você pode ler como utiliza-lo nesta página:

- [Gerenciador de Pacotes do Redox](https://doc.redox-os.org/book/ch02-08-pkg.html)

## Quais são as variantes do Redox?

O Redox possuí variantes para cada tarefa, leia sobre elas abaixo:

- `server-minimal` - A variante mais enxuta com um sistema básico, destinada a dispositivos embarcados, computadores muito antigos e programadores.

- `desktop-minimal` - A variante mais enxuta com o ambiente de desktop Orbital incluído, destinado para dispositivos embarcados, computadores muito antigos e programadores.

- `server` - A variante para servidores, com um sistema completo e ferramentas de rede, destinado para admnistradores de rede, dispositivos embarcados, computadores fracos e programadores.

- `desktop` - A variante padrão com um sistema completo, o ambiente de desktop Orbital e ferramentas úteis, destinado para o uso diário, produtores, programadores e jogadores.

- `dev` - A variante para desenvolvimento com um sistema completo e ferramentas de programação, destinado para programadores.

- `demo` - A variante para demonstração com um sistema completo, ferramentas, reprodutores e jogos, destinado para testadores, jogadores e programadores.

## Quais dispositivos o Redox suporta?

Há bilhões de dispositivos com centenas de modelos/arquiteturas no mundo, nós tentamos escrever drivers para os dispositivos mais utilizados para ajudar mais pessoas, alguns drivers são específicos para um dispositivo e outros são específicos de arquitetura.

Leia o [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) para ver todos os computadores testados.

### CPU

- [x86_64/AMD64](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86_64) - (Intel/AMD)
- [x86/i686](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/x86) - (Intel/AMD a partir do Pentium II e após, incompleto)
- [ARM64](https://gitlab.redox-os.org/redox-os/kernel/-/tree/master/src/arch/aarch64) - (incompleto)

### Interfaces do Hardware

- [ACPI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/acpid)
- [PCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcid)

(USB breve)

### Vídeo

- [VGA](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vesad) - (BIOS)
- GOP (UEFI)
- [LLVMpipe](https://docs.mesa3d.org/drivers/llvmpipe.html) - Renderização de Software

(Intel/AMD e outros no futuro)

### Som

- [Intel chipsets](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ihdad)
- [Realtek chipsets](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ac97d)
- [PC speaker](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/pcspkrd)

([Sound Blaster](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/sb16d) em breve)

### Armazenamento

- [IDE](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ided) - (PATA)
- [AHCI](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ahcid) - (SATA)
- [NVMe](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/nvmed)

(USB em breve)

### Periféricos

- [Teclados PS/2](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [Mouse PS/2](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)
- [Touchpad PS/2](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ps2d)

(USB em breve)

### Internet

- [Intel Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/e1000d)
- [Intel 10 Gigabit ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/ixgbed)
- [Realtek ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/rtl8168d)

(Wi-Fi/[Atheros ethernet](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/alxd) em breve)

## Quais máquinas virtuais o Redox possui integração?

- [QEMU](https://www.qemu.org/)
- [VirtualBox](https://gitlab.redox-os.org/redox-os/drivers/-/tree/master/vboxd)

No futuro o microkernel poderia agir como um supervisor, similar ao [Xen](https://xenproject.org/).

Um [supervisor](https://en.wikipedia.org/wiki/Hypervisor) é um software que executa múltiplas instâncias isoladas de sistemas operacionais simultaneamente.

## Como compilar o Redox?

Atualmente o Redox tem um script de bootstrap para o Debian/Ubuntu/Pop OS! com suporte não mantido para outras distribuições.

Nós estamos em transição para o Podman como nosso método de compilação principal, ele é método de compilação recomendado para sistemas que não sejam baseados no Debian, pois ele evita problemas de ambiente durante a compilação.

- [Guia no Livro do Redox](https://doc.redox-os.org/book/ch02-05-building-redox.html) - (Debian/Ubuntu/Pop OS!)
- [Guia do Podman no Livro do Redox](https://doc.redox-os.org/book/ch02-06-podman-build.html)

### Como abrir o QEMU sem interface gráfica

Execute:

- `make qemu vga=no`

### Como diagnosticar seu Redox em caso de erros

Leia todo o livro do Redox antes para ver se seu problema é sua configuração de compilação ou ferramentas de compilação, se isto não resolver seu erro, leia:

- [Guia de Diagnóstico no Livro do Redox](https://doc.redox-os.org/book/ch08-05-troubleshooting.html)
- [Guia de Diagnóstico no GitLab](https://gitlab.redox-os.org/redox-os/redox#help-redox-wont-compile)

### Como reportar bugs para o Redox?

Verifique as Issues no GitLab primeiro para ver se seu problema é conhecido.

- [Guia para Relatório de Bug no Livro do Redox](https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html)
- [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md)

## Como contribuir para o Redox?

Você pode contribuir para o Redox de diversas formas, veja elas em [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md).

## Eu tenho um problema/pergunta para a equipe do Redox

- Leia a [Documentação](/docs/).
- Leia todo [livro do Redox](https://doc.redox-os.org/book/) para ver se isso responde suas pergunta/corrige seu problema.
- Se a documentação/livro não resolver, diga sua pergunta/problema nas salas [Redox Support](https://matrix.to/#/#redox-support:matrix.org) ou [Redox Dev](https://matrix.to/#/#redox-dev:matrix.org) no Matrix.
