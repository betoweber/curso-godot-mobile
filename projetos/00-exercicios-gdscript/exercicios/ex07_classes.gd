extends RefCounted
# =============================================================================
# EXERCÍCIO 07 — Classes
#
# Em GDScript, CADA ARQUIVO .gd é uma classe. Este arquivo é a classe
# "Personagem". Quem usa faz:   var p = load("ex07_classes.gd").new("Herói", 100)
#
# `_init()` é o construtor — roda quando o objeto é criado com .new().
# Variáveis declaradas no topo do arquivo são as propriedades do objeto.
#
# (Em scripts de nós, você normalmente usa `class_name Personagem` no topo
#  para registrar o nome globalmente. Aqui não usamos para não conflitar
#  com o gabarito.)
# =============================================================================

var nome: String
var vida: int
var vida_max: int


## Guarde o nome e a vida máxima. A vida começa cheia.
func _init(p_nome: String, p_vida_max: int) -> void:
	pass  # TODO


## Diminui a vida, mas ela nunca fica abaixo de 0.  Dica: max()
func levar_dano(quantidade: int) -> void:
	pass  # TODO


## Aumenta a vida, mas nunca acima de vida_max.  Dica: min() ou clampi()
func curar(quantidade: int) -> void:
	pass  # TODO


func esta_vivo() -> bool:
	return true  # TODO
