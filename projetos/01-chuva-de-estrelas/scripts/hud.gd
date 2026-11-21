class_name HUD
extends CanvasLayer
## Interface: placar, vidas, tela inicial e tela de fim de jogo.
## CanvasLayer desenha por cima do jogo e NÃO se move com a câmera.

signal comecar_pressionado

@onready var label_pontos: Label = %Pontos
@onready var label_vidas: Label = %Vidas
@onready var tela_inicio: Control = %TelaInicio
@onready var tela_fim: Control = %TelaFim
@onready var label_resultado: Label = %Resultado
@onready var label_recorde: Label = %Recorde


func _ready() -> void:
	Jogo.pontos_mudaram.connect(func(p): label_pontos.text = "★ %d" % p)
	Jogo.vidas_mudaram.connect(func(v): label_vidas.text = "♥".repeat(v))
	Jogo.fim_de_jogo.connect(_mostrar_fim)
	label_recorde.text = "Recorde: %d" % Jogo.recorde
	tela_inicio.show()
	tela_fim.hide()


func _on_jogar_pressed() -> void:
	tela_inicio.hide()
	tela_fim.hide()
	comecar_pressionado.emit()


func _mostrar_fim() -> void:
	label_resultado.text = "Você fez %d pontos\nRecorde: %d" % [Jogo.pontos, Jogo.recorde]
	tela_fim.show()
	# Animação de entrada com Tween
	tela_fim.modulate.a = 0.0
	create_tween().tween_property(tela_fim, "modulate:a", 1.0, 0.3)
