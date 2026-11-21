# 08 · Mobile: telas, toque e desempenho

> ⏱️ ~3h · 🎯 Entender o que muda quando o jogo roda num celular
> Esta é a lição mais diretamente ligada à sua matéria da pós — vale reler depois.

## 1. Mil telas diferentes

Celulares vão de 16:9 a 21:9 ou mais, com notch, ilha dinâmica, cantos arredondados, barras de gesto.
Estratégia do Godot: você desenha numa **resolução base** (nosso 720×1280) e escolhe como adaptar:

| Stretch Mode | O que faz | Quando usar |
|---|---|---|
| `disabled` | sem escala: 1 unidade = 1 pixel real | ferramentas, raramente jogos |
| `canvas_items` | escala tudo, desenhando em alta resolução | **maioria dos jogos mobile**, UI nítida |
| `viewport` | renderiza na base e amplia a imagem | pixel art estrita/retrô |

| Stretch Aspect | Tela com proporção diferente da base... |
|---|---|
| `keep` | barras pretas (letterbox) |
| `keep_width` / `keep_height` | mantém um eixo, expande o outro |
| `expand` | mostra **mais área** do jogo, sem barras. Seu código precisa usar `get_viewport_rect().size` em vez de 720/1280 fixos |

O gabarito usa `canvas_items` + `expand`, e por isso o jogador calcula a posição a partir do tamanho real da tela.

### Testando tamanhos diferentes no Mac

- No editor, *Project Settings → Display → Window → Size → Window Width/Height Override* — mude para
  simular um celular "alto" (ex: 360×800) ou um tablet (600×800).
- Rodando o jogo, redimensione a janela e veja a UI se adaptar.
- **Melhor ainda: teste no celular de verdade** (lição 11) — cedo e sempre.

### Safe area (notch e barras)

```gdscript
var area_segura: Rect2i = DisplayServer.get_display_safe_area()
var tela: Vector2i = DisplayServer.screen_get_size()
# Converta para coordenadas do jogo e aplique como margem no seu MarginContainer do topo.
```

Exercício guiado no final.

## 2. Toque e multitoque

- `event.index` identifica o dedo (0, 1, 2...). Num joystick + botão de pulo, cada controle "adota" um dedo
  e ignora os outros. Veja `projetos/02-arena-3d/scripts/joystick_virtual.gd`.
- `Input Devices → Pointing → Emulate Mouse From Touch` (ligado por padrão): toques geram cliques — por isso
  `Button` funciona no celular sem fazer nada.
- `Emulate Touch From Mouse`: o contrário, para testar no Mac. Só simula **um** dedo; multitoque, só no aparelho.
- Nó pronto: `TouchScreenButton` (2D) — pode disparar uma **ação** do Input Map (ex: "pular").
- **Gestos**: `InputEventMagnifyGesture` (pinça) e `InputEventPanGesture` — o Godot gera no trackpad do Mac
  e em plataformas que suportam. Para controle total (ex: zoom de câmera), calcule a pinça você mesmo
  pela distância entre dois dedos (ótimo exercício de multitoque).

### Input Map: abstraia os controles

Em *Project Settings → Input Map* crie ações (`mover_esquerda`, `pular`...) e associe teclas/botões.
O código pergunta pela **ação**, não pela tecla:

```gdscript
if Input.is_action_just_pressed("pular"): ...
var dir := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
```

O joystick virtual do projeto 3D chama `Input.action_press("mover_direita", forca)` — e o mesmo código de
movimento funciona com teclado, controle e toque. **Estude esse script.**

## 3. Recursos do aparelho

```gdscript
Input.vibrate_handheld(100)              # vibração (ms). Android: ligar permissão VIBRATE no export
OS.get_name()                            # "Android", "iOS", "macOS"...
OS.has_feature("mobile")                 # true em Android/iOS
DisplayServer.is_touchscreen_available()
Input.get_accelerometer()                # Vector3 — controle por inclinação!
DisplayServer.screen_set_keep_on(true)   # não deixa a tela apagar
```

### Ciclo de vida do app

No celular o jogador troca de app, recebe ligação, bloqueia a tela. Trate:

```gdscript
func _notification(what: int) -> void:
	match what:
		NOTIFICATION_APPLICATION_PAUSED, NOTIFICATION_APPLICATION_FOCUS_OUT:
			get_tree().paused = true
			Jogo.salvar()                       # salve! o sistema pode matar o app
		NOTIFICATION_WM_GO_BACK_REQUEST:        # botão/gesto "voltar" do Android
			abrir_menu_pausa()
```

Para o "voltar" chegar ao seu código: *Project Settings → Application → Config → Quit On Go Back* = desligado.

## 4. Desempenho

Celulares são fortes, mas têm **bateria e temperatura**. Jogo que esquenta o aparelho é desinstalado.

| Faça | Por quê |
|---|---|
| Renderer **Compatibility** para 2D | máxima compatibilidade e leveza |
| Renderer **Mobile** para 3D | feito para GPUs de celular |
| Libere com `queue_free()` o que sai da tela | memória e CPU |
| **Object pooling** para tiros/partículas muito frequentes | criar/destruir 100×/s custa caro |
| Texturas em potências razoáveis, atlas de sprites | menos memória e trocas de textura |
| `CPUParticles2D` em aparelhos antigos | `GPUParticles2D` é mais rápido, mas a Compatibility tem limitações |
| Evite `_process` em centenas de nós: desligue com `set_process(false)` quando parado | CPU |
| Limite FPS se o jogo for calmo: `Engine.max_fps = 30` | bateria |
| Áudio: `.ogg` para música, `.wav` curtos para efeitos | tamanho vs. CPU |

Ferramentas: **Debugger → Profiler** (o que custa tempo por frame), **Monitors** (FPS, draw calls, memória),
e **Debug → Deploy with Remote Debug** para ver tudo isso **com o jogo rodando no celular**.

## 🏋️ Exercícios

1. Rode o Chuva de Estrelas com override 360×800 e depois 800×800. O que quebra? Conserte.
2. Implemente pausa automática ao trocar de app (`NOTIFICATION_APPLICATION_FOCUS_OUT`).
3. **Safe area**: faça o `MarginContainer` do topo usar a safe area como margem superior mínima.
4. **Desafio**: controle a nave por **inclinação** (`Input.get_accelerometer().x`) como opção nas configurações.
   Só dá para testar no aparelho.

## ✅ Eu sei...

- [ ] explicar stretch mode e aspect, e escolher para 2D/pixel art/3D
- [ ] escrever código que não depende de 720×1280 fixos
- [ ] tratar multitoque por `index`
- [ ] usar Input Map e por que isso ajuda no mobile
- [ ] tratar pausa do app e o botão voltar
- [ ] citar 5 cuidados de desempenho no mobile

➡️ Próxima: [09 · Juice: som, partículas, tweens e tremor](09-juice-som-particulas.md)
