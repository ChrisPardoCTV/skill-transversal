---
name: cwv-sentinel
description: Detecta y diagnostica regresiones de Core Web Vitals (LCP, INP, CLS) en URLs críticas, correlacionándolas con deploys recientes para señalar la causa probable. Usar cuando se pida monitorear performance web, revisar Core Web Vitals, investigar por qué subió el LCP/INP/CLS de un sitio, o analizar el impacto de un release en performance.
---

# CWV Sentinel

Agente de monitoreo de Core Web Vitals para sitios y apps del dominio de Plataforma.

## Propósito

Detectar regresiones de LCP, INP y CLS en URLs críticas antes de que se conviertan en un problema de SEO o experiencia, y señalar la causa probable correlacionando el momento de la degradación con deploys recientes.

## Cuándo usar

- El usuario pide revisar el estado de Core Web Vitals de un sitio/URL.
- El usuario pregunta por qué empeoró el LCP/INP/CLS de una página.
- El usuario quiere saber si un release/deploy afectó performance.
- Se necesita un reporte de URLs críticas en rojo/amarillo/verde.

## Flujo de trabajo

1. **Definir alcance:** confirmar la lista de URLs críticas a evaluar (si no se especifica, pedirla o usar la última conocida).
2. **Obtener datos:** consultar la fuente de Core Web Vitals disponible (CrUX API, PageSpeed Insights API, export de RUM/GA4, o el dataset que el usuario provea). Si no hay acceso directo a una API, pedir al usuario el archivo/export correspondiente.
3. **Calcular baseline:** usar los últimos 7-14 días como referencia por URL y métrica (p75 de LCP, INP, CLS).
4. **Detectar regresión:** marcar cualquier métrica con degradación >10% vs. baseline, clasificando severidad (leve/moderada/crítica) según el umbral:
   - LCP: verde <2.5s, ámbar 2.5-4s, rojo >4s
   - INP: verde <200ms, ámbar 200-500ms, rojo >500ms
   - CLS: verde <0.1, ámbar 0.1-0.25, rojo >0.25
5. **Correlacionar causa probable:** cruzar el timestamp de la regresión con el historial de deploys/releases (changelog, CI/CD) de esa URL o sitio. Si coincide una ventana de deploy con el inicio de la degradación, señalarlo como causa probable.
6. **Entregar resultado:** reporte accionable con:
   - URL, métrica afectada, valor anterior vs. actual, % de cambio.
   - Deploy/cambio sospechoso (si se identificó) con fecha/hora.
   - Recomendación técnica concreta (ej. lazy loading, preload de fuente, eliminar layout shift de un banner).

## Formato de salida esperado

```
[SEVERIDAD] URL — Métrica: valor anterior → valor actual (Δ%)
Causa probable: deploy/cambio + fecha
Recomendación: acción técnica concreta
```

## KPI relacionados

LCP p75 en URLs críticas, % de URLs críticas en verde, disponibilidad, tiempo de detección de degradación.

## Notas

- Si no hay datos de RUM reales, aclarar que el análisis es sobre datos de laboratorio (menos representativo del usuario real).
- No inventar datos de performance: si falta la fuente, pedirla explícitamente antes de concluir.
