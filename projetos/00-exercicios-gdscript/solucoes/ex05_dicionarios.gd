extends RefCounted
# GABARITO

func adicionar_item(inventario: Dictionary, item: String, quantidade: int) -> void:
	# get(chave, padrão) devolve o padrão se a chave não existir
	inventario[item] = inventario.get(item, 0) + quantidade


func total_itens(inventario: Dictionary) -> int:
	var total := 0
	for item in inventario:
		total += inventario[item]
	return total
	# Alternativa: for qtd in inventario.values(): total += qtd


func remover_item(inventario: Dictionary, item: String, quantidade: int) -> bool:
	if inventario.get(item, 0) < quantidade:
		return false
	inventario[item] -= quantidade
	if inventario[item] == 0:
		inventario.erase(item)
	return true
