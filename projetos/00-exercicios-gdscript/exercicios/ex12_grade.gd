extends RefCounted
# =============================================================================
# EXERCÍCIO 12 — Grades 2D (base de jogos de puzzle / match-3)   (nível 2)
# Lição: 13 (ideia "puzzle de deslizar")
#
# Uma grade é um array de linhas:  grade[y][x]
#     var grade := [
#         [1, 2, 2],     # y = 0
#         [3, 3, 3],     # y = 1
#     ]
#     grade[1][0]  -> 3       (linha 1, coluna 0)
#
# Vector2i é um Vector2 de inteiros — ótimo para posições em grades.
#     Vector2i.LEFT == Vector2i(-1, 0)    Vector2i.UP == Vector2i(0, -1)
#
# Neste exercício, 0 significa "casa vazia".
# =============================================================================


## Cria uma grade altura × largura preenchida com `valor`.
## CUIDADO: cada linha precisa ser um array DIFERENTE (não reaproveite o mesmo!).
func criar_grade(largura: int, altura: int, valor: int) -> Array:
	return []  # TODO


## true se (x, y) é uma posição válida da grade.
func dentro_da_grade(grade: Array, x: int, y: int) -> bool:
	return false  # TODO


## Quantos dos 4 vizinhos (esquerda, direita, cima, baixo) têm o mesmo valor que grade[y][x]?
## Vizinhos fora da grade não contam.
func contar_vizinhos_iguais(grade: Array, x: int, y: int) -> int:
	return 0  # TODO


## Encontra todas as posições que fazem parte de uma sequência HORIZONTAL de
## 3 ou mais valores iguais (ignorando 0). Ordem: linha por linha, da esquerda
## para a direita.
##   [[1, 1, 1, 2],
##    [0, 0, 0, 3]]   -> [Vector2i(0,0), Vector2i(1,0), Vector2i(2,0)]
func encontrar_trincas_horizontais(grade: Array) -> Array[Vector2i]:
	var resultado: Array[Vector2i] = []
	# TODO
	return resultado
