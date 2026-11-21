# 05 · Instâncias por código, timers e colisões

> ⏱️ ~3h · 🎯 Criar objetos durante o jogo e detectar quando se tocam

## Passo 1 — A cena do item

`cenas/item.tscn`:

```
Item (Area2D)          ← item.gd
└── CollisionShape2D   ← CircleShape2D raio 28
```

Um único tipo de cena para estrela **e** meteoro, escolhido por um `enum` exportado:

```gdscript
class_name Item
extends Area2D

enum Tipo { ESTRELA, METEORO }

@export var tipo := Tipo.ESTRELA
@export var velocidade := 300.0

func _ready() -> void:
	queue_redraw()   # pede para chamar _draw()

func _process(delta: float) -> void:
	position.y += velocidade * delta
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()     # saiu da tela → libera a memória (importante no celular!)

func _draw() -> void:
	if tipo == Tipo.ESTRELA:
		draw_circle(Vector2.ZERO, 30, Color.GOLD)
	else:
		draw_circle(Vector2.ZERO, 32, Color.SADDLE_BROWN)
```

> `_draw()` desenha formas por código. O gabarito desenha uma estrela de 5 pontas com `draw_colored_polygon` — tente!

## Passo 2 — Spawner com Timer

Na `main.tscn`, adicione um `Timer` chamado `Spawner` (Wait Time `0.9`, Autostart ✅) e conecte `timeout`:

```gdscript
extends Node2D

const ITEM_CENA := preload("res://cenas/item.tscn")

func _on_spawner_timeout() -> void:
	var item: Item = ITEM_CENA.instantiate()      # cria uma cópia da cena
	item.tipo = Item.Tipo.METEORO if randf() < 0.35 else Item.Tipo.ESTRELA
	item.position = Vector2(randf_range(50, 670), -60)
	$Itens.add_child(item)                         # só aparece depois de entrar na árvore
```

`preload` carrega quando o script é carregado (rápido, recomendado para coisas sempre usadas).
`load` carrega na hora que a linha roda.

## Passo 3 — Colisão

`Area2D` emite sinais quando algo entra:
- `area_entered(area)` — outra **Area2D** entrou
- `body_entered(body)` — um **corpo físico** (CharacterBody2D, RigidBody2D, StaticBody2D) entrou

No jogador:

```gdscript
signal pegou_estrela
signal foi_atingido

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if not area is Item:
		return
	if area.tipo == Item.Tipo.ESTRELA:
		pegou_estrela.emit()
	else:
		foi_atingido.emit()
	area.queue_free()
```

E a `main.gd` conecta esses sinais para contar pontos (por enquanto num `print`).

### Camadas de colisão (Collision Layers & Masks)

No Inspector de qualquer `CollisionObject2D`:
- **Layer** = "em quais camadas EU estou"
- **Mask** = "quais camadas EU enxergo"

Dê nomes às camadas em *Project Settings → Layer Names → 2D Physics* (ex: 1=jogador, 2=itens, 3=inimigos).
Em jogos maiores isso evita checagens desnecessárias (e é mais rápido — importante no celular).

## Passo 4 — Dificuldade progressiva

Guarde os pontos na `main.gd` e use-os para acelerar o jogo:

```gdscript
item.velocidade = 300.0 + pontos * 6.0
$Spawner.wait_time = max(0.35, 0.9 - pontos * 0.01)
```

## 🐞 Depuração

- **Debug → Visible Collision Shapes**: mostra as formas de colisão rodando o jogo.
- `print()` e `print_debug()` (mostra também arquivo e linha).
- Clique na margem esquerda do script para criar um **breakpoint** (bolinha vermelha). O jogo pausa ali e você
  inspeciona variáveis na aba Debugger.
- **Debugger → Monitors**: FPS, memória, contagem de objetos. Se `Object Count` só cresce, você esqueceu um `queue_free()`.

## 🏋️ Exercícios

1. Adicione um terceiro tipo: **coração** (raro, 5%) que recupera vida.
2. Faça os meteoros caírem em leve diagonal (velocidade X aleatória pequena).
3. **Desafio**: crie `VisibleOnScreenNotifier2D` no item e use o sinal `screen_exited` em vez de checar `position.y`.
   Qual abordagem você prefere e por quê?

🧪 **Exercício automático ex15 (cooldown)**: uma classe de recarga — perfeita para um tiro da nave com intervalo
mínimo. Faça e depois use no seu jogo (ex: tocar na tela atira, no máximo 3 tiros por segundo).

## ✅ Eu sei...

- [ ] instanciar cenas com `preload` + `instantiate()` + `add_child()`
- [ ] usar `Timer` e seu sinal `timeout`
- [ ] a diferença entre `area_entered` e `body_entered`
- [ ] para que servem Layer e Mask
- [ ] usar `queue_free()` para liberar memória
- [ ] ver as colisões e usar breakpoints

➡️ Próxima: [06 · Sprites do Aseprite e animação](06-sprites-aseprite-animacao.md)
