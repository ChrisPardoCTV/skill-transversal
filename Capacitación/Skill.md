---
name: capacitacion-skills-transversales
description: >
  Cataloga y explica todas las skills del repositorio "skill-transversal" (Diseño, Producto y
  Herramientas) usado por los equipos de Producto/Diseño de Caracol Televisión: qué hace cada
  skill, cuándo se dispara, sus patrones clave y dónde vive el archivo SKILL.md completo dentro
  del repo. Úsala SIEMPRE que alguien pregunte "qué skills tenemos", "catálogo de skills
  transversales", "qué hace la skill X", pida un resumen de capacitación/onboarding sobre las
  skills del equipo, quiera saber cuál skill usar para una tarea de producto o diseño, o
  mencione la carpeta "Capacitación" / el repo "skill-transversal". No reemplaza a las skills
  individuales — este documento es el mapa; para ejecutar el trabajo real (escribir una user
  story, un roadmap, una crítica de diseño, etc.) se debe abrir e invocar la skill específica
  correspondiente.
license: Apache-2.0
metadata:
  author: Equipo Producto/diseño digital
  version: "1.0"
  language: es
  source_repo: https://github.com/ChrisPardoCTV/skill-transversal
allowed-tools: Read
---

## Cuándo usar

- Alguien nuevo en el equipo pregunta qué skills existen o cómo empezar (onboarding/capacitación).
- Alguien duda entre varias skills para una tarea ("¿uso user-story o product-discovery para esto?").
- Se necesita un resumen rápido de una skill sin abrir el `SKILL.md` completo.
- Se va a armar o actualizar material de capacitación sobre el repo `skill-transversal`.
- El archivo `Capacitación/Skill.md` del repo aparece vacío o desactualizado — este documento
  es el reemplazo funcional mientras ese archivo se completa.

Este documento **no ejecuta** las skills — es un índice. Cuando la tarea real sea escribir,
revisar o planificar algo, seguí el puntero hacia el `SKILL.md` correspondiente y aplicá esa
skill directamente.

## Cómo está organizado el repo

```
skill-transversal/
├── skills/
│   ├── design/      → skills de Diseño
│   ├── product/     → skills de Producto
│   └── _tooling/     → skills de infraestructura (sync, instalación)
├── dist/
│   ├── design/skills-bundle.md    → bundle para subir a Project Knowledge (Claude.ai)
│   └── product/skills-bundle.md   → idem, para el equipo de Producto
└── scripts/install.sh             → instalación inicial vía CLI
```

Cada skill vive en `skills/<área>/<nombre>/SKILL.md`. Para instalarlas o actualizarlas localmente
se usa la skill `skill-sync` (ver más abajo) — nunca se edita el bundle directamente.

## Catálogo de skills

### Diseño

| Skill | Se dispara cuando... | Qué resuelve |
|---|---|---|
| **design-critique** (`skills/design/design-critique`) | Piden feedback sobre una pantalla, revisar un diseño, o correr una sesión de crítica estructurada. | Framework de crítica por capas (objetivo, usuario, jerarquía, consistencia, accesibilidad, factibilidad), escala de severidad 🔴 bloqueante / 🟡 mejora / 🟢 sugerencia, y un checklist de auto-crítica antes de compartir con el equipo. |
| **handoff-spec** (`skills/design/handoff-spec`) | El diseño ya está aprobado y hay que documentarlo para ingeniería. | Checklist de completitud de handoff (todos los estados, responsive, motion, tokens en vez de hex/px, edge cases, accesibilidad) y una plantilla de spec por componente lista para copiar. |

### Producto

| Skill | Se dispara cuando... | Qué resuelve |
|---|---|---|
| **user-story** (`skills/product/user-story`) | Piden escribir, revisar o refinar una historia de usuario, épica o criterios de aceptación. | Formato As a / I want / So that, checklist INVEST, criterios de aceptación en Gherkin, estrategias de split de épicas, red flags a corregir. Incluye una regla de marca Caracol: toda historia que publique contenido informativo debe llevar un criterio de aceptación de verificación/fuente. |
| **product-discovery** (`skills/product/product-discovery`) | Se arranca discovery de una idea nueva, hay que formular hipótesis, o diseñar experimentos antes de construir. | Framing de problema en 5 pasos, formato de hipótesis validable, mapa de riesgo vs. conocibilidad de supuestos, y tipos de experimento por fidelidad (concierge, Wizard of Oz, landing page, prototipo, A/B, MLP). |
| **product-roadmap** (`skills/product/product-roadmap`) | Hay que planear o priorizar un roadmap, o comunicarlo a distintos stakeholders. | Elección entre Now/Next/Later, roadmap por resultados, trimestral o por features; frameworks RICE y MoSCoW; anti-patrón output vs. outcome. Incluye una restricción de marca Caracol: ninguna iniciativa "Now"/"Must" puede sacrificar verificación editorial por velocidad, y el impacto sobre la confianza informativa se puntúa en el RICE, no solo el uso. |
| **okr-planning** (`skills/product/okr-planning`) | Se definen o califican OKRs trimestrales o anuales. | Anatomía Objetivo/Key Result/Iniciativa, reglas de calidad de KRs (medible, outcome no output), regla de 2–4 KRs por objetivo, y escala de calificación estilo Google (0.6–0.7 es el target sano, no 1.0). |
| **feature-flag** (`skills/product/feature-flag`) | Se implementa una funcionalidad detrás de un flag, o hay que planear un rollout progresivo. | Tipos de flag (release, experiment, ops, permission) con su ciclo de vida, convención de nombres `{team}-{feature}-{context}`, fases de rollout (interno → canary → gradual → graduación) con gates de decisión, y reglas de limpieza (todo flag necesita dueño, fecha de expiración y ticket de cleanup). |

### Herramientas

| Skill | Se dispara cuando... | Qué resuelve |
|---|---|---|
| **skill-sync** (`skills/_tooling/skill-sync`) | Alguien corre `/skill-sync pull` o `/skill-sync list`, o pregunta si sus skills están actualizadas. | Sincroniza las skills del equipo desde el repo de GitHub `skill-transversal` hacia `~/.claude/skills/` (git pull o clone según corresponda), listando versiones instaladas. Nunca sobreescribe su propia carpeta durante el pull, para no romperse a sí misma en pleno uso. |

## Principio de marca transversal — Caracol Televisión

Dos skills del catálogo (`user-story` y `product-roadmap`) llevan incorporada la misma regla de
fondo, porque la marca de Caracol se sostiene sobre la veracidad y fiabilidad de la información
que entrega a sus audiencias:

- Toda historia o iniciativa que publique o muestre contenido informativo (noticias, alertas,
  data en vivo, notificaciones) debe tratar esa confianza como un requisito de primer nivel, no
  como un detalle de implementación.
- Ninguna iniciativa puede acelerarse a costa de saltarse verificación de fuente o revisión
  editorial.
- Ante la duda sobre si algo compromete la fiabilidad informativa, se escala a revisión editorial
  antes de comprometerlo en un roadmap o marcarlo "Ready".

Si se crean nuevas skills de Producto que toquen contenido informativo, vale la pena heredar este
mismo principio en vez de reinventarlo.

## Cómo elegir la skill correcta

```
¿Es sobre una pantalla/diseño ya hecho?
  → feedback puntual          → design-critique
  → listo para ingeniería     → handoff-spec

¿Es sobre una funcionalidad/idea de producto?
  → todavía no sabemos si construirla   → product-discovery
  → ya la vamos a construir, hay que documentarla → user-story
  → hay que decidir cuándo y con qué prioridad     → product-roadmap
  → hay que medir el progreso del trimestre        → okr-planning
  → ya está construida, falta el rollout           → feature-flag

¿Es sobre las skills mismas?
  → instalar/actualizar/listar         → skill-sync
```

## Mantenimiento de este catálogo

Este archivo es un índice manual: si se agrega, renombra o retira una skill en
`skills/design/`, `skills/product/` o `skills/_tooling/`, hay que actualizar la tabla
correspondiente acá para que no quede desactualizado. La fuente de verdad de cada skill sigue
siendo su propio `SKILL.md` — este documento resume, no reemplaza.
