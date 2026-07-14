---
name: product-discovery
description: >
  Guides product discovery process: problem framing, hypothesis definition, and experiment design.
  Trigger: When user asks to run discovery, validate an idea, define experiments, or map user problems.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
allowed-tools: Read, Edit, Write
---

## When to Use

- Starting discovery on a new feature or problem space
- Formulating hypotheses before building
- Designing lean experiments to validate assumptions
- Synthesizing research into actionable insights

## Critical Patterns

### Discovery vs. Delivery — Know Which Mode You're In

| Discovery | Delivery |
|-----------|----------|
| Reduces uncertainty | Reduces scope |
| Output: decisions | Output: working software |
| Tools: interviews, prototypes, data | Tools: sprints, CI/CD |
| "Should we build X?" | "How do we build X?" |

### Problem Framing — Always Before Solutions

```
1. Problem Statement  → What is happening that shouldn't be?
2. Who it affects     → Which persona / segment?
3. Frequency          → How often? At what scale?
4. Current workaround → How do users cope today?
5. Cost of inaction   → What's the business impact of NOT solving it?
```

### Hypothesis Format

```
We believe that [doing/building X]
for [persona]
will result in [measurable outcome]
because [assumption/rationale].

We'll know this is true when [metric changes by Y in Z timeframe].
```

### Assumption Mapping — Risk vs. Knowability

```
High Risk + Unknown  → VALIDATE FIRST (riskiest assumptions)
High Risk + Known    → Monitor & document
Low Risk + Unknown   → Validate if cheap
Low Risk + Known     → Build with confidence
```

### Experiment Types by Fidelity

| Type | Cost | Signal Quality | Use When |
|------|------|---------------|----------|
| Concierge (manual) | Very low | High | Validating demand |
| Wizard of Oz | Low | High | Validating UX before engineering |
| Landing page | Low | Medium | Measuring interest |
| Prototype (clickable) | Medium | High | Validating usability |
| A/B test | High | Very high | Optimizing known flows |
| MLP (Min Lovable Product) | High | Very high | Market validation at scale |

## Code Examples

### Discovery Brief Template

```markdown
## Discovery Brief — [Problem/Feature Name]

### Problem Statement
[What is happening that creates friction or lost value?]

### Affected Persona
[Name] — [Short description of who they are and their context]

### Success Metric
Primary: [Metric + target + timeframe]
Secondary: [Optional metric]

### Riskiest Assumption
[The one thing that if wrong, invalidates the entire solution]

### Experiment Plan
Method: [Type of experiment]
Duration: [Timeframe]
Success threshold: [What result tells us to proceed?]
Failure threshold: [What result tells us to pivot?]
```

### Hypothesis Example

```markdown
We believe that **adding a quick-apply option** (one-click from job listing)
for **job seekers with a complete profile**
will result in **a 20% increase in application completion rate**
because users currently abandon the multi-step form due to friction.

We'll know this is true when the 7-day application completion rate
rises from 34% to 41% within 4 weeks of rollout.
```

## Commands

```bash
# No CLI commands — this skill is a research and design workflow
```

## Resources

- **Templates**: See [assets/](assets/) for discovery brief and hypothesis canvas
