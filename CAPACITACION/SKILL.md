---
name: estados-ui-checklist
description: >
  Verifica que un componente o pantalla tenga diseñados todos los estados de interfaz (default, hover,
  focus, active, disabled, loading, error, empty) antes de pasar a desarrollo o a crítica de diseño.
  Trigger: Cuando el usuario pida revisar un componente/pantalla antes de handoff, pregunte "¿me falta
  algún estado?", o comparta un diseño para verificar que esté completo antes de entregarlo.
license: Apache-2.0
metadata:
  author: equipo-producto-diseno
  version: "1.0"
allowed-tools: Read, Write
---

<!--
  Esta skill vive en CAPACITACION/ como EJEMPLO DE ENTRENAMIENTO: sirve para que el equipo vea,
  con un caso simple y real, cómo se arma una skill (frontmatter + reglas + ejemplos) antes de
  escribir las propias. Si la quieren usar de verdad, muévanla a skills/design/estados-ui-checklist/
  siguiendo la convención del README principal del repo.
-->

## Para qué sirve

Un motivo muy común de retrasos entre Diseño y Desarrollo es que un componente llega a handoff
con solo el estado "default" resuelto. Esta skill hace una revisión rápida, antes de entregar,
para confirmar que ningún estado quedó sin diseñar.

## Cuándo usarla

- Antes de mandar un componente o pantalla a desarrollo
- Antes de subir un diseño a crítica de equipo
- Cuando alguien pregunta "¿esto ya está listo para handoff?"
- Al documentar un componente nuevo en el design system

## Checklist de estados obligatorios

| Estado | Pregunta guía | ¿Aplica siempre? |
|--------|---------------|-------------------|
| Default | ¿Cómo se ve en su condición normal, sin interacción? | Sí |
| Hover | ¿Qué cambia al pasar el mouse (desktop)? | Sí, si es interactivo |
| Focus | ¿Hay un indicador visible al navegar con teclado (Tab)? | Sí, si es interactivo |
| Active/Pressed | ¿Cómo se ve en el instante del clic/tap? | Sí, si es un botón o control |
| Disabled | ¿Se distingue claramente que no se puede usar? | Si aplica a ese componente |
| Loading | ¿Qué se muestra mientras carga (skeleton, spinner)? | Si depende de datos async |
| Error | ¿Cómo se comunica un error (mensaje, color, ícono)? | Si puede fallar la acción |
| Empty | ¿Qué se muestra cuando no hay contenido/datos? | Si es una lista, feed o resultado de búsqueda |

Si la respuesta a "¿aplica siempre?" es sí y el estado no está diseñado, es un bloqueante para
handoff, no un "nice to have".

## Cómo hacer la revisión

1. Abrir el frame en Figma y listar el componente o pantalla a revisar.
2. Recorrer la tabla de arriba estado por estado, marcando ✅ diseñado / ⚠️ falta / ➖ no aplica.
3. Para cada ⚠️, anotar qué falta específicamente (no solo "falta el estado").
4. Resumir el resultado en un formato corto y accionable (ver ejemplo abajo).

## Ejemplo de salida

```markdown
### Revisión de estados — Card de "Últimas noticias"

| Estado | Resultado |
|--------|-----------|
| Default | ✅ Diseñado |
| Hover | ✅ Diseñado (overlay 80% opacidad) |
| Focus | ⚠️ Falta — no hay outline visible para navegación por teclado |
| Active | ➖ No aplica (no es clickeable directamente, navega el contenedor) |
| Disabled | ➖ No aplica |
| Loading | ⚠️ Falta — no hay skeleton mientras carga la imagen |
| Error | ⚠️ Falta — no hay fallback si la imagen no carga |
| Empty | ➖ No aplica |

**Conclusión:** 3 bloqueantes antes de handoff (focus, loading, error). El resto está listo.
```

## Resultado esperado

Una lista corta y priorizada de qué falta diseñar, sin ambigüedad, lista para agregar como
comentario en Figma o como tarea en el tablero del equipo.

### Autor

Julian Camilo Capera