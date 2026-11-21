extends RefCounted
# GABARITO

var duracao: float
var restante := 0.0


func _init(p_duracao: float) -> void:
	duracao = p_duracao


func pode_usar() -> bool:
	return restante <= 0.0


func usar() -> bool:
	if not pode_usar():
		return false
	restante = duracao
	return true


func atualizar(delta: float) -> void:
	restante = maxf(restante - delta, 0.0)


func progresso() -> float:
	if duracao <= 0.0:
		return 1.0
	return 1.0 - restante / duracao
