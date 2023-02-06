+++
title = "Funções"
+++

## Modularidade real

Você pode mudar cada componente do sistema sem reiniciar o sistema, similar ao [livepatching]).

[livepatching]: https://en.wikipedia.org/wiki/Kpatch

## Isolamento de bugs

O kernel é pequeno e está perto de ser livre de bugs (objetivo do príncipio [KISS]), um bug em um componente do sistema não pode [quebrar o sistema].

[KISS]: https://en.wikipedia.org/wiki/KISS_principle
[quebrar o sistema]: https://en.wikipedia.org/wiki/Kernel_panic

## Design de não-reinicialização

O kernel é pequeno e muda muito pouco (correção de bugs), então você não precisa reiniciar seu sistema para atualizar, já que a maioria dos serviços do sistema estão no espaço do usuário, eles podem ser trocados durante a execução.

A frequência de atualizações é menor também (menos chance de bugs).

## Sem necessidade para mitigações de exploit

O design em microkernel escrito em Rust torna a maioria das falhas de segurança C/C++ irrelevante/inútil, com esse design o invasor/hacker não pode usar estes bugs para explorar o sistema.

## Sistema de arquivos inspirado no ZFS

O Redox utiliza o RedoxFS como sistema de arquivos padrão, ele suporta as mesmas funções do [ZFS] (copy-on-write, integridade de arquivos, volumes, snapshots, etc) com mudanças na implementação.

Espere alto desempenho e segurança dos dados (endurecido contra a perda de arquivos).

[ZFS]: https://docs.freebsd.org/en/books/handbook/zfs/

## Melhor desempenho do sistema e menos uso de memória

Como o kernel é pequeno, ele usa menos memória para fazer sua função.

Além de ser pequeno, o sistema é escrito em Rust, essa linguaguem de programação ajuda os programadores a escrever um código melhor sem problemas de desempenho.

A Rust implementa otimização de desempenho com segurança por padrão.

## Drivers escritos em Rust

Drivers written in Rust have less bugs, more security and performance (less bugs can bring more performance).
Drivers escritos em Rust tem menos bugs, mais segurança e desempenho (menos bugs podem melhorar o desempenho do dispositivo).

- [Dispositivos suportados atualmente](/faq/#which-devices-redox-support)

## Fácil de desenvolver e depurar

A maioria dos componentes do sistema estão no espaço do usuário, você não precisa de virtualização para testar/depurar eles, mais rápido de desenvolver.
