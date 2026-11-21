extends RefCounted
# GABARITO

func criar_grade(largura: int, altura: int, valor: int) -> Array:
	var grade := []
	for y in altura:
		var linha := []
		linha.resize(largura)
		linha.fill(valor)
		grade.append(linha)
	return grade


func dentro_da_grade(grade: Array, x: int, y: int) -> bool:
	return y >= 0 and y < grade.size() and x >= 0 and x < grade[y].size()


func contar_vizinhos_iguais(grade: Array, x: int, y: int) -> int:
	var valor = grade[y][x]
	var total := 0
	for d in [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]:
		var nx: int = x + d.x
		var ny: int = y + d.y
		if dentro_da_grade(grade, nx, ny) and grade[ny][nx] == valor:
			total += 1
	return total


func encontrar_trincas_horizontais(grade: Array) -> Array[Vector2i]:
	var resultado: Array[Vector2i] = []
	for y in grade.size():
		var linha: Array = grade[y]
		var x := 0
		while x < linha.size():
			var fim := x
			while fim + 1 < linha.size() and linha[fim + 1] == linha[x]:
				fim += 1
			var tamanho := fim - x + 1
			if linha[x] != 0 and tamanho >= 3:
				for i in range(x, fim + 1):
					resultado.append(Vector2i(i, y))
			x = fim + 1
	return resultado
