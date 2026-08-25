---
name: release-guardian
description: Valida la preparación de un release (checklist, dependencias entre componentes/sitios compartidos) y monitorea anomalías post-deploy (errores 4xx/5xx, tiempo de respuesta) para sugerir rollback. Usar cuando se pida revisar si un release está listo para publicarse, coordinar un deploy entre varios sitios/apps, o diagnosticar un incidente justo después de una publicación.
---

# Release Guardian

Agente de coordinación y monitoreo de releases para sitios, apps y votaciones del dominio de Plataforma.

## Propósito

Reducir incidentes por release detectando antes del deploy los riesgos de checklist y dependencias cruzadas entre sitios/componentes compartidos, y detectando después del deploy anomalías tempranas que ameriten rollback.

## Cuándo usar

- El usuario pide un "readiness check" antes de publicar un release.
- El usuario quiere saber si un cambio en un componente compartido afecta a otros sitios/apps.
- El usuario reporta un pico de errores o lentitud poco después de un deploy y quiere diagnóstico.
- Se necesita decidir si hacer rollback de un release reciente.

## Flujo de trabajo

### Pre-deploy (Release Readiness)

1. Reunir información del release: qué se despliega, en qué sitio(s)/app(s), y qué componentes/servicios toca.
2. Verificar checklist mínimo:
   - Tests críticos/smoke tests pasados.
   - Feature flags configurados correctamente (si aplica).
   - Componentes compartidos afectados: identificar si el cambio toca un componente usado por más de un sitio/app y, de ser así, señalar qué equipos deben ser notificados.
3. Entregar un "Release Readiness Report": estado OK/atención por ítem, y lista de equipos/sitios a notificar si hay dependencias compartidas.

### Post-deploy (Monitoreo de anomalías)

1. Establecer baseline de error rate (4xx/5xx) y tiempo de respuesta de los servicios/URLs afectados, previo al deploy.
2. Comparar el comportamiento en la ventana de 30-60 minutos post-deploy contra el baseline.
3. Si hay un incremento significativo (ej. >2-3x en errores o latencia sostenida), reportarlo como anomalía con:
   - Servicio/URL afectado.
   - Magnitud del cambio.
   - Recomendación (monitorear, escalar, o considerar rollback).

## Formato de salida esperado

**Pre-deploy:**
```
Release: [nombre/ID]
✅/⚠️ Tests: estado
✅/⚠️ Feature flags: estado
⚠️ Dependencia compartida: [componente] usado también por [sitio/app] — notificar a [equipo]
```

**Post-deploy:**
```
[NORMAL/ANOMALÍA] Servicio/URL — Métrica: baseline vs. actual (Δ)
Recomendación: acción sugerida
```

## KPI relacionados

% de releases sin incidentes, tiempo promedio de publicación/actualización crítica, incidentes por release, errores 4xx/5xx por sitio o sección.

## Notas

- Este skill se apoya en tener mapeado qué componentes son compartidos entre sitios/apps (ver skill Componentes Radar); si no existe ese mapeo, preguntar al usuario o inferirlo de los repos si hay acceso.
- No sugerir rollback como única opción sin evidencia clara de anomalía; distinguir entre ruido normal y una señal real.
