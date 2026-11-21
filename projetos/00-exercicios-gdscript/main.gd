extends Control
## Tela que roda o verificador e mostra o resultado.
## Aperte F5 (Cmd+B no Mac) para rodar o projeto.
## Fluxo: edite um arquivo em exercicios/ -> salve (Cmd+S) -> rode de novo.

const Verificador = preload("res://verificador.gd")

@onready var resultado: RichTextLabel = $Margem/Coluna/Resultado
@onready var ver_solucoes: CheckBox = $Margem/Coluna/Botoes/VerSolucoes


func _ready() -> void:
	_rodar()


func _on_verificar_pressed() -> void:
	_rodar()


func _rodar() -> void:
	var pasta := "res://solucoes/" if ver_solucoes.button_pressed else "res://exercicios/"
	var relatorio: Dictionary = Verificador.new().verificar_tudo(pasta)
	resultado.text = relatorio.bbcode
	print(relatorio.texto)
