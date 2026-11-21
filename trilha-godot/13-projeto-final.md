# 13 · Projeto final: seu jogo mobile

> ⏱️ 2–4 semanas · 🎯 Um jogo **seu**, pequeno e completo, rodando no celular

Terminar um jogo pequeno ensina mais do que começar dez grandes. Este projeto junta tudo:
GDScript, cenas, UI responsiva, toque, juice, save, export — e assets seus (Aseprite e/ou Blender).

## Regras do projeto

1. **Escopo pequeno**: 1 mecânica principal que dá para explicar em uma frase.
2. **Mobile first**: controles pensados para o dedo desde o primeiro protótipo. Teste no celular toda semana.
3. **Completo**: menu → jogo → fim de jogo → jogar de novo, com recorde salvo e sons.
4. **Seus assets**: ao menos o personagem principal feito por você.
5. **Versionado**: commits pequenos e frequentes em `meus-projetos/projeto-final`.

## Ideias (escolha uma ou invente)

| Ideia | Mecânica em uma frase | Foco técnico |
|---|---|---|
| **Salto infinito** | toque para pular entre plataformas que sobem | física 2D, geração procedural, câmera |
| **Corte de frutas pixel art** | deslize o dedo para cortar o que é lançado | `ScreenDrag`, trilha do dedo (`Line2D`), partículas |
| **Puzzle de deslizar** | arraste blocos numa grade para formar linhas | grade em código (**ex12**), swipes (**ex13**), tweens |
| **Torre de defesa mini** | toque em espaços para colocar torres | instâncias, pathfinding (`Path2D`), economia |
| **Runner 3D low poly** | deslize para trocar de faixa e desviar | 3D, assets do Blender, gestos |
| **Arena 3D (evolução do gabarito)** | sobreviva a ondas pegando moedas | joystick, inimigos, modelos animados do Blender |

## Plano sugerido

| Semana | Entrega |
|---|---|
| 1 | **Documento de 1 página** (mecânica, controles, como perde/ganha, referências visuais) + **protótipo com formas** jogável no celular |
| 2 | Loop completo (menu, jogo, fim, recorde salvo). Ainda feio, mas inteiro. |
| 3 | Arte e som. Juice. |
| 4 | Polimento, testes com outras pessoas, ícone, export final. |

## Checklist de "pronto"

- [ ] abre direto num menu com botão grande de jogar
- [ ] funciona em retrato (ou paisagem) travado, em pelo menos 2 tamanhos de tela diferentes
- [ ] nenhum texto/botão importante escondido pelo notch
- [ ] pausa ao trocar de app; botão voltar do Android faz algo sensato
- [ ] sons + música com volume ajustável (ou mudo)
- [ ] recorde salvo entre sessões
- [ ] roda a 60 FPS (ou 30 estáveis) num celular intermediário sem esquentar
- [ ] ícone e nome próprios
- [ ] 3 pessoas jogaram e você corrigiu o que elas acharam confuso

## Peça revisões ao tutor

- `/revisar` antes de cada commit (ou deixe o hook de pré-commit fazer isso sozinho)
- "Revisa a arquitetura do meu projeto em `meus-projetos/projeto-final` — o que você organizaria diferente?"
- "Meu jogo cai para 40 FPS no celular quando tem muitas partículas, como investigar?"
- "Me ajuda a quebrar a semana 2 em tarefas pequenas"

🎓 Terminou? Você chega na pós sabendo mais do que o básico. Bom curso!

➡️ Bônus: [14 · Shaders](14-shaders.md) (dá personalidade visual ao projeto final) e
[15 · Publicar nas lojas](15-publicar-nas-lojas.md).
