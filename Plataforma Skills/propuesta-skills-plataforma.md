# Propuesta de Skills de IA — Dominio de Plataforma Digital

## Tabla comparativa

| # | Skill | Frente principal | KPI que impacta | Impacto | Esfuerzo | Prioridad |
|---|-------|------------------|------------------|---------|----------|-----------|
| 1 | **CWV Sentinel** | Performance / Core Web Vitals | LCP p75, % URLs verdes, disponibilidad | Alto | Medio | 1ª |
| 2 | **Release Guardian** | UX/UI consistente y releases coordinados | % releases sin incidentes, tiempo de publicación | Alto | Medio-Alto | 2ª |
| 3 | **Componentes Radar** | Templates/componentes reutilizables, deuda técnica | % componentes reutilizables, deuda técnica | Medio-Alto | Medio | 3ª |
| 4 | **Costo & Roadmap Copiloto** | Costos, roadmap, benchmarking | Costo por sitio/visita, ROI de iniciativas | Medio | Bajo-Medio | 4ª |

---

## 1. CWV Sentinel

**Problema:** El diagnóstico de Core Web Vitals es reactivo: las regresiones de LCP/INP/CLS se detectan tarde y correlacionar la causa (imagen sin optimizar, script de terceros, deploy reciente) toma horas.

**Usuarios:** Productora Digital, Frontend, SEO, Performance Engineering.

**Cómo funcionaría:**
- **Fuentes:** CrUX API / PageSpeed Insights, RUM (New Relic, Datadog, GA4 + Web Vitals library), logs de deploy (CI/CD), Search Console.
- **Análisis:** monitoreo diario de URLs críticas, detección de regresión (>10% vs. baseline de 7 días), correlación temporal con deploys, clasificación por severidad.
- **Entregable:** alerta accionable (Slack/Teams) con URL, métrica, % de cambio, deploy sospechoso y recomendación técnica concreta.

**KPI impactado:** LCP p75, % URLs críticas en verde, tiempo de detección de degradación.

**Ejemplo:**
> LCP de `/gol-caracol/en-vivo` subió de 2.1s a 3.4s tras el deploy #482 (hace 6h). Causa probable: banner de sponsors bloqueante. Sugerencia: `fetchpriority="low"` + defer.

**Prioridad:** Alto impacto / esfuerzo medio.

**Riesgos/dependencias:** requiere RUM real (no solo lab data) y metadatos de deploy; falsos positivos sin baseline limpio. Dato mínimo: URLs críticas definidas + 30 días de histórico CWV.

---

## 2. Release Guardian

**Problema:** Releases coordinados entre sitios/apps generan incidentes por checklist no unificado, dependencias cruzadas no detectadas y rollback lento por falta de trazabilidad.

**Usuarios:** Productora Digital, líderes técnicos por sitio, QA, DevOps.

**Cómo funcionaría:**
- **Fuentes:** Jira/Linear, changelog de repos, calendario de releases, smoke tests, monitoreo de errores 4xx/5xx post-deploy.
- **Análisis:** checklist pre-deploy (tests, feature flags, dependencias de componentes compartidos) + monitoreo post-deploy de anomalías de error rate vs. baseline.
- **Entregable:** "Release Readiness Report" pre-deploy + alerta automática post-deploy con sugerencia de rollback.

**KPI impactado:** % releases sin incidentes, tiempo promedio de publicación/actualización crítica, incidentes por release.

**Ejemplo:**
> Release #219 (Noticias Caracol – módulo video) listo, 3/3 tests OK. Atención: `VideoPlayer` es compartido con BLU Radio — notificar antes de publicar.
> Post-deploy: 5xx subió 4x en `/api/comments` en 10 min → rollback sugerido.

**Prioridad:** Alto impacto / esfuerzo medio-alto.

**Riesgos/dependencias:** requiere logs de error en tiempo real y mapeo de dependencias entre componentes compartidos (se beneficia de Componentes Radar). Dato mínimo: calendario de releases + logs de error por sitio.

---

## 3. Componentes Radar

**Problema:** Falta visibilidad centralizada de qué componentes/templates se reutilizan vs. se duplican entre sitios, generando deuda técnica e inconsistencia visual.

**Usuarios:** Productora Digital, Frontend leads, Diseño (design system).

**Cómo funcionaría:**
- **Fuentes:** repos de código (análisis estático de imports/componentes), Figma (uso de librería vs. instancias detached), documentación del design system.
- **Análisis:** escaneo periódico de repos, detección de componentes duplicados/similares entre sitios, drift Figma-código, priorización de candidatos a unificar.
- **Entregable:** mapa de reutilización + backlog priorizado de componentes a compartir, con estimación de esfuerzo/impacto.

**KPI impactado:** % componentes/templates reutilizables, reducción de deuda técnica.

**Ejemplo:**
> 4 implementaciones distintas de "card de video" en Noticias, Gol, BLU y La Kalle. Unificarlas reduciría ~1,200 líneas de CSS duplicado. Esfuerzo estimado: 2 sprints.

**Prioridad:** Medio-alto impacto / esfuerzo medio.

**Riesgos/dependencias:** requiere convención mínima de nombrado/metadatos; puede generar ruido sin calibrar umbral de similitud. Dato mínimo: acceso de lectura a repos del dominio.

---

## 4. Costo & Roadmap Copiloto

**Problema:** El seguimiento de costos de infraestructura por sitio, priorización de roadmap y benchmarking competitivo se hace manualmente y con poca frecuencia.

**Usuarios:** Productora Digital, liderazgo de Producto, Finanzas/FinOps.

**Cómo funcionaría:**
- **Fuentes:** facturación cloud (AWS/GCP Cost Explorer), CDN, licencias CMS/terceros, datos de tráfico, benchmarking público (PageSpeed de competidores, SimilarWeb).
- **Análisis:** agregación de costo por sitio/servicio, detección de anomalías de gasto, costo por 1000 visitas, comparación mensual de CWV/disponibilidad vs. competencia.
- **Entregable:** dashboard mensual + alertas de anomalía de costo + informe de benchmarking con recomendaciones de inversión.

**KPI impactado:** costo por sitio/visita, disponibilidad y CWV relativos a competencia.

**Ejemplo:**
> Gasto de CDN de Gol Caracol subió 35% vs. tráfico +8% → posible mala config de caché. Ahorro potencial estimado: $X/mes.
> Benchmarking: LCP de competidor Y es 1.8s vs. nuestro 2.9s en "en vivo".

**Prioridad:** Medio impacto / esfuerzo bajo-medio.

**Riesgos/dependencias:** acceso a facturación cloud/terceros (restricciones de Finanzas); benchmarking limitado por rate limits de APIs públicas. Dato mínimo: acceso de solo lectura a cost explorer.

---

## Recomendación para los próximos 90 días

**Construir primero: CWV Sentinel.** Mueve directamente los KPI núcleo (LCP p75, % URLs verdes, disponibilidad), tiene menor dependencia organizacional que las otras tres, y genera valor visible rápido para justificar la inversión en las siguientes skills.

### MVP de 4 semanas — CWV Sentinel

| Semana | Foco |
|--------|------|
| 1 | Definir URLs críticas (10-15) y conectar fuente de datos (CrUX API o RUM existente). Baseline de 7-14 días. |
| 2 | Lógica de detección de regresión (umbral configurable) + correlación temporal con logs de deploy/CI. |
| 3 | Alerta automatizada a Slack/Teams (URL, métrica, % cambio, deploy sospechoso). Validar con 2-3 casos reales. |
| 4 | Piloto en 1-2 sitios críticos (ej. Noticias Caracol, Gol Caracol). Medir tiempo de detección vs. proceso manual y ajustar umbrales. |

**Criterio de éxito del MVP:** reducir el tiempo de detección de una regresión de CWV de días a horas, y validar al menos 1 causa raíz correctamente atribuida a un deploy.
