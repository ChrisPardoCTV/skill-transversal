---
name: user-story
description: >
  Guía la escritura de historias de usuario bien formadas con criterios de aceptación siguiendo el principio INVEST.
  Activador: Cuando el usuario pida escribir, revisar o refinar una historia de usuario, épica o criterios de aceptación.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.1"
  language: es
allowed-tools: Read, Edit, Write
---

## Cuándo Usar

- El usuario pide escribir o refinar una historia de usuario
- El usuario quiere criterios de aceptación para una funcionalidad
- Revisión de historias por completitud o ambigüedad
- División de épicas en historias más pequeñas y entregables

## Patrones Críticos

### Formato de Historia

```
Como [persona],
Quiero [acción/objetivo],
Para [valor de negocio/resultado].
```

### Checklist INVEST

| Criterio | Pregunta a Hacer |
|----------|-------------------|
| **I**ndependiente | ¿Puede entregarse sin depender de otra historia? |
| **N**egociable | ¿El CÓMO está abierto a discusión? |
| **V**aliosa | ¿Entrega valor al usuario o al negocio? |
| **E**stimable | ¿El equipo puede estimar el esfuerzo? |
| **S**mall (Pequeña) | ¿Cabe en un sprint? |
| **T**esteable | ¿Se pueden verificar los criterios de aceptación? |

### Formato de Criterios de Aceptación (Gherkin)

```gherkin
Dado [contexto/precondición]
Cuando [acción realizada]
Entonces [resultado esperado]
```

### Estrategias de División de Historias

| Patrón | Cuándo Usarlo |
|--------|----------------|
| Por paso del flujo | La historia tiene pasos secuenciales A→B→C |
| Por rol de usuario | Distintas personas necesitan flujos diferentes |
| Por variación de datos | Misma acción, distintos tipos de entrada |
| Por operación CRUD | Crear / Leer / Actualizar / Eliminar por separado |
| Por camino feliz/borde | Flujo principal primero, manejo de errores después |

## Ejemplos de Código

### Historia bien formada

```markdown
**US-042 — Filtrar productos por categoría**

Como **comprador recurrente**,
Quiero **filtrar el catálogo de productos por categoría**,
Para **encontrar artículos relevantes más rápido sin recorrer todo el catálogo**.

**Criterios de Aceptación:**

Dado que estoy en la página del catálogo
Cuando selecciono "Electrónica" en el filtro de categoría
Entonces solo aparecen en la lista los productos etiquetados como "Electrónica"
Y el filtro activo se resalta visualmente

Dado que estoy en la página del catálogo con un filtro activo
Cuando hago clic en "Limpiar filtros"
Entonces se muestran todos los productos nuevamente
Y ningún filtro queda resaltado

**Definición de Hecho (DoD):**
- [ ] El filtro persiste al navegar hacia atrás en el navegador
- [ ] Funciona en viewport móvil (375px+)
- [ ] Se dispara evento de analítica al aplicar el filtro
```

### Historia mal escrita (NO HACER)

```markdown
# Mal: Sin persona, sin valor, sin criterios testeables
Como usuario, quiero una mejor búsqueda, para que sea buena.
```

## Comandos

```bash
# Sin comandos de CLI — esta skill es un flujo de escritura, no una herramienta de código
```

## Recursos

- **Plantillas**: Ver [assets/](assets/) para plantillas de historias y criterios de aceptación
