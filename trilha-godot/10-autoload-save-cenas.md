# 10 · Autoload, salvar progresso e trocar de cena

> ⏱️ ~2h · 🎯 Estado global, persistência e fluxo entre telas

## Autoload (singleton)

Um script registrado em *Project Settings → Globals → Autoload* é criado **uma vez**, antes da primeira cena,
e **sobrevive à troca de cenas**. Qualquer script o acessa pelo nome.

Gabarito: `projetos/01-chuva-de-estrelas/scripts/jogo.gd` registrado como `Jogo`.

```gdscript
# Em qualquer lugar:
Jogo.pontos += 1
Jogo.pontos_mudaram.connect(_atualizar_placar)
```

Bons usos: pontuação/estado da partida, configurações, save, gerenciador de áudio, transições de cena.
Mau uso: jogar **tudo** no autoload (vira uma "classe deus" difícil de manter).

### Setters: reagir quando um valor muda

```gdscript
var pontos := 0:
	set(valor):
		pontos = valor
		pontos_mudaram.emit(pontos)     # o HUD escuta isso; ninguém precisa "avisar" o HUD
```

## Salvando dados

`user://` é a pasta de dados do app — funciona em **todas** as plataformas (no celular é a área privada do app).
No Mac fica em `~/Library/Application Support/Godot/app_userdata/<Nome do Projeto>/`.
(Menu *Project → Open User Data Folder* abre a pasta.)

### ConfigFile — simples, legível (formato .ini)

```gdscript
func salvar() -> void:
	var cfg := ConfigFile.new()
	cfg.set_value("progresso", "recorde", recorde)
	cfg.set_value("opcoes", "volume_musica", 0.8)
	cfg.save("user://save.cfg")

func carregar() -> void:
	var cfg := ConfigFile.new()
	if cfg.load("user://save.cfg") == OK:
		recorde = cfg.get_value("progresso", "recorde", 0)   # 0 = padrão se não existir
```

### JSON — bom para estruturas maiores

```gdscript
var dados := {"recorde": 42, "skins": ["azul", "dourada"]}
var f := FileAccess.open("user://save.json", FileAccess.WRITE)
f.store_string(JSON.stringify(dados))

var f2 := FileAccess.open("user://save.json", FileAccess.READ)
var lido = JSON.parse_string(f2.get_as_text())
```

> ⚠️ JSON transforma todos os números em `float`. Converta com `int()` ao ler.
> Para salvar `Resource`s customizados existe `ResourceSaver`, mas evite carregar `.tres` de fontes não confiáveis
> (eles podem conter código).

**Quando salvar no celular?** Ao fim de cada partida e no `NOTIFICATION_APPLICATION_PAUSED` (lição 08).
Nunca confie que o app vai "fechar direitinho".

## Trocando de cena

```gdscript
get_tree().change_scene_to_file("res://cenas/menu.tscn")
get_tree().change_scene_to_packed(preload("res://cenas/fase2.tscn"))
get_tree().reload_current_scene()
```

A cena atual é destruída e a nova é criada. Autoloads continuam vivos.

### Transição com fade (autoload `Transicao`)

```
Transicao (CanvasLayer, layer = 100)   ← transicao.gd
└── Cortina (ColorRect, Full Rect, preto, modulate.a = 0, Mouse Filter = Ignore)
```

```gdscript
extends CanvasLayer

func ir_para(caminho: String) -> void:
	var t := create_tween()
	t.tween_property($Cortina, "modulate:a", 1.0, 0.25)
	await t.finished
	get_tree().change_scene_to_file(caminho)
	create_tween().tween_property($Cortina, "modulate:a", 0.0, 0.25)
```

Registre `transicao.tscn` (a **cena**, não só o script) como autoload e use `Transicao.ir_para("res://...")`.

## 🏋️ Exercícios

1. Crie `jogo.gd` como autoload no seu projeto com pontos, vidas, recorde e salvar/carregar.
2. Separe o jogo em cenas: `menu.tscn` (título, recorde, botão Jogar, botão Opções) → `main.tscn` → volta ao menu.
3. Tela de **Opções** com dois `HSlider` (música e efeitos) salvos no `ConfigFile` e aplicados nos audio buses.
4. **Desafio**: loja simples — estrelas acumuladas compram skins da nave (cores ou sprites), salvas no save.

🧪 **Exercício automático ex14 (save robusto)**: JSON com versão, arquivo corrompido e saves antigos — os três
problemas reais de todo save de jogo.

## ✅ Eu sei...

- [ ] criar e usar um autoload
- [ ] salvar e carregar com ConfigFile e JSON em `user://`
- [ ] trocar de cena e fazer transição com fade
- [ ] quando salvar num app mobile

➡️ Próxima: [11 · Exportar para Android e iPhone](11-exportar-android-ios.md)
