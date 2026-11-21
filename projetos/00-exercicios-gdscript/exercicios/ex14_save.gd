extends RefCounted
# =============================================================================
# EXERCÍCIO 14 — Save robusto com JSON   (nível 2)
# Lição: 10
#
# Saves de verdade precisam aguentar:
#   - arquivo corrompido ou vazio      -> não pode travar o jogo
#   - save de uma versão antiga do jogo -> chaves novas não existem ainda
#   - JSON transforma TODO número em float (42 vira 42.0)
#
#     JSON.stringify({"a": 1})       -> '{"a":1}'
#     JSON.parse_string('{"a":1}')   -> {"a": 1.0}  (ou null se o texto for inválido)
#     var json := JSON.new()          -> versão "silenciosa": json.parse(texto) retorna OK
#     json.parse(texto) == OK            ou um erro, e o resultado fica em json.data
#     dic.merge(outro, true)         -> copia as chaves de `outro` para `dic`, sobrescrevendo
#     dic.duplicate(true)            -> cópia profunda
# =============================================================================

const VERSAO_SAVE := 2


## Os valores de um save novo. (Já pronto.)
func padrao() -> Dictionary:
	return {"versao": VERSAO_SAVE, "recorde": 0, "moedas": 0, "skins": ["padrao"]}


## Converte para texto JSON, incluindo "versao": VERSAO_SAVE.
## Não altere o dicionário recebido!
func serializar(dados: Dictionary) -> String:
	return ""  # TODO


## Lê o texto e devolve um save COMPLETO:
##   - texto inválido (ou que não seja um dicionário) -> padrao()
##   - chaves que faltarem vêm de padrao()
##   - "versao", "recorde" e "moedas" devem voltar como int
func desserializar(texto: String) -> Dictionary:
	return {}  # TODO
