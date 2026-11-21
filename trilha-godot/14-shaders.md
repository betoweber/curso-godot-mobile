# 14 · Shaders para low poly e pixel art

> ⏱️ ~4h · 🎯 Entender o que é um shader e criar os 3 efeitos que mais combinam com seu estilo:
> **toon**, **contorno** e **flash de dano**
> 📁 Prontos nos gabaritos: `projetos/02-arena-3d/shaders/` e `projetos/01-chuva-de-estrelas/shaders/`

## O que é um shader?

Um **programa que roda na placa de vídeo**, milhares de vezes em paralelo: uma vez para cada vértice e/ou para cada
pixel. Com ele você controla **como as coisas são desenhadas**: cor, luz, deformação, transparência.

O Godot usa uma linguagem parecida com GLSL (C). Arquivos `.gdshader`. Três funções principais:

| Função | Roda para cada... | Usa para |
|---|---|---|
| `vertex()` | vértice | deformar/mover a malha (vento, ondas, inflar) |
| `fragment()` | pixel | a cor base (`ALBEDO` no 3D, `COLOR` no 2D) |
| `light()` | pixel × cada luz | como a luz ilumina (toon, etc.) — só 3D |

E o tipo no topo:
- `shader_type canvas_item;` → 2D e UI
- `shader_type spatial;` → 3D
- (`particles`, `sky`, `fog` → casos especiais)

### Sintaxe em 1 minuto

```glsl
shader_type canvas_item;

uniform float intensidade : hint_range(0.0, 1.0) = 0.5;  // aparece no Inspector
uniform vec4 cor : source_color = vec4(1.0);              // seletor de cor

void fragment() {
	vec4 c = COLOR;                 // vec2, vec3, vec4 = vetores de 2, 3, 4 floats
	c.rgb = mix(c.rgb, cor.rgb, intensidade);   // mix = lerp
	COLOR = c;
}
```

- Todo número com ponto: `1.0`, não `1` (float e int não se misturam).
- Sem `print()`. Para "depurar", pinte a saída: `COLOR = vec4(UV, 0.0, 1.0);` mostra as coordenadas UV como cor.
- Funções úteis: `mix`, `clamp`, `step`, `smoothstep`, `floor`, `fract`, `sin`, `dot`, `length`, `texture(...)`.
- `TIME` = segundos desde o início (para animar).

### Como aplicar

1. Selecione o nó (Sprite2D, MeshInstance3D...) → **Material** → *New ShaderMaterial*.
2. Clique no ShaderMaterial → **Shader** → *New Shader* → salve como `.gdshader`.
3. O editor de shader abre embaixo. Os `uniform`s aparecem em *Shader Parameters* no Inspector.
4. Por código: `material.set_shader_parameter("intensidade", 1.0)`.

> 💡 **Visual Shaders**: na hora de criar, dá para escolher *VisualShader* (editor de nós, sem código, parecido com o
> Shader Editor do Blender). Bom para experimentar; aqui vamos de código, que é mais fácil de ler e versionar.

## Efeito 1 — Flash de dano (2D)

`projetos/01-chuva-de-estrelas/shaders/flash.gdshader`:

```glsl
shader_type canvas_item;
uniform vec4 cor_flash : source_color = vec4(1.0);
uniform float intensidade : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	COLOR.rgb = mix(COLOR.rgb, cor_flash.rgb, intensidade);
}
```

E no `jogador.gd`, um Tween anima o parâmetro de 1 até 0 em 0,25 s:

```gdscript
create_tween().tween_method(
	func(v: float): material_flash.set_shader_parameter("intensidade", v), 1.0, 0.0, 0.25)
```

> Por que não usar `modulate = Color.WHITE`? `modulate` **multiplica** a cor — branco × cor = a mesma cor.
> Ficar branco de verdade só com shader. É o efeito clássico de "levou dano" em pixel art.

⚠️ Todos os nós que usam o **mesmo** material compartilham os parâmetros. Para piscar só um inimigo,
marque **Resource → Local to Scene** no ShaderMaterial (cada instância ganha sua cópia).

## Efeito 2 — Toon shading (3D)

`projetos/02-arena-3d/shaders/toon.gdshader` — leia os comentários do arquivo. A ideia central:

```glsl
void light() {
	float luz = clamp(dot(NORMAL, LIGHT), 0.0, 1.0) * ATTENUATION;  // 0..1 (degradê suave)
	float degrau = floor(luz * float(faixas) + 0.5) / float(faixas); // 0, 0.33, 0.66, 1 (degraus!)
	vec3 tom = mix(cor_sombra.rgb, vec3(1.0), degrau);              // sombra colorida
	DIFFUSE_LIGHT += tom * LIGHT_COLOR / PI;
}
```

- `dot(NORMAL, LIGHT)` mede o quanto a superfície está virada para a luz.
- `floor(...)` transforma o degradê em **faixas** → visual de desenho animado.
- Sombras **coloridas** (roxo, azul) em vez de cinza deixam o low poly bem mais bonito.
- A textura usa `filter_nearest` → funciona com suas texturas pixel art da trilha Blender (B02).

> Atalho sem shader: `StandardMaterial3D` → *Shading → Diffuse Mode = Toon*. Menos controle, mas zero código.

## Efeito 3 — Contorno (3D)

`contorno.gdshader` usa a técnica **inverted hull**: desenha o modelo de novo, inflado ao longo das normais e só com as
faces de trás (`cull_front`), numa cor sólida. Ligue no **Next Pass** do material toon (veja `cenas/jogador.tscn`).

```glsl
shader_type spatial;
render_mode unshaded, cull_front;
uniform float espessura = 0.025;
void vertex() { VERTEX += NORMAL * espessura; }
void fragment() { ALBEDO = vec3(0.08, 0.05, 0.12); }
```

⚠️ **Em modelos low poly com sombreamento flat** (Shade Flat no Blender), as normais são separadas por face e o contorno
"abre" nas quinas. Soluções: no Blender use *Shade Smooth* (ou *Smooth by Angle*) numa cópia do modelo só para o contorno, ou use
`espessura` bem pequena, ou o recurso *Grow* do `StandardMaterial3D` (aba *Grow*) num next pass com *Cull Mode = Front*.
Em formas arredondadas (personagens) funciona muito bem.

## Mais ideias (tente sozinho!)

| Efeito | Pista |
|---|---|
| Vento em árvores/grama | `vertex()`: `VERTEX.x += sin(TIME * 2.0 + VERTEX.y) * 0.05 * VERTEX.y;` |
| Água rolando (2D) | `fragment()`: `texture(TEXTURE, UV + vec2(TIME * 0.1, 0.0))` com textura em *Repeat* |
| Dissolver (morte do inimigo) | textura de ruído (`NoiseTexture2D`) + `if (ruido < progresso) discard;` |
| Contorno 2D de sprite pixel art | amostre os 4 vizinhos com `TEXTURE_PIXEL_SIZE` e pinte onde o alfa do vizinho > 0 |
| Paleta trocada (skins) | `fragment()`: substitua cores exatas por outras (ótimo para pixel art) |

[godotshaders.com](https://godotshaders.com) tem centenas de exemplos gratuitos — leia o código para aprender.

## Shaders e celular

- O `fragment()` roda **para cada pixel da tela** — telas de celular têm milhões. Mantenha simples.
- Evite `discard` e transparência em áreas grandes (custam caro em GPUs mobile).
- `light()` customizado roda por luz: poucas luzes no 3D mobile (1 direcional + poucas omni).
- Na primeira vez que um shader aparece, ele é **compilado** → pode dar um "engasgo". Mostre os efeitos
  numa tela de carregamento ou no menu antes (o Godot 4 tem melhorado isso com cache de pipelines, mas teste no aparelho).
- Os renderers *Compatibility* e *Mobile* suportam shaders customizados; alguns recursos avançados só existem no *Forward+*.

## 🏋️ Exercícios

1. Na Arena 3D, ajuste `faixas`, `cor_sombra` e `espessura` no Inspector (jogador → Modelo → Corpo → material) e
   veja ao vivo.
2. Aplique o toon nas caixas e no chão (com cores diferentes). Dica: crie **um** material `.tres` e reutilize.
3. Faça os meteoros do Chuva de Estrelas piscarem em vermelho antes de explodir (reuse o flash com outra `cor_flash`).
4. Crie o shader de **vento** e aplique numa árvore low poly sua (trilha Blender).
5. **Desafio**: shader de **dissolver** para quando um inimigo morre na Arena 3D.

## ✅ Eu sei...

- [ ] explicar vertex, fragment e light
- [ ] criar um ShaderMaterial, expor `uniform`s e alterá-los por código
- [ ] fazer flash de dano, toon e contorno
- [ ] usar Local to Scene quando cada instância precisa do seu valor
- [ ] citar cuidados de desempenho com shaders no celular

➡️ Próxima (bônus): [15 · Publicar nas lojas](15-publicar-nas-lojas.md)
