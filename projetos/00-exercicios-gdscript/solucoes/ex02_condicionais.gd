extends RefCounted
# GABARITO

func classificar_vida(vida: int) -> String:
	if vida <= 0:
		return "morto"
	elif vida < 25:
		return "crítico"
	elif vida < 75:
		return "ferido"
	else:
		return "saudável"


func maior_de_tres(a: int, b: int, c: int) -> int:
	# Jeito "na mão":
	var maior := a
	if b > maior:
		maior = b
	if c > maior:
		maior = c
	return maior
	# Jeito curto: return max(a, b, c)


func pode_pular(no_chao: bool, tem_pulo_duplo: bool) -> bool:
	return no_chao or tem_pulo_duplo
