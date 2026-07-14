# Skills Bundle — Design
> Equipo: design · Generado: 2026-07-14 · 0221bb4
> Fuente: https://github.com/ChrisPardoCTV/skill-transversal

## Cómo usar este archivo

Subí este archivo a tu Claude Project como **Project Knowledge** y listo — Claude aplica las skills automáticamente cuando detecta el contexto. No necesitás hacer nada más.

**Para actualizar:** cuando el equipo suba cambios, reemplazá este archivo en tu Project Knowledge por la nueva versión.

## Índice de Skills

| Skill | Descripción | Se activa cuando... |
|-------|-------------|---------------------|
| `design-critique` | Guides structured design critique sessions with actionable, principle-based feedback. | When user asks to review a design, give feedback on a screen, or run a critique session. |
| `handoff-spec` | Guides writing complete design handoff specifications for engineering teams. | When user asks to document a design for handoff, write specs, or prepare designs for development. |


---

# Skill: design-critique


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


---

# Skill: handoff-spec


## When to Use

- Design is approved and ready for engineering
- Writing component or screen specifications
- Documenting interaction states and edge cases
- Preparing assets and tokens for developers

## Critical Patterns

### Handoff Completeness Checklist

A handoff spec is incomplete if any of these are missing:

| Item | Why it matters |
|------|---------------|
| All states documented | Hover, focus, disabled, error, empty, loading |
| Responsive behavior | How layout changes at each breakpoint |
| Motion specs | Duration, easing, trigger for animations |
| Token references | Colors and spacing by token name, not hex/px |
| Edge cases | Long text, empty states, error states |
| Accessibility notes | ARIA labels, keyboard nav, focus order |

### Spec Format

```markdown
## Component: {Name}

**Purpose:** {What it does in one sentence}
**Location:** {Screen / flow where it appears}
**Figma link:** {Direct link to frame}

### States
- Default: ...
- Hover: ...
- Active: ...
- Disabled: ...
- Error: ...

### Specs
- Width: {token or fixed value}
- Height: {min-height if dynamic}
- Padding: {token name}
- Typography: {token name}
- Color: {token name}
- Border radius: {token name}

### Behavior
- {Interaction description}
- Transition: {duration} {easing}

### Accessibility
- Role: {ARIA role}
- Label: "{text}"
- Keyboard: {Tab order, Enter/Space behavior}

### Edge cases
- Long text: {truncate / wrap behavior}
- Empty state: {what shows}
- Error state: {error message format}
```

## Code Examples

### Complete handoff note

```markdown
## Component: Video Card

**Purpose:** Entry point to video content in feed and search results
**Location:** Home feed, Search results, Category pages
**Figma link:** figma.com/file/...

### States
- Default: Thumbnail + title + metadata visible
- Hover (desktop): Play icon overlay at 80% opacity
- Focus: 2px outline using color.focus token
- Loading: Skeleton placeholder, same dimensions

### Specs
- Width: 100% of container (fluid)
- Min-height: 240px
- Padding: spacing.md (16px)
- Title: typography.body.lg.semibold
- Metadata: typography.body.sm, color.text.secondary
- Border radius: radius.md (8px)

### Behavior
- Click: Navigate to player view
- Hover overlay fade-in: 150ms ease-out

### Accessibility
- Role: article
- Label: "{title} — {duration} — {channel}"
- Keyboard: Enter activates, same as click

### Edge cases
- Title > 2 lines: truncate with ellipsis
- No thumbnail: show brand placeholder image
- Live content: replace duration with "EN VIVO" badge
```

## Commands

```bash
# No CLI commands — this skill is a documentation workflow
```

## Resources

- **Templates**: See [assets/](assets/) for handoff spec templates
