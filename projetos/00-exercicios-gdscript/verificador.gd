extends RefCounted
## Corretor automático dos exercícios.
## Você NÃO precisa mexer aqui — mas pode ler para aprender! Ele usa
## load() para carregar scripts, chama funções dinamicamente e compara resultados.

var _ok := 0
var _falhas := 0
var _bb := PackedStringArray()
var _txt := PackedStringArray()


func verificar_tudo(pasta: String) -> Dictionary:
	_bb.append("[font_size=22][b]Verificando: %s[/b][/font_size]\n" % pasta)
	_txt.append("== Verificando: %s ==" % pasta)

	_ex01(pasta)
	_ex02(pasta)
	_ex03(pasta)
	_ex04(pasta)
	_ex05(pasta)
	_ex06(pasta)
	_ex07(pasta)
	_ex08(pasta)
	_ex09(pasta)

	var total := _ok + _falhas
	var resumo := "%d de %d testes passaram." % [_ok, total]
	if _falhas == 0:
		_bb.append("\n[color=#7CFC9A][b]🎉 %s Tudo certo![/b][/color]" % resumo)
	else:
		_bb.append("\n[color=#FFD166][b]%s Continue![/b][/color]" % resumo)
	_txt.append("\n" + resumo)
	return {"bbcode": "\n".join(_bb), "texto": "\n".join(_txt), "falhas": _falhas, "ok": _ok}


# --- Testes de cada exercício -------------------------------------------------

func _ex01(pasta: String) -> void:
	var e = _abrir(pasta, "ex01_variaveis.gd", "01 · Variáveis e tipos")
	if e == null: return
	_checar("dobro(4) == 8", e.dobro(4), 8)
	_checar("dobro(-3) == -6", e.dobro(-3), -6)
	_checar("saudacao(\"Ana\") == \"Olá, Ana!\"", e.saudacao("Ana"), "Olá, Ana!")
	_checar("eh_par(10) == true", e.eh_par(10), true)
	_checar("eh_par(7) == false", e.eh_par(7), false)
	_checar("area_retangulo(3.0, 2.5) == 7.5", e.area_retangulo(3.0, 2.5), 7.5)


func _ex02(pasta: String) -> void:
	var e = _abrir(pasta, "ex02_condicionais.gd", "02 · Condicionais")
	if e == null: return
	_checar("classificar_vida(0) == \"morto\"", e.classificar_vida(0), "morto")
	_checar("classificar_vida(-5) == \"morto\"", e.classificar_vida(-5), "morto")
	_checar("classificar_vida(10) == \"crítico\"", e.classificar_vida(10), "crítico")
	_checar("classificar_vida(50) == \"ferido\"", e.classificar_vida(50), "ferido")
	_checar("classificar_vida(100) == \"saudável\"", e.classificar_vida(100), "saudável")
	_checar("maior_de_tres(3, 9, 4) == 9", e.maior_de_tres(3, 9, 4), 9)
	_checar("maior_de_tres(7, 2, 1) == 7", e.maior_de_tres(7, 2, 1), 7)
	_checar("pode_pular(true, false) == true", e.pode_pular(true, false), true)
	_checar("pode_pular(false, false) == false", e.pode_pular(false, false), false)
	_checar("pode_pular(false, true) == true (pulo duplo)", e.pode_pular(false, true), true)


func _ex03(pasta: String) -> void:
	var e = _abrir(pasta, "ex03_loops.gd", "03 · Loops")
	if e == null: return
	_checar("soma_ate(5) == 15", e.soma_ate(5), 15)
	_checar("soma_ate(1) == 1", e.soma_ate(1), 1)
	_checar("contar_vogais(\"godot engine\") == 5", e.contar_vogais("godot engine"), 5)
	_checar("contar_vogais(\"xyz\") == 0", e.contar_vogais("xyz"), 0)
	_checar("contagem_regressiva(3) == [3, 2, 1]", e.contagem_regressiva(3), [3, 2, 1])
	_checar("fizzbuzz(5) == [\"1\",\"2\",\"Fizz\",\"4\",\"Buzz\"]", e.fizzbuzz(5), ["1", "2", "Fizz", "4", "Buzz"])
	var fb15: Array = e.fizzbuzz(15)
	_checar("fizzbuzz(15)[14] == \"FizzBuzz\"", fb15[14] if fb15.size() >= 15 else null, "FizzBuzz")


func _ex04(pasta: String) -> void:
	var e = _abrir(pasta, "ex04_arrays.gd", "04 · Arrays")
	if e == null: return
	_checar("filtrar_pares([1,2,3,4,6]) == [2,4,6]", e.filtrar_pares([1, 2, 3, 4, 6]), [2, 4, 6])
	_checar("maior_valor([3, 17, 8]) == 17", e.maior_valor([3, 17, 8]), 17)
	_checar("maior_valor([-5, -2, -9]) == -2", e.maior_valor([-5, -2, -9]), -2)
	_checar("dobrar_todos([1, 2, 3]) == [2, 4, 6]", e.dobrar_todos([1, 2, 3]), [2, 4, 6])
	var original := [1, 2, 3]
	e.dobrar_todos(original)
	_checar("dobrar_todos NÃO modifica o array original", original, [1, 2, 3])
	_checar("media([2, 4, 9]) == 5.0", e.media([2, 4, 9]), 5.0)
	_checar("media([]) == 0.0", e.media([]), 0.0)


func _ex05(pasta: String) -> void:
	var e = _abrir(pasta, "ex05_dicionarios.gd", "05 · Dicionários (inventário)")
	if e == null: return
	var inv := {}
	e.adicionar_item(inv, "poção", 2)
	e.adicionar_item(inv, "poção", 3)
	e.adicionar_item(inv, "espada", 1)
	_checar("adicionar_item soma quantidades: poção == 5", inv.get("poção"), 5)
	_checar("adicionar_item cria item novo: espada == 1", inv.get("espada"), 1)
	_checar("total_itens(inv) == 6", e.total_itens(inv), 6)
	_checar("remover_item(inv, \"poção\", 2) == true", e.remover_item(inv, "poção", 2), true)
	_checar("depois de remover: poção == 3", inv.get("poção"), 3)
	_checar("remover_item(inv, \"poção\", 10) == false (não tem o bastante)", e.remover_item(inv, "poção", 10), false)
	e.remover_item(inv, "espada", 1)
	_checar("item com quantidade 0 sai do dicionário", inv.has("espada"), false)
	_checar("remover_item de item inexistente == false", e.remover_item(inv, "arco", 1), false)


func _ex06(pasta: String) -> void:
	var e = _abrir(pasta, "ex06_vetores.gd", "06 · Vector2 (matemática de jogos)")
	if e == null: return
	_checar("distancia((0,0), (3,4)) == 5", e.distancia(Vector2.ZERO, Vector2(3, 4)), 5.0)
	_checar("direcao((0,0), (10,0)) == (1,0)", e.direcao(Vector2.ZERO, Vector2(10, 0)), Vector2(1, 0))
	_checar("direcao((1,1), (1,-9)) == (0,-1)", e.direcao(Vector2(1, 1), Vector2(1, -9)), Vector2(0, -1))
	_checar("mover_para((0,0), (10,0), 3) == (3,0)", e.mover_para(Vector2.ZERO, Vector2(10, 0), 3.0), Vector2(3, 0))
	_checar("mover_para((0,0), (2,0), 5) == (2,0) (não passa do alvo)", e.mover_para(Vector2.ZERO, Vector2(2, 0), 5.0), Vector2(2, 0))
	_checar("esta_perto((0,0), (1,1), 2) == true", e.esta_perto(Vector2.ZERO, Vector2(1, 1), 2.0), true)
	_checar("esta_perto((0,0), (5,5), 2) == false", e.esta_perto(Vector2.ZERO, Vector2(5, 5), 2.0), false)


func _ex07(pasta: String) -> void:
	var script = _abrir_script(pasta, "ex07_classes.gd", "07 · Classes (Personagem)")
	if script == null: return
	var p = script.new("Herói", 100)
	_checar("nome == \"Herói\"", p.nome, "Herói")
	_checar("vida começa igual a vida_max (100)", p.vida, 100)
	p.levar_dano(30)
	_checar("levar_dano(30) -> vida == 70", p.vida, 70)
	p.curar(50)
	_checar("curar(50) não passa da vida_max -> vida == 100", p.vida, 100)
	p.levar_dano(500)
	_checar("vida nunca fica negativa -> vida == 0", p.vida, 0)
	_checar("esta_vivo() == false com vida 0", p.esta_vivo(), false)


func _ex08(pasta: String) -> void:
	var script = _abrir_script(pasta, "ex08_sinais.gd", "08 · Sinais")
	if script == null: return
	var alvo = script.new()
	var registro := {"mudancas": [], "mortes": 0}
	alvo.vida_mudou.connect(func(nova): registro.mudancas.append(nova))
	alvo.morreu.connect(func(): registro.mortes += 1)
	alvo.levar_dano(1)
	alvo.levar_dano(1)
	_checar("vida_mudou emitido com a vida nova: [2, 1]", registro.mudancas, [2, 1])
	_checar("ainda não morreu", registro.mortes, 0)
	alvo.levar_dano(5)
	_checar("morreu emitido quando vida chega a 0", registro.mortes, 1)
	alvo.levar_dano(1)
	_checar("morreu NÃO é emitido de novo depois de morto", registro.mortes, 1)


func _ex09(pasta: String) -> void:
	var e = _abrir(pasta, "ex09_match_enum.gd", "09 · Enum, match e strings")
	if e == null: return
	var Estado = e.Estado
	_checar("nome_do_estado(PARADO) == \"Parado\"", e.nome_do_estado(Estado.PARADO), "Parado")
	_checar("nome_do_estado(PULANDO) == \"Pulando\"", e.nome_do_estado(Estado.PULANDO), "Pulando")
	_checar("animacao_para(Vector2.ZERO, true) == \"idle\"", e.animacao_para(Vector2.ZERO, true), "idle")
	_checar("animacao_para(Vector2(100,0), true) == \"run\"", e.animacao_para(Vector2(100, 0), true), "run")
	_checar("animacao_para(Vector2(0,-50), false) == \"jump\"", e.animacao_para(Vector2(0, -50), false), "jump")
	_checar("animacao_para(Vector2(0,50), false) == \"fall\"", e.animacao_para(Vector2(0, 50), false), "fall")
	_checar("formatar_tempo(125) == \"02:05\"", e.formatar_tempo(125), "02:05")
	_checar("formatar_tempo(0) == \"00:00\"", e.formatar_tempo(0), "00:00")


# --- Utilidades ---------------------------------------------------------------

func _abrir_script(pasta: String, arquivo: String, titulo: String):
	_bb.append("\n[b][color=#8EC5FF]%s[/color][/b]  [color=#888](%s)[/color]" % [titulo, arquivo])
	_txt.append("\n-- %s (%s)" % [titulo, arquivo])
	var caminho := pasta + arquivo
	if not ResourceLoader.exists(caminho):
		_falhou("arquivo não encontrado: " + caminho)
		return null
	var script: GDScript = load(caminho)
	if script == null or not script.can_instantiate():
		_falhou("o script tem erro de sintaxe — abra ele no editor e veja a linha vermelha")
		return null
	return script


func _abrir(pasta: String, arquivo: String, titulo: String):
	var script = _abrir_script(pasta, arquivo, titulo)
	return script.new() if script != null else null


func _iguais(a, b) -> bool:
	if typeof(a) == TYPE_FLOAT or typeof(b) == TYPE_FLOAT:
		if typeof(a) in [TYPE_INT, TYPE_FLOAT] and typeof(b) in [TYPE_INT, TYPE_FLOAT]:
			return is_equal_approx(float(a), float(b))
	if typeof(a) == TYPE_VECTOR2 and typeof(b) == TYPE_VECTOR2:
		return a.is_equal_approx(b)
	if typeof(a) == TYPE_ARRAY and typeof(b) == TYPE_ARRAY:
		if a.size() != b.size():
			return false
		for i in a.size():
			if not _iguais(a[i], b[i]):
				return false
		return true
	return typeof(a) == typeof(b) and a == b


func _checar(descricao: String, obtido, esperado) -> void:
	if _iguais(obtido, esperado):
		_ok += 1
		_bb.append("  [color=#7CFC9A]✔[/color] " + descricao)
		_txt.append("  [OK]    " + descricao)
	else:
		_falhou("%s   → obtido: %s" % [descricao, var_to_str(obtido)])


func _falhou(mensagem: String) -> void:
	_falhas += 1
	_bb.append("  [color=#FF6B6B]✘ %s[/color]" % mensagem)
	_txt.append("  [FALHA] " + mensagem)
