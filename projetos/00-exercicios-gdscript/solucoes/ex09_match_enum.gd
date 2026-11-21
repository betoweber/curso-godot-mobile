extends RefCounted
# GABARITO

enum Estado { PARADO, ANDANDO, PULANDO }


func nome_do_estado(estado: Estado) -> String:
	match estado:
		Estado.PARADO:
			return "Parado"
		Estado.ANDANDO:
			return "Andando"
		Estado.PULANDO:
			return "Pulando"
	return "?"


func animacao_para(velocidade: Vector2, no_chao: bool) -> String:
	if not no_chao:
		return "jump" if velocidade.y < 0 else "fall"
	if abs(velocidade.x) > 0.1:
		return "run"
	return "idle"


func formatar_tempo(segundos_totais: int) -> String:
	var minutos := segundos_totais / 60
	var segundos := segundos_totais % 60
	return "%02d:%02d" % [minutos, segundos]
