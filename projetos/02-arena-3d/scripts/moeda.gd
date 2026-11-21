class_name Moeda
extends Area3D
## Moeda que gira e flutua. Some quando o jogador encosta.

signal coletada

var _tempo := randf() * TAU
@onready var _altura_base := position.y


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _process(delta: float) -> void:
	_tempo += delta
	rotate_y(3.0 * delta)
	position.y = _altura_base + sin(_tempo * 3.0) * 0.15


func _on_body_entered(body: Node3D) -> void:
	if body is Jogador3D:
		coletada.emit()
		set_deferred("monitoring", false)
		var tween := create_tween()
		tween.tween_property(self, "scale", Vector3.ONE * 0.01, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
		tween.tween_callback(queue_free)
