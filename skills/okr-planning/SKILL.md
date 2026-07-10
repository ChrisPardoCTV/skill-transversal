---
name: okr-planning
description: >
  Guides OKR definition, alignment, and grading for product teams.
  Trigger: When user asks to define OKRs, key results, write objectives, or review OKR quality.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
allowed-tools: Read, Edit, Write
---

## When to Use

- Defining quarterly or annual OKRs
- Reviewing key results for quality (output vs. outcome)
- Aligning product OKRs with company-level goals
- Grading OKRs at end of cycle

## Critical Patterns

### OKR Anatomy

```
Objective  → Qualitative, inspirational, time-bound direction
Key Result → Quantitative, measurable signal of progress toward the Objective
Initiative → Project/task that drives a Key Result (NOT a Key Result itself)
```

### Objective Quality Rules

- Inspirational, not mechanical ("Become the go-to tool for X" not "Ship 3 features")
- Clear owner (team or person)
- Time-bound by default (quarter implied)
- No verbs like "improve" without a KR to quantify it

### Key Result Quality Rules

| Rule | Good KR | Bad KR |
|------|---------|--------|
| **Measurable** | Increase activation rate from 40% to 65% | Improve onboarding |
| **Outcome, not output** | Reduce churn from 8% to 4% | Ship retention module |
| **Binary or ranged** | NPS ≥ 45 by Q3 | Good NPS score |
| **Attainable but ambitious** | 70% confidence achievable | 100% guaranteed to hit |

### OKR Count Rule

```
1 Objective → 2–4 Key Results (max)
Too many KRs → team loses focus, measure everything, improve nothing
```

### Grading Scale (Google Model)

| Score | Meaning |
|-------|---------|
| 0.7–1.0 | Exceptional — possibly set too low |
| 0.6–0.7 | Good — stretch was real |
| 0.4–0.6 | OK — significant progress |
| 0.0–0.4 | Underperformed — review blockers |

> A score of 1.0 every quarter = OKRs are too safe. Aim for 0.6–0.7.

### OKR Alignment Check

```
Company OKR → Are my product OKRs contributing to at least one company KR?
Product OKR  → Are my team OKRs contributing to at least one product KR?
Team OKR     → Are my initiatives clearly linked to a team KR?
```

## Code Examples

### Well-formed OKR

```markdown
## Q3 2026 — Growth Team OKRs

### O1: Make activation a competitive advantage

**KR1:** Increase D7 activation rate from 38% to 58%
**KR2:** Reduce median time-to-first-value from 6 days to 2 days
**KR3:** Achieve an onboarding NPS of ≥ 50 (currently 31)

*Initiatives (NOT Key Results):*
- Redesign onboarding checklist (→ KR1, KR2)
- Add contextual tooltips for core actions (→ KR1)
- Implement progress bar in setup flow (→ KR2)
```

### Poorly written OKR (DON'T)

```markdown
# Bad — Outputs masquerading as Key Results
O1: Improve the product

KR1: Launch new dashboard  ← output
KR2: Fix bugs in onboarding ← task
KR3: Better performance  ← not measurable
```

## Commands

```bash
# No CLI commands — this skill is a planning workflow
```

## Resources

- **Templates**: See [assets/](assets/) for OKR planning canvas
