---
name: design-critique
description: >
  Guides structured design critique sessions with actionable, principle-based feedback.
  Trigger: When user asks to review a design, give feedback on a screen, or run a critique session.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
allowed-tools: Read, Write
---

## When to Use

- User shares a design and asks for feedback
- Running a structured critique session with the team
- Reviewing screens before handoff to engineering
- Validating design decisions against principles

## Critical Patterns

### Critique Framework (not personal, not vague)

Feedback must be tied to a principle, not opinion:

```
✗ "I don't like the button color"
✓ "The CTA lacks contrast against the background (WCAG AA requires 4.5:1 ratio)"

✗ "This feels cluttered"
✓ "There are 4 competing focal points — hierarchy is unclear for first-time users"
```

### Critique Structure

| Layer | Question |
|-------|----------|
| **Goal** | What problem does this screen solve? |
| **User** | Who is this for and what do they need to do? |
| **Hierarchy** | Where does the eye go first? Is that correct? |
| **Consistency** | Does this follow the design system? |
| **Accessibility** | Contrast, touch targets, labels — compliant? |
| **Feasibility** | Can engineering implement this as-is? |

### Severity Scale

| Level | Label | Meaning |
|-------|-------|---------|
| 🔴 | Blocker | Must fix before handoff |
| 🟡 | Improvement | Should fix, won't block |
| 🟢 | Suggestion | Nice to have, low priority |

## Code Examples

### Well-structured critique comment

```markdown
🔴 **Blocker — Contrast ratio**
The body text (#767676) on white background has a 4.48:1 ratio.
WCAG AA requires 4.5:1 for normal text.
Fix: use #757575 or darker.

🟡 **Improvement — Touch target**
The "Dismiss" link is 24px tall — below the 44px minimum for mobile.
Fix: wrap in a larger tap area or convert to button.

🟢 **Suggestion — Micro-interaction**
Adding a subtle state change on the card hover would reinforce affordance.
```

## Commands

```bash
# No CLI commands — this skill is a design review workflow
```

## Resources

- **Templates**: See [assets/](assets/) for critique templates and checklists
