extends RefCounted
# =============================================================================
# EXERCÍCIO 04 — Arrays
#
#     var a := [10, 20, 30]
#     a[0]            # 10
#     a.size()        # 3
#     a.append(40)    # adiciona no fim
#     a.is_empty()    # false
#     a.has(20)       # true
#
# Arrays tipados (mais seguros):  var nomes: Array[String] = []
#
# Funções de ordem superior (recebem uma função "lambda"):
#     a.filter(func(x): return x > 15)   # [20, 30]
#     a.map(func(x): return x * 10)      # [100, 200, 300]
# =============================================================================


## Retorna só os números pares.  [1,2,3,4,6] -> [2,4,6]
func filtrar_pares(numeros: Array) -> Array:
	return []  # TODO


## Retorna o maior número do array (pode ter negativos!).
func maior_valor(numeros: Array) -> int:
	return 0  # TODO


## Retorna um array NOVO com cada valor dobrado — sem alterar o original.
## Pegadinha: arrays são passados por REFERÊNCIA em GDScript.
func dobrar_todos(numeros: Array) -> Array:
	return []  # TODO


## Média dos valores. Array vazio -> 0.0 (não divida por zero!)
func media(numeros: Array) -> float:
	return -1.0  # TODO
