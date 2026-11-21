# B03 · Esqueleto (rig) e animação

> ⏱️ ~4h · 🎯 Personagem com animações `idle` e `correr` prontas para o Godot

## Conceitos

- **Armature** (armadura): o esqueleto, feito de **bones** (ossos).
- **Rigging**: ligar a malha aos ossos (*skinning*). Cada vértice tem **pesos** dizendo quanto cada osso o move.
- **Pose Mode**: onde você posiciona os ossos para animar.
- **Action**: uma animação (sequência de *keyframes*). Cada Action vira uma animação no `AnimationPlayer` do Godot.

## Opção A — Rápido: Rigify ou Auto-Rig

Para humanoides existe o addon **Rigify** (vem com o Blender; ative em Preferences → Add-ons). Ele gera um rig
completo — mas complexo e pesado para um personagem low poly de celular. **Para começar, prefira a Opção B**.
Outra alternativa: o site **Mixamo** (Adobe, gratuito com conta) faz rig e animações automaticamente a partir de um
modelo exportado em FBX.

## Opção B — Esqueleto simples na mão (recomendado para aprender)

### 1. Criar ossos

1. Object Mode, cursor 3D na origem. Shift+A → **Armature** (cria um osso).
2. Na aba de propriedades da armadura (bonequinho verde) → *Viewport Display* → **In Front** ✅ (vê através da malha).
3. Tab (Edit Mode da armadura). Posicione o primeiro osso como **quadril** (`hips`).
4. Selecione a ponta e **E** para extrudar ossos encadeados: `spine` → `head`.
5. Para braços/pernas: a partir do quadril/peito, E para extrudar `upper_arm.L` → `forearm.L`, `thigh.L` → `shin.L`.
6. Nomes terminando em `.L`/`.R` permitem espelhar: selecione os ossos do lado esquerdo →
   *Armature → Symmetrize*.
7. Renomeie todos os ossos (F2). Nomes claros ajudam muito no Godot.

> Um personagem chibi precisa de ~10–15 ossos. Menos ossos = mais leve no celular.

### 2. Ligar a malha

1. Object Mode: clique na **malha**, depois Shift+clique na **armadura** (a armadura por último = ativa).
2. **Ctrl+P → With Automatic Weights**.
3. Teste: selecione a armadura → **Pose Mode** (Ctrl+Tab) → gire ossos (R). A malha deve acompanhar.
4. Algo deforma errado? Selecione a malha → modo **Weight Paint** e pinte (vermelho = 100% de influência,
   azul = 0%). Em low poly, muitas vezes é mais fácil atribuir pesos por grupo de vértices em Edit Mode
   (Properties → Object Data → Vertex Groups → Assign com Weight 1.0) — cada parte rígida segue um osso.

### 3. Animar

1. Workspace **Animation**. Mude um painel para **Dope Sheet → Action Editor**.
2. Clique **New** e renomeie a Action para `idle`.
3. Pose Mode, frame 1: selecione todos os ossos (A) → **I** → *Location & Rotation* (cria keyframes).
4. Frame 20: abaixe levemente o quadril e incline a cabeça → I.
5. Frame 40: copie o frame 1 (no Dope Sheet: selecione as chaves do frame 1 → Shift+D → arraste para 40).
6. Defina o fim da animação em 40 (Timeline → End). Espaço = play.
7. Clique no ícone de **escudo (Fake User)** ao lado do nome da Action — senão o Blender pode descartar
   Actions não usadas ao salvar!
8. **New Action** → `correr`: ciclo de 16–24 frames com pernas alternando (frame 1: perna esquerda na frente,
   meio: direita na frente, fim = início).

> 💡 **Nome com `-loop`**: Actions terminadas em `-loop` (ex: `correr-loop`) são importadas pelo Godot já com loop ativado.
> Ou ative o loop depois, no Godot.

> ℹ️ Em versões recentes do Blender (4.4+), Actions ganharam **slots** (uma Action pode animar vários objetos).
> Para um único personagem o fluxo acima continua igual; se a interface mostrar um campo "Slot", deixe o padrão.

### Princípios que fazem diferença mesmo em low poly

- **Antecipação e exagero**: antes do pulo, agachar.
- **Overlap**: cabeça e braços atrasam 1–2 frames em relação ao corpo.
- **Ciclos**: o primeiro e o último frame iguais para o loop não "pular".
- Animações de jogo são **curtas** (0,5–1,5 s) e legíveis de longe.

## 🏋️ Exercícios

1. Rig do personagem da B01/B02 com ≤ 15 ossos.
2. Actions: `idle-loop`, `correr-loop`, `pular` (sem loop).
3. **Desafio**: uma animação `comemorar` para quando pegar todas as moedas na Arena 3D.

## ✅ Eu sei...

- [ ] criar uma armadura com ossos nomeados e simétricos
- [ ] fazer *parenting* com pesos automáticos e corrigir pesos
- [ ] criar várias Actions e protegê-las com Fake User
- [ ] fazer um ciclo de animação que dá loop sem "pulo"

➡️ [B04 · Exportar para o Godot](B04-exportar-para-godot.md)
