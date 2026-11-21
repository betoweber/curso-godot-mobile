# 03 · Scripts em nós, ciclo de vida e sinais

> ⏱️ ~3h · 🎯 Fazer nós "ganharem vida" com scripts e se comunicarem
> 🧪 Exercícios: ex07, ex08, ex09

## Script = comportamento de um nó

Um script **estende** um tipo de nó. Ao anexar `jogador.gd` a um `Area2D`, o script *é* esse Area2D,
com tudo que ele já sabe fazer, mais o que você escrever.

```gdscript
class_name Jogador          # opcional: registra o tipo globalmente (aparece no "Add Node"!)
extends Area2D              # obrigatório: qual nó este script estende

@export var velocidade := 300.0   # aparece no Inspector — designers ajustam sem mexer no código
@onready var sprite: Sprite2D = $Sprite2D   # pega o nó filho quando a cena estiver pronta
```

### Acessando outros nós

```gdscript
$Sprite2D                    # filho direto chamado "Sprite2D"
$Visual/Olhos                # neto
get_node("Visual/Olhos")     # o mesmo, por código
%Pontos                      # nó marcado como "Access as Unique Name" (clique direito no nó)
get_parent()                 # o pai
get_tree().get_nodes_in_group("inimigos")   # todos os nós de um grupo
```

> 💡 Arraste um nó da árvore para o script segurando **Cmd** e o Godot escreve o `@onready var` para você.

## O ciclo de vida

O Godot chama certas funções automaticamente. Você só escreve as que precisa:

| Função | Quando roda | Use para |
|---|---|---|
| `_init()` | quando o objeto é criado na memória | raramente em nós |
| `_ready()` | quando o nó **e todos os filhos** entraram na árvore | configuração inicial, conectar sinais |
| `_process(delta)` | todo frame (60×/s ou mais) | movimento visual, animações, UI |
| `_physics_process(delta)` | em passos fixos (60×/s) | movimento com física/colisão |
| `_input(event)` | a cada evento de entrada | atalhos globais |
| `_unhandled_input(event)` | eventos que a UI **não** consumiu | controle do jogador |
| `_exit_tree()` | quando sai da árvore | limpeza |

### O que é `delta`?

O tempo (em segundos) desde o último frame. Num celular a 30 FPS, delta ≈ 0.033; num Mac a 120 FPS, ≈ 0.008.
**Multiplique movimento por delta** para o jogo ter a mesma velocidade em qualquer aparelho:

```gdscript
func _process(delta: float) -> void:
	position.x += 300 * delta     # 300 pixels por SEGUNDO, em qualquer FPS
```

## Sinais: nós conversando sem se conhecer

**Regra de ouro do Godot: "chame para baixo, sinalize para cima"** (*call down, signal up*).
- Um pai pode chamar métodos dos filhos diretamente (`$Jogador.pular()`).
- Um filho **não deveria** conhecer o pai. Ele **emite um sinal** e quem se interessar escuta.

```gdscript
# jogador.gd
signal morreu
signal vida_mudou(nova_vida: int)

func levar_dano(qtd: int) -> void:
	vida -= qtd
	vida_mudou.emit(vida)
	if vida <= 0:
		morreu.emit()
```

```gdscript
# main.gd (o pai)
func _ready() -> void:
	$Jogador.morreu.connect(_on_jogador_morreu)
	$Jogador.vida_mudou.connect($HUD.atualizar_vida)

func _on_jogador_morreu() -> void:
	get_tree().reload_current_scene()
```

### Conectando pelo editor

1. Selecione o nó (ex: um `Button`) → aba **Node** → **Signals**.
2. Duplo clique em `pressed()` → escolha o nó que recebe → **Connect**.
3. O Godot cria `func _on_button_pressed():` no script de destino.

Os dois jeitos são válidos. Pelo código é mais explícito; pelo editor é mais visual.
Os projetos do curso usam os dois para você ver ambos.

## Mão na massa

Crie `meus-projetos/03-sinais` com esta cena:

```
Main (Node2D)            ← main.gd
├── Botao (Button)       ← texto "Clique"
├── Contador (Label)
└── Relogio (Timer)      ← Wait Time = 1, Autostart = ligado
```

Objetivos:
1. Cada clique no botão soma 1 no Label (conecte `pressed` pelo editor).
2. A cada segundo o `Relogio` subtrai 1 (conecte `timeout` pelo código no `_ready`).
3. Se chegar a 10, mostre "Você venceu!" e desabilite o botão (`$Botao.disabled = true`).

## 🏋️ Exercícios automáticos

Faça **ex07** (classes), **ex08** (sinais) e **ex09** (enum/match). O ex09 tem a lógica real de escolher
animação de um personagem de plataforma — você vai reusar isso.

### Nível 2 (opcional, mas recomendado)

- **ex10** — lambdas, `sort_custom` e closures (ranking de jogadores)
- **ex11** — máquina de estados de um inimigo (padrão que você vai usar na lição 12)

## 📖 Leia o código de referência

Abra `projetos/01-chuva-de-estrelas/scripts/jogador.gd` e responda (pode conferir com o tutor):

1. Quais sinais o jogador declara? Quem se conecta a eles?
2. Por que ele usa `_unhandled_input` e não `_input`?
3. O que `1.0 - exp(-suavidade * delta)` faz? (dica: suavização independente de FPS)

## ✅ Eu sei...

- [ ] a diferença entre `_ready`, `_process` e `_physics_process`
- [ ] por que multiplicar por `delta`
- [ ] usar `@export` e `@onready`
- [ ] declarar, emitir e conectar sinais (pelo código e pelo editor)
- [ ] explicar "chame para baixo, sinalize para cima"
- [ ] ex07, ex08 e ex09 verdes

➡️ Próxima: [04 · Primeiro jogo 2D: a nave](04-primeiro-jogo-2d.md)
