extends RefCounted
# =============================================================================
# EXERCÍCIO 09 — enum, match e formatação de strings
#
# `enum` dá nomes a números — ótimo para estados de personagem:
#     enum Estado { PARADO, ANDANDO, PULANDO }   # 0, 1, 2
#     var estado := Estado.PARADO
#
# `match` é o "switch" do GDScript:
#     match estado:
#         Estado.PARADO:
#             ...
#         Estado.ANDANDO, Estado.PULANDO:
#             ...
#         _:                 # qualquer outro valor
#             ...
#
# Formatação:  "%02d:%02d" % [1, 5]  ->  "01:05"
# Operador ternário:  var x = "sim" if condicao else "não"
# =============================================================================

enum Estado { PARADO, ANDANDO, PULANDO }


## Use match. PARADO -> "Parado", ANDANDO -> "Andando", PULANDO -> "Pulando"
func nome_do_estado(estado: Estado) -> String:
	return ""  # TODO


## Escolhe a animação do personagem (lógica real de jogo de plataforma!):
##   no ar e subindo (velocidade.y < 0) -> "jump"
##   no ar e caindo                     -> "fall"
##   no chão e andando (|x| > 0.1)      -> "run"
##   no chão parado                     -> "idle"
func animacao_para(velocidade: Vector2, no_chao: bool) -> String:
	return ""  # TODO


## 125 segundos -> "02:05".  Dica: divisão inteira (/) e resto (%).
func formatar_tempo(segundos_totais: int) -> String:
	return ""  # TODO
