extends RefCounted
# =============================================================================
# EXERCÍCIO 02 — Condicionais (if / elif / else) e operadores lógicos
#
#     if vida <= 0:
#         morrer()
#     elif vida < 20:
#         piscar_tela()
#     else:
#         pass            # `pass` = "não faça nada"
#
# Operadores lógicos: `and`, `or`, `not`  (também aceita &&, ||, !)
# Comparação: ==  !=  <  >  <=  >=
# =============================================================================


## Retorna:
##   "morto"    se vida <= 0
##   "crítico"  se vida < 25
##   "ferido"   se vida < 75
##   "saudável" caso contrário
func classificar_vida(vida: int) -> String:
	return ""  # TODO


## Retorna o maior dos três números.
## Tente primeiro com if! Depois descubra a função pronta `max()`.
func maior_de_tres(a: int, b: int, c: int) -> int:
	return 0  # TODO


## O personagem pode pular se estiver no chão OU se tiver pulo duplo disponível.
func pode_pular(no_chao: bool, tem_pulo_duplo: bool) -> bool:
	return false  # TODO
