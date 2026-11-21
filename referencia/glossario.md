# Glossário

| Termo | Significado |
|---|---|
| **Nó (Node)** | bloco básico do Godot; cada um faz uma coisa |
| **Cena (Scene, .tscn)** | árvore de nós salva; reutilizável e instanciável |
| **Instância** | uma cópia de uma cena usada dentro de outra |
| **Script (.gd)** | comportamento anexado a um nó; estende o tipo do nó |
| **Sinal (Signal)** | evento que um nó emite e outros escutam |
| **Grupo** | etiqueta para achar/afetar vários nós (`"inimigos"`) |
| **Autoload / Singleton** | nó global criado no início e mantido entre cenas |
| **Resource (.tres/.res)** | dado reutilizável (material, tema, SpriteFrames, curva...) |
| **`res://`** | pasta do projeto (somente leitura no jogo exportado) |
| **`user://`** | pasta de dados do jogador (saves, configs) |
| **delta** | segundos desde o último frame |
| **Frame / FPS** | um quadro desenhado / quadros por segundo |
| **Physics tick** | passo fixo da física (60/s por padrão) |
| **Viewport** | "tela" onde algo é renderizado |
| **CanvasLayer** | camada 2D independente da câmera (UI) |
| **Control** | nó de interface (botões, textos, containers) |
| **Âncora (Anchor)** | ponto da tela do pai ao qual um Control se prende |
| **Collision Layer / Mask** | em que camadas estou / quais camadas enxergo |
| **Tween** | animação de propriedade criada por código |
| **Juice** | feedback exagerado que deixa o jogo gostoso (som, tremor, partículas) |
| **Stretch mode / aspect** | como o jogo se adapta a resoluções diferentes |
| **Safe area** | área da tela livre de notch/cantos/barras |
| **Export template** | motor pré-compilado usado para exportar para uma plataforma |
| **APK / AAB** | pacote Android para instalar / para publicar na Play Store |
| **Draw call** | pedido de desenho para a GPU; menos = mais rápido |
| **Object pooling** | reaproveitar objetos em vez de criar/destruir |
| **Low poly** | estilo 3D com poucos polígonos |
| **UV** | mapeamento da textura 2D sobre o modelo 3D |
| **Armature / Bone** | esqueleto / osso para animar modelos |
| **Rigging / Skinning / Weights** | montar esqueleto / ligar malha / influência de cada osso |
| **Action** (Blender) | uma animação; vira uma animação no AnimationPlayer |
| **glTF / .glb** | formato aberto de modelos 3D (o preferido pelo Godot) |
| **Greyboxing** | prototipar o jogo com formas simples antes da arte |
