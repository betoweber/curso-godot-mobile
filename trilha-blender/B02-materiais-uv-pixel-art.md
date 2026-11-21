# B02 · Materiais, UV e texturas pixel art

> ⏱️ ~3h · 🎯 Colorir modelos de dois jeitos leves para mobile — e usar o Aseprite no 3D

## Jeito 1 — Cores chapadas por material (mais simples)

1. Selecione o objeto → Properties → aba **Material** (bolinha vermelha) → **New**.
2. Em *Base Color*, escolha a cor. *Roughness* alto (0.8–1) para visual fosco "de brinquedo".
3. Para várias cores: clique **+** para criar mais *slots* de material. Em Edit Mode, selecione as faces →
   escolha o material → **Assign**.

✅ Exporta perfeitamente para o Godot (vira `StandardMaterial3D`).
⚠️ Cada material a mais = mais *draw calls*. Para mobile, 1–4 materiais por modelo está ótimo.

## Jeito 2 — Textura pixel art com paleta (o queridinho do low poly)

Ideia: **uma única imagem pequena** (ex: 16×16) com quadradinhos de cor (uma paleta). Cada face do modelo é
mapeada (UV) para cima de uma cor. Resultado: 1 material, 1 textura minúscula, qualquer número de cores.
E com texturas um pouco maiores (32×32, 64×64), você **desenha detalhes em pixel art** (olhos, roupas, tábuas do caixote).

### O que é UV?

O modelo é 3D; a imagem é 2D. O **UV map** diz qual pedaço da imagem vai em cada face — como desmontar uma caixa de
papelão e deitar no chão. U e V são os eixos da imagem (como X e Y).

### Passo a passo

1. **Aseprite**: crie uma imagem 32×32 com sua paleta (ex: 4×4 quadrados de 8 px) ou o desenho da textura.
   Exporte `textura_personagem.png`.
2. **Blender**: workspace **UV Editing** (aba no topo). Esquerda: editor de UV/imagem. Direita: viewport 3D.
3. No editor de imagem: *Image → Open* → sua textura.
4. No material do objeto (workspace **Shading**): Shift+A → *Texture → Image Texture*, escolha a imagem,
   ligue **Color → Base Color** do Principled BSDF.
5. ⭐ No nó Image Texture, troque **Linear → Closest**. Sem isso a pixel art fica borrada.
6. Volte ao UV Editing. Edit Mode, selecione tudo, **U → Smart UV Project** (ou *Unwrap* depois de marcar *seams*).
7. Agora selecione grupos de faces no 3D e, no editor UV, **S** (escala 0) para encolhê-las num ponto e **G** para
   arrastar para cima da cor desejada. Para faces com desenho, posicione/escale a ilha UV sobre o desenho.
8. Viewport em modo **Material Preview** (Z → Material Preview) para ver o resultado.

> 💡 **Fluxo de ida e volta**: deixe o Aseprite e o Blender abertos. Salve no Aseprite → no Blender,
> *Image → Reload* (Option+R no editor de imagem). Iteração rápida!

> 💡 **Densidade de pixels**: para o visual ficar coerente, tente manter todos os pixels do mesmo tamanho no modelo.
> Ex: 1 pixel da textura ≈ 3 cm no modelo, em todas as faces.

## No Godot (prévia da B04)

O glTF leva a textura junto, mas o filtro *Closest* nem sempre vem. No Godot, no material do mesh importado:
**Sampling → Filter → Nearest**. Ou, na importação, extraia os materiais e ajuste uma vez (detalhes na B04).

## 🏋️ Exercícios

1. Caixote com textura 32×32 desenhada no Aseprite (tábuas, pregos).
2. Personagem da B01 com uma paleta 16×16 (Jeito 2): pele, roupa, cabelo, olhos.
3. **Desafio**: a mesma paleta para **todos** os modelos do seu jogo (moeda, caixote, árvore, personagem) — uma
   textura só para tudo. Isso dá unidade visual e é super eficiente.

## ✅ Eu sei...

- [ ] criar materiais e atribuir a faces
- [ ] explicar o que é UV
- [ ] usar Image Texture com interpolação Closest
- [ ] mapear faces sobre uma paleta pixel art

➡️ [B03 · Esqueleto e animação](B03-rig-e-animacao.md)
