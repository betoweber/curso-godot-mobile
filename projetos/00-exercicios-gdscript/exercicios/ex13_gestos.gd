extends RefCounted
# =============================================================================
# EXERCÍCIO 13 — Reconhecendo gestos de toque   (nível 2)
# Lição: 08 (mobile)
#
# No jogo real você guarda a posição/tempo do InputEventScreenTouch quando
# o dedo encosta (pressed = true) e quando solta (pressed = false), e chama
# classificar_gesto(). Tempo atual: Time.get_ticks_msec() / 1000.0
#
# Lembre: no 2D o Y cresce para BAIXO.
# =============================================================================

const DISTANCIA_MINIMA_SWIPE := 20.0   # pixels
const TEMPO_SEGURAR := 0.5             # segundos


## Regras:
##   - andou menos que DISTANCIA_MINIMA_SWIPE:
##         "segurar" se duracao >= TEMPO_SEGURAR, senão "toque"
##   - senão, o eixo que mais andou decide:
##         horizontal -> "swipe_direita" / "swipe_esquerda"
##         vertical   -> "swipe_baixo"   / "swipe_cima"
func classificar_gesto(inicio: Vector2, fim: Vector2, duracao: float) -> String:
	return ""  # TODO


## Pinça (zoom com dois dedos): quanto a distância entre os dedos mudou.
## 100 -> 150 = 1.5 (afastou, zoom in). Se distancia_inicial <= 0, retorne 1.0.
func fator_pinca(distancia_inicial: float, distancia_atual: float) -> float:
	return 0.0  # TODO


## Aplica o fator ao zoom, limitado entre minimo e maximo.
func aplicar_zoom(zoom_atual: float, fator: float, minimo: float, maximo: float) -> float:
	return 0.0  # TODO
