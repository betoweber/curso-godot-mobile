extends RefCounted
# GABARITO

func soma_ate(n: int) -> int:
	var total := 0
	for i in range(1, n + 1):
		total += i
	return total


func contar_vogais(texto: String) -> int:
	var vogais := "aeiou"
	var contador := 0
	for letra in texto.to_lower():
		if letra in vogais:
			contador += 1
	return contador


func contagem_regressiva(de: int) -> Array:
	var resultado := []
	var i := de
	while i > 0:
		resultado.append(i)
		i -= 1
	return resultado
	# Alternativa: return range(de, 0, -1)


func fizzbuzz(n: int) -> Array[String]:
	var resultado: Array[String] = []
	for i in range(1, n + 1):
		if i % 15 == 0:
			resultado.append("FizzBuzz")
		elif i % 3 == 0:
			resultado.append("Fizz")
		elif i % 5 == 0:
			resultado.append("Buzz")
		else:
			resultado.append(str(i))
	return resultado
