extends RefCounted
# GABARITO

enum Estado { PATRULHANDO, PERSEGUINDO, ATACANDO, FUGINDO }

const ALCANCE_ATAQUE := 1.5
const ALCANCE_VISAO := 8.0
const ALCANCE_DESISTIR := 12.0


func proximo_estado(atual: Estado, distancia: float, vida: int) -> Estado:
	if vida < 20:
		return Estado.FUGINDO
	if distancia <= ALCANCE_ATAQUE:
		return Estado.ATACANDO
	if distancia <= ALCANCE_VISAO:
		return Estado.PERSEGUINDO
	if atual == Estado.PERSEGUINDO and distancia <= ALCANCE_DESISTIR:
		return Estado.PERSEGUINDO
	return Estado.PATRULHANDO
