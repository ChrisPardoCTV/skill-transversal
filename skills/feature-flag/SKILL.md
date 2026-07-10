---
name: feature-flag
description: >
  Guides feature flag strategy: naming, lifecycle, rollout plans, and cleanup policies.
  Trigger: When user asks to implement a feature flag, plan a rollout, or manage flag lifecycle.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.0"
allowed-tools: Read, Edit, Write
---

## When to Use

- Implementing a new feature behind a flag
- Planning a progressive rollout (canary, percentage, segment)
- Defining flag naming conventions and ownership
- Scheduling flag cleanup after graduation

## Critical Patterns

### Feature Flag Types

| Type | Purpose | Lifetime |
|------|---------|----------|
| **Release flag** | Decouple deploy from release | Short (days to weeks) |
| **Experiment flag** | A/B test / validate hypothesis | Short (duration of test) |
| **Ops flag** | Kill switch / circuit breaker | Medium (until stable) |
| **Permission flag** | Enable per plan/role/tenant | Long (permanent) |

### Flag Naming Convention

```
{team}-{feature}-{context}

Examples:
  growth-onboarding-checklist-v2
  platform-billing-new-flow
  infra-search-elastic-migration
  core-dark-mode-rollout
```

Rules:
- All lowercase, hyphens only
- Include owning team as prefix
- Avoid generic names (`new-feature`, `test-flag`)

### Rollout Strategy

```
Phase 1 — Internal (0–1%)
  → Employees, QA, internal accounts only
  → Goal: catch critical bugs before users see them

Phase 2 — Canary (1–5%)
  → Random user sample
  → Monitor: error rate, latency, key funnel metrics

Phase 3 — Gradual (5 → 20 → 50 → 100%)
  → Gate on stable metrics at each step
  → Each step: 24–48h observation window

Phase 4 — Graduation
  → Remove flag from code
  → Flag deleted from system within 2 weeks
```

### Flag Lifecycle Rules

1. Every flag MUST have an owner (person or team)
2. Every flag MUST have an expiry date defined at creation
3. Release and experiment flags must be removed within 30 days of full rollout
4. Never merge code that adds a flag without a cleanup ticket created

### Rollout Decision Gate

```
Before advancing to next % threshold, verify:
- [ ] Error rate stable (within 10% of baseline)
- [ ] Latency p99 within SLA
- [ ] Key product metric (conversion, activation) not degraded
- [ ] No spike in support tickets or CS escalations
```

## Code Examples

### Flag Definition (Generic)

```json
{
  "key": "growth-onboarding-checklist-v2",
  "description": "New onboarding checklist with guided steps for first-time users",
  "owner": "growth-team",
  "type": "release",
  "created": "2026-07-10",
  "expires": "2026-08-10",
  "cleanup_ticket": "PROD-4421",
  "rollout": {
    "strategy": "percentage",
    "current": 10,
    "target": 100
  }
}
```

### Rollout Plan Document

```markdown
## Rollout Plan — growth-onboarding-checklist-v2

**Owner:** Growth Team  
**Cleanup ticket:** PROD-4421  
**Target graduation date:** 2026-08-10

| Phase | % | Start | Gate Metrics |
|-------|---|-------|-------------|
| Internal | 1% | 2026-07-15 | No critical errors |
| Canary | 5% | 2026-07-17 | Error rate < 0.5%, activation not degraded |
| Phase 1 | 20% | 2026-07-21 | D7 activation ≥ 38% (baseline) |
| Phase 2 | 50% | 2026-07-25 | Same as Phase 1 |
| Full | 100% | 2026-07-29 | Same as Phase 1 |
| Cleanup | — | 2026-08-05 | Flag removed from code |
```

## Commands

```bash
# Example using LaunchDarkly CLI (ld-cli)
ld-cli flag create --key growth-onboarding-checklist-v2 --project default
ld-cli flag update --key growth-onboarding-checklist-v2 --rollout 10

# Example using Unleash CLI
unleash feature create --name growth-onboarding-checklist-v2
```

## Resources

- **Templates**: See [assets/](assets/) for rollout plan and flag definition templates
