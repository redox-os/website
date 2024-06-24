+++
title = "FAQ"
+++

Essa página contém perguntas e respostas para iniciantes e usuários comuns.

- [O que é o Redox?](#o-que-%C3%A9-o-redox)
- [O que Redox significa?](#o-que-redox-significa)
- [Quais funções o Redox possui?](#quais-fun%C3%A7%C3%B5es-o-redox-possui)
    - [Benefícios do Microkernel](#benefícios-do-microkernel)
    - [Benefícios da Rust](#benefícios-da-rust)
    - [Comparação com outros sistemas operacionais](#comparação-com-outros-sistemas-operacionais)
- [Qual o propósito do Redox?](#qual-o-prop%C3%B3sito-do-redox)
- [O que posso fazer com o Redox?](#o-que-posso-fazer-com-o-redox)
- [O que é um sistema Unix-like?](#o-que-%C3%A9-um-sistema-unix-like)
- [Como o Redox é inspirado em outros sistemas?](#como-o-redox-%C3%A9-inspirado-em-outros-sistemas)
- [O que é um microkernel?](#o-que-%C3%A9-um-microkernel)
- [Quais programas o Redox executa?](#quais-programas-o-redox-executa)
- [Como instalar programas no Redox?](#como-instalar-programas-no-redox)
- [Quais são as variantes do Redox?](#quais-são-as-variantes-do-redox)
- [Quais dispositivos o Redox suporta?](#quais-dispositivos-o-redox-suporta)
- [Tenho um computador fraco, o Redox irá funcionar?](#tenho-um-computador-fraco-o-redox-irá-funcionar)
- [Quais máquinas virtuais o Redox possui integração?](#quais-m%C3%A1quinas-virtuais-o-redox-possui-integra%C3%A7%C3%A3o)
- [Como compilar o Redox?](#como-compilar-o-redox)
- [Como diagnosticar seu Redox em caso de erros](#como-diagnosticar-seu-redox-em-caso-de-erros)
- [Como reportar bugs para o Redox](#como-reportar-bugs-para-o-redox)
- [Como contribuir para o Redox?](#como-contribuir-para-o-redox)
- [Eu tenho um problema/pergunta para a equipe do Redox](#eu-tenho-um-problemapergunta-para-a-equipe-do-redox)

## O que é o Redox?

Redox é um sistema operacional baseado em microkernel, completo, funcional, para uso geral criado em 2015, com foco em segurança, liberdade, confiabilidade, correção e pragmatismo.

Onde for possível, os componentes do sistema serão escritos em Rust e executam no espaço do usuário.

### Estado atual

O Redox está em qualidade alpha/beta, pois implementamos novas funções enquanto corrigimos bugs.

Portanto, ele não está pronto para uso diário, sinta-se livre para testar o sistema até sua maturidade e **não armazene arquivos sensíveis sem o devido backup.**

A versão 1.0 será lançada quando todas as APIs do sistema forem consideradas estáveis.

## O que Redox significa?

[Redox](https://en.wikipedia.org/wiki/Redox) é a reação química (redução-oxidação) que cria a ferrugem, sendo o Redox um sistema operacional escrito em Rust, faz sentido.

Ele soa similar com Minix e Linux também.

## Quais funções o Redox possui?

### Benefícios do Microkernel

- **Modularidade real**

Você pode modificar/trocar a maioria dos componentes do sistema sem reiniciar o sistema, similar a alguns módulos de kernel e [livepatching](https://en.wikipedia.org/wiki/Kpatch) porém mais seguro.

- **Isolamento de bugs**

A maioria dos componentes do sistema executam no espaço do usuário em um sistema com microkernel, um bug em componentes do sistema fora do kernel não pode [quebrar o kernel](https://en.wikipedia.org/wiki/Kernel_panic).

- **Design de não-reinicialização**

O kernel é pequeno e muda muito pouco (correção de bugs), portanto você não precisa reiniciar seu sistema com frequência para atualizar, já que a maioria dos serviços do sistema estão no espaço do usuário, eles podem ser trocados/atualizados durante a execução (reduzindo muito o tempo offline de servidores).

- **Fácil de desenvolver e depurar**

A maioria dos componentes do sistema estão no espaço do usuário, simplificando os testes e depuração.

Se você quiser ler mais sobre os benefícios citados acima, leia [esta](https://doc.redox-os.org/book/ch04-01-microkernels.html) página.

### Benefícios da Rust

- **Menos suscetível a bugs**

A síntaxe restritiva e os requisitos do compilador para compilar o código reduzem muito a probabilidade de bugs.

- **Menos vulnerável a corrupção de dados**

O compilador da Rust ajuda o programador a evitar erros de memória e condições de corrida, o que reduz a probabilidade dos bugs de corrupção de dados.

- **Sem necessidade para mitigações de exploit das linguagens C e C++**

O design de um microkernel escrito em Rust protege contra as falhas de memória das linguagens C e C++, isolando o sistema do kernel a superfície de ataque é muito limitada.

- **Sistema de arquivos inspirado no ZFS**

O Redox utiliza o RedoxFS como sistema de arquivos padrão, ele suporta funções parecidas com as do [ZFS](https://docs.freebsd.org/en/books/handbook/zfs/) com uma implementação escrita em Rust.

Espere alto desempenho e segurança dos dados (copy-on-write, integridade de arquivos, volumes, snapshots, endurecido contra a perda de arquivos).

- **Melhorias de segurança/confiabilidade sem impacto significante no desempenho**

Como o kernel é pequeno, ele usa menos memória para fazer suas funções e o código limitado no kernel torna ele quase livre de bugs (objetivo do príncipio [KISS](https://en.wikipedia.org/wiki/KISS_principle)).

O design seguro e veloz da linguagem Rust, combinado com a pequena quantidade de código no kernel, ajudam a garantir um núcleo fácil, confiável e veloz de manter.

- **Segurança de Concorrência**

O suporte para segurança de concorrência nas linguagens de programmação C/C++ é frágil e muito fácil de escrever um programa que parece seguro para executar em vários threads, mas introduz bugs útis e buracos de segurança.

Se um thread acessa um pedaço do estado ao mesmo tempo que outro thread está modificando, o programa todo pode exibir bugs confusos e bizarros.

Você pode ver [este](https://en.wikipedia.org/wiki/Time_of_check_to_time_of_use) exemplo de uma categoria séria de bugs de segurança que a segurança de concorrência corrige.

Mas na Rust esse tipo de bug é fácil de evitar, o mesmo sistema de escrita que nos previne de escrever de forma insegura também nos previne de escrever padrões perigosos de acesso simultâneo.

- **Drivers escritos em Rust**

Drivers escritos em Rust possuem incentivos para ter menos bugs e portanto melhor segurança.

### Comparação com outros sistemas operacionais

Você pode ver como o Redox é em comparação com o Linux, FreeBSD e Plan 9 nessas páginas:

- [Funções do Redox OS](https://doc.redox-os.org/book/ch04-11-features.html)
- [Comparando o Redox Com Outros Sistemas Operacionais](https://doc.redox-os.org/book/ch01-05-how-redox-compares.html)

## Qual o propósito do Redox?

O objetivo principal do Redox é ser um sistema de propósito geral com foco em segurança, confiabilidade e correção.

O Redox pretende ser uma alternativa aos sistemas Unix (Linux/BSD) existentes também, podendo executar programas Unix com apenas compilação ou modificações mínimas.

- [Nossos Objetivos](https://doc.redox-os.org/book/ch01-01-our-goals.html)

## O que posso fazer com o Redox?

Como um sistema de propósito geral, você é capaz de realizar praticamente qualquer tarefa na maioria dos dispositivos com alto desempenho e segurança.

O Redox está em desenvolvimento, portanto nossa lista de aplicações suportada é limitada atualmente, mas crescente.

- [Casos de Uso](https://doc.redox-os.org/book/ch01-04-redox-use-cases.html)

## O que é um sistema Unix-like?

Qualquer sistema compátivel com a [Especificação Única do Unix](https://en.wikipedia.org/wiki/Single_UNIX_Specification) e [POSIX](https://en.wikipedia.org/wiki/POSIX), portanto com uma [Shell](https://en.wikipedia.org/wiki/Unix_shell), o conceito de "[Tudo é um arquivo](https://en.wikipedia.org/wiki/Everything_is_a_file)", multitarefa e multiusuário.

[Unix](https://pt.wikipedia.org/wiki/Unix) foi um sistema operacional de multitarefa muito influente e impactou as decisões de design em diversos sistemas modernos.

- [Artigo da Wikipedia](https://pt.wikipedia.org/wiki/Sistema_operacional_tipo_Unix)

## Como o Redox é inspirado em outros sistemas?

### [Plan 9](http://9p.io/plan9/index.html)

Este sistema da Bell Labs trouxe o conceito de "Tudo é um arquivo" ao seu maior nível, fazendo toda a comunicação do sistema pelo sistemas de arquivos.

Você apenas precisa montar o software em algum local para obter a função desejada, qualquer software pode funcionar dessa forma.

- [Drew DeVault explicando o Plan 9](https://drewdevault.com/2022/11/12/In-praise-of-Plan-9.html)
- [Como o Redox foi influenciado pelo Plan 9](https://doc.redox-os.org/book/ch05-00-urls-schemes-resources.html)

### [Minix](https://minix3.org/)

O sistema Unix-like com microkernel mais influente, ele possuí funções avançadas tais como modularidade do sistema, resistência a [quebra do kernel](https://en.wikipedia.org/wiki/Kernel_panic), reincarnação de driver, proteção contra drivers ruins e interfaces seguras para a [comunicação dos processos](https://en.wikipedia.org/wiki/Inter-process_communication).

O Redox é largamente inspirado pelo Minix, ele tem funções e arquitetura similar escrita em Rust.

- [Como o Redox foi influenciado pelo Minix](https://doc.redox-os.org/book/ch04-01-microkernels.html)

### [seL4](https://sel4.systems/)

O mais veloz e simples microkernel do mundo, focado em desempenho e simplicidade.

O Redox segue o mesmo princípio, tentando deixar o espaço do kernel o menor possível (movendo componentes para o espaço do usuário e reduzindo a quantidade de chamadas do sistema, passando a complexidade para o espaço do usuário) e mantendo o desempenho geral bom (reduzindo o custo da troca de contexto).

### [BSD](https://www.bsd.org/)

Essa [família](https://en.wikipedia.org/wiki/Research_Unix) de sistemas Unix implementou diversas melhorias para os sistemas Unix, as variantes de código-aberto dos sistemas BSD adicionaram muitas melhorias no sistema original (assim como o Linux fez).

- [FreeBSD](https://www.freebsd.org/) - O Redox se inspirou no [Capsicum](https://man.freebsd.org/cgi/man.cgi?capsicum(4)) (um sistema baseado em capacidades) e [jails](https://en.wikipedia.org/wiki/Freebsd_jail) (uma tecnologia de isolamento)) para a implementação de namespaces.

- [OpenBSD](https://www.openbsd.org/) - O Redox se inspirou no isolamento de [chamadas do sistema](https://man.openbsd.org/pledge.2), [sistema de arquivos](https://man.openbsd.org/unveil.2), [servidor gráfico](https://www.xenocara.org/) e [servidor de áudio](https://man.openbsd.org/sndiod.8) e [outros](https://www.openbsd.org/innovations.html).

### [Linux](https://www.kernel.org/)

O kernel monolítico mais avançado e o maior projeto de código-aberto do mundo, ele trouxe muitas melhorias e otimizações para o mundo Unix-like.

O Redox tenta implementar as melhorias de desempenho do Linux em um design de microkernel.

## O que é um microkernel?

Um microkernel é um modelo para núcleo de sistema operacional com uma pequena quantidade de código executando no maior privilégio do processador, este modelo melhora a estabilidade e segurança, com um pequeno custo de desempenho.

Você pode ler mais sobre [aqui](https://doc.redox-os.org/book/ch04-01-microkernels.html).

## Quais programas o Redox executa?

O Redox é desenhado para ser compátivel-em-código com a maioria dos sistemas Unix, Linux e programas POSIX, necessitando apenas de compilação.

Atualmente, a maioria das aplicações com interface gráfica requer um port, já que não suportamos X11 ou Wayland ainda.

Softwares importantes que o Redox suporta:

- GNU Bash
- FFMPEG
- Git
- RustPython
- SDL2
- OpenSSL
- Mesa3D
- GCC
- LLVM

Você pode ver todos os componentes do Redox e programas portados [aqui](https://static.redox-os.org/pkg/x86_64-unknown-redox/)

## Como instalar programs no Redox?

O Redox tem um gerenciador de pacotes similar ao `apt` (Debian) e `pkg` (FreeBSD), você pode aprender a como utiliza-lo [aqui](https://doc.redox-os.org/book/ch02-08-pkg.html).

## Quais são as variantes do Redox?

O Redox possuí variantes para cada tarefa, leia sobre elas abaixo:

- `minimal` - A variante mais simples com um sistema básico sem suporte a Internet, destinada a dispositivos embarcados, computadores muito antigos e programadores.

- `minimal-net` - A variante mais enxuta com um sistema básico e suporte a Internet, destinada a dispositivos embarcados, computadores muito antigos e programadores.

- `desktop-minimal` - A variante mais enxuta com o ambiente de desktop Orbital incluído, destinada para dispositivos embarcados, computadores muito antigos e programadores.

- `server` - A variante para servidores, com um sistema completo e ferramentas de rede, destinada a servidores, dispositivos embarcados, computadores fracos e programadores.

- `desktop` - A variante padrão com um sistema completo, o ambiente de desktop Orbital e ferramentas úteis, destinada a usuários comuns, produtores, jogadores e programadores.

- `dev` - A variante para desenvolvimento com um sistema completo e ferramentas de programação, destinada a programadores.

- `demo` - A variante para demonstração com um sistema completo, ferramentas, reprodutores e jogos, destinado a usuários comuns, jogadores e programadores.

## Quais dispositivos o Redox suporta?

Há bilhões de dispositivos com centenas de modelos/arquiteturas no mundo, nós tentamos escrever drivers para os dispositivos mais utilizados para ajudar mais pessoas, alguns drivers são específicos para um dispositivo e outros são específicos de arquitetura.

Leia o [HARDWARE.md](https://gitlab.redox-os.org/redox-os/redox/-/blob/master/HARDWARE.md) para ver todos os computadores testados.

### CPU

- Intel - 64-bit (x86_64) e 32-bit (i686) a partir do Pentium II e após com limitações.
- AMD - 64-bit (AMD64) e 32-bit.
- ARM - 64-bit (Aarch64) com limitações.

### Interfaces do Hardware

- ACPI
- PCI

(USB em breve)

### Vídeo

- VGA - (BIOS)
- GOP (UEFI)
- [LLVMpipe](https://docs.mesa3d.org/drivers/llvmpipe.html) (Emulação da OpenGL na CPU)

(Intel/AMD e outros no futuro)

### Som

- Chipsets Intel
- Chipsets Realtek
- Alto-falante de PC

(Sound Blaster em breve)

### Armazenamento

- IDE (PATA)
- SATA (AHCI)
- NVMe

(USB em breve)

### Periféricos

- Teclados, mouse e touchpad PS/2
- Teclados, mouse e touchpad USB

### Internet

- Intel Gigabit ethernet
- Intel 10 Gigabit ethernet
- Realtek ethernet

(Wi-Fi e Atheros ethernet em breve)

## Tenho um computador fraco, o Redox irá funcionar?

Um processador de computador é a máquina mais complexa do mundo, até os mais antigos são poderosos para a maioria das tarefas, isso depende da tarefa.

O principal problema com os computadores antigos é a quantidade de memória RAM disponível (eles foram vendidos em uma época onde pentes de memória RAM eram caros) e a falta das extensões SSE/AVX (os programas usam elas para acelerar os algoritmos), portanto alguns programas modernos podem não funcionar ou precisam de muita memória RAM para tarefas complexas.

O Redox irá funcionar normalmente (se a arquitetura do processador for suportada pelo sistema) porém você terá que testar cada programa.

## Quais máquinas virtuais o Redox possui integração?

- QEMU
- VirtualBox

No futuro o microkernel poderia agir como um supervisor, similar ao [Xen](https://xenproject.org/).

Um [supervisor](https://en.wikipedia.org/wiki/Hypervisor) é um software que executa múltiplas instâncias isoladas de sistemas operacionais simultaneamente.

## Como compilar o Redox?

Atualmente o Redox tem um script de bootstrap para o Pop OS!, Ubuntu, Debian, Fedora, Arch Linux, openSUSE e FreeBSD com suporte não mantido para outras distribuições.

Nós também oferecemos o Podman como método de compilação universal, esse é método de compilação recomendado para sistemas que não sejam baseados no Debian, pois ele evita problemas de ambiente durante a compilação.

- [Guia no Livro do Redox](https://doc.redox-os.org/book/ch02-05-building-redox.html) - (Pop OS!, Ubuntu, Debian, Fedora, Arch Linux, openSUSE and FreeBSD)
- [Guia do Podman no Livro do Redox](https://doc.redox-os.org/book/ch02-06-podman-build.html)

## Como diagnosticar seu Redox em caso de erros

Leia [essa](https://doc.redox-os.org/book/ch08-05-troubleshooting.html) página ou nos explique no [Chat](https://doc.redox-os.org/book/ch13-01-chat.html).

## Como reportar bugs para o Redox?

Leia [essa](https://doc.redox-os.org/book/ch12-03-creating-proper-bug-reports.html) página e verifique as Issues no GitLab para ver se seu problema foi reportado por alguém.

## Como contribuir para o Redox?

Você pode contribuir para o Redox de diversas formas, veja elas em [CONTRIBUTING](https://gitlab.redox-os.org/redox-os/redox/blob/master/CONTRIBUTING.md).

## Eu tenho um pergunta/problema para a equipe do Redox

- Leia a [Documentação](/docs/) para saber mais sobre partes internas do Redox.
- Leia todo o [livro do Redox](https://doc.redox-os.org/book/) para ver se responde sua pergunta ou conserta seu problema.
- Se a documentação e o livro não resolver, faça sua pergunta ou diga seu problema no [Chat](https://doc.redox-os.org/book/ch13-01-chat.html).
