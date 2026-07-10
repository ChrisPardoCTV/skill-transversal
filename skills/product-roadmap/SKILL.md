---
name: product-roadmap
description: >
  Guía la planificación de roadmaps, marcos de priorización y comunicación de roadmap orientada a resultados (outcomes).
  Activador: Cuando el usuario pida planificar un roadmap, priorizar funcionalidades o comunicar la dirección de producto.
license: Apache-2.0
metadata:
  author: gentleman-programming
  version: "1.1"
  language: es
allowed-tools: Read, Edit, Write
---

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
