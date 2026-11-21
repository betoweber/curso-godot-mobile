extends RefCounted
# =============================================================================
# EXERCÍCIO 05 — Dicionários (um inventário de RPG)
#
#     var inv := {"poção": 2, "chave": 1}
#     inv["poção"]            # 2
#     inv["espada"] = 1       # cria/atualiza
#     inv.has("chave")        # true
#     inv.get("arco", 0)      # 0 (valor padrão se não existir)
#     inv.erase("chave")      # remove
#     for item in inv:        # percorre as CHAVES
#         print(item, inv[item])
#
# Dicionários também são passados por referência: alterar `inventario`
# dentro da função altera o dicionário de quem chamou.
# =============================================================================


## Soma `quantidade` ao item (criando se não existir).
func adicionar_item(inventario: Dictionary, item: String, quantidade: int) -> void:
	pass  # TODO


## Retorna a soma de todas as quantidades.
func total_itens(inventario: Dictionary) -> int:
	return 0  # TODO


## Remove `quantidade` do item.
## - Se não houver o suficiente (ou o item não existir), não mexe e retorna false.
## - Se a quantidade chegar a 0, apaga a chave do dicionário.
## - Se deu certo, retorna true.
func remover_item(inventario: Dictionary, item: String, quantidade: int) -> bool:
	return false  # TODO
