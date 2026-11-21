extends RefCounted
# GABARITO

const VERSAO_SAVE := 2


func padrao() -> Dictionary:
	return {"versao": VERSAO_SAVE, "recorde": 0, "moedas": 0, "skins": ["padrao"]}


func serializar(dados: Dictionary) -> String:
	var copia := dados.duplicate(true)
	copia["versao"] = VERSAO_SAVE
	return JSON.stringify(copia)


func desserializar(texto: String) -> Dictionary:
	# JSON.new().parse() não imprime erro no Output quando o texto é inválido
	# (JSON.parse_string também funcionaria, mas mostra um ERROR vermelho).
	var json := JSON.new()
	if json.parse(texto) != OK:
		return padrao()
	var lido = json.data
	if not lido is Dictionary:
		return padrao()
	var resultado := padrao()
	resultado.merge(lido, true)        # o que veio do arquivo sobrescreve o padrão
	for chave in ["versao", "recorde", "moedas"]:
		resultado[chave] = int(resultado[chave])
	return resultado
