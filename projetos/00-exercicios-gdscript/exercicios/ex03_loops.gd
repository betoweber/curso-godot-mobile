extends RefCounted
# =============================================================================
# EXERCÍCIO 03 — Loops (for / while)
#
#     for i in 5:               # 0, 1, 2, 3, 4
#     for i in range(1, 6):     # 1, 2, 3, 4, 5   (o fim NÃO entra)
#     for i in range(10, 0, -2):# 10, 8, 6, 4, 2
#     for letra in "abc":       # "a", "b", "c"
#     for inimigo in inimigos:  # cada item de um array
#
#     while condicao:
#         ...
#
# Arrays: var lista := []   lista.append(42)
# =============================================================================


## Soma 1 + 2 + ... + n.  soma_ate(5) -> 15
func soma_ate(n: int) -> int:
	return 0  # TODO


## Conta quantas vogais (a, e, i, o, u) existem no texto.
## Dica: `letra in "aeiou"` funciona! E texto.to_lower() deixa tudo minúsculo.
func contar_vogais(texto: String) -> int:
	return 0  # TODO


## Retorna [de, de-1, ..., 1].  contagem_regressiva(3) -> [3, 2, 1]
## Tente com `while`.
func contagem_regressiva(de: int) -> Array:
	return []  # TODO


## O clássico! Para cada número de 1 até n:
##   múltiplo de 3 e 5 -> "FizzBuzz", de 3 -> "Fizz", de 5 -> "Buzz",
##   senão o próprio número como texto: str(i)
func fizzbuzz(n: int) -> Array[String]:
	var resultado: Array[String] = []
	# TODO
	return resultado
