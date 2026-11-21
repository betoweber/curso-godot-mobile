extends RefCounted
# GABARITO

signal vida_mudou(nova_vida: int)
signal morreu

var vida := 3


func levar_dano(quantidade: int) -> void:
	if vida <= 0:
		return  # já está morto: não faz nada
	vida = max(vida - quantidade, 0)
	vida_mudou.emit(vida)
	if vida == 0:
		morreu.emit()
