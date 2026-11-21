extends RefCounted
# GABARITO

func ordenar_ranking(jogadores: Array) -> Array:
	var copia := jogadores.duplicate()
	copia.sort_custom(func(a, b):
		if a.pontos != b.pontos:
			return a.pontos > b.pontos
		return a.nome < b.nome
	)
	return copia


func nomes_acima_de(jogadores: Array, minimo: int) -> Array:
	return jogadores.filter(func(j): return j.pontos >= minimo).map(func(j): return j.nome)


func criar_multiplicador(fator: int) -> Callable:
	return func(x): return x * fator
