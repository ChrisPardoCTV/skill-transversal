---
name: transcripcion-subtitulado
description: Genera transcripciones y subtítulos (SRT/VTT) con timestamps a partir de archivos de audio o video, usando whisper (whisper.cpp o la CLI de OpenAI whisper) para la transcripción automática. Usa esta skill siempre que el usuario mencione transcribir, subtitular, generar subtítulos, "sacar el texto" de un audio/video, traducir subtítulos, sincronizar timestamps, o pida archivos .srt/.vtt a partir de una grabación, podcast, entrevista o video. También aplica cuando el usuario ya tiene una transcripción o subtítulo y quiere corregirlo, reformatear timestamps, o dividir/unir segmentos.
---

# Transcripción y subtitulado

Genera transcripciones de texto y subtítulos con timestamps (`.srt` / `.vtt`) a partir de audio o video, y edita transcripciones existentes.

## Flujo de trabajo

1. **Si el input es video**, extrae primero la pista de audio en un formato limpio para el reconocimiento de voz (mono, 16kHz, WAV funciona mejor con whisper):
   ```bash
   ffmpeg -i input.mp4 -vn -ac 1 -ar 16000 -c:a pcm_s16le audio.wav
   ```

2. **Transcribe el audio.** Verifica primero qué herramienta hay disponible en el sistema:
   ```bash
   which whisper 2>/dev/null || which whisper.cpp 2>/dev/null || which main 2>/dev/null
   pip show openai-whisper 2>/dev/null
   ```
   - Si está instalado `whisper` (paquete `openai-whisper`), es lo más simple:
     ```bash
     whisper audio.wav --model medium --language Spanish --output_format all --output_dir ./salida
     ```
     `--output_format all` genera `.srt`, `.vtt`, `.txt` y `.json` en un solo paso — normalmente es lo que quieres, no reinventes el parseo de timestamps a mano.
   - Si no hay ninguna herramienta de transcripción instalada, dile al usuario claramente que no puedes ejecutar reconocimiento de voz localmente sin `openai-whisper` o `whisper.cpp`, y ofrece instalarlo si tiene permisos (`pip install openai-whisper`) o pídele que suba una transcripción ya hecha para trabajar sobre ella.
   - Ajusta `--language` al idioma real del contenido (español en la mayoría de casos de Caracol TV) y `--model` según la precisión/velocidad que necesite el usuario (`base` rápido/impreciso, `medium` buen balance, `large` máxima precisión, más lento).

3. **Revisa la calidad del resultado** antes de entregarlo: abre el `.srt` generado y detecta líneas obviamente mal transcritas (nombres propios, jerga, marcas — el modelo suele equivocarse ahí). Corrige manualmente lo que sea evidente por contexto en vez de entregar el output crudo sin revisar.

4. **Entrega el/los archivo(s)** que el usuario pidió (`.srt`, `.vtt`, texto plano) y menciona explícitamente el modelo e idioma usados, para que el usuario sepa qué tan confiable es.

## Generar o editar SRT/VTT manualmente

Cuando el usuario ya tiene texto con marcas de tiempo (por ejemplo, extraídas de otra fuente) y solo necesita el archivo formateado, o cuando pide corregir/ajustar un `.srt`/`.vtt` existente, usa `scripts/srt_tools.py` en vez de escribir el formato a mano — evita errores de numeración y de formato de tiempo:

```bash
python scripts/srt_tools.py shift entrada.srt salida.srt --seconds 2.5   # adelanta/retrasa todos los timestamps
python scripts/srt_tools.py to-vtt entrada.srt salida.vtt                # convierte SRT -> VTT
python scripts/srt_tools.py validate entrada.srt                         # revisa formato y solapamientos
```

Si necesitas construir un SRT desde cero a partir de una lista de (texto, inicio, fin), usa la función `write_srt` del mismo script en vez de formatear los timestamps manualmente — el formato `HH:MM:SS,mmm` es fácil de teclear mal.

## Formato de referencia

**SRT:**
```
1
00:00:00,000 --> 00:00:02,500
Texto del primer subtítulo.

2
00:00:02,500 --> 00:00:05,000
Segundo subtítulo.
```

**VTT** (misma estructura, cabecera `WEBVTT` y `.` en vez de `,` en los milisegundos):
```
WEBVTT

00:00:00.000 --> 00:00:02.500
Texto del primer subtítulo.
```

## Notas importantes

- No hay forma de "adivinar" una transcripción sin ejecutar un modelo de reconocimiento de voz o sin que el usuario provea el texto — no inventes contenido de audio que no puedes escuchar.
- Los subtítulos para difusión suelen tener límites de longitud por línea (usualmente ~42 caracteres, 2 líneas) y duración mínima en pantalla (~1 segundo) — si el usuario menciona que son para TV o streaming, pregunta o aplica estos límites razonables al dividir segmentos largos.
