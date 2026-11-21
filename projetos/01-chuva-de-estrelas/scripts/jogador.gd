class_name Jogador
extends Area2D
## A nave do jogador. Segue o dedo (toque/arrasto) ou as setas do teclado.

signal pegou_estrela
signal foi_atingido

@export var velocidade_teclado := 900.0  ## pixels por segundo
@export var suavidade := 14.0            ## quanto maior, mais rápido alcança o dedo
@export var margem := 50.0               ## distância mínima da borda da tela

var _alvo_x := 0.0
var _invencivel := false

@onready var visual: Polygon2D = $Visual


func _ready() -> void:
	# Posiciona a nave perto da base da tela (a altura varia entre celulares!)
	position.y = get_viewport_rect().size.y - 180.0
	_alvo_x = position.x
	area_entered.connect(_on_area_entered)


## _unhandled_input recebe eventos que a UI não consumiu (assim tocar num
## botão não move a nave). Com "emulate_touch_from_mouse" ligado nas
## configurações, o mouse também gera eventos de toque no computador.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		_alvo_x = event.position.x
	elif event is InputEventScreenDrag:
		_alvo_x = event.position.x


func _process(delta: float) -> void:
	# Teclado (útil para testar no Mac)
	var eixo := Input.get_axis("ui_left", "ui_right")
	if eixo != 0.0:
		_alvo_x += eixo * velocidade_teclado * delta

	var largura := get_viewport_rect().size.x
	_alvo_x = clampf(_alvo_x, margem, largura - margem)

	# lerp = interpolação: anda uma fração do caminho a cada frame (movimento suave)
	position.x = lerpf(position.x, _alvo_x, 1.0 - exp(-suavidade * delta))

	# Inclina a nave na direção do movimento (pequeno "juice")
	visual.rotation = clampf((_alvo_x - position.x) * 0.004, -0.4, 0.4)


func _on_area_entered(area: Area2D) -> void:
	if not Jogo.jogando:
		return
	if not area is Item:
		return
	# Depois do "is", o Godot sabe que area é um Item e conhece seus métodos.
	if area.tipo == Item.Tipo.ESTRELA:
		pegou_estrela.emit()
		area.coletar()
	elif not _invencivel:
		foi_atingido.emit()
		area.explodir()
		_piscar()


## Fica invencível por 1 segundo, piscando — usando um Tween.
func _piscar() -> void:
	_invencivel = true
	var tween := create_tween().set_loops(5)
	tween.tween_property(visual, "modulate:a", 0.2, 0.1)
	tween.tween_property(visual, "modulate:a", 1.0, 0.1)
	await tween.finished
	_invencivel = false
