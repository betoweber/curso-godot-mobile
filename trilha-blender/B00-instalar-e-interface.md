# B00 · Instalação e interface do Blender (no Mac)

> ⏱️ ~1h30

## Configuração essencial para Mac

**Edit → Preferences** (ou **Cmd+,**):

| Onde | O quê | Por quê |
|---|---|---|
| Input → **Emulate 3 Button Mouse** | ✅ | sem botão do meio: **Option + clique** orbita |
| Input → **Emulate Numpad** | ✅ | as teclas **1–9 da fileira de cima** viram o teclado numérico (vistas) |
| Input → Trackpad | padrão | **dois dedos** orbitam, **Shift+dois dedos** move, **pinça/Cmd+dois dedos** dá zoom |
| Interface → Resolution Scale | ajuste | aumente se as letras estiverem pequenas |
| Save & Load → Auto Save | ✅ | Blender trava às vezes; salve sempre (**Cmd+S**) |

> ⚠️ Com *Emulate Numpad*, as teclas 1/2/3 deixam de trocar o modo de seleção em Edit Mode... e passam a ser vistas.
> Para trocar vértice/aresta/face use os ícones no cabeçalho do viewport (ou ative/desative conforme preferir).
> Muitos tutoriais assumem teclado numérico — guarde esta tabela.

## Vistas (com Emulate Numpad)

| Tecla | Vista |
|---|---|
| 1 | frente (Ctrl+1: trás) |
| 3 | direita (Ctrl+3: esquerda) |
| 7 | topo |
| 5 | alterna perspectiva/ortográfica |
| 0 | câmera |
| ` (crase/til) | menu de vistas em pizza |
| . (ponto) ou Numpad . | focar no selecionado (também: View → Frame Selected) |

## A interface em 5 minutos

- **Viewport 3D** (centro), **Outliner** (lista de objetos, canto superior direito),
  **Properties** (abas de propriedades, embaixo à direita), **Timeline** (embaixo).
- Abas no topo (*Layout, Modeling, UV Editing, Shading, Animation*...) são **workspaces**: arranjos prontos de janelas.
- **Tab** alterna **Object Mode** (mexe em objetos inteiros) e **Edit Mode** (mexe em vértices/arestas/faces).
- **N** abre a barra lateral (medidas exatas), **T** a barra de ferramentas.
- **F3** busca qualquer comando pelo nome. Esqueceu um atalho? F3. (No Mac pode ser **fn+F3**.)

## Os atalhos de ouro

| Atalho | Ação |
|---|---|
| **G** | mover (*grab*) — depois **X/Y/Z** trava no eixo, digite um número para valor exato |
| **R** | girar |
| **S** | escalar |
| **Shift+A** | adicionar objeto |
| **X** ou **Delete** | apagar |
| **Shift+D** | duplicar |
| **Cmd+Z** | desfazer |
| **A** / **Option+A** | selecionar tudo / nada |
| **H** / **Option+H** | esconder / mostrar |
| **Ctrl+A** | aplicar transformações (importante antes de exportar!) — no Blender, vários atalhos usam **Ctrl** mesmo no Mac |

Exemplo: `G Z 2 Enter` = mover 2 metros para cima. `R X 90 Enter` = girar 90° no eixo X.

## Unidades e escala para o Godot

- 1 unidade do Blender = **1 metro** = 1 unidade do Godot. Mantenha assim.
- Um personagem humanoide ≈ **1,7–1,8 m**. Uma moeda ≈ 0,5 m (no jogo, exagerar ajuda a ver).
- O Blender usa **Z para cima**; o Godot usa **Y para cima**. O exportador glTF converte sozinho (*+Y Up*).
- A frente do personagem: no Blender, faça ele olhar para **-Y** (vista frontal, tecla 1). Ao exportar, isso vira **+Z**
  no Godot — exatamente o que o script da Arena 3D espera (`atan2(x, z)`).

## 🏋️ Exercício: aquecimento

1. Apague o cubo padrão (X). Shift+A → Mesh → Monkey (a Suzanne).
2. Orbite com o trackpad, olhe de frente (1), de lado (3), de cima (7).
3. Mova, gire e escale com G/R/S travando eixos e digitando valores.
4. Faça um "boneco de neve" com 3 esferas (UV Sphere) e um cone de nariz. Salve em `fonte-blender/boneco.blend`.

## Recursos

- Canal **Grant Abbitt** (YouTube) — low poly e assets para jogos, didático.
- **Imphenzia** — low poly muito rápido ("low poly em 10 minutos").
- Manual oficial: [docs.blender.org](https://docs.blender.org/manual/en/latest/)

➡️ [B01 · Modelagem low poly](B01-modelagem-low-poly.md)
