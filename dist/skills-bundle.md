# Skills Bundle — Gentleman Programming
> Generado: 2026-07-14 · ddbea86
> Fuente: https://github.com/ChrisPardoCTV/skill-transversal

## Cómo usar este archivo

Este archivo contiene todas las skills del equipo de producto. Subilo a tu Claude Project como **Project Knowledge** y listo — Claude las aplica automáticamente cuando detecta que estás trabajando en algo relacionado. No necesitás hacer nada más.

**Para actualizar:** cuando el equipo suba cambios, descargá la nueva versión de este archivo desde el repositorio y reemplazá el archivo anterior en tu Project Knowledge.

## Índice de Skills

| Skill | Descripción | Se activa cuando... |
|-------|-------------|---------------------|
| `user-story` | Guides writing well-formed user stories with acceptance criteria following the INVEST principle. | When user asks to write, review, or refine a user story, epic, or acceptance criteria. |
| `product-discovery` | Guides product discovery process: problem framing, hypothesis definition, and experiment design. | When user asks to run discovery, validate an idea, define experiments, or map user problems. |
| `product-roadmap` | Guía la planificación de roadmaps, marcos de priorización y comunicación de roadmap orientada a resultados (outcomes). | Cuando el usuario pida planificar un roadmap, priorizar funcionalidades o comunicar la dirección de producto. |
| `okr-planning` | Guides OKR definition, alignment, and grading for product teams. | When user asks to define OKRs, key results, write objectives, or review OKR quality. |
| `feature-flag` | Guides feature flag strategy: naming, lifecycle, rollout plans, and cleanup policies. | When user asks to implement a feature flag, plan a rollout, or manage flag lifecycle. |


---

# Skill: user-story


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


---

# Skill: product-discovery


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


---

# Skill: product-roadmap


## Cuándo Usar

- Definir o revisar un roadmap de producto
- Priorizar un backlog usando un framework
- Comunicar el roadmap a stakeholders
- Elegir entre Now / Next / Later o planificación trimestral

## Patrones Críticos

### Tipos de Roadmap — Elige el Correcto

| Tipo | Mejor Para | Evitar Cuando |
|------|-------------|----------------|
| **Now / Next / Later** | Etapa temprana, alcance incierto | Los stakeholders necesitan fechas fijas |
| **Basado en resultados (outcomes)** | Fase de ajuste producto-mercado | Los equipos necesitan detalle a nivel de tarea |
| **Trimestral (alineado a OKR)** | Organizaciones en escalamiento con dependencias | El roadmap cambia cada 2 semanas |
| **Basado en features** | Organizaciones orientadas a ventas, enterprise | El objetivo es la innovación |

### Marcos de Priorización

#### Puntaje RICE

```
RICE = (Alcance × Impacto × Confianza) / Esfuerzo
```

| Campo | Escala |
|-------|--------|
| Alcance (Reach) | # de usuarios afectados por período |
| Impacto | 3=masivo / 2=alto / 1=medio / 0.5=bajo / 0.25=mínimo |
| Confianza | 100% / 80% / 50% |
| Esfuerzo | Persona-meses |

#### MoSCoW

| Prioridad | Significado |
|-----------|--------------|
| **Must (Debe)** | No negociable para el lanzamiento |
| **Should (Debería)** | Alto valor, no está en el camino crítico |
| **Could (Podría)** | Deseable si hay capacidad disponible |
| **Won't (No hará)** | Fuera de alcance — documentado explícitamente |

### Anti-Patrón: Resultado (Outcome) vs Entregable (Output)

```
# Roadmap de entregables (NO HACER — compromete al equipo con soluciones)
Q3: Construir nuevo dashboard
Q4: Rediseñar onboarding

# Roadmap de resultados (SÍ HACER — compromete a entregar valor)
Q3: Reducir el tiempo hasta el primer valor de 7 días a 2 días
Q4: Aumentar la tasa de activación de 40% a 65%
```

### Reglas de Comunicación con Stakeholders

1. **Ejecutivos**: resultados + impacto de negocio, sin listas de features
2. **Ingeniería**: épicas + restricciones + dependencias
3. **Ventas/CS**: cronogramas + qué está comprometido vs. qué es direccional
4. **Usuarios**: temas + problemas que se están resolviendo

## Ejemplos de Código

### Tabla de Puntaje RICE (Markdown)

```markdown
| Feature | Alcance | Impacto | Confianza | Esfuerzo | RICE |
|---------|---------|---------|-----------|----------|------|
| SSO Login | 5000 | 2 | 80% | 2 | 4000 |
| Modo oscuro | 2000 | 0.5 | 100% | 1 | 1000 |
| Exportación masiva | 800 | 3 | 50% | 3 | 400 |
```

### Plantilla Now / Next / Later

```markdown
## Roadmap de Producto — [Trimestre/Período]

### Now (sprint/trimestre actual)
- **[Tema]**: [Qué estamos construyendo + resultado esperado]

### Next (siguiente trimestre)
- **[Tema]**: [Qué planeamos abordar + hipótesis]

### Later (6+ meses)
- **[Tema]**: [Dirección, sujeta a descubrimiento]

> Los elementos en "Later" son direccionales, no comprometidos.
```

## Comandos

```bash
# Sin comandos de CLI — esta skill es un flujo de trabajo de planificación
```

## Recursos

- **Plantillas**: Ver [assets/](assets/) para plantillas de puntaje RICE y de roadmap


---

# Skill: okr-planning


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


---

# Skill: feature-flag


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
