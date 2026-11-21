# Cola de GDScript (Godot 4)

```gdscript
class_name Inimigo                      # registra o tipo globalmente (opcional)
extends CharacterBody2D                 # qual nó este script estende

signal morreu(pontos: int)              # sinal com parâmetro

enum Estado { PATRULHA, PERSEGUINDO }

const VELOCIDADE_MAX := 200.0
@export var vida := 3                   # editável no Inspector
@export_range(0, 500) var alcance := 120.0
@export var alvo: Node2D                # arraste um nó no Inspector
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var placar: Label = %Placar    # nó com nome único

var estado := Estado.PATRULHA
var _privada := 0                       # convenção: _ = uso interno


func _ready() -> void:
	add_to_group("inimigos")
	$Timer.timeout.connect(_on_timer_timeout)


func _physics_process(delta: float) -> void:
	match estado:
		Estado.PATRULHA:
			velocity.x = 50
		Estado.PERSEGUINDO:
			velocity = global_position.direction_to(alvo.global_position) * VELOCIDADE_MAX
	move_and_slide()


func levar_dano(qtd: int = 1) -> void:
	vida -= qtd
	if vida <= 0:
		morreu.emit(10)
		queue_free()


func _on_timer_timeout() -> void:
	pass
```

## Tipos e coleções

```gdscript
var a: Array[int] = [1, 2, 3]
a.append(4); a.erase(2); a.has(3); a.size(); a.is_empty(); a.pick_random(); a.shuffle()
a.filter(func(x): return x > 1); a.map(func(x): return x * 2); a.reduce(func(acc, x): return acc + x, 0)

var d := {"ouro": 10, "nome": "Ana"}
d["ouro"]; d.get("xp", 0); d.has("nome"); d.keys(); d.values(); d.erase("nome")
for chave in d: print(chave, d[chave])

var t: Dictionary[String, int] = {}   # dicionário tipado (Godot 4.4+)
```

## Matemática de jogo

```gdscript
randf()                     # 0.0..1.0
randf_range(-1.0, 1.0)
randi_range(1, 6)           # dado
clampf(x, 0.0, 1.0)  /  clampi(n, 0, 10)
lerpf(a, b, 0.1)            # interpolação
move_toward(atual, alvo, passo)
lerp_angle(a, b, t)         # interpola ângulos pelo caminho mais curto
deg_to_rad(90)  /  rad_to_deg(PI)
snappedf(3.14159, 0.01)     # 3.14
abs(x), sign(x), sqrt(x), pow(x, 2), sin(t), cos(t), atan2(y, x)

v.length(), v.normalized(), v.distance_to(w), v.direction_to(w), v.angle(), v.rotated(r)
Vector2.from_angle(r)  # vetor unitário com ângulo r
v.limit_length(100)
```

## Nós e árvore

```gdscript
var n := CENA.instantiate()
add_child(n)
n.queue_free()                       # remove com segurança no fim do frame
get_tree().get_nodes_in_group("inimigos")
get_tree().call_group("inimigos", "levar_dano", 1)
get_tree().paused = true
get_tree().change_scene_to_file("res://menu.tscn")
get_tree().create_timer(1.0).timeout   # use com await
is_instance_valid(n)                 # o nó ainda existe?
```

## Espera e tempo

```gdscript
await get_tree().create_timer(0.5).timeout
await $AnimationPlayer.animation_finished
await tween.finished
await get_tree().process_frame        # espera 1 frame
```

## Tween

```gdscript
var t := create_tween()
t.tween_property(self, "position:y", 100.0, 0.3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
t.tween_interval(0.2)
t.tween_callback(queue_free)
create_tween().set_parallel().set_loops()   # paralelo e em loop
```

## Entrada

```gdscript
Input.is_action_pressed("pular")         # segurando
Input.is_action_just_pressed("pular")    # neste frame
Input.get_axis("esq", "dir")             # -1..1
Input.get_vector("esq", "dir", "cima", "baixo")  # Vector2 normalizado

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed: ...
	if event is InputEventScreenDrag: event.relative   # quanto o dedo andou
	if event.is_action_pressed("pausar"): ...
```

## Depurar

```gdscript
print("x = ", x)            # Output
print_debug(x)              # + arquivo e linha
push_warning("cuidado")     # aparece no Debugger
assert(vida >= 0, "vida negativa!")   # só em debug
breakpoint                  # pausa aqui (como um breakpoint no editor)
```

## Godot 3 → 4 (para tutoriais antigos)

| Godot 3 | Godot 4 |
|---|---|
| `KinematicBody2D` | `CharacterBody2D` |
| `export var` / `onready var` | `@export var` / `@onready var` |
| `yield(obj, "sinal")` | `await obj.sinal` |
| `connect("sinal", self, "metodo")` | `sinal.connect(metodo)` |
| `emit_signal("sinal")` | `sinal.emit()` |
| `move_and_slide(velocidade, Vector2.UP)` | `velocity = ...; move_and_slide()` |
| `instance()` | `instantiate()` |
| `Spatial` | `Node3D` |
| `rand_range()` | `randf_range()` |
| `Tween` como nó | `create_tween()` |
