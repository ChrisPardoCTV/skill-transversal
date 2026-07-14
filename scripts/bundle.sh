#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
OUTPUT="$REPO_ROOT/dist/skills-bundle.md"

DATE=$(date '+%Y-%m-%d')
GIT_HASH=$(git -C "$REPO_ROOT" rev-parse --short HEAD 2>/dev/null || echo "unknown")

SKILL_ORDER=(user-story product-discovery product-roadmap okr-planning feature-flag)

get_name() {
  grep '^name:' "$1" | head -1 | sed 's/^name: *//'
}

get_description() {
  awk '/^description:/{found=1; next} found && /^  [^ ]/{print; exit}' "$1" | sed 's/^  //'
}

get_trigger() {
  awk '/^description:/{found=1; next} found && /^  /{print} found && /^[a-zA-Z]/{exit}' "$1" \
    | grep -E '(Trigger:|Activador:)' | sed -E 's/.*(Trigger|Activador): *//'
}

strip_frontmatter() {
  awk 'BEGIN{n=0} /^---$/{n++; next} n>=2{print}' "$1" \
    | sed 's|See \[assets/\](assets/)[^.]*\.|*(ver documentación del equipo)*|g'
}

{
  echo "# Skills Bundle — Gentleman Programming"
  echo "> Generado: ${DATE} · ${GIT_HASH}"
  echo "> Fuente: https://github.com/ChrisPardoCTV/skill-transversal"
  echo ""
  echo "## Cómo usar este archivo"
  echo ""
  echo "Este archivo contiene todas las skills del equipo de producto. Subilo a tu Claude Project como **Project Knowledge** y listo — Claude las aplica automáticamente cuando detecta que estás trabajando en algo relacionado. No necesitás hacer nada más."
  echo ""
  echo "**Para actualizar:** cuando el equipo suba cambios, descargá la nueva versión de este archivo desde el repositorio y reemplazá el archivo anterior en tu Project Knowledge."
  echo ""
  echo "## Índice de Skills"
  echo ""
  echo "| Skill | Descripción | Se activa cuando... |"
  echo "|-------|-------------|---------------------|"

  for skill in "${SKILL_ORDER[@]}"; do
    skill_file="$SKILLS_DIR/$skill/SKILL.md"
    [[ -f "$skill_file" ]] || continue
    name=$(get_name "$skill_file")
    desc=$(get_description "$skill_file")
    trigger=$(get_trigger "$skill_file")
    printf "| \`%s\` | %s | %s |\n" "$name" "$desc" "$trigger"
  done

  for skill in "${SKILL_ORDER[@]}"; do
    skill_file="$SKILLS_DIR/$skill/SKILL.md"
    [[ -f "$skill_file" ]] || continue
    name=$(get_name "$skill_file")
    printf "\n\n---\n\n# Skill: %s\n\n" "$name"
    strip_frontmatter "$skill_file"
  done

} > "$OUTPUT"

echo "Bundle generado: $OUTPUT"
echo "Skills incluidas: ${#SKILL_ORDER[@]}"
echo "Tamaño: $(wc -c < "$OUTPUT" | tr -d ' ') bytes"
