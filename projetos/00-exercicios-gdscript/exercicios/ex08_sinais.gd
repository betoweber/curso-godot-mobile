extends RefCounted
# =============================================================================
# EXERCÍCIO 08 — Sinais (signals): o "sistema de eventos" do Godot
#
# Um objeto DECLARA um sinal e o EMITE quando algo acontece. Outros objetos
# se CONECTAM a ele, sem que o emissor precise saber quem está ouvindo.
# Isso deixa o código desacoplado (ex: o jogador não precisa conhecer o HUD).
#
#     signal pegou_moeda(valor: int)       # declarar
#     pegou_moeda.emit(10)                 # emitir
#     jogador.pegou_moeda.connect(_on_jogador_pegou_moeda)   # conectar
#
# Tarefa: implemente levar_dano() emitindo os sinais certos.
# =============================================================================

signal vida_mudou(nova_vida: int)
signal morreu

var vida := 3


## 1. Se já estiver morto (vida <= 0), não faça nada.
## 2. Diminua a vida (mínimo 0) e emita `vida_mudou` com o novo valor.
## 3. Se a vida chegou a 0, emita `morreu`.
func levar_dano(quantidade: int) -> void:
	pass  # TODO
