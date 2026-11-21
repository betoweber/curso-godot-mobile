extends RefCounted
# GABARITO

func filtrar_pares(numeros: Array) -> Array:
	var pares := []
	for n in numeros:
		if n % 2 == 0:
			pares.append(n)
	return pares
	# Estilo funcional: return numeros.filter(func(n): return n % 2 == 0)


func maior_valor(numeros: Array) -> int:
	var maior: int = numeros[0]
	for n in numeros:
		if n > maior:
			maior = n
	return maior
	# Atalho: return numeros.max()


func dobrar_todos(numeros: Array) -> Array:
	# map() cria um array NOVO, então o original não é alterado.
	return numeros.map(func(n): return n * 2)


func media(numeros: Array) -> float:
	if numeros.is_empty():
		return 0.0
	var soma := 0.0
	for n in numeros:
		soma += n
	return soma / numeros.size()
