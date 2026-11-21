extends SceneTree
## Verificador usado pelo hook de pre-commit (.githooks/pre-commit).
## Carrega scripts (.gd), cenas (.tscn) e recursos (.tres), e confere o project.godot
## SEM executá-los, só para detectar erros de sintaxe, de tipo e referências quebradas.
##
## Uso:
##   godot --headless --path <projeto> --script <repo>/ferramentas/checar_godot.gd -- res://a.gd res://b.tscn
## Sai com código 1 se algum arquivo tiver problema.

func _initialize() -> void:
	var falhas := 0
	for caminho in OS.get_cmdline_user_args():
		var problema := _checar(caminho)
		if problema.is_empty():
			print("  ✔ ", caminho)
		else:
			falhas += 1
			printerr("  ✘ %s — %s" % [caminho, problema])
	quit(1 if falhas > 0 else 0)


func _checar(caminho: String) -> String:
	if caminho == "res://project.godot":
		return _checar_projeto()
	if not FileAccess.file_exists(caminho):
		return "arquivo não encontrado"
	# Referências a arquivos que não existem (ex: renomeou um script e a cena não foi atualizada)
	for dep in ResourceLoader.get_dependencies(caminho):
		var dep_caminho: String = dep.get_slice("::", dep.get_slice_count("::") - 1)
		if dep_caminho.begins_with("res://") and not ResourceLoader.exists(dep_caminho):
			return "referencia um arquivo que não existe: " + dep_caminho
	var recurso := ResourceLoader.load(caminho, "", ResourceLoader.CACHE_MODE_IGNORE)
	if recurso == null:
		return "não carregou (veja o erro acima)"
	if recurso is GDScript and not recurso.can_instantiate():
		return "erro de compilação (veja a linha indicada acima)"
	if recurso is PackedScene and not recurso.can_instantiate():
		return "cena inválida"
	# Obs.: shaders (.gdshader) só compilam de verdade quando são desenhados na tela,
	# então aqui só garantimos que o arquivo carrega. Rode a cena para testar o shader.
	return ""


## Confere se a cena principal e os autoloads apontam para arquivos que existem.
func _checar_projeto() -> String:
	var principal: String = ProjectSettings.get_setting("application/run/main_scene", "")
	if not principal.is_empty() and not ResourceLoader.exists(principal):
		return "a cena principal (Application > Run > Main Scene) não existe: " + principal
	for prop in ProjectSettings.get_property_list():
		var nome: String = prop.name
		if nome.begins_with("autoload/"):
			var alvo := str(ProjectSettings.get_setting(nome)).trim_prefix("*")
			if not ResourceLoader.exists(alvo):
				return "o autoload '%s' aponta para um arquivo que não existe: %s" % [nome.trim_prefix("autoload/"), alvo]
	return ""
