extends RefCounted
# =============================================================================
# EXERCÍCIO 15 — Cooldown (tempo de recarga)   (nível 2)
# Lição: 05 / 09
#
# Quase todo jogo tem cooldowns: tiro, dash, habilidade especial. Dá para usar
# um nó Timer, mas uma classe simples atualizada no _process é leve e fácil de testar:
#
#     var tiro = Cooldown.new(0.3)
#     func _process(delta):
#         tiro.atualizar(delta)
#         if tocou_na_tela and tiro.usar():
#             atirar()
#     # e uma barra de UI pode mostrar tiro.progresso()
#
# Esta classe é o arquivo inteiro (como no ex07).
# =============================================================================

var duracao: float
var restante := 0.0      # segundos até poder usar de novo (0 = pronto)


func _init(p_duracao: float) -> void:
	pass  # TODO


func pode_usar() -> bool:
	return false  # TODO


## Se puder usar: inicia a recarga e retorna true. Senão retorna false.
func usar() -> bool:
	return false  # TODO


## Diminui o tempo restante (nunca abaixo de 0).
func atualizar(delta: float) -> void:
	pass  # TODO


## 0.0 = acabou de usar, 1.0 = pronto. (Para desenhar uma barrinha de recarga.)
func progresso() -> float:
	return 0.0  # TODO
