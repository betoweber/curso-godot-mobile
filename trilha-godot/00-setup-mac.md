# 00 · Preparando o Mac

> ⏱️ ~1h · 🎯 Godot, Blender, Aseprite e o repositório funcionando

## 1. Godot

1. Baixe em **https://godotengine.org/download/macos/** a versão **4.x estável mais recente**
   (este curso foi testado com a **4.7.2**). Escolha a versão normal (*não* a ".NET" — vamos usar GDScript).
2. Abra o `.dmg` e arraste o **Godot.app** para **Aplicativos**.
3. Se o macOS bloquear: **Ajustes do Sistema → Privacidade e Segurança → Abrir Mesmo Assim**.
4. Ao abrir, aparece o **Gerenciador de Projetos**. Use **Importar** para abrir os projetos deste repositório
   (selecione o `project.godot` de cada pasta em `projetos/`).

> 💡 **Idioma do editor**: recomendo deixar o editor em **inglês** (Editor → Editor Settings → Interface → Editor → Editor Language).
> 99% dos tutoriais, da documentação e das respostas em fóruns usam os nomes em inglês. As lições deste curso
> usam os nomes em inglês dos menus, com tradução quando ajuda.

> 💡 **Versões**: quando a pós começar, use a versão que o professor indicar. Diferenças entre versões 4.x
> são pequenas; tudo aqui vale para qualquer 4.x recente. **Godot 3.x é bem diferente** — se achar um tutorial
> com `KinematicBody2D`, `yield` ou `export var`, ele é do Godot 3.

### Godot pela linha de comando (opcional, mas útil)

O executável fica dentro do app. Crie um atalho no terminal (zsh):

```bash
echo 'alias godot="/Applications/Godot.app/Contents/MacOS/Godot"' >> ~/.zshrc
source ~/.zshrc
godot --version
```

Com isso você pode, por exemplo, rodar o corretor de exercícios pelo terminal:

```bash
cd projetos/00-exercicios-gdscript
godot --headless --path . --script res://cli.gd
```

## 2. Blender

- Baixe em **https://www.blender.org/download/** — escolha **macOS Apple Silicon** (M1/M2/M3/M4) ou **Intel**.
- Uma versão LTS (suporte longo) é a escolha mais segura. Os passos da trilha valem para Blender 4.x e 5.x.
- Configuração para Mac está na lição [B00](../trilha-blender/B00-instalar-e-interface.md) (trackpad/sem teclado numérico).

## 3. Aseprite

Você já tem. Só confira que ele está atualizado — vamos exportar *sprite sheets* na lição 06.

## 4. Este repositório no Mac

Você precisa do `git` (vem com as *Command Line Tools* da Apple) e, de preferência, do `gh` (GitHub CLI):

```bash
xcode-select --install          # instala git e ferramentas (se ainda não tiver)
brew install gh                 # se usar Homebrew (https://brew.sh)
gh auth login                   # login no GitHub
gh repo clone betoweber/curso-godot-mobile ~/Developer/curso-godot-mobile
```

Fluxo de estudo sugerido:

```bash
cd ~/Developer/curso-godot-mobile
git pull                        # pega atualizações
# ... estuda, faz exercícios, cria seus projetos em meus-projetos/ ...
git add -A && git commit -m "Lição 04 concluída" && git push
```

Assim seu progresso fica salvo no GitHub e sincronizado entre o Mac e o Steam Deck.

## 5. Editor de código

O editor de scripts **embutido no Godot já é ótimo** e é o que as lições assumem.
Se preferir VS Code: instale a extensão **godot-tools** e configure em
*Editor Settings → Text Editor → External*. Não é necessário no começo.

## 6. Tirando dúvidas com o tutor

Na raiz do repositório há um `CLAUDE.md` que transforma o Claude Code num **tutor de Godot**.
Abra o terminal na pasta do repositório e rode `claude`. Exemplos de perguntas:

- "Não entendi a diferença entre `_process` e `_physics_process`"
- "Meu exercício 04 falha no teste `media([]) == 0.0`, me dá uma dica sem a resposta"
- "Revisa o código do meu jogador em `meus-projetos/...`"
- "Me faz um quiz da lição 03"

## ✅ Checklist

- [ ] Godot abre e mostra o Gerenciador de Projetos
- [ ] Importei `projetos/00-exercicios-gdscript` e rodei com **Cmd+B** (aparece a lista de testes)
- [ ] Blender instalado e abre
- [ ] Repositório clonado no Mac, consigo fazer `git push`

➡️ Próxima: [01 · O editor, nós e cenas](01-editor-nos-e-cenas.md)
