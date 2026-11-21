# 04 · Primeiro jogo 2D: a nave que segue o dedo

> ⏱️ ~3h · 🎯 Começar a construir **Chuva de Estrelas** do zero, já pensando em celular
> 📁 Gabarito: `projetos/01-chuva-de-estrelas`

Das lições 04 a 10 você vai **reconstruir** o jogo de referência por conta própria, em
`meus-projetos/chuva-de-estrelas`. Tente sem olhar o gabarito; consulte quando travar.

## Passo 1 — Projeto configurado para celular

1. Novo projeto em `meus-projetos/chuva-de-estrelas`, renderer **Compatibility**
   (roda em praticamente todo Android/iPhone, inclusive os mais antigos — ótimo para 2D).
2. **Project → Project Settings** (ligue *Advanced Settings* no canto superior direito):

| Configuração | Valor | Por quê |
|---|---|---|
| Display → Window → Size → Viewport Width / Height | `720` / `1280` | resolução "de design" em retrato |
| Display → Window → Size → Window Width/Height Override | `405` / `720` | janela menor no Mac (só no desktop) |
| Display → Window → Stretch → Mode | `canvas_items` | escala o jogo para qualquer tela |
| Display → Window → Stretch → Aspect | `expand` | telas mais altas/largas mostram mais área, sem barras pretas |
| Display → Window → Handheld → Orientation | `Portrait` | trava o celular em retrato |
| Input Devices → Pointing → Emulate Touch From Mouse | ✅ | o mouse gera eventos de toque no Mac |

> A lição 08 aprofunda resolução e telas diferentes. Por enquanto, confie nessas configurações.

## Passo 2 — A cena do jogador

Crie `cenas/jogador.tscn`:

```
Jogador (Area2D)            ← script jogador.gd
├── Visual (Polygon2D)      ← desenhe um triângulo (nave) clicando pontos no editor
└── CollisionShape2D        ← Shape: CircleShape2D, raio ~30
```

Por que `Area2D` e não `CharacterBody2D`? A nave não precisa bater em paredes nem ter física — só
**detectar** quando algo encosta. `Area2D` é perfeito para isso (e mais leve).

> 💡 Ainda não tem arte? Use `Polygon2D` ou `ColorRect`. Na lição 06 você troca por sprites do Aseprite.
> Protótipo feio primeiro, arte depois — isso é prática real da indústria.

## Passo 3 — Seguindo o dedo

O celular gera dois eventos principais:

| Evento | Quando |
|---|---|
| `InputEventScreenTouch` | dedo encostou (`pressed == true`) ou soltou (`pressed == false`) |
| `InputEventScreenDrag` | dedo arrastou |

Ambos têm `position` (onde na tela) e `index` (qual dedo — para multitoque).

```gdscript
extends Area2D

var alvo_x := 0.0

func _ready() -> void:
	position.y = get_viewport_rect().size.y - 180.0   # perto da base, em qualquer tela
	alvo_x = position.x

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		alvo_x = event.position.x
	elif event is InputEventScreenDrag:
		alvo_x = event.position.x

func _process(delta: float) -> void:
	position.x = move_toward(position.x, alvo_x, 1200 * delta)
```

Teste com o mouse no Mac (graças ao *Emulate Touch From Mouse*).

### Melhorias (faça uma de cada vez e sinta a diferença)

1. **Limitar às bordas**: `alvo_x = clampf(alvo_x, 50, largura - 50)`.
2. **Teclado** para testar: `Input.get_axis("ui_left", "ui_right")` devolve -1, 0 ou 1.
3. **Movimento suave** com `lerp` em vez de velocidade constante:
   ```gdscript
   position.x = lerpf(position.x, alvo_x, 1.0 - exp(-14.0 * delta))
   ```
   (Isso anda uma *fração* da distância a cada frame: rápido quando longe, suave ao chegar.)
4. **Inclinar a nave** na direção do movimento: `$Visual.rotation = (alvo_x - position.x) * 0.004`.

## Passo 4 — Cena principal

```
Main (Node2D)        ← main.gd (vazio por enquanto)
├── Itens (Node2D)   ← onde os itens caindo vão morar (próxima lição)
└── Jogador          ← instância de jogador.tscn
```

Defina `main.tscn` como cena principal (*Project Settings → Application → Run → Main Scene*). Rode!

## 🏋️ Exercícios

1. Faça a nave também se mover um pouco no eixo Y (até 200 px acima da posição inicial), seguindo o dedo.
2. Mostre num `Label` a posição do toque atual (útil para depurar).
3. **Desafio**: mude o controle para "botões" — tocar na metade esquerda da tela move para a esquerda,
   na direita move para a direita, enquanto o dedo estiver encostado. (Dica: guarde se o dedo está pressionado.)

## ✅ Eu sei...

- [ ] configurar um projeto mobile em retrato
- [ ] tratar `InputEventScreenTouch` e `InputEventScreenDrag`
- [ ] quando usar `Area2D`
- [ ] usar `lerp`/`move_toward`/`clamp` para movimento

➡️ Próxima: [05 · Instâncias por código, timers e colisões](05-spawner-e-colisoes.md)
