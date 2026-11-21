extends RefCounted
# =============================================================================
# EXERCÍCIO 01 — Variáveis, tipos e funções
# Lição: trilha-godot/02-gdscript-basico.md
#
# Em GDScript você declara variáveis com `var`:
#     var vida = 100            # tipo inferido em tempo de execução (dinâmico)
#     var vida: int = 100       # tipo explícito (recomendado!)
#     var vida := 100           # tipo inferido pelo valor (int) — atalho popular
#
# Funções usam `func`, e podem declarar o tipo de retorno com `->`:
#     func somar(a: int, b: int) -> int:
#         return a + b
#
# ATENÇÃO: GDScript usa INDENTAÇÃO (tab) para definir blocos, como Python.
#
# Tarefa: substitua cada `return ...  # TODO` pela resposta certa.
# Depois rode o projeto (F5 / Cmd+B) e veja os testes ficarem verdes.
# =============================================================================


## Retorna o dobro de n.  dobro(4) -> 8
func dobro(n: int) -> int:
	return 0  # TODO


## Retorna "Olá, <nome>!".  saudacao("Ana") -> "Olá, Ana!"
## Dica: strings se juntam com `+`, ou use formatação: "Olá, %s!" % nome
func saudacao(nome: String) -> String:
	return ""  # TODO


## Retorna true se n for par.
## Dica: o operador `%` dá o resto da divisão. 10 % 2 == 0
func eh_par(n: int) -> bool:
	return false  # TODO


## Retorna a área de um retângulo (largura × altura).
func area_retangulo(largura: float, altura: float) -> float:
	return 0.0  # TODO
