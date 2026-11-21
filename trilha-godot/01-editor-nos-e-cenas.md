# 01 · O editor, nós e cenas

> ⏱️ ~2h · 🎯 Entender a ideia central do Godot: **tudo é uma árvore de nós**

## A ideia central

No Godot, um jogo é feito de **nós** (*nodes*). Cada nó faz **uma** coisa:

| Nó | O que faz |
|---|---|
| `Sprite2D` | mostra uma imagem |
| `CollisionShape2D` | define uma forma de colisão |
| `Area2D` | detecta quando algo entra nela |
| `CharacterBody2D` | corpo que você move por código, com colisão |
| `Timer` | conta tempo e avisa quando acaba |
| `AudioStreamPlayer` | toca um som |
| `Label`, `Button` | texto e botão de interface |
| `Camera2D` | define o que aparece na tela |

Você **combina** nós numa árvore para criar coisas mais complexas:

```
Jogador (CharacterBody2D)      ← o "dono": tem o script com a lógica
├── Sprite2D                   ← aparência
├── CollisionShape2D           ← forma física
└── AudioStreamPlayer2D        ← som de pulo
```

Essa árvore salva num arquivo `.tscn` é uma **cena**. E aqui está o pulo do gato:
**uma cena pode ser usada dentro de outra** (instanciada). O `Jogador.tscn` vira um único nó dentro
do `Fase1.tscn`. Inimigos, moedas, balas, botões, a fase inteira — tudo são cenas.

> Pense em cenas como "prefabs" (Unity) ou "componentes" (React). Uma cena = um objeto reutilizável.

## Tour pelo editor

Abra o Godot e crie um projeto novo em `meus-projetos/01-tour` (renderer: **Compatibility**).

```
┌─────────────┬──────────────────────────────────┬──────────────┐
│ Scene       │      Viewport (2D / 3D / Script)  │  Inspector   │
│ (árvore de  │                                    │ (propriedades│
│  nós)       │                                    │  do nó       │
├─────────────┤                                    │  selecionado)│
│ FileSystem  │                                    │              │
│ (arquivos   ├──────────────────────────────────┤  Node        │
│  res://)    │ Output / Debugger / Audio ...      │ (sinais)     │
└─────────────┴──────────────────────────────────┴──────────────┘
```

- **Scene**: a árvore de nós da cena aberta.
- **FileSystem**: os arquivos do projeto. `res://` é a raiz do projeto.
- **Inspector**: propriedades do nó selecionado. Passe o mouse sobre qualquer propriedade para ver a explicação.
- **Node** (aba ao lado do Inspector): os **sinais** do nó e os **grupos**.
- **Output**: onde aparece o `print()`.
- Topo: **2D**, **3D**, **Script**, **AssetLib** alternam o painel central.

## Mão na massa: sua primeira cena

1. Na aba Scene, clique **Other Node** → busque `Node2D` → crie. Renomeie para `Mundo` (F2 ou duplo clique).
2. Com `Mundo` selecionado, **Cmd+A** (adicionar filho) → `Sprite2D`.
3. Arraste o `icon.svg` do FileSystem para a propriedade **Texture** do Sprite2D no Inspector.
4. Mova o sprite no viewport (tecla **W** = mover, **E** = girar, **S** = escalar).
5. **Cmd+S** para salvar como `mundo.tscn`.
6. **Cmd+B** (rodar projeto). Ele pergunta qual é a cena principal → *Select Current*.

🎉 Você tem uma janela com o ícone do Godot.

### Agora com instâncias

1. Crie uma cena nova (**Cmd+N**), raiz `Sprite2D` com o `icon.svg`. Salve como `icone.tscn`.
2. Volte em `mundo.tscn`. Arraste `icone.tscn` do FileSystem para o viewport **3 vezes**.
3. Abra `icone.tscn` e mude o **Modulate** (Inspector → CanvasItem → Visibility) para vermelho. Salve.
4. Volte para `mundo.tscn`: **todas as instâncias ficaram vermelhas**. Esse é o poder das cenas.
5. Mude a escala de **uma** das instâncias no mundo — só ela muda (você sobrescreveu a propriedade localmente;
   repare no ícone ↺ de "reverter" no Inspector).

## Coordenadas 2D

- Origem `(0, 0)` no **canto superior esquerdo**.
- **X** cresce para a direita, **Y cresce para baixo** (ao contrário da matemática da escola!).
- `position` é relativa ao **pai**. `global_position` é relativa ao mundo.

Experimente: mova o `Mundo` (pai) e veja os filhos irem junto.

## Explore o projeto pronto

Importe `projetos/01-chuva-de-estrelas` e:

1. Rode (**Cmd+B**). Jogue um pouco (o mouse simula o dedo).
2. Abra `cenas/main.tscn` e observe a árvore. Clique em cada nó e leia o Inspector.
3. Abra `cenas/jogador.tscn`. Quais nós formam a nave?
4. Na cena main, selecione `Spawner` → aba **Node**: veja o sinal `timeout` conectado (ícone verde).
5. Com o jogo rodando, vá em **Debugger → Remote** (na aba Scene aparece "Remote") — você vê a árvore **ao vivo**,
   com os itens sendo criados e destruídos.

## 🏋️ Exercícios

1. Na sua cena `mundo.tscn`, adicione um `Label` com seu nome e um `ColorRect` como fundo.
   Qual aparece na frente? Mude a ordem na árvore e veja o que acontece. (Dica: a ordem da árvore é a ordem de desenho.)
2. Ache no Inspector do Sprite2D a propriedade que espelha a imagem horizontalmente.
3. No projeto Chuva de Estrelas, mude a cor da nave e o tamanho da tela de jogo (*Project Settings → Display → Window*).

## ✅ Eu sei...

- [ ] explicar o que é um nó e o que é uma cena
- [ ] instanciar uma cena dentro de outra
- [ ] usar Inspector, FileSystem e a árvore Remote do Debugger
- [ ] explicar por que Y cresce para baixo no 2D

## 💬 Perguntas para o tutor

- "Quando eu devo criar uma cena separada em vez de só adicionar nós?"
- "Qual a diferença entre Node, Node2D e Control?"

➡️ Próxima: [02 · GDScript básico](02-gdscript-basico.md)
