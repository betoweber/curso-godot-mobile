class_name Jogador3D
extends CharacterBody3D
## Personagem 3D. CharacterBody3D = corpo controlado por código
## (você define a velocidade, e move_and_slide() cuida das colisões).

@export var velocidade := 6.0
@export var forca_pulo := 7.0
@export var giro := 12.0  ## rapidez para virar na direção do movimento

## Pega a gravidade das configurações do projeto (padrão 9.8)
var gravidade: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var modelo: Node3D = $Modelo


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravidade * delta

	if Input.is_action_just_pressed("pular") and is_on_floor():
		velocity.y = forca_pulo

	# get_vector junta 4 ações num Vector2 (já normalizado). Funciona com
	# teclado, controle E com o joystick virtual (que "aperta" essas ações).
	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	# No 3D o chão é o plano XZ: x da entrada -> X, y da entrada -> Z
	var direcao := Vector3(entrada.x, 0, entrada.y)

	if direcao.length() > 0.01:
		velocity.x = direcao.x * velocidade
		velocity.z = direcao.z * velocidade
		# Vira o modelo suavemente para onde está andando
		var angulo_alvo := atan2(direcao.x, direcao.z)
		modelo.rotation.y = lerp_angle(modelo.rotation.y, angulo_alvo, giro * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, velocidade)
		velocity.z = move_toward(velocity.z, 0, velocidade)

	move_and_slide()

	# Caiu da arena? Volta para o centro.
	if global_position.y < -10:
		global_position = Vector3(0, 2, 0)
		velocity = Vector3.ZERO
