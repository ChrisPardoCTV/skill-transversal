#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/ChrisPardoCTV/skill-transversal.git"
CACHE_DIR="$HOME/.claude/skill-transversal-cache"
SKILLS_DIR="$HOME/.claude/skills"

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

ok()   { echo -e "${GREEN}✓${NC} $*"; }
err()  { echo -e "${RED}✗${NC} $*" >&2; exit 1; }
warn() { echo -e "${YELLOW}!${NC} $*"; }

echo "skill-transversal — instalador de skills"
echo "========================================="
echo ""

if ! command -v git &>/dev/null; then
  err "git no encontrado. Instalalo primero: https://git-scm.com/downloads"
fi
ok "git: $(git --version)"

if [[ ! -d "$SKILLS_DIR" ]]; then
  warn "~/.claude/skills/ no existe. Creando directorio..."
  mkdir -p "$SKILLS_DIR"
fi
ok "directorio de skills: $SKILLS_DIR"

echo ""
echo "Sincronizando repositorio..."

if [[ -d "$CACHE_DIR/.git" ]]; then
  ok "cache existente encontrada, actualizando..."
  git -C "$CACHE_DIR" pull origin main
else
  ok "clonando en $CACHE_DIR..."
  git clone "$REPO_URL" "$CACHE_DIR"
fi

echo ""
echo "Instalando skills..."

installed=0
# Iterate two levels deep: skills/{team}/{skill-name}/
for skill_dir in "$CACHE_DIR/skills/"/*/*/; do
  [[ -f "$skill_dir/SKILL.md" ]] || continue
  skill_name=$(basename "$skill_dir")
  dest="$SKILLS_DIR/$skill_name"
  mkdir -p "$dest"
  cp -r "$skill_dir/." "$dest/"
  ok "$skill_name"
  installed=$((installed + 1))
done

echo ""
echo "========================================="
ok "$installed skills instaladas en $SKILLS_DIR"
echo ""
echo "Próximos pasos:"
echo "  1. Reiniciá Claude Code"
echo "  2. Probá: /skill-sync list"
echo "  3. Para actualizar en el futuro: /skill-sync pull"
