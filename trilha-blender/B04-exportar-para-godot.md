# B04 · Exportar para o Godot (glTF)

> ⏱️ ~2h · 🎯 Seu personagem animado andando na Arena 3D

## Por que glTF (.glb)?

glTF é o "JPEG do 3D": formato aberto, que o Godot importa muito bem — malha, materiais, texturas, esqueleto e
animações num arquivo só. Use **`.glb`** (binário, tudo num arquivo) em vez de `.gltf` + arquivos soltos.

## Exportando do Blender

*File → Export → glTF 2.0 (.glb/.gltf)*. Opções importantes:

| Seção | Opção | Valor |
|---|---|---|
| Format | | **glTF Binary (.glb)** |
| Include | Limit to → Selected Objects | ✅ se o .blend tem outras coisas (selecione malha **e** armadura) |
| Transform | +Y Up | ✅ (padrão — converte Z-up do Blender para Y-up do Godot) |
| Data → Mesh | Apply Modifiers | ✅ (aplica o Mirror etc.) |
| Data → Material | Materials: Export; Images: Automatic | |
| Animation | Animation ✅, Mode: **Actions** | exporta todas as Actions como animações |
| Animation | Always Sample Animations | pode desligar para arquivos menores; ligue se algo sair diferente |

Salve dentro do projeto Godot, ex: `projetos/02-arena-3d/modelos/personagem.glb`.

> 💡 **Exportar direto do .blend**: o Godot também importa `.blend` diretamente (ele chama o Blender por baixo dos
> panos). Configure em *Editor Settings → FileSystem → Import → Blender → Blender Path*
> (`/Applications/Blender.app/Contents/MacOS/Blender`). Prático, mas exige Blender instalado em toda máquina
> que abrir o projeto — `.glb` é mais portátil. Comece com `.glb`.

## No Godot

### 1. Ver o que veio

Volte ao editor: o `.glb` é importado. **Duplo clique** nele abre a janela **Advanced Import Settings**:
árvore de nós, materiais, animações e malhas. Dá para dar play nas animações ali.

### 2. Usar o modelo

Arraste o `.glb` para uma cena — ele vira uma instância (nó com ícone de "cena herdada"). Na Arena 3D:

1. Abra `cenas/jogador.tscn`.
2. Apague (ou esconda) os filhos `Corpo` e `Oculos` do nó `Modelo`.
3. Arraste `modelos/personagem.glb` para **dentro** de `Modelo`.
4. Ajuste escala/posição se necessário (os pés devem tocar y = 0; a cápsula de colisão deve envolver o corpo).
5. Rode. O personagem deve virar na direção do movimento (o script gira `Modelo`) — se ele andar "de costas",
   gire o modelo importado 180° em Y (ou corrija a frente no Blender: rosto para **-Y**).

### 3. Tocar as animações

O glTF importado contém um `AnimationPlayer`. No `jogador_3d.gd`:

```gdscript
@onready var anim: AnimationPlayer = $Modelo/personagem/AnimationPlayer
# (confira o caminho real na árvore: clique direito no modelo → "Editable Children" para ver os nós internos)

func _physics_process(delta: float) -> void:
	# ... movimento ...
	move_and_slide()
	_animar()

func _animar() -> void:
	var horizontal := Vector2(velocity.x, velocity.z).length()
	var nova := "idle-loop"
	if not is_on_floor():
		nova = "pular"
	elif horizontal > 0.5:
		nova = "correr-loop"
	if anim.current_animation != nova:
		anim.play(nova, 0.15)       # 0.15 s de transição suave (blend)
```

(Os nomes das animações aparecem exatamente como as Actions do Blender — veja no Advanced Import Settings.)

Para máquinas de estado mais complexas, estude `AnimationTree` + `AnimationNodeStateMachine` depois.

### 4. Colisões a partir do Blender

Para cenários, nomeie objetos no Blender com **sufixos** e o Godot cria colisões automaticamente:

| Sufixo no nome | Resultado no Godot |
|---|---|
| `-col` | malha visível + `StaticBody3D` com colisão igual à malha |
| `-convcol` | idem, com colisão convexa (mais leve) |
| `-colonly` | **só** colisão, malha invisível (use caixas simples como colisor de um modelo detalhado) |
| `-noimp` | não importa o objeto |
| `-loop` (em animações) | animação com loop |

Ex: `Caixote-convcol`, `Chao-col`, `ColisorArvore-colonly`.

### 5. Texturas pixel art nítidas

Se a textura veio borrada:
1. Advanced Import Settings → aba de **Materials** → selecione o material → **Extract** (salva como `.tres`
   editável) — ou use *Material Override* no `MeshInstance3D`.
2. No material: **Sampling → Filter → Nearest** (e *Mipmaps* desligados para visual 100% nítido de perto).

### 6. Reimportando

Mudou no Blender? Exporte por cima do mesmo `.glb`. O Godot reimporta sozinho e as cenas que usam o modelo atualizam.
(Mudanças feitas **dentro** do modelo instanciado podem se perder — por isso prefira ajustar via nós pai ou
nas configurações de importação.)

## Bônus: 3D → sprites 2D (pixel art pré-renderizada)

Técnica clássica (Donkey Kong Country, Dead Cells): modelar e animar em 3D e **renderizar como sprites**.
No Blender: câmera **ortográfica** apontada para o personagem, resolução baixa (ex: 64×64), *Render → Film →
Transparent* ✅, filtro de pixel ~0 (*Film → Filter Size* 0). Renderize a animação (Ctrl+F12) como sequência de PNGs,
monte a sprite sheet (o Aseprite importa sequências!) e retoque à mão no Aseprite. Combina seus dois mundos.

## 🏋️ Exercícios

1. Seu personagem com `idle` e `correr` animando na Arena 3D.
2. Troque as caixas da Arena pelo seu caixote (`Caixote-convcol`) e a moeda pela sua moeda.
3. **Desafio**: um cenário (árvores, pedras, cerca) modelado no Blender como **um** `.glb` com colisões por sufixo,
   substituindo o chão da arena.

## ✅ Eu sei...

- [ ] exportar `.glb` com as opções certas
- [ ] instanciar o modelo e trocar o visual do jogador
- [ ] tocar animações importadas com transição
- [ ] gerar colisões por sufixo
- [ ] deixar texturas pixel art nítidas no Godot

🎉 Trilha Blender concluída! Volte para a [lição 13 · Projeto final](../trilha-godot/13-projeto-final.md).
