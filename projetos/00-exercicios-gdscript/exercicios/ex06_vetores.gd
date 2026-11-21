extends RefCounted
# =============================================================================
# EXERCÍCIO 06 — Vector2: a matemática que você mais vai usar em jogos 2D
#
#     var pos := Vector2(100, 50)
#     pos.x, pos.y
#     pos + Vector2(10, 0)          # soma
#     pos * 2                       # escala
#     pos.length()                  # comprimento (magnitude)
#     pos.normalized()              # mesmo sentido, comprimento 1
#     a.distance_to(b)              # distância entre pontos
#     a.direction_to(b)             # vetor unitário de a até b
#     a.move_toward(b, passo)       # anda até `passo` em direção a b
#
# ATENÇÃO: no Godot 2D o eixo Y cresce para BAIXO. Vector2.UP == (0, -1).
# Tente resolver primeiro com a matemática "crua" (subtração, length()),
# depois troque pelas funções prontas.
# =============================================================================


func distancia(a: Vector2, b: Vector2) -> float:
	return 0.0  # TODO


## Vetor de comprimento 1 apontando de `de` para `para`.
func direcao(de: Vector2, para: Vector2) -> Vector2:
	return Vector2.ZERO  # TODO


## Move `posicao` no máximo `passo` unidades em direção ao alvo, sem passar dele.
## (É isso que um inimigo faz a cada frame para perseguir o jogador.)
func mover_para(posicao: Vector2, alvo: Vector2, passo: float) -> Vector2:
	return posicao  # TODO


## true se a distância entre a e b for menor ou igual ao raio.
func esta_perto(a: Vector2, b: Vector2, raio: float) -> bool:
	return false  # TODO
