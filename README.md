# skill-transversal

AI skills registry for cross-functional teams. Skills define how Claude behaves when assisting with specific tasks — user stories, roadmaps, design critiques, OKRs, and more.

Part of the [Backing Digital](https://github.com/ChrisPardoCTV) GitHub organization.

---

## Repository Structure

```
skill-transversal/
├── skills/
│   ├── product/          → Product team skills
│   ├── design/           → Design team skills
│   └── _tooling/         → Internal skills (skill-sync)
├── dist/
│   ├── product/          → Compiled bundle for Claude.ai Teams
│   └── design/           → Compiled bundle for Claude.ai Teams
├── scripts/
│   └── install.sh        → First-time CLI setup script
└── .claude/
    └── commands/
        └── generate-skill-bundle.md  → /generate-skill-bundle slash command
```

---

## How Skills Work

Each skill is a `SKILL.md` file with a YAML frontmatter that defines its name, description, version, and trigger condition. Claude loads the skill automatically when the user's request matches the trigger.

```yaml
---
name: user-story
description: >
  Guides writing well-formed user stories with acceptance criteria following the INVEST principle.
  Trigger: When user asks to write, review, or refine a user story, epic, or acceptance criteria.
metadata:
  version: "1.2"
---
```

---

## Installation

### Claude.ai Teams (non-technical)

1. Download the bundle for your team:
   - **Product** → [dist/product/skills-bundle.md](dist/product/skills-bundle.md)
   - **Design** → [dist/design/skills-bundle.md](dist/design/skills-bundle.md)
2. Go to your Claude Project → **Project Knowledge** → upload the file
3. Done — Claude applies skills automatically in every conversation

**To update:** replace the file in Project Knowledge with the latest version from this repo.

### Claude Code CLI (technical)

**First-time setup:**
```bash
bash <(curl -fsSL https://raw.githubusercontent.com/ChrisPardoCTV/skill-transversal/main/scripts/install.sh)
```

This clones the repo into `~/.claude/skill-transversal-cache/` and copies all skills to `~/.claude/skills/`.

**Future updates** (from within any project in Claude Code):
```
/skill-sync pull
```

---

## Maintainer Guide

### Updating a skill

1. Edit `skills/{team}/{skill-name}/SKILL.md`
2. Bump the `version` in frontmatter
3. Regenerate the bundle from Claude Code:
   ```
   /generate-skill-bundle {team}
   ```
4. Commit and push:
   ```bash
   git add -A && git commit -m "feat(skills): update {skill-name} to vX.X" && git push
   ```

### Adding a new skill

1. Create `skills/{team}/{skill-name}/SKILL.md` following the frontmatter convention
2. Add a row to [AGENTS.md](AGENTS.md)
3. Run `/generate-skill-bundle {team}`
4. Commit: `feat(skills): add {skill-name} to {team}`

### Adding a new team

1. Create `skills/{team}/` with at least one skill inside
2. Add a new section to [AGENTS.md](AGENTS.md)
3. Run `/generate-skill-bundle {team}` — `dist/{team}/skills-bundle.md` is created automatically
4. Commit: `feat(skills): add {team} team`

### /generate-skill-bundle command

Available in Claude Code when working inside this repo. Reads all `SKILL.md` files for a given team, understands the content, and produces a compiled `dist/{team}/skills-bundle.md` ready for Claude.ai Teams upload.

```
/generate-skill-bundle product
/generate-skill-bundle design
/generate-skill-bundle all
```

---

## Skill Frontmatter Convention

```yaml
---
name: {skill-name}               # kebab-case, matches folder name
description: >
  {One sentence description}.
  Trigger: {When Claude should load this skill}.
license: Apache-2.0
metadata:
  author: {author}
  version: "{major.minor}"       # bump minor for additions, major for breaking changes
allowed-tools: Read, Edit, Write # tools Claude is allowed to use
---
```

---

## Available Skills

See [AGENTS.md](AGENTS.md) for the full index with versions and links.
