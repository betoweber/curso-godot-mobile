# 06 · Sprites do Aseprite e animação

> ⏱️ ~3h · 🎯 Levar sua pixel art para o Godot do jeito certo

## Configuração para pixel art

Pixel art borrada é o erro nº 1. No projeto:

| Configuração | Valor |
|---|---|
| Rendering → Textures → Canvas Textures → Default Texture Filter | **Nearest** |
| (opcional, visual "retrô" estrito) Display → Window → Stretch → Mode | `viewport` |
| (opcional) Display → Window → Stretch → Scale Mode | `integer` |
| (opcional) Rendering → 2D → Snap → Snap 2D Transforms to Pixel | ✅ |

> **canvas_items vs viewport**: `canvas_items` desenha em alta resolução (texto nítido, movimento suave).
> `viewport` renderiza na resolução baixa e amplia — pixels perfeitamente quadrados, visual retrô.
> Para pixel art "pura" use `viewport` com uma resolução base pequena (ex: 180×320) e Scale Mode `integer`.
> Para um jogo mobile misto (pixel art + UI nítida), `canvas_items` com filtro Nearest funciona bem.

## Do Aseprite para o Godot

### Opção A — Sprite único (estático)

1. No Aseprite: **File → Export As...** → `nave.png` (escala 1×; o Godot amplia).
2. Copie para `assets/sprites/`. O Godot importa sozinho.
3. Troque o `Polygon2D` da nave por um `Sprite2D` com essa textura. Ajuste `scale` se precisar.

### Opção B — Sprite sheet animado (recomendado)

1. No Aseprite, com as animações em **tags** (ex: `idle`, `turbo`):
   **File → Export Sprite Sheet** → Layout: *By Rows* ou *Horizontal Strip*; marque **JSON Data** se quiser o plugin.
2. No Godot, use `AnimatedSprite2D`:
   - Inspector → **Sprite Frames** → *New SpriteFrames* → clique para abrir o painel **SpriteFrames** embaixo.
   - Crie as animações (`idle`, `turbo`), clique no ícone de grade (**Add frames from Sprite Sheet**),
     informe colunas/linhas e selecione os quadros.
   - Ajuste FPS e Loop de cada animação.
3. No código: `$AnimatedSprite2D.play("turbo")`.

### Opção C — Plugin Aseprite Wizard ⭐

O plugin **Aseprite Wizard** importa arquivos `.aseprite` direto, com as tags
virando animações. Instale pela aba **AssetLib** do editor → busque "Aseprite Wizard" → Install →
ative em *Project Settings → Plugins*. Configure o caminho do Aseprite: no Mac,
`/Applications/Aseprite.app/Contents/MacOS/aseprite`.

Vantagem: você edita no Aseprite, salva, e o Godot atualiza sozinho.

## AnimationPlayer: anime QUALQUER coisa

`AnimatedSprite2D` troca quadros. `AnimationPlayer` anima **qualquer propriedade** de qualquer nó numa linha
do tempo: posição, cor, escala, visibilidade, até chamar funções.

Experimente na nave:
1. Adicione um `AnimationPlayer` à cena do jogador.
2. No painel Animation (embaixo), crie a animação `dano`.
3. Selecione o Sprite, clique no ícone de 🔑 ao lado de **Modulate** no Inspector para criar uma chave em 0s (branco),
   mova o cursor para 0.1s, mude para vermelho, crie outra chave; volte ao branco em 0.2s.
4. No código: `$AnimationPlayer.play("dano")`.

> **Tween vs AnimationPlayer**: Tween é criado por código, ótimo para coisas dinâmicas (o gabarito usa Tweens).
> AnimationPlayer é visual e melhor para animações elaboradas e fixas. Use os dois!

## Ideias de sprites para criar no Aseprite

| Sprite | Tamanho | Animações |
|---|---|---|
| nave | 32×32 | `idle` (2 frames, chama do motor), `turbo` |
| estrela | 16×16 | `brilho` (4 frames girando/piscando) |
| meteoro | 24×24 | `gira` (4 frames) |
| fundo | 180×320 | parallax opcional: 2–3 camadas de estrelas |

Paleta: limite-se a 8–16 cores (ex: [Lospec](https://lospec.com/palette-list)) para dar unidade.

## 🏋️ Exercícios

1. Troque nave, estrela e meteoro por sprites seus.
2. Faça a nave tocar `turbo` quando estiver se movendo rápido e `idle` quando parada
   (lembra do `animacao_para()` do ex09? mesma ideia).
3. **Desafio**: crie um fundo com **parallax** — use o nó `Parallax2D` com 2 camadas de estrelas em velocidades diferentes
   (`autoscroll` no eixo Y).

## ✅ Eu sei...

- [ ] configurar filtro Nearest para pixel art
- [ ] exportar sprite sheet do Aseprite e montar SpriteFrames
- [ ] usar `AnimatedSprite2D.play()`
- [ ] animar propriedades com `AnimationPlayer`

➡️ Próxima: [07 · Interface: HUD, menus e telas](07-ui-hud-telas.md)
