# Agent Skills — skill-transversal

Transversal skills for product teams. Load the relevant skill before tackling the associated task.

## Product Skills

| Skill | Description | File |
|-------|-------------|------|
| `user-story` | Write and review user stories with INVEST criteria and Gherkin acceptance criteria | [SKILL.md](skills/user-story/SKILL.md) |
| `product-roadmap` | Plan and prioritize roadmaps using RICE, MoSCoW and outcome-based communication | [SKILL.md](skills/product-roadmap/SKILL.md) |
| `product-discovery` | Run discovery cycles: problem framing, hypothesis definition, and experiment design | [SKILL.md](skills/product-discovery/SKILL.md) |
| `okr-planning` | Define and grade OKRs with outcome-focused key results and alignment checks | [SKILL.md](skills/okr-planning/SKILL.md) |
| `feature-flag` | Manage feature flag lifecycle: naming, rollout phases, gate metrics, and cleanup | [SKILL.md](skills/feature-flag/SKILL.md) |
| `skill-sync` | Sync and install product team skills from GitHub to `~/.claude/skills/` (Claude Code CLI) | [SKILL.md](skills/skill-sync/SKILL.md) |

## Distribution

### Para el equipo de producto (Claude.ai web)

1. Descargá [`dist/skills-bundle.md`](dist/skills-bundle.md) desde este repositorio
2. En Claude.ai → abrí tu Project → **Project Knowledge** → subí el archivo
3. Listo — Claude las aplica automáticamente en todas las conversaciones del proyecto

**Para actualizar:** cuando el equipo suba cambios, reemplazá el archivo en Project Knowledge por la nueva versión del bundle.

### Para el equipo técnico (Claude Code CLI)

**Primera vez:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ChrisPardoCTV/skill-transversal/main/scripts/install.sh)
```

**Actualizaciones:**
```
/skill-sync pull
```

### Regenerar el bundle (después de modificar skills)

```bash
bash scripts/bundle.sh
```

Siempre regenerar y commitear `dist/skills-bundle.md` junto con cualquier cambio en `skills/*/SKILL.md`.

## Usage

Skills are loaded by the AI agent when the user's request matches the trigger defined in each `SKILL.md` frontmatter. You can also load them explicitly by referencing the skill name.

## Adding a New Skill

Follow the [skill-creator](https://github.com/ChrisPardoCTV/skill-creator) conventions:

1. Create `skills/{skill-name}/SKILL.md` with complete frontmatter
2. Add a row to the table above
3. Run `bash scripts/bundle.sh` to update `dist/skills-bundle.md`
4. Commit with `feat(skills): add {skill-name} skill`
