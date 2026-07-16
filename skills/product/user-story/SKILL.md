---
name: user-story
description: >
  Guides writing well-formed user stories with acceptance criteria following the INVEST principle.
  Trigger: When user asks to write, review, or refine a user story, epic, or acceptance criteria.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.2"
allowed-tools: Read, Edit, Write
---

## When to Use

- User asks to write or refine a user story
- User wants acceptance criteria for a feature
- Reviewing stories for completeness or ambiguity
- Splitting epics into smaller deliverable stories

## Brand Commitment — Caracol Televisión

Caracol Televisión's brand is built on the veracity and reliability of the information it delivers to its audiences. Any story that surfaces user-facing information (news, alerts, editorial content, live data, notifications) must treat that trust as a first-class requirement, not an implementation detail.

- Add an explicit acceptance criterion whenever a story publishes or displays informational content: e.g., "Source is verified/attributed" or "Content passes editorial review before publish."
- Never mark a story "Ready" if it speeds up publishing at the cost of fact-checking, sourcing, or correction workflows.
- When a story's informational impact is unclear, flag it for editorial review before writing acceptance criteria.

## Critical Patterns

### Story Format

```
As a [persona],
I want to [action/goal],
So that [business value/outcome].
```

### INVEST Checklist

| Criterion | Question to Ask |
|-----------|-----------------|
| **I**ndependent | Can it be delivered without depending on another story? |
| **N**egotiable | Is the HOW open to discussion? |
| **V**aluable | Does it deliver value to user or business? |
| **E**stimable | Can the team estimate effort? |
| **S**mall | Fits in one sprint? |
| **T**estable | Can acceptance criteria be verified? |

### Acceptance Criteria Format (Gherkin)

```gherkin
Given [context/precondition]
When [action performed]
Then [expected outcome]
```

### Story Splitting Strategies

| Pattern | When to Use |
|---------|-------------|
| By workflow step | Story has sequential steps A→B→C |
| By user role | Different personas need different flows |
| By data variation | Same action, different input types |
| By CRUD operation | Create / Read / Update / Delete separately |
| By happy/edge path | Core flow first, error handling after |

### Red Flags — Stop and rewrite if you see these

| Red Flag | Problem |
|----------|---------|
| "As a user..." | No specific persona — who exactly? |
| "I want the system to..." | Output, not outcome — what does the user need to achieve? |
| No acceptance criteria | Untestable — how does anyone know it's done? |
| Story spans multiple sprints | Too big — split it |
| "And also..." in the So That | Multiple values — split it |
| Informational content with no verification/source criterion | Compromises Caracol's core brand promise: accurate, reliable information |

## Code Examples

### Well-formed story

```markdown
**US-042 — Filter products by category**

As a **returning buyer**,
I want to **filter the product catalog by category**,
So that **I find relevant items faster without scrolling the entire catalog**.

**Acceptance Criteria:**

Given I'm on the catalog page
When I select "Electronics" from the category filter
Then only products tagged as "Electronics" appear in the list
And the active filter is visually highlighted

Given I'm on the catalog page with an active filter
When I click "Clear filters"
Then all products are displayed again
And no filter is highlighted

**Definition of Done:**
- [ ] Filter persists on browser back navigation
- [ ] Works on mobile viewport (375px+)
- [ ] Analytics event fired on filter apply
```

### Poorly written story (DON'T)

```markdown
# Bad: No persona, no value, no testable criteria
As a user, I want a better search, so that it's good.
```

## Commands

```bash
# No CLI commands — this skill is a writing workflow, not a code tool
```

## Resources

- **Templates**: See [assets/](assets/) for story and AC templates
