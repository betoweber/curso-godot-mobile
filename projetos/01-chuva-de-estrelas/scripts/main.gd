extends Node2D
## Cena principal: cria itens, liga os sinais e controla a dificuldade.

const ITEM_CENA := preload("res://cenas/item.tscn")

@export var chance_meteoro := 0.35

@onready var jogador: Jogador = $Jogador
@onready var spawner: Timer = $Spawner
@onready var camera: Camera2D = $Camera2D
@onready var hud: HUD = $HUD
@onready var itens: Node2D = $Itens

var _tremor := 0.0


func _ready() -> void:
	jogador.pegou_estrela.connect(_on_jogador_pegou_estrela)
	jogador.foi_atingido.connect(_on_jogador_foi_atingido)
	hud.comecar_pressionado.connect(_comecar)
	Jogo.fim_de_jogo.connect(_on_fim_de_jogo)


func _comecar() -> void:
	for item in itens.get_children():
		item.queue_free()
	Jogo.novo_jogo()
	spawner.wait_time = 0.9
	spawner.start()


func _on_spawner_timeout() -> void:
	var item: Item = ITEM_CENA.instantiate()
	item.tipo = Item.Tipo.METEORO if randf() < chance_meteoro else Item.Tipo.ESTRELA
	var largura := get_viewport_rect().size.x
	item.position = Vector2(randf_range(50, largura - 50), -60)
	# Fica mais difícil conforme os pontos aumentam
	item.velocidade = 300.0 + Jogo.pontos * 6.0
	itens.add_child(item)
	spawner.wait_time = max(0.35, 0.9 - Jogo.pontos * 0.01)


func _on_jogador_pegou_estrela() -> void:
	Jogo.pontos += 1


func _on_jogador_foi_atingido() -> void:
	Jogo.vidas -= 1
	_tremor = 18.0
	Input.vibrate_handheld(120)  # vibra o celular (ignorado no computador)


func _on_fim_de_jogo() -> void:
	spawner.stop()


func _process(delta: float) -> void:
	# Tremor de tela (screen shake): desloca a câmera aleatoriamente e vai diminuindo
	if _tremor > 0.0:
		camera.offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * _tremor
		_tremor = move_toward(_tremor, 0.0, 60.0 * delta)
	else:
		camera.offset = Vector2.ZERO
