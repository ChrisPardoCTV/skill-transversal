---
name: edicion-recorte-video
description: Corta, recorta, une, convierte y edita clips de video usando ffmpeg — trims por timestamp, concatenación de varios clips, cambio de formato/resolución/codec, extracción de frames, cambios de velocidad, y overlays de texto simple. Usa esta skill siempre que el usuario mencione cortar/recortar/editar un video, unir o concatenar clips, convertir un video a otro formato o resolución, extraer un frame/thumbnail, cambiar la velocidad de un video, comprimir un video, o pida comandos de ffmpeg para procesar video.
---

# Edición y recorte de video

Manipula archivos de video con `ffmpeg`. Antes de nada, confirma que está disponible:

```bash
ffmpeg -version
```

Si no está instalado, dile al usuario que se necesita `ffmpeg` en el sistema y no intentes simularlo con otra herramienta.

## Principio general

Prefiere `-c copy` (copia de stream sin recodificar) cuando la operación lo permite — cortes en puntos de keyframe, cambios de contenedor sin tocar el video/audio. Es instantáneo y sin pérdida de calidad. Solo recurre a recodificar (`-c:v libx264` etc.) cuando la operación lo requiere de verdad: cortes en un punto exacto no alineado a keyframe, cambios de resolución/codec, overlays, o cambios de velocidad.

Siempre verifica la duración/resolución de un video de entrada antes de operar sobre él si no la conoces:
```bash
ffprobe -v error -show_entries format=duration -show_entries stream=width,height,codec_name -of default=noprint_wrappers=1 input.mp4
```

## Recortar (trim)

Recorte rápido sin recodificar (puede desplazarse unos frames del punto exacto si no cae en un keyframe):
```bash
ffmpeg -ss 00:00:10 -to 00:00:25 -i input.mp4 -c copy output.mp4
```

Recorte exacto al frame (recodifica, más lento pero preciso — usa esto si el usuario necesita el corte exacto):
```bash
ffmpeg -i input.mp4 -ss 00:00:10 -to 00:00:25 -c:v libx264 -c:a aac output.mp4
```

## Unir / concatenar clips

Si todos los clips comparten codec y resolución, usa el método de lista de concat (rápido, sin recodificar):
```bash
printf "file '%s'\n" clip1.mp4 clip2.mp4 clip3.mp4 > lista.txt
ffmpeg -f concat -safe 0 -i lista.txt -c copy output.mp4
```

Si los clips tienen formatos/resoluciones distintas, hay que recodificar todos a un formato común primero (o usar el filtro `concat` que sí puede mezclar streams):
```bash
ffmpeg -i clip1.mp4 -i clip2.mp4 -filter_complex \
  "[0:v][0:a][1:v][1:a]concat=n=2:v=1:a=1[v][a]" \
  -map "[v]" -map "[a]" output.mp4
```

## Convertir formato / resolución / codec

```bash
ffmpeg -i input.mov -c:v libx264 -crf 20 -preset medium -c:a aac -b:a 160k output.mp4
```
- `-crf` controla calidad (menor = mejor calidad y más peso; 18-23 es el rango típico usable).
- Cambiar resolución: agrega `-vf scale=1280:720` (usa `-2` en una dimensión para mantener proporción, ej. `scale=1280:-2`).
- Cambiar framerate: `-r 30`.

## Extraer frames / thumbnail

Un frame en un segundo exacto:
```bash
ffmpeg -ss 00:00:05 -i input.mp4 -frames:v 1 thumbnail.jpg
```

Un frame cada N segundos:
```bash
ffmpeg -i input.mp4 -vf fps=1/5 frame_%04d.jpg
```

## Cambiar velocidad

Video (sin tocar audio) — 2x más rápido:
```bash
ffmpeg -i input.mp4 -vf "setpts=0.5*PTS" -an output.mp4
```

Video + audio a la vez (más simple, usa el script incluido que ajusta ambos filtros correctamente):
```bash
python scripts/change_speed.py input.mp4 output.mp4 --factor 2.0
```
Ajustar solo el audio con `atempo` es engañoso porque ese filtro solo acepta valores entre 0.5 y 2.0 por instancia — para factores fuera de ese rango hay que encadenarlo varias veces; el script ya maneja ese encadenamiento, no lo repliques a mano si no es necesario.

## Overlay de texto simple

```bash
ffmpeg -i input.mp4 -vf "drawtext=text='Caracol TV':fontcolor=white:fontsize=36:x=(w-text_w)/2:y=h-th-30:box=1:boxcolor=black@0.5" -c:a copy output.mp4
```
Ajusta `x`/`y` para posicionar (esta fórmula centra horizontalmente y lo pega cerca del borde inferior), y `box=1:boxcolor=...` da un fondo semitransparente para legibilidad. Si el sistema no tiene una fuente por defecto configurada para `drawtext`, puede ser necesario indicar `fontfile=/ruta/a/fuente.ttf`.

## Notas importantes

- Siempre pregunta o confirma la ruta de salida antes de sobrescribir un archivo existente — ffmpeg pide confirmación (`y/N`) si el output ya existe; usa `-y` solo cuando sea claro que sobrescribir es lo esperado, y `-n` si prefieres que falle en vez de sobrescribir por accidente.
- Para trabajos con muchos parámetros repetidos (batch de recortes, batch de conversiones), usa `scripts/batch_trim.py` como plantilla en vez de escribir un bucle de shell desde cero.
