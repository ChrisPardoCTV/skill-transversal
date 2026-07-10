---
name: user-story
description: >
  Guides writing well-formed user stories with acceptance criteria following the INVEST principle.
  Trigger: When user asks to write, review, or refine a user story, epic, or acceptance criteria.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
allowed-tools: Read, Edit, Write
---

## When to Use

- User asks to write or refine a user story
- User wants acceptance criteria for a feature
- Reviewing stories for completeness or ambiguity
- Splitting epics into smaller deliverable stories

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
