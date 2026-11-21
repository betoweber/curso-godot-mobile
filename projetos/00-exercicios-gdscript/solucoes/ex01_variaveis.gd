extends RefCounted
# GABARITO — só olhe depois de tentar! :)

func dobro(n: int) -> int:
	return n * 2


func saudacao(nome: String) -> String:
	return "Olá, " + nome + "!"
	# Alternativa com formatação: return "Olá, %s!" % nome


func eh_par(n: int) -> bool:
	return n % 2 == 0


func area_retangulo(largura: float, altura: float) -> float:
	return largura * altura
