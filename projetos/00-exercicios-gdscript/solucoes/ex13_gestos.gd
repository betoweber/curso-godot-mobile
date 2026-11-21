extends RefCounted
# GABARITO

const DISTANCIA_MINIMA_SWIPE := 20.0
const TEMPO_SEGURAR := 0.5


func classificar_gesto(inicio: Vector2, fim: Vector2, duracao: float) -> String:
	var delta := fim - inicio
	if delta.length() < DISTANCIA_MINIMA_SWIPE:
		return "segurar" if duracao >= TEMPO_SEGURAR else "toque"
	if abs(delta.x) > abs(delta.y):
		return "swipe_direita" if delta.x > 0 else "swipe_esquerda"
	return "swipe_baixo" if delta.y > 0 else "swipe_cima"


func fator_pinca(distancia_inicial: float, distancia_atual: float) -> float:
	if distancia_inicial <= 0.0:
		return 1.0
	return distancia_atual / distancia_inicial


func aplicar_zoom(zoom_atual: float, fator: float, minimo: float, maximo: float) -> float:
	return clampf(zoom_atual * fator, minimo, maximo)
