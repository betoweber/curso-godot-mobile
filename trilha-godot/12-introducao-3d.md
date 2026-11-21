# 12 · Introdução ao 3D

> ⏱️ ~4h · 🎯 Os conceitos do 3D no Godot e um personagem andando com joystick virtual
> 📁 Gabarito: `projetos/02-arena-3d`

Tudo que você aprendeu vale no 3D: nós, cenas, sinais, scripts. Muda o espaço e alguns nós.

## Equivalências 2D → 3D

| 2D | 3D |
|---|---|
| `Node2D` | `Node3D` |
| `Sprite2D` | `MeshInstance3D` (malha) / `Sprite3D` |
| `Area2D`, `CharacterBody2D`... | `Area3D`, `CharacterBody3D`... |
| `CollisionShape2D` | `CollisionShape3D` |
| `Camera2D` | `Camera3D` |
| `Vector2` | `Vector3` |
| — | `DirectionalLight3D`, `OmniLight3D`, `SpotLight3D` (luzes) |
| — | `WorldEnvironment` (céu, luz ambiente, efeitos) |

### Eixos

- **Y é para cima** no 3D (ao contrário do 2D!). O chão é o plano **XZ**.
- **-Z é "para frente"** por convenção do Godot (câmeras olham para -Z).
- Cores dos eixos no editor: **X vermelho, Y verde, Z azul**.

## Navegando no viewport 3D (Mac)

- **Botão direito + mover o mouse**: olhar em volta. Segurando o botão direito, **WASD** voa pela cena (modo freelook).
- **Trackpad**: dois dedos orbitam; **Shift** + dois dedos move; pinça dá zoom.
- **F**: foca no objeto selecionado.
- O "gizmo" de eixos no canto superior direito: clique num eixo para ver de frente/topo/lado.
- **Q/W/E/R**: selecionar / mover / girar / escalar.

## Anatomia de uma cena 3D

```
Main (Node3D)
├── WorldEnvironment      ← céu (ProceduralSkyMaterial), luz ambiente, tonemap
├── Sol (DirectionalLight3D)  ← luz "infinita", com sombras
├── Chao (StaticBody3D)       ← corpo que não se move
│   ├── MeshInstance3D        ← o que se VÊ
│   └── CollisionShape3D      ← o que COLIDE (formas simples = mais rápido)
├── Jogador (CharacterBody3D)
└── Camera3D
```

> 💡 Atalho: na barra do viewport 3D há botões para **adicionar sol e ambiente de preview** à cena com um clique
> (os três pontinhos ao lado de "Perspective" / ícones de sol e globo).

### Meshes primitivas

`MeshInstance3D` → Mesh: `BoxMesh`, `SphereMesh`, `CapsuleMesh`, `CylinderMesh`, `PlaneMesh`...
Perfeitas para prototipar ("greyboxing") antes de modelar no Blender.

### Materiais

`StandardMaterial3D` (em *Material Override* ou no próprio mesh):
- **Albedo**: cor/textura base
- **Metallic / Roughness**: metal vs. plástico, polido vs. fosco
- **Emission**: brilho próprio
- **Texture Filter → Nearest**: essencial para texturas pixel art (trilha Blender, B02)

## CharacterBody3D: movimento

Leia `projetos/02-arena-3d/scripts/jogador_3d.gd`. Pontos-chave:

```gdscript
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravidade * delta                 # gravidade manual

	var entrada := Input.get_vector("mover_esquerda", "mover_direita", "mover_frente", "mover_tras")
	var direcao := Vector3(entrada.x, 0, entrada.y)    # 2D da entrada → plano XZ
	velocity.x = direcao.x * velocidade
	velocity.z = direcao.z * velocidade

	move_and_slide()                                   # move e desliza nas colisões
```

- `velocity` é uma propriedade do próprio CharacterBody3D.
- `move_and_slide()` usa `velocity` e `delta` internamente — **não** multiplique por delta antes.
- `is_on_floor()` só é atualizado depois de `move_and_slide()`.

### Movimento relativo à câmera

Com a câmera fixa olhando de cima (como no gabarito), "para cima no joystick" = -Z. Se a câmera girar,
você precisa girar a direção junto:

```gdscript
var direcao := (camera.global_basis * Vector3(entrada.x, 0, entrada.y))
direcao.y = 0
direcao = direcao.normalized() * entrada.length()
```

## Joystick virtual

`projetos/02-arena-3d/scripts/joystick_virtual.gd` é um `Control` que ocupa a metade esquerda da tela.
Ele aperta as ações do Input Map com intensidade, então o jogador não sabe se é teclado ou toque.
Leia o código inteiro — ele usa `_gui_input`, `index` do dedo, `limit_length` e `_draw`.

## 🏋️ Exercícios (no gabarito ou numa cópia dele)

1. Rode a Arena 3D. Ande com WASD e com o mouse no joystick.
2. Adicione um **botão de pulo** na metade direita da tela (`TouchScreenButton` com `action = "pular"`,
   ou um `Button` que chama `Input.action_press("pular")` / `action_release`).
3. Faça a câmera girar 45° em Y (visão isométrica) e corrija o movimento para ser relativo à câmera.
4. Adicione **inimigos** simples: `CharacterBody3D` vermelhos que andam em direção ao jogador
   (`direction_to`) — encostou, perde uma vida.
5. **Desafio**: um `Timer` de 60 s; pegue o máximo de moedas antes de acabar. Salve o recorde (lição 10).

## ✅ Eu sei...

- [ ] os eixos do 3D no Godot (Y para cima, -Z para frente)
- [ ] montar uma cena com ambiente, luz, chão com colisão e câmera
- [ ] mover um `CharacterBody3D` com `move_and_slide()`
- [ ] explicar como o joystick virtual se integra ao Input Map
- [ ] criar materiais básicos

➡️ Agora é uma boa hora para a [trilha Blender](../trilha-blender/README.md) — e depois: [13 · Projeto final](13-projeto-final.md)
