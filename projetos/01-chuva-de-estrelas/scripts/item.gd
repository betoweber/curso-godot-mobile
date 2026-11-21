class_name Item
extends Area2D
## Algo que cai do céu: uma estrela (boa) ou um meteoro (ruim).
## O visual é desenhado por código com _draw() — na lição 05 você troca
## por um sprite feito no Aseprite.

enum Tipo { ESTRELA, METEORO }

@export var tipo := Tipo.ESTRELA
@export var velocidade := 300.0

var _girar := 0.0


var _explodiu := false


func _ready() -> void:
	_girar = randf_range(-3.0, 3.0)
	if tipo == Tipo.METEORO:
		velocidade *= randf_range(1.0, 1.4)
	queue_redraw()


func _process(delta: float) -> void:
	position.y += velocidade * delta
	rotation += _girar * delta
	# Saiu pela parte de baixo da tela? Remove da memória.
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()


func _draw() -> void:
	if _explodiu:
		return  # não desenha nada: só as partículas aparecem
	if tipo == Tipo.ESTRELA:
		var pontos := PackedVector2Array()
		for i in 10:
			var raio := 34.0 if i % 2 == 0 else 15.0
			var angulo := TAU * i / 10.0 - PI / 2.0
			pontos.append(Vector2.from_angle(angulo) * raio)
		draw_colored_polygon(pontos, Color("ffd166"))
	else:
		draw_circle(Vector2.ZERO, 32, Color("8d6e63"))
		draw_circle(Vector2(-10, -8), 8, Color("6d4c41"))
		draw_circle(Vector2(12, 10), 6, Color("6d4c41"))


func coletar() -> void:
	set_deferred("monitorable", false)  # evita pegar duas vezes
	var tween := create_tween().set_parallel()
	tween.tween_property(self, "scale", Vector2(1.8, 1.8), 0.15)
	tween.tween_property(self, "modulate:a", 0.0, 0.15)
	tween.chain().tween_callback(queue_free)


func explodir() -> void:
	set_deferred("monitorable", false)
	var particulas: CPUParticles2D = $Particulas
	particulas.emitting = true
	_explodiu = true
	queue_redraw()
	velocidade = 0.0
	_girar = 0.0
	await particulas.finished
	queue_free()
