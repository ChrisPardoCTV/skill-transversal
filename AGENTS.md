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

## Usage

Skills are loaded by the AI agent when the user's request matches the trigger defined in each `SKILL.md` frontmatter. You can also load them explicitly by referencing the skill name.

## Adding a New Skill

Follow the [skill-creator](https://github.com/ChrisPardoCTV/skill-creator) conventions:

1. Create `skills/{skill-name}/SKILL.md` with complete frontmatter
2. Add a row to the table above
3. Commit with `feat(skills): add {skill-name} skill`
