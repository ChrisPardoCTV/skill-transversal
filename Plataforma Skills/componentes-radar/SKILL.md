---
name: componentes-radar
description: Analiza repos de código y Figma para detectar componentes/templates duplicados o inconsistentes entre sitios y priorizar cuáles conviene unificar en el design system. Usar cuando se pida auditar reutilización de componentes, detectar deuda técnica de frontend, o encontrar candidatos a unificar en un sistema de diseño compartido.
---

# Componentes Radar

Agente de auditoría de reutilización de componentes y templates entre los sitios/apps del dominio de Plataforma.

## Propósito

Dar visibilidad de qué tan reutilizados vs. duplicados están los componentes/templates entre sitios, para reducir deuda técnica y mejorar consistencia UX/UI, priorizando qué unificar primero según impacto y esfuerzo.

## Cuándo usar

- El usuario pide un mapa o auditoría de reutilización de componentes.
- El usuario sospecha que hay implementaciones duplicadas de un mismo tipo de componente (ej. cards, players, headers) entre sitios.
- El usuario quiere detectar drift entre lo definido en Figma (design system) y lo implementado en código.
- Se necesita priorizar un backlog de deuda técnica de frontend.

## Flujo de trabajo

1. **Definir alcance:** confirmar qué repos/sitios y qué tipo de componente se va a analizar (o hacerlo de forma general si no se especifica).
2. **Inventariar componentes:** revisar los repos disponibles e identificar componentes por nombre, propósito visual/funcional y ubicación (ej. "card de noticia" en Noticias Caracol, Gol Caracol, BLU, La Kalle).
3. **Detectar duplicación/similitud:** agrupar componentes que cumplen la misma función aunque tengan nombres o implementaciones distintas. Señalar cuántas variantes existen y en qué sitios.
4. **Comparar contra Figma (si hay acceso):** identificar si el componente en código corresponde a un componente de la librería de Figma o es una instancia "detached"/modificada (drift).
5. **Priorizar:** ordenar los candidatos a unificar según:
   - Frecuencia de uso (cuántos sitios lo usan).
   - Esfuerzo estimado de unificación (líneas de código, complejidad).
   - Impacto en consistencia visual y mantenimiento.
6. **Entregar backlog:** lista priorizada con estimación de impacto/esfuerzo por candidato.

## Formato de salida esperado

```
Componente: [tipo de componente]
Variantes encontradas: [N] en [sitios]
Drift con Figma: sí/no
Impacto estimado: alto/medio/bajo
Esfuerzo estimado: alto/medio/bajo
Recomendación: unificar / mantener / evaluar más adelante
```

## KPI relacionados

% de componentes/templates reutilizables, reducción de deuda técnica (componentes duplicados eliminados por trimestre), consistencia UX/UI.

## Notas

- Si no hay acceso a los repos o a Figma, pedir explícitamente el acceso o los archivos exportados antes de concluir; no inventar el estado de reutilización.
- Calibrar el umbral de "similitud" con criterio: dos componentes con el mismo propósito visual pero implementación distinta cuentan como duplicados aunque el nombre no coincida.
