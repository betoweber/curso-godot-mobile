#!/usr/bin/env bash
# Configura este clone do repositório (rode uma vez em cada computador):
#   ./ferramentas/configurar.sh
set -e
cd "$(git rev-parse --show-toplevel)"

git config core.hooksPath .githooks
chmod +x .githooks/* ferramentas/*.sh 2>/dev/null || true
echo "✔ Hook de pré-commit ativado (.githooks/pre-commit)"

if [ -n "${GODOT:-}" ] && [ -x "$GODOT" ]; then
	echo "✔ Godot: $GODOT"
elif command -v godot >/dev/null 2>&1; then
	echo "✔ Godot: $(command -v godot)"
elif [ -x /Applications/Godot.app/Contents/MacOS/Godot ]; then
	echo "✔ Godot: /Applications/Godot.app"
else
	echo "⚠ Godot não encontrado. Instale em /Applications (Mac) ou defina a variável GODOT."
	echo "  Sem ele, o hook pula a verificação de scripts e cenas."
fi

if command -v claude >/dev/null 2>&1; then
	echo "✔ Claude Code encontrado — a revisão automática está ligada"
	echo "  (para desligar: git config curso.revisaoClaude false)"
else
	echo "⚠ Claude Code não encontrado — o hook vai pular a revisão do Claude."
	echo "  Instale: https://claude.com/claude-code  (ou use /revisar dentro do Claude Code)"
fi
