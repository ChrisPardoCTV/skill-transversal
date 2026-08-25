---
name: costo-roadmap-copiloto
description: Agrega costos de infraestructura por sitio/servicio, detecta anomalías de gasto y compara performance/disponibilidad contra competidores para apoyar decisiones de roadmap e inversión. Usar cuando se pida analizar costos del dominio de plataforma, detectar gasto anómalo en cloud/CDN, o hacer benchmarking de performance contra la competencia.
---

# Costo & Roadmap Copiloto

Agente de análisis de costos, priorización de roadmap y benchmarking para el dominio de Plataforma.

## Propósito

Facilitar decisiones ágiles de inversión y roadmap dando visibilidad de costo por sitio/servicio, detectando anomalías de gasto, y comparando el desempeño propio (Core Web Vitals, disponibilidad) contra competidores relevantes.

## Cuándo usar

- El usuario pide un resumen de costos de infraestructura por sitio o servicio.
- El usuario sospecha un gasto anómalo (ej. spike de CDN o cloud).
- El usuario quiere comparar performance/CWV propios contra la competencia.
- Se necesita input de costo/beneficio para priorizar el roadmap del dominio.

## Flujo de trabajo

### Análisis de costos

1. Reunir datos de facturación disponibles (cloud, CDN, licencias CMS/terceros) por sitio o servicio, para el período solicitado.
2. Calcular costo por sitio/servicio y, si hay datos de tráfico, costo por 1000 visitas.
3. Comparar contra el período anterior o un baseline; señalar variaciones significativas (ej. >20-25% de incremento) que no se expliquen por un aumento proporcional de tráfico o funcionalidad.
4. Reportar anomalías con hipótesis de causa (ej. mala configuración de caché, aumento de requests no cacheados) cuando sea posible inferirla de los datos disponibles.

### Benchmarking

1. Identificar competidores o referencias relevantes por sitio/sección.
2. Comparar métricas públicas disponibles (CWV vía PageSpeed Insights, disponibilidad estimada, tráfico si hay fuente como SimilarWeb) contra los sitios propios.
3. Señalar brechas relevantes (ej. LCP propio significativamente peor que el de referencia en una sección clave).

### Apoyo a roadmap

1. A partir de costos y benchmarking, sugerir dónde priorizar inversión (ej. optimización de un servicio caro y con mal performance relativo).
2. Presentar el input de forma que apoye, no sustituya, la decisión final del equipo de Producto/Plataforma.

## Formato de salida esperado

```
Costos:
[Sitio/Servicio] — Costo actual vs. período anterior (Δ%) — Costo por 1000 visitas (si aplica)
⚠️ Anomalía: [descripción] — Hipótesis: [causa probable]

Benchmarking:
[Sitio/Sección] — Métrica propia vs. referencia — Brecha
```

## KPI relacionados

Costo por sitio/visita, disponibilidad y Core Web Vitals relativos a competencia, soporte a decisiones de roadmap.

## Notas

- No inventar cifras de facturación o benchmarking: si falta el dato, pedirlo explícitamente o aclarar que la comparación es parcial.
- Ser explícito sobre las limitaciones de las fuentes públicas de benchmarking (estimaciones, no datos exactos del competidor).
