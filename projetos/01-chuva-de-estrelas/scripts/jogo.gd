extends Node
## AUTOLOAD (singleton) "Jogo".
## Registrado em Project > Project Settings > Globals > Autoload.
## Fica vivo durante todo o jogo, mesmo quando trocamos de cena,
## e qualquer script pode acessá-lo pelo nome: Jogo.pontos, Jogo.salvar()...

signal pontos_mudaram(pontos: int)
signal vidas_mudaram(vidas: int)
signal fim_de_jogo

const ARQUIVO_SAVE := "user://save.cfg"  # user:// = pasta de dados do app (funciona no celular)
const VIDAS_INICIAIS := 3

var pontos := 0:
	set(valor):
		pontos = valor
		pontos_mudaram.emit(pontos)

var vidas := VIDAS_INICIAIS:
	set(valor):
		vidas = max(valor, 0)
		vidas_mudaram.emit(vidas)
		if vidas == 0:
			_terminar()

var recorde := 0
var jogando := false


func _ready() -> void:
	carregar()


func novo_jogo() -> void:
	pontos = 0
	vidas = VIDAS_INICIAIS
	jogando = true


func _terminar() -> void:
	if not jogando:
		return
	jogando = false
	if pontos > recorde:
		recorde = pontos
		salvar()
	fim_de_jogo.emit()


func salvar() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("progresso", "recorde", recorde)
	cfg.save(ARQUIVO_SAVE)


func carregar() -> void:
	var cfg := ConfigFile.new()
	if cfg.load(ARQUIVO_SAVE) == OK:
		recorde = cfg.get_value("progresso", "recorde", 0)
