# 07 · Interface: HUD, menus e telas

> ⏱️ ~3h · 🎯 Montar interfaces que se adaptam a qualquer tela de celular

## Nós de interface (Control)

Todo nó verde no "Add Node" é um `Control`. Eles não usam `position` livre como o 2D:
usam **âncoras** e **containers** para se posicionar de forma responsiva.

| Nó | Uso |
|---|---|
| `Label` | texto |
| `Button`, `TextureButton` | botões (o segundo usa imagens: normal/pressionado) |
| `TextureRect`, `NinePatchRect` | imagens; NinePatch estica bordas sem deformar (painéis de pixel art!) |
| `ProgressBar`, `TextureProgressBar` | barras de vida/carregamento |
| `VBoxContainer` / `HBoxContainer` | empilham filhos vertical/horizontalmente |
| `MarginContainer` | adiciona margem interna |
| `CenterContainer` | centraliza o filho |
| `GridContainer` | grade (inventário, seleção de fase) |
| `PanelContainer` | fundo de painel ao redor do filho |

### Âncoras em 1 minuto

Com um Control selecionado, o botão **Layout** (ícone de âncora na barra do viewport) tem presets:
*Full Rect*, *Top Wide*, *Center*, *Bottom Right*... A âncora diz "grude neste ponto da tela do pai".
Com *Top Wide*, a barra de pontos fica no topo em qualquer largura de celular.

**Regra prática**: use âncoras só no nó raiz de cada bloco; dentro dele, use **containers**.
Filhos de containers não podem ser movidos à mão — o container decide. Ajuste com *Size Flags* (Fill, Expand)
e *Custom Minimum Size*.

## CanvasLayer: a UI não anda com a câmera

Coloque a interface dentro de um `CanvasLayer`. Ele desenha numa camada separada, por cima do jogo,
e ignora a `Camera2D` (o tremor de tela não balança o placar).

## Mão na massa: o HUD do Chuva de Estrelas

Crie `cenas/hud.tscn`:

```
HUD (CanvasLayer)                       ← hud.gd
├── Topo (MarginContainer)              ← Layout: Top Wide; margens 32
│   └── Linha (HBoxContainer)
│       ├── Pontos (Label)  %           ← Size Flags H: Expand  (empurra o próximo para a direita)
│       └── Vidas (Label)   %
├── TelaInicio (CenterContainer) %      ← Full Rect
│   └── Coluna (VBoxContainer)
│       ├── Titulo (Label)
│       ├── Recorde (Label) %
│       └── Jogar (Button)              ← Custom Minimum Size: 360×110 (dedo grande!)
└── TelaFim (CenterContainer) %         ← Full Rect, Visible desligado
    └── Painel (PanelContainer) → MarginContainer → VBoxContainer
        ├── Titulo, Resultado (Label) %, JogarDeNovo (Button)
```

`%` = clique direito → **Access as Unique Name**. Assim o script usa `%Pontos` sem se importar com o caminho.

```gdscript
class_name HUD
extends CanvasLayer

signal comecar_pressionado

func atualizar_pontos(p: int) -> void:
	%Pontos.text = "★ %d" % p

func _on_jogar_pressed() -> void:      # conecte os DOIS botões aqui
	%TelaInicio.hide()
	%TelaFim.hide()
	comecar_pressionado.emit()
```

A `main.gd` escuta `comecar_pressionado` para iniciar o spawner (veja o gabarito).

## Temas (Theme)

Em vez de mudar fonte/cor em cada nó, crie um **Theme** (`.tres`):
1. No FileSystem: clique direito → *New Resource* → `Theme` → `tema.tres`.
2. Abra-o: o editor de tema aparece embaixo. Adicione tipos (`Button`, `Label`) e defina fontes, cores, estilos.
3. Aplique no nó raiz da UI (propriedade **Theme**) — todos os filhos herdam.
4. Ou globalmente: *Project Settings → GUI → Theme → Custom*.

Fontes pixel art gratuitas: procure em [Google Fonts](https://fonts.google.com/?query=pixel) ("Press Start 2P", "Silkscreen")
ou fontes CC0 da [Kenney](https://kenney.nl/assets/kenney-fonts).

## Dicas de UI mobile

- **Alvos de toque ≥ 48 dp** (na nossa resolução 720px de largura, botões de ~100px de altura são confortáveis).
- O polegar alcança bem a **parte de baixo** da tela. Botões de ação embaixo, informação em cima.
- Evite colocar coisas importantes nos cantos superiores (câmera/notch) — veja *safe area* na lição 08.
- Feedback visual ao tocar: o `Button` já muda no estado *pressed*; com Theme você estiliza.

## 🏋️ Exercícios

1. Monte o HUD com telas de início e fim e ligue ao jogo.
2. Troque o texto de vidas por ícones: um `HBoxContainer` com `TextureRect` de corações que você esconde/mostra.
3. Adicione um botão de **pausa** (canto superior direito) que abre um painel "Continuar / Sair".
   Dica: `get_tree().paused = true` e mude o **Process → Mode** do painel de pausa para `Always`.
4. **Desafio**: crie um `Theme` com uma fonte pixel art e `StyleBoxTexture`/NinePatch desenhado no Aseprite.

## ✅ Eu sei...

- [ ] usar âncoras e containers em vez de posicionar à mão
- [ ] por que a UI vai num `CanvasLayer`
- [ ] usar nós com nome único (`%`)
- [ ] pausar o jogo e manter a UI funcionando
- [ ] criar e aplicar um Theme

➡️ Próxima: [08 · Mobile: telas, toque e desempenho](08-mobile-telas-toque-desempenho.md)
