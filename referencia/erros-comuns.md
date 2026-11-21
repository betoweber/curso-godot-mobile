# Erros comuns (e como resolver)

| Mensagem / sintoma | Causa | Solução |
|---|---|---|
| `Invalid access to property or key 'x' on a base object of type 'null instance'` | `$NomeDoNo` não existe (nome/caminho errado) ou foi acessado antes do `_ready` | confira o nome na árvore; use `@onready`; use `%NomeUnico` |
| `Mixed use of tabs and spaces for indentation` | indentação misturada | no editor de script: menu *Edit → Indentation → Convert Indent to Tabs* |
| `Not all code paths return a value` | função com `-> tipo` sem `return` em algum caminho | adicione `return` no final |
| `Function "x" not found in base self` | método não existe neste script ou nome errado | confira a grafia; o método é do nó certo? |
| `Cannot call method 'x' on a null value` | variável ainda `null` | inicialize; verifique `is_instance_valid()` |
| `Invalid call. Nonexistent function 'x' in base 'Area2D'` | chamou método de script num nó sem esse script | use `if area is Item:` antes |
| Sinal conectado mas função não roda | assinatura errada, nó diferente, ou conectou duas vezes | veja a aba Node → Signals; confira parâmetros |
| Jogo mais rápido em um computador | movimento sem `* delta` | multiplique por delta (exceto com `move_and_slide`) |
| Personagem atravessa paredes | movendo `position` direto num CharacterBody | use `velocity` + `move_and_slide()` |
| Colisão não detecta | Layer/Mask não batem, `monitoring` desligado, falta CollisionShape | ligue *Debug → Visible Collision Shapes* |
| Pixel art borrada | filtro Linear | *Default Texture Filter* = Nearest (lição 06) |
| Botão não responde | um Control por cima "rouba" o clique | no Control de cima: *Mouse → Filter = Ignore* |
| Toque não funciona no Mac | falta emular | *Emulate Touch From Mouse* ✅ |
| Som corta quando objeto some | player é filho do nó que deu `queue_free` | toque o som em outro nó (lição 09) |
| Modelo do Blender gigante/deitado | escala/rotação não aplicadas | Ctrl+A → All Transforms no Blender |
| Modelo do Blender "furado" | normais invertidas | Edit Mode → A → Shift+N |
| Animações do Blender sumiram | Actions sem Fake User | ícone de escudo nas Actions (B03) |

**Dica de ouro**: copie a mensagem de erro inteira (aba *Debugger → Errors*) e pergunte ao tutor
junto com o trecho de código.
