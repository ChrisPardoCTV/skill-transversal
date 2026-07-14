---
name: handoff-spec
description: >
  Guides writing complete design handoff specifications for engineering teams.
  Trigger: When user asks to document a design for handoff, write specs, or prepare designs for development.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
allowed-tools: Read, Write
---

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
