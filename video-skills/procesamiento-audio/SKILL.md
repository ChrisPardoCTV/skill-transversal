---
name: procesamiento-audio
description: Extrae, convierte y procesa pistas de audio usando ffmpeg — extraer audio de un video, convertir entre formatos (mp3/wav/aac/flac), normalizar volumen, remover silencios, reducir ruido de fondo básico, y ajustar bitrate/sample rate/canales. Usa esta skill siempre que el usuario mencione extraer el audio de un video, convertir un audio de formato, normalizar o subir/bajar el volumen, quitar silencios de una grabación, reducir ruido de fondo, o ajustar la calidad/bitrate de un archivo de audio.
Owner: Camilo Perdomo
---

# Extracción y procesamiento de audio

Manipula pistas de audio con `ffmpeg`. Verifica que esté disponible antes de empezar:
```bash
ffmpeg -version
```

## Extraer audio de un video

```bash
ffmpeg -i input.mp4 -vn -c:a copy audio.aac      # copia el stream de audio tal cual (rápido, sin pérdida)
ffmpeg -i input.mp4 -vn -c:a libmp3lame -q:a 2 audio.mp3   # o recodifica directamente a mp3
```
Usa `-c:a copy` cuando el formato de salida acepte el codec original del video (ej. video con audio AAC -> `.m4a`/`.aac`). Si el usuario pide un formato distinto (mp3, wav), hay que recodificar.

## Convertir formato

```bash
ffmpeg -i input.wav -c:a libmp3lame -b:a 192k output.mp3   # a mp3, bitrate constante
ffmpeg -i input.mp3 -ar 44100 -ac 2 output.wav              # a wav (PCM sin comprimir)
ffmpeg -i input.wav -c:a aac -b:a 192k output.aac            # a aac
ffmpeg -i input.wav -c:a flac output.flac                    # a flac (sin pérdida, comprimido)
```
- `-ar` = sample rate (44100 estándar música, 16000 suficiente y más liviano para voz/transcripción).
- `-ac` = número de canales (1 = mono, 2 = estéreo). Para voz/podcasts, mono suele bastar y reduce peso a la mitad.
- `-b:a` = bitrate (solo aplica a formatos con compresión con pérdida como mp3/aac).

## Normalizar volumen

Para normalización simple de un solo paso (buen resultado en la mayoría de casos), usa el filtro `loudnorm` (normalización de loudness percibido, estándar EBU R128 — es lo que se usa en broadcast/streaming):
```bash
ffmpeg -i input.wav -af loudnorm=I=-16:TP=-1.5:LRA=11 output.wav
```
`I=-16` es un target típico para contenido online/podcast; para TV/broadcast en Colombia el estándar suele pedir `-23 LUFS` — pregunta al usuario el contexto de entrega si no lo especifica.

Si solo se necesita subir/bajar el volumen por un factor fijo (no normalización perceptual):
```bash
ffmpeg -i input.wav -af "volume=1.5" output.wav   # 1.5x más fuerte
ffmpeg -i input.wav -af "volume=-6dB" output.wav  # 6dB más bajo
```

## Remover silencios

El filtro `silenceremove` elimina tramos de silencio automáticamente:
```bash
ffmpeg -i input.wav -af silenceremove=start_periods=1:start_threshold=-40dB:start_silence=0.3:detection=peak,\
silenceremove=stop_periods=-1:stop_threshold=-40dB:stop_silence=0.3:detection=peak output.wav
```
- `stop_periods=-1` significa "aplica a todos los silencios, no solo el inicial/final".
- Ajusta `-40dB` (umbral) según qué tan sensible debe ser — más negativo (-50dB) detecta solo silencios muy profundos, menos negativo (-30dB) es más agresivo y puede cortar pausas naturales del habla.
- Para solo recortar silencio al inicio y al final (caso más común y más seguro), usa `scripts/trim_silence.py` en vez del filtro completo — es más predecible que ajustar los cuatro parámetros a mano.

## Reducir ruido de fondo (básico)

ffmpeg incluye `afftdn` (denoise por FFT), útil para ruido de fondo constante (ventilador, hiss, zumbido):
```bash
ffmpeg -i input.wav -af "afftdn=nr=12:nf=-25" output.wav
```
- `nr` = cantidad de reducción de ruido (mayor valor = más agresivo, pero puede degradar la voz si se pasa).
- Esto NO sustituye herramientas dedicadas de reducción de ruido con IA (ej. RNNoise, Adobe Podcast) para casos difíciles — si el ruido es muy fuerte o variable, dile al usuario que el resultado será limitado y sugiere una herramienta especializada si la calidad es crítica.

## Notas importantes

- Antes de procesar, revisa las propiedades del archivo de entrada si no las conoces:
  ```bash
  ffprobe -v error -show_entries stream=codec_name,sample_rate,channels,bit_rate -of default=noprint_wrappers=1 input.wav
  ```
- Encadena filtros con comas dentro de un mismo `-af` (ej. `-af "loudnorm=I=-16,afftdn=nr=10"`) en vez de correr ffmpeg varias veces — es más rápido y evita pérdida de calidad por recodificar repetidamente.
- Confirma con el usuario antes de sobrescribir el archivo original; usa `-y` solo cuando sobrescribir sea claramente lo esperado.
