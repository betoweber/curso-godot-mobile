# 02 · GDScript básico

> ⏱️ ~4h (em 2–3 sessões) · 🎯 Ler e escrever GDScript com tranquilidade
> 🧪 Exercícios: `projetos/00-exercicios-gdscript` (ex01 a ex06)

GDScript é a linguagem do Godot. Parece Python: indentação define blocos, sem `;`, sem `{}`.
Ela foi feita para jogos: tem `Vector2`, `Color`, sinais e acesso a nós embutidos.

## Como funcionam os exercícios

1. Importe `projetos/00-exercicios-gdscript` no Godot e rode (**Cmd+B**).
2. Você vê uma lista de testes ✘ vermelhos.
3. Abra `exercicios/ex01_variaveis.gd` (duplo clique no FileSystem). Leia os comentários — **eles são a aula**.
4. Substitua cada `# TODO`. Salve (**Cmd+S**). Clique em **Verificar** (ou rode de novo).
5. Repita até ficar tudo ✔ verde. Travou? Peça uma **dica** ao tutor antes de olhar `solucoes/`.

## Resumo da linguagem

### Variáveis e tipos

```gdscript
var vida = 100              # dinâmico (aceita qualquer tipo depois)
var vida: int = 100         # tipado: o editor avisa se você errar o tipo
var vida := 100             # tipo inferido (int) — o mais usado
const VIDA_MAXIMA := 100    # constante: não muda

# Tipos que você vai usar o tempo todo
var nome: String = "Ana"
var velocidade: float = 250.5
var vivo: bool = true
var posicao: Vector2 = Vector2(10, 20)
var cor: Color = Color.RED
var inimigos: Array[Node] = []
var inventario: Dictionary = {"poção": 2}
```

> 💡 **Use tipos sempre que puder.** O autocompletar fica muito melhor, erros aparecem antes de rodar,
> e o código fica mais rápido. Os projetos do curso seguem esse estilo.

### Funções

```gdscript
func somar(a: int, b: int) -> int:
	return a + b

func dizer_oi(nome: String = "mundo") -> void:   # valor padrão; void = não retorna nada
	print("Oi, ", nome)
```

### Condicionais, loops, match

```gdscript
if vida <= 0:
	morrer()
elif vida < 20:
	tocar_alarme()
else:
	pass

for i in 3:                    # 0, 1, 2
	print(i)
for inimigo in inimigos:
	inimigo.queue_free()
while vida > 0:
	vida -= 1

match estado:
	"parado": tocar("idle")
	"andando", "correndo": tocar("run")
	_: print("estado desconhecido")
```

### Strings

```gdscript
var s := "Pontos: " + str(10)           # concatenação (str() converte)
var s2 := "Pontos: %d  Tempo: %.1f" % [10, 3.14159]   # formatação → "Pontos: 10  Tempo: 3.1"
var s3 := "texto".to_upper()            # "TEXTO"
```

### Vector2 — a estrela do 2D

```gdscript
var v := Vector2(3, 4)
v.length()               # 5.0
v.normalized()           # (0.6, 0.8)  — direção pura
a.distance_to(b)
a.direction_to(b)
a.move_toward(b, 10)
Vector2.UP               # (0, -1)  lembre: Y para baixo!
```

**Por que normalizar?** Se o jogador aperta ↑ e → ao mesmo tempo, o vetor é `(1, -1)`, comprimento ≈ 1.41.
Sem normalizar ele anda 41% mais rápido na diagonal. `Input.get_vector()` já devolve normalizado.

## Ordem sugerida

| Sessão | Exercícios | Foco |
|---|---|---|
| 1 | ex01, ex02 | variáveis, funções, if |
| 2 | ex03, ex04 | loops e arrays |
| 3 | ex05, ex06 | dicionários e Vector2 |

## Pegadinhas comuns

- **Indentação**: o Godot usa **tab**. Misturar tab e espaços dá erro. (Editor → Editor Settings → Text Editor → Behavior → Indent)
- **Divisão inteira**: `5 / 2 == 2` (int). Use `5 / 2.0` ou `float(5) / 2` para `2.5`.
- **Arrays e dicionários são referências**: passar para uma função e modificar lá modifica o original. Use `.duplicate()` para copiar.
- **`=` vs `==`**: atribuição vs comparação.
- **Godot 3 vs 4**: `export var` → `@export var`; `onready var` → `@onready var`; `yield` → `await`.

## Onde consultar

- Dentro do editor: **Opt+Espaço** ou menu Help → *Search Help* — documentação offline de toda classe.
- Cmd+clique numa função ou classe no script abre a documentação dela.
- [GDScript reference](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html)
- [cola de GDScript deste curso](../referencia/gdscript-cola.md)

## ✅ Eu sei...

- [ ] ex01 a ex06 verdes
- [ ] declarar variáveis tipadas e funções com tipo de retorno
- [ ] explicar por que normalizar vetores de direção
- [ ] usar `for` com `range()` e com arrays

## 💬 Perguntas para o tutor

- "Me explica a diferença entre `var x = 1` e `var x := 1`"
- "Me dá mais 3 exercícios parecidos com o ex04, mais difíceis"

➡️ Próxima: [03 · Scripts em nós, ciclo de vida e sinais](03-scripts-ciclo-de-vida-sinais.md)
