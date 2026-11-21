extends RefCounted
# =============================================================================
# EXERCÍCIO 10 — Lambdas, ordenação e funções como valores   (nível 2)
# Lição: 03 (extra)
#
# Em GDScript, funções são valores (tipo Callable). Uma lambda é uma função sem nome:
#     var dobrar := func(x): return x * 2
#     dobrar.call(5)                       # 10
#
# Arrays aceitam lambdas:
#     a.sort_custom(func(x, y): return x > y)   # ordena decrescente (retorne true se x vem ANTES de y)
#     a.filter(func(x): return x > 0)
#     a.map(func(x): return x * 10)
#
# Lambdas de várias linhas:
#     a.sort_custom(func(x, y):
#         if x.pontos != y.pontos:
#             return x.pontos > y.pontos
#         return x.nome < y.nome
#     )
#
# Dicionários: j.pontos é o mesmo que j["pontos"].
# =============================================================================


## Recebe [{"nome": "Ana", "pontos": 50}, ...] e retorna um array NOVO ordenado
## por pontos (maior primeiro). Empate: ordem alfabética do nome.
## O array original não pode ser alterado (dica: duplicate()).
func ordenar_ranking(jogadores: Array) -> Array:
	return []  # TODO


## Nomes dos jogadores com pontos >= minimo, na ordem original.
## Desafio: uma linha só, com filter + map.
func nomes_acima_de(jogadores: Array, minimo: int) -> Array:
	return []  # TODO


## Retorna uma FUNÇÃO que multiplica seu argumento por `fator`.
##   var triplo = criar_multiplicador(3)
##   triplo.call(4)  -> 12
## (A lambda "lembra" o valor de fator — isso se chama closure.)
func criar_multiplicador(fator: int) -> Callable:
	return func(x): return x  # TODO
