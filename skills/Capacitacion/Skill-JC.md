---
name: feedback-rapido-diseno
description: >
  Da feedback breve y accionable sobre una pieza de diseño (pantalla, componente o pieza gráfica),
  usando una plantilla corta de 3 puntos: qué funciona, qué mejorar y una sugerencia concreta.
  Trigger: Cuando alguien comparte un diseño y pide un feedback rápido, opinión o pequeño comentario
  (no una crítica completa de diseño).
license: Apache-2.0
metadata:
  author: Equipo Producto/diseño digital
  version: "1.0"
allowed-tools: Read, Write
---

## Cuándo usar esta skill

- Alguien comparte una captura, link de Figma o pieza de diseño y pide "un feedback rápido" o "qué opinas".
- Se necesita un comentario corto para dejar en una tarea, PR o hilo de chat — no una auditoría completa.
- Es una revisión informal, antes de pasar a una crítica de diseño más profunda (para eso existe la skill `design-critique`).

Esta skill es un **ejemplo sencillo** pensado para capacitación: muestra la estructura mínima que
debe tener una skill (frontmatter + secciones) usando un caso simple y fácil de replicar.

## Patrones clave

### La plantilla de 3 puntos

Todo feedback rápido sigue el mismo formato, sin importar la pieza:

```
✅ Qué funciona: <algo concreto que sí resuelve el problema>
⚠️ Qué mejorar: <un problema puntual, no una lista larga>
💡 Sugerencia: <una acción concreta y pequeña, no un rediseño>
```

Reglas simples:

- Máximo un punto por línea. Si hay más de 3 problemas, es momento de pedir una crítica completa
  en lugar de un feedback rápido.
- La sugerencia siempre debe ser algo que se pueda hacer en minutos, no en días.
- Nunca dejar solo la queja ("⚠️") sin una sugerencia ("💡") al lado.

### Tono

- Directo y amable, sin rodeos ni "creo que tal vez quizás".
- Enfocado en la pieza, no en la persona ("el botón pierde contraste" en vez de "no cuidaste el contraste").

## Ejemplos de código

### Feedback bien estructurado

```markdown
✅ Qué funciona: La jerarquía visual es clara, el ojo va directo al CTA principal.
⚠️ Qué mejorar: El texto de ayuda (#9E9E9E) tiene poco contraste sobre el fondo blanco.
💡 Sugerencia: Cambiar a un gris más oscuro (#6B6B6B o el token de "texto secundario" del sistema).
```

### Feedback que NO sigue la plantilla (evitar)

```markdown
✗ "Está bien pero no me convence del todo, tal vez cambiaría algo del color."
```

Esto no dice qué funciona, no señala un problema concreto, y no da una sugerencia accionable.

## Comandos

```bash
# No requiere comandos — es una skill conversacional de feedback.
```

## Recursos

- Para revisiones más profundas (jerarquía, accesibilidad, consistencia con el sistema de diseño),
  usar la skill `design-critique` del equipo de diseño.
