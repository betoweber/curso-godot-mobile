# B01 · Modelagem low poly

> ⏱️ ~4h (3 modelos) · 🎯 Dominar as 6 ferramentas que fazem 90% de um modelo low poly

## As ferramentas (Edit Mode — Tab)

Modos de seleção no cabeçalho do viewport: **vértice / aresta / face**.

| Atalho | Ferramenta | Pense como... |
|---|---|---|
| **E** | Extrude | "puxar" uma face para fora criando volume |
| **I** | Inset | criar uma face menor dentro da face (moldura) |
| **Ctrl+R** | Loop Cut | cortar um anel de arestas (mais detalhe onde precisa) |
| **Ctrl+B** | Bevel | chanfrar quinas |
| **M** | Merge | juntar vértices |
| **F** | Fill | criar face entre vértices/arestas selecionados |
| **Option+clique** | selecionar loop | seleciona um anel inteiro |
| **L** | selecionar ligados | seleciona a "ilha" sob o cursor |

Mais duas coisas que você vai usar sempre:
- **Modificador Mirror** (Properties → chave inglesa 🔧 → Add Modifier → Generate → Mirror): modele metade, o outro lado é espelhado.
- **Shade Flat** (Object Mode → clique direito → Shade Flat): o visual facetado clássico do low poly.

## Modelo 1 — Moeda (15 min)

1. Shift+A → Mesh → **Cylinder**. No painel que aparece no canto inferior esquerdo (*Adjust Last Operation*):
   **Vertices: 12**, Radius 0.35, Depth 0.08.
2. Tab → modo face → selecione a face de cima → **I** (inset) pequeno → **E** e afunde um pouquinho (relevo).
   Repita na face de baixo.
3. R X 90 para deixar em pé. Ctrl+A → *All Transforms*.
4. Salve `fonte-blender/moeda.blend`.

## Modelo 2 — Caixote (30 min)

1. Cubo padrão. Tab, selecione todas as faces (A) → **I** → aperte **I de novo** durante o inset para fazer
   *individual* (cada face com sua moldura).
2. Com as faces internas selecionadas, **E** e um valor negativo pequeno (afunda as tábuas).
3. (Opcional) Ctrl+B nas arestas externas com 1 segmento para chanfrar.
4. Salve `fonte-blender/caixote.blend`.

## Modelo 3 — Personagem simples (2–3h)

Estilo "boneco de brinquedo": cabeça grande, corpo simples, membros como blocos. Proporções *chibi* funcionam muito bem
no celular (o jogador vê de longe, em tela pequena).

1. **Referência**: desenhe no Aseprite uma frente e um perfil 64×64 do personagem. Importe no Blender:
   Shift+A → Image → *Reference*, na vista frontal (1) e lateral (3).
2. **Corpo**: cubo → Mirror (eixo X, *Clipping* ✅) → Ctrl+R para cortar no meio → apague a metade esquerda.
   Extrude (E) as faces para formar pernas e braços; S para afinar.
3. **Cabeça**: cubo separado (ou extrudado do pescoço), Bevel com 1–2 segmentos para arredondar.
4. Mantenha **poucos polígonos**: para mobile, um personagem principal de **500 a 3.000 triângulos** é confortável.
   Veja a contagem: *Overlays* (ícone de círculos sobrepostos) → **Statistics** ✅.
5. **Origem nos pés**: o Godot posiciona o modelo pela origem. Object Mode → coloque o cursor 3D no chão
   (Shift+C reseta para a origem do mundo) → modele com os pés em Z = 0 →
   *Object → Set Origin → Origin to 3D Cursor*.
6. Olhando para **-Y** (vista frontal = tecla 1 mostra o rosto).
7. Aplique o Mirror quando terminar (ou deixe que o exportador aplique — opção *Apply Modifiers*).

## Boas práticas para assets de jogo

- **Ctrl+A → All Transforms** antes de exportar (escala 1, rotação 0).
- **Nomes claros** no Outliner (`Personagem`, `Caixote`) — viram nomes de nós no Godot.
- **Normais para fora**: Edit Mode → A → Shift+N (recalcular). Faces invertidas aparecem "furadas" no Godot.
- Evite faces com mais de 4 lados em partes que vão deformar (articulações).

## 🏋️ Exercícios

1. Os 3 modelos acima.
2. Um **cenário pequeno**: árvore low poly (cilindro + 2–3 icosferas achatadas), pedra (icosfera com vértices puxados),
   cerca.
3. **Desafio**: modele uma nave low poly para o *Chuva de Estrelas*. (Na B04 há uma dica para transformar
   modelos 3D em sprites 2D!)

## ✅ Eu sei...

- [ ] usar Extrude, Inset, Loop Cut, Bevel, Merge
- [ ] modelar simétrico com Mirror
- [ ] contar triângulos e manter o modelo leve
- [ ] colocar a origem nos pés e aplicar transformações

➡️ [B02 · Materiais, UV e texturas pixel art](B02-materiais-uv-pixel-art.md)
