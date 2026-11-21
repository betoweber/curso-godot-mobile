extends SceneTree
## Versão de linha de comando do verificador. Exemplo (Mac):
##   /Applications/Godot.app/Contents/MacOS/Godot --headless --path . --script res://cli.gd
## Para verificar o gabarito, adicione: -- --solucoes

const Verificador = preload("res://verificador.gd")


func _init() -> void:
	var pasta := "res://exercicios/"
	if "--solucoes" in OS.get_cmdline_user_args():
		pasta = "res://solucoes/"
	var relatorio := Verificador.new().verificar_tudo(pasta)
	print(relatorio.texto)
	quit(0 if relatorio.falhas == 0 else 1)
