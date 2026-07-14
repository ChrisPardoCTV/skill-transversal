#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="$REPO_ROOT/skills"
DIST_DIR="$REPO_ROOT/dist"

DATE=$(date '+%Y-%m-%d')
GIT_HASH=$(git -C "$REPO_ROOT" rev-parse --short HEAD 2>/dev/null || echo "unknown")

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

generate_bundle() {
  local team="$1"
  local team_dir="$SKILLS_DIR/$team"
  local output_dir="$DIST_DIR/$team"
  local output="$output_dir/skills-bundle.md"

  [[ -d "$team_dir" ]] || return

  local skill_dirs=()
  while IFS= read -r d; do
    [[ -f "$d/SKILL.md" ]] && skill_dirs+=("$d")
  done < <(find "$team_dir" -mindepth 1 -maxdepth 1 -type d | sort)

  [[ ${#skill_dirs[@]} -eq 0 ]] && return

  mkdir -p "$output_dir"

  {
    local team_cap
    team_cap=$(echo "$team" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
    echo "# Skills Bundle — ${team_cap}"
    echo "> Equipo: $team · Generado: ${DATE} · ${GIT_HASH}"
    echo "> Fuente: https://github.com/ChrisPardoCTV/skill-transversal"
    echo ""
    echo "## Cómo usar este archivo"
    echo ""
    echo "Subí este archivo a tu Claude Project como **Project Knowledge** y listo — Claude aplica las skills automáticamente cuando detecta el contexto. No necesitás hacer nada más."
    echo ""
    echo "**Para actualizar:** cuando el equipo suba cambios, reemplazá este archivo en tu Project Knowledge por la nueva versión."
    echo ""
    echo "## Índice de Skills"
    echo ""
    echo "| Skill | Descripción | Se activa cuando... |"
    echo "|-------|-------------|---------------------|"

    for skill_dir in "${skill_dirs[@]}"; do
      local skill_file="$skill_dir/SKILL.md"
      local name desc trigger
      name=$(get_name "$skill_file")
      desc=$(get_description "$skill_file")
      trigger=$(get_trigger "$skill_file")
      printf "| \`%s\` | %s | %s |\n" "$name" "$desc" "$trigger"
    done

    for skill_dir in "${skill_dirs[@]}"; do
      local skill_file="$skill_dir/SKILL.md"
      local name
      name=$(get_name "$skill_file")
      printf "\n\n---\n\n# Skill: %s\n\n" "$name"
      strip_frontmatter "$skill_file"
    done

  } > "$output"

  local size
  size=$(wc -c < "$output" | tr -d ' ')
  echo "  ✓ $team → dist/$team/skills-bundle.md (${#skill_dirs[@]} skills, ${size} bytes)"
}

echo "Generando bundles por equipo..."
echo ""

for team_dir in "$SKILLS_DIR"/*/; do
  team=$(basename "$team_dir")
  [[ "$team" == _* ]] && continue  # skip _tooling and other internal folders
  generate_bundle "$team"
done

echo ""
echo "Bundles generados en $DIST_DIR"
