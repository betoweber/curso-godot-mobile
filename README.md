# 🎮 Curso Godot Mobile (+ Blender)

Curso prático e pessoal para aprender **desenvolvimento de jogos mobile com Godot 4** e **criação de assets 3D
com Blender** — preparação para a disciplina de desenvolvimento de jogos da pós.

- 📚 **14 lições de Godot** — do editor até exportar para Android/iPhone, com foco em mobile
- 🧪 **Exercícios de GDScript com corretor automático** (63 testes, com gabarito)
- 🕹️ **2 jogos de referência completos e comentados**: um 2D mobile (toque) e um 3D (joystick virtual)
- 🧊 **5 lições de Blender** — low poly, texturas pixel art com Aseprite, animação e exportação para o Godot
- 🤖 **Tutor**: abra o Claude Code nesta pasta e tire dúvidas — ele conhece o curso (veja `CLAUDE.md`)

Testado com **Godot 4.7.2**. Vale para qualquer Godot 4.x recente.

---

## 🚀 Começando

1. Siga a lição [00 · Preparando o Mac](trilha-godot/00-setup-mac.md).
2. Abra o Godot, clique em **Import** e escolha `projetos/00-exercicios-gdscript/project.godot`.
3. Rode com **Cmd+B**. Você verá os testes dos exercícios — todos vermelhos. Sua missão é deixá-los verdes. 🙂
4. Marque seu avanço em [PROGRESSO.md](PROGRESSO.md) e faça commit.

## 🗺️ Trilha

### Godot

| # | Lição | Projeto / prática |
|---|---|---|
| 00 | [Preparando o Mac](trilha-godot/00-setup-mac.md) | instalar tudo |
| 01 | [O editor, nós e cenas](trilha-godot/01-editor-nos-e-cenas.md) | tour + explorar o gabarito |
| 02 | [GDScript básico](trilha-godot/02-gdscript-basico.md) | ex01–ex06 🧪 |
| 03 | [Scripts, ciclo de vida e sinais](trilha-godot/03-scripts-ciclo-de-vida-sinais.md) | ex07–ex09 🧪 |
| 04 | [Primeiro jogo 2D: a nave](trilha-godot/04-primeiro-jogo-2d.md) | Chuva de Estrelas: toque |
| 05 | [Instâncias, timers e colisões](trilha-godot/05-spawner-e-colisoes.md) | Chuva de Estrelas: itens |
| 06 | [Sprites do Aseprite e animação](trilha-godot/06-sprites-aseprite-animacao.md) | sua pixel art no jogo |
| 07 | [Interface: HUD, menus e telas](trilha-godot/07-ui-hud-telas.md) | Chuva de Estrelas: UI |
| 08 | [Mobile: telas, toque e desempenho](trilha-godot/08-mobile-telas-toque-desempenho.md) | ⭐ núcleo mobile |
| 09 | [Juice: som, partículas, tweens](trilha-godot/09-juice-som-particulas.md) | deixar gostoso |
| 10 | [Autoload, save e cenas](trilha-godot/10-autoload-save-cenas.md) | recorde, menu |
| 11 | [Exportar para Android e iPhone](trilha-godot/11-exportar-android-ios.md) | 📱 no seu celular |
| 12 | [Introdução ao 3D](trilha-godot/12-introducao-3d.md) | Arena 3D |
| 13 | [Projeto final](trilha-godot/13-projeto-final.md) | **seu** jogo |

### Blender ([visão geral](trilha-blender/README.md))

| # | Lição |
|---|---|
| B00 | [Instalação e interface no Mac](trilha-blender/B00-instalar-e-interface.md) |
| B01 | [Modelagem low poly](trilha-blender/B01-modelagem-low-poly.md) |
| B02 | [Materiais, UV e texturas pixel art](trilha-blender/B02-materiais-uv-pixel-art.md) |
| B03 | [Esqueleto e animação](trilha-blender/B03-rig-e-animacao.md) |
| B04 | [Exportar para o Godot](trilha-blender/B04-exportar-para-godot.md) |

### Referência rápida

[Cola de GDScript](referencia/gdscript-cola.md) · [Atalhos no Mac](referencia/atalhos-mac.md) ·
[Erros comuns](referencia/erros-comuns.md) · [Glossário](referencia/glossario.md) · [Recursos](referencia/recursos.md)

## 📅 Cronograma sugerido (~4–6 h por semana)

| Semana | Conteúdo |
|---|---|
| 1 | 00, 01 |
| 2–3 | 02 (exercícios 01–06) |
| 4 | 03 (exercícios 07–09) |
| 5 | 04, 05 |
| 6 | 06 · *B00 em paralelo* |
| 7 | 07 |
| 8 | 08 |
| 9 | 09, 10 |
| 10 | 11 — jogo no celular! |
| 11 | 12 |
| 12–13 | B01, B02 |
| 14 | B03, B04 |
| 15–18 | 13 — projeto final |

Atrasou? Tudo bem. A ordem importa mais que o ritmo. Se a pós começar antes de terminar, priorize
**02, 03, 04, 05, 07, 08 e 11** — é o núcleo de "jogo mobile em Godot".

## 📁 Estrutura

```
├── trilha-godot/          lições de Godot (00–13)
├── trilha-blender/        lições de Blender (B00–B04)
├── referencia/            cola, atalhos, erros comuns, glossário, recursos
├── projetos/
│   ├── 00-exercicios-gdscript/   exercícios + corretor automático + gabarito
│   ├── 01-chuva-de-estrelas/     jogo 2D mobile completo (gabarito das lições 04–11)
│   └── 02-arena-3d/              jogo 3D com joystick virtual (lição 12 e trilha Blender)
├── meus-projetos/         ✍️ SEU espaço: seus projetos e experimentos
├── PROGRESSO.md           checklist do seu avanço
└── CLAUDE.md              instruções do tutor (Claude Code)
```

## 🤖 Tirando dúvidas com o tutor

Com o [Claude Code](https://claude.com/claude-code) instalado no Mac:

```bash
cd ~/Developer/curso-godot-mobile
claude
```

Exemplos:
- *"Estou na lição 05. Não entendi Layer e Mask."*
- *"Meu ex05 falha em `remover_item`. Me dá uma dica, sem a resposta."*
- *"Revisa meu `meus-projetos/chuva-de-estrelas/scripts/jogador.gd`."*
- *"Faz um quiz de 5 perguntas sobre a lição 08."*
- *"Marca a lição 04 como concluída no PROGRESSO.md."*

## Rodando o corretor pelo terminal (opcional)

```bash
alias godot="/Applications/Godot.app/Contents/MacOS/Godot"
cd projetos/00-exercicios-gdscript
godot --headless --path . --import          # só na primeira vez (gera o cache .godot/)
godot --headless --path . --script res://cli.gd               # seus exercícios
godot --headless --path . --script res://cli.gd -- --solucoes # o gabarito
```
