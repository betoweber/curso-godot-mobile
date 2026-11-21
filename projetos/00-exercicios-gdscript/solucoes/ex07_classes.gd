extends RefCounted
# GABARITO

var nome: String
var vida: int
var vida_max: int


func _init(p_nome: String, p_vida_max: int) -> void:
	nome = p_nome
	vida_max = p_vida_max
	vida = p_vida_max


func levar_dano(quantidade: int) -> void:
	vida = max(vida - quantidade, 0)


func curar(quantidade: int) -> void:
	vida = min(vida + quantidade, vida_max)
	# Ou: vida = clampi(vida + quantidade, 0, vida_max)


func esta_vivo() -> bool:
	return vida > 0
