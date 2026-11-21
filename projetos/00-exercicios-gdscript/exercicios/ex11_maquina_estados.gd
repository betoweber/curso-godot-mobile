extends RefCounted
# =============================================================================
# EXERCÍCIO 11 — Máquina de estados de um inimigo   (nível 2)
# Lição: 03 (extra) / 12 (inimigos)
#
# Uma máquina de estados (FSM) decide o comportamento a partir do estado atual
# e do que está acontecendo. É o padrão nº 1 para IA simples de inimigos e
# para personagens (parado/correndo/pulando).
#
# Regras, NESTA ORDEM de prioridade:
#   1. vida < 20                    -> FUGINDO       (de qualquer estado)
#   2. distancia <= ALCANCE_ATAQUE  -> ATACANDO
#   3. distancia <= ALCANCE_VISAO   -> PERSEGUINDO
#   4. se JÁ estava PERSEGUINDO e distancia <= ALCANCE_DESISTIR
#                                   -> continua PERSEGUINDO
#      (isso é "histerese": evita o inimigo ficar trocando de estado sem parar
#       quando o jogador está bem na borda do alcance de visão)
#   5. senão                        -> PATRULHANDO
# =============================================================================

enum Estado { PATRULHANDO, PERSEGUINDO, ATACANDO, FUGINDO }

const ALCANCE_ATAQUE := 1.5
const ALCANCE_VISAO := 8.0
const ALCANCE_DESISTIR := 12.0


func proximo_estado(atual: Estado, distancia: float, vida: int) -> Estado:
	return atual  # TODO
