extends Node3D
## Espalha moedas pela arena e conta os pontos.

const MOEDA := preload("res://cenas/moeda.tscn")

@export var quantidade_moedas := 12
@export var raio_arena := 9.0

var pontos := 0

@onready var label_pontos: Label = %Pontos
@onready var moedas: Node3D = $Moedas


func _ready() -> void:
	_espalhar_moedas()


func _espalhar_moedas() -> void:
	for i in quantidade_moedas:
		var moeda: Moeda = MOEDA.instantiate()
		var angulo := randf() * TAU
		var dist := randf_range(2.0, raio_arena)
		moeda.position = Vector3(cos(angulo) * dist, 1.0, sin(angulo) * dist)
		moeda.coletada.connect(_on_moeda_coletada)
		moedas.add_child(moeda)


func _on_moeda_coletada() -> void:
	pontos += 1
	label_pontos.text = "Moedas: %d / %d" % [pontos, quantidade_moedas]
	if pontos == quantidade_moedas:
		label_pontos.text = "Você pegou todas!"
		await get_tree().create_timer(2.0).timeout
		pontos = 0
		label_pontos.text = "Moedas: 0 / %d" % quantidade_moedas
		_espalhar_moedas()
