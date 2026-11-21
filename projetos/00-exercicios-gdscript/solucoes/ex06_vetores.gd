extends RefCounted
# GABARITO

func distancia(a: Vector2, b: Vector2) -> float:
	return a.distance_to(b)


func direcao(de: Vector2, para: Vector2) -> Vector2:
	return (para - de).normalized()
	# Ou: return de.direction_to(para)


func mover_para(posicao: Vector2, alvo: Vector2, passo: float) -> Vector2:
	return posicao.move_toward(alvo, passo)


func esta_perto(a: Vector2, b: Vector2, raio: float) -> bool:
	return a.distance_to(b) <= raio
