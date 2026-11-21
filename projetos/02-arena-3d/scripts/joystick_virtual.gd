class_name JoystickVirtual
extends Control
## Joystick virtual para celular.
## Em vez de expor um valor próprio, ele "aperta" as ações do Input Map
## com intensidade proporcional. Assim o código do jogador usa só
## Input.get_vector() e funciona igual com teclado, controle ou toque.

@export var raio := 110.0
@export var raio_bolinha := 50.0
@export var zona_morta := 0.15
@export var acao_esquerda := &"mover_esquerda"
@export var acao_direita := &"mover_direita"
@export var acao_cima := &"mover_frente"
@export var acao_baixo := &"mover_tras"
@export var so_em_touchscreen := false  ## true = esconde no computador

var _dedo := -1                 # índice do dedo que está controlando (-1 = nenhum)
var _centro := Vector2.ZERO     # onde o dedo encostou primeiro
var _vetor := Vector2.ZERO      # -1..1 em cada eixo


func _ready() -> void:
	if so_em_touchscreen and not DisplayServer.is_touchscreen_available():
		hide()


## _gui_input só recebe eventos que acontecem DENTRO da área deste Control.
## Assim o joystick ocupa, por exemplo, só a metade esquerda da tela.
func _gui_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.pressed and _dedo == -1:
			_dedo = event.index
			_centro = event.position
			_atualizar(event.position)
		elif not event.pressed and event.index == _dedo:
			_soltar()
		accept_event()
	elif event is InputEventScreenDrag and event.index == _dedo:
		_atualizar(event.position)
		accept_event()


func _atualizar(pos_dedo: Vector2) -> void:
	var deslocamento := (pos_dedo - _centro).limit_length(raio)
	_vetor = deslocamento / raio
	if _vetor.length() < zona_morta:
		_vetor = Vector2.ZERO
	_aplicar_acoes()
	queue_redraw()


func _soltar() -> void:
	_dedo = -1
	_vetor = Vector2.ZERO
	_aplicar_acoes()
	queue_redraw()


func _aplicar_acoes() -> void:
	_acao(acao_esquerda, -_vetor.x)
	_acao(acao_direita, _vetor.x)
	_acao(acao_cima, -_vetor.y)
	_acao(acao_baixo, _vetor.y)


func _acao(nome: StringName, forca: float) -> void:
	if forca > 0.0:
		Input.action_press(nome, forca)
	else:
		Input.action_release(nome)


func _draw() -> void:
	if _dedo == -1:
		# Dica visual de onde tocar
		var c := Vector2(raio + 40, size.y - raio - 40)
		draw_circle(c, raio, Color(1, 1, 1, 0.08))
		draw_arc(c, raio, 0, TAU, 48, Color(1, 1, 1, 0.25), 3.0)
		return
	draw_circle(_centro, raio, Color(1, 1, 1, 0.12))
	draw_arc(_centro, raio, 0, TAU, 48, Color(1, 1, 1, 0.4), 3.0)
	draw_circle(_centro + _vetor * raio, raio_bolinha, Color(1, 1, 1, 0.6))
