# Agent Skills — skill-transversal

Transversal AI skills organized by team. Each skill defines when and how Claude should behave when assisting with a specific type of task.

## Skill Index

### Product

| Skill | Description | Version | File |
|-------|-------------|---------|------|
| `user-story` | Write and review user stories with INVEST criteria and Gherkin acceptance criteria | v1.2 | [SKILL.md](skills/product/user-story/SKILL.md) |
| `product-roadmap` | Plan and prioritize roadmaps using RICE, MoSCoW and outcome-based communication | v1.1 | [SKILL.md](skills/product/product-roadmap/SKILL.md) |
| `product-discovery` | Run discovery cycles: problem framing, hypothesis definition, and experiment design | v1.0 | [SKILL.md](skills/product/product-discovery/SKILL.md) |
| `okr-planning` | Define and grade OKRs with outcome-focused key results and alignment checks | v1.0 | [SKILL.md](skills/product/okr-planning/SKILL.md) |
| `feature-flag` | Manage feature flag lifecycle: naming, rollout phases, gate metrics, and cleanup | v1.0 | [SKILL.md](skills/product/feature-flag/SKILL.md) |

### Design

| Skill | Description | Version | File |
|-------|-------------|---------|------|
| `design-critique` | Run structured design critique sessions with principle-based, severity-tagged feedback | v1.1 | [SKILL.md](skills/design/design-critique/SKILL.md) |
| `handoff-spec` | Write complete design handoff specs for engineering: states, tokens, behavior, accessibility | v1.0 | [SKILL.md](skills/design/handoff-spec/SKILL.md) |

### Tooling (internal)

| Skill | Description | File |
|-------|-------------|------|
| `skill-sync` | Sync and install skills from GitHub to `~/.claude/skills/` via `/skill-sync pull` | [SKILL.md](skills/_tooling/skill-sync/SKILL.md) |

## Distribution

### Claude.ai Teams (non-technical users)

Download the bundle for your team and upload it to your Claude Project as **Project Knowledge**:

| Team | Bundle |
|------|--------|
| Product | [dist/product/skills-bundle.md](dist/product/skills-bundle.md) |
| Design | [dist/design/skills-bundle.md](dist/design/skills-bundle.md) |

Claude applies the skills automatically — no further setup needed.

**To update:** when the team pushes changes, replace the file in your Project Knowledge with the new version.

### Claude Code CLI (technical users)

**First-time setup:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ChrisPardoCTV/skill-transversal/main/scripts/install.sh)
```

**Updates:**
```
/skill-sync pull
```

## Maintainer Workflow

### Adding a new skill

1. Create `skills/{team}/{skill-name}/SKILL.md` following the frontmatter convention
2. Add a row to the index above
3. Run `/generate-skill-bundle {team}` in Claude Code to regenerate the bundle
4. Commit: `feat(skills): add {skill-name} to {team}`

### Adding a new team

1. Create `skills/{team}/` directory with at least one skill
2. Add a new section to the index above
3. Run `/generate-skill-bundle {team}` — the bundle is created automatically at `dist/{team}/skills-bundle.md`
4. Commit: `feat(skills): add {team} team skills`

### Updating an existing skill

1. Edit the `SKILL.md` file and bump the `version` in frontmatter
2. Run `/generate-skill-bundle {team}` to regenerate the bundle
3. Commit: `feat(skills): update {skill-name} to vX.X`
