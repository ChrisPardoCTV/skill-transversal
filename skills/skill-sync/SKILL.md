---
name: skill-sync
description: >
  Syncs product team skills from the skill-transversal GitHub repo to ~/.claude/skills/.
  Trigger: When user runs /skill-sync pull, /skill-sync list, or asks to update, sync, or install skills.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
allowed-tools: Bash, Read
---

## When to Use

- User runs `/skill-sync pull` or says "actualizar skills", "sync skills", "pull latest skills"
- User runs `/skill-sync list` or asks "qué skills tengo instaladas?"
- User wants to install product team skills for the first time
- User asks if their skills are up to date

## Critical Patterns

### Cache Location

Use `~/.claude/skill-transversal-cache/` as the persistent local git mirror. Never clone into a project directory or temp folder.

```
~/.claude/skill-transversal-cache/   ← git mirror del repo
~/.claude/skills/                    ← donde Claude Code carga las skills
```

### Bootstrap Protection

Never overwrite the `skill-sync` directory during a pull — it would replace the running skill. Always skip it during copy. It updates on the next `install.sh` run.

### Git First, Copy Second

1. Cache exists → `git pull origin main`
2. Cache missing → `git clone` into cache path
3. Copy `skills/*/` from cache to `~/.claude/skills/` (excluding `skill-sync`)

## Commands

### `/skill-sync list`

Run this bash to show installed skills with versions:

```bash
echo "Skills instaladas:"
echo ""
for dir in ~/.claude/skills/*/; do
  skill=$(basename "$dir")
  skill_file="$dir/SKILL.md"
  [[ -f "$skill_file" ]] || continue
  version=$(grep '  version:' "$skill_file" | head -1 | sed 's/.*version: *//' | tr -d '"')
  desc=$(awk '/^description:/{found=1; next} found && /^  [^ ]/{print; exit}' "$skill_file" | sed 's/^  //' | cut -c1-55)
  printf "  %-22s v%-5s %s\n" "$skill" "${version:-?}" "$desc"
done
```

### `/skill-sync pull`

Run this bash to pull latest skills from GitHub:

```bash
REPO_URL="https://github.com/ChrisPardoCTV/skill-transversal.git"
CACHE="$HOME/.claude/skill-transversal-cache"
SKILLS_DEST="$HOME/.claude/skills"

if ! command -v git &>/dev/null; then
  echo "Error: git no está instalado."
  exit 1
fi

echo "Sincronizando con skill-transversal..."

if [[ -d "$CACHE/.git" ]]; then
  git -C "$CACHE" pull origin main
else
  git clone "$REPO_URL" "$CACHE"
fi

echo ""
echo "Instalando skills:"
installed=0
for skill_dir in "$CACHE/skills/"/*/; do
  skill_name=$(basename "$skill_dir")
  [[ "$skill_name" == "skill-sync" ]] && continue
  dest="$SKILLS_DEST/$skill_name"
  mkdir -p "$dest"
  cp -r "$skill_dir/." "$dest/"
  echo "  ✓ $skill_name"
  installed=$((installed + 1))
done

echo ""
echo "Sync completado: $installed skills actualizadas."
echo "Usá /skill-sync list para ver las versiones instaladas."
```

## Resources

- Repo: https://github.com/ChrisPardoCTV/skill-transversal
- Setup inicial (CLI): `bash scripts/install.sh` desde una copia local del repo
- Para Claude.ai web: descargar `dist/skills-bundle.md` y subir a Project Knowledge
