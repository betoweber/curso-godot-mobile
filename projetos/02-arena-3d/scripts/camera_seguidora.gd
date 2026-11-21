extends Camera3D
## Câmera que segue um alvo de longe, mantendo o mesmo ângulo (estilo isométrico).

@export var alvo: Node3D
@export var distancia := Vector3(0, 9, 8)
@export var suavidade := 5.0


func _ready() -> void:
	if alvo:
		global_position = alvo.global_position + distancia
		look_at(alvo.global_position)


func _physics_process(delta: float) -> void:
	if alvo == null:
		return
	var destino := alvo.global_position + distancia
	global_position = global_position.lerp(destino, 1.0 - exp(-suavidade * delta))
