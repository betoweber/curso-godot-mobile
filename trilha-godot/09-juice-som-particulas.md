# 09 · Juice: som, partículas, tweens e tremor

> ⏱️ ~3h · 🎯 Transformar um protótipo "correto" num jogo **gostoso** de jogar

"Juice" é o feedback exagerado que faz cada ação parecer satisfatória. Mesmo jogo, mesma lógica — a diferença
entre "meh" e "só mais uma partida". Assista à palestra clássica *"Juice it or lose it"* (Martin Jonasson & Petri Purho, YouTube).

## Tweens — animação por código

```gdscript
# Pulsar o placar quando ganha ponto
var t := create_tween()
t.tween_property(%Pontos, "scale", Vector2(1.4, 1.4), 0.08)
t.tween_property(%Pontos, "scale", Vector2.ONE, 0.12)
```

```gdscript
# Várias propriedades ao mesmo tempo, com curva e no fim remove o nó
var t := create_tween().set_parallel()
t.tween_property(self, "scale", Vector2(1.8, 1.8), 0.15).set_trans(Tween.TRANS_BACK)
t.tween_property(self, "modulate:a", 0.0, 0.15)
t.chain().tween_callback(queue_free)
```

- `set_trans()` muda a curva (`TRANS_SINE`, `TRANS_BACK`, `TRANS_ELASTIC`, `TRANS_BOUNCE`...).
- `set_ease()` define onde a curva acelera (`EASE_IN`, `EASE_OUT`, `EASE_IN_OUT`).
- Veja as curvas em [easings.net](https://easings.net).
- `await t.finished` espera o tween terminar.

> ⚠️ Para o `scale` funcionar num `Label`/Control, ajuste o **Pivot Offset** para o centro do nó.

## Partículas

`CPUParticles2D` / `GPUParticles2D`. Configurações-chave:

| Propriedade | Efeito |
|---|---|
| `amount`, `lifetime` | quantas e por quanto tempo |
| `one_shot` + `explosiveness = 1` | explosão única (todas de uma vez) |
| `direction`, `spread` | para onde vão (spread 180 = todas as direções) |
| `initial_velocity`, `gravity` | velocidade e queda |
| `scale_amount`, `color_ramp` | tamanho e cor ao longo da vida (fade out!) |
| `emission_shape` | de um ponto, círculo, retângulo... |

O gabarito tem dois exemplos: a explosão do meteoro (`item.tscn`) e o céu estrelado de fundo (`main.tscn` → `CeuEstrelado`).

## Tremor de tela (screen shake)

```gdscript
var tremor := 0.0

func tremer(forca: float) -> void:
	tremor = forca

func _process(delta: float) -> void:
	if tremor > 0:
		$Camera2D.offset = Vector2(randf_range(-1, 1), randf_range(-1, 1)) * tremor
		tremor = move_toward(tremor, 0, 60 * delta)
```

Combine com `Input.vibrate_handheld(120)` — no celular a vibração é parte do juice!

Outros truques baratos e eficazes:
- **Hit stop**: congelar o jogo ~50 ms no impacto (`Engine.time_scale = 0.05`, depois volta a 1 com um timer
  criado com `get_tree().create_timer(0.05, true, false, true)` — o último `true` ignora o time_scale).
- **Flash branco** no sprite atingido (modulate ou shader).
- **Squash & stretch**: achatar/esticar no pulo e na aterrissagem.
- **Números flutuantes**: "+1" subindo e sumindo onde pegou a estrela.

## Som

```
Jogador
└── SomPegar (AudioStreamPlayer2D)    ← Stream: pegar.wav
```

```gdscript
$SomPegar.pitch_scale = randf_range(0.9, 1.1)   # variação evita repetição irritante
$SomPegar.play()
```

- `AudioStreamPlayer` (sem posição, para música/UI), `AudioStreamPlayer2D`/`3D` (com posição e volume pela distância).
- **Cuidado**: se o nó for removido com `queue_free()`, o som corta. Para o som da estrela coletada, toque o som
  no jogador ou num gerenciador de áudio (autoload), não na estrela.
- **Barramentos (Audio Buses)**: aba *Audio* embaixo. Crie `Musica` e `Efeitos` e aponte cada player para o seu.
  Daí um menu de volume é só `AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"), db)`.
- Música em loop: no import do `.ogg`, marque **Loop**.

### Onde conseguir sons

- **Gerar efeitos 8-bit**: [jsfxr](https://sfxr.me) ou ChipTone (navegador) — perfeitos com pixel art.
- **Bibliotecas livres**: [Kenney](https://kenney.nl/assets?q=audio) (CC0), [OpenGameArt](https://opengameart.org), [Freesound](https://freesound.org) (confira a licença).

## 🏋️ Exercícios

1. Adicione ao seu jogo: som ao pegar estrela (com pitch aleatório), som de explosão, música de fundo em loop.
2. Faça o placar "pular" a cada ponto (tween) e um "+1" flutuante.
3. Explosão de partículas amarelas ao pegar estrela.
4. **Desafio**: hit stop + flash branco + tremor quando um meteoro atinge a nave. Compare jogar com e sem.

## ✅ Eu sei...

- [ ] criar tweens sequenciais e paralelos
- [ ] configurar uma explosão one-shot de partículas
- [ ] fazer tremor de tela com Camera2D
- [ ] tocar sons sem cortar quando o nó some
- [ ] usar audio buses para separar música e efeitos

➡️ Próxima: [10 · Autoload, salvar progresso e trocar de cena](10-autoload-save-cenas.md)
