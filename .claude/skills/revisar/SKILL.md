---
name: revisar
description: Revisa as mudanças do estudante antes do commit (como um professor de Godot). Use quando pedirem "revisa antes de eu commitar", "/revisar", "posso commitar?" ou "revisa o que eu fiz".
---

# Revisão antes do commit

1. Descubra o que revisar:
   - `git diff --cached --stat` — se houver algo preparado (staged), revise isso.
   - Se não houver nada staged, revise `git diff --stat` + arquivos novos de `git status --short`
     (e diga que a pessoa ainda precisa dar `git add`).
   - Se a pessoa indicar um arquivo/pasta, revise só isso.
2. Rode as verificações automáticas, se possível:
   - Godot: `/Applications/Godot.app/Contents/MacOS/Godot` (Mac) ou `godot` no PATH. Para cada projeto alterado
     (pasta com `project.godot`), rode
     `<godot> --headless --path <projeto> --script <raiz>/ferramentas/checar_godot.gd -- res://arquivo1.gd res://cena.tscn`
     (importe antes com `--import` se não houver a pasta `.godot/`).
   - Se mexeu em `projetos/00-exercicios-gdscript/exercicios/`, rode `<godot> --headless --path projetos/00-exercicios-gdscript --script res://cli.gd`.
3. Leia `ferramentas/instrucoes-revisao.md` e siga **exatamente** os critérios, as regras especiais (principalmente:
   **não resolver exercícios**) e o formato de resposta.
4. Depois da revisão, ofereça ajuda para corrigir os 🔴 e 🟡 — mas só edite arquivos se a pessoa pedir,
   e nunca escreva a resposta de um exercício sem pedido explícito.
5. Se a pessoa ainda não ativou o hook neste computador (`git config core.hooksPath` vazio), sugira rodar
   `./ferramentas/configurar.sh`.
