---
name: product-roadmap
description: >
  Guides roadmap planning, prioritization frameworks, and outcome-based roadmap communication.
  Trigger: When user asks to plan a roadmap, prioritize features, or communicate product direction.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
allowed-tools: Read, Edit, Write
---

## When to Use

- Defining or reviewing a product roadmap
- Prioritizing a backlog using a framework
- Communicating roadmap to stakeholders
- Choosing between Now / Next / Later or quarterly planning

## Critical Patterns

### Roadmap Types — Choose the Right One

| Type | Best For | Avoid When |
|------|----------|------------|
| **Now / Next / Later** | Early-stage, uncertain scope | Stakeholders need fixed dates |
| **Outcome-based** | Product-market fit phase | Teams need task-level detail |
| **Quarterly (OKR-aligned)** | Scaling orgs with dependencies | Roadmap changes every 2 weeks |
| **Feature-based** | Sales-driven orgs, enterprise | Innovation is the goal |

### Prioritization Frameworks

#### RICE Score

```
RICE = (Reach × Impact × Confidence) / Effort
```

| Field | Scale |
|-------|-------|
| Reach | # users affected per period |
| Impact | 3=massive / 2=high / 1=medium / 0.5=low / 0.25=minimal |
| Confidence | 100% / 80% / 50% |
| Effort | Person-months |

#### MoSCoW

| Priority | Meaning |
|----------|---------|
| **Must** | Non-negotiable for launch |
| **Should** | High value, not critical path |
| **Could** | Nice-to-have if capacity allows |
| **Won't** | Out of scope — explicitly documented |

### Outcome vs Output Anti-Pattern

```
# Output roadmap (DON'T — commits team to solutions)
Q3: Build new dashboard
Q4: Redesign onboarding

# Outcome roadmap (DO — commits to value delivered)
Q3: Reduce time-to-first-value from 7 days to 2 days
Q4: Increase activation rate from 40% to 65%
```

### Stakeholder Communication Rules

1. **Executives**: outcomes + business impact, no feature lists
2. **Engineering**: epics + constraints + dependencies
3. **Sales/CS**: timelines + what's committed vs. directional
4. **Users**: themes + problems being solved

## Code Examples

### RICE Scoring Table (Markdown)

```markdown
| Feature | Reach | Impact | Confidence | Effort | RICE |
|---------|-------|--------|------------|--------|------|
| SSO Login | 5000 | 2 | 80% | 2 | 4000 |
| Dark mode | 2000 | 0.5 | 100% | 1 | 1000 |
| Bulk export | 800 | 3 | 50% | 3 | 400 |
```

### Now / Next / Later Template

```markdown
## Product Roadmap — [Quarter/Period]

### Now (current sprint/quarter)
- **[Theme]**: [What we're building + expected outcome]

### Next (following quarter)
- **[Theme]**: [What we plan to tackle + hypothesis]

### Later (6+ months)
- **[Theme]**: [Direction, subject to discovery]

> Items in "Later" are directional, not committed.
```

## Commands

```bash
# No CLI commands — this skill is a planning workflow
```

## Resources

- **Templates**: See [assets/](assets/) for RICE scoring and roadmap templates
