#!/usr/bin/env python3
"""Plantilla para recortar el mismo video en varios segmentos definidos en un JSON.

Uso:
    python batch_trim.py input.mp4 segmentos.json salida_dir/

segmentos.json:
[
  {"name": "intro", "start": "00:00:00", "end": "00:00:15"},
  {"name": "cierre", "start": "00:10:00", "end": "00:10:30"}
]
"""
import argparse
import json
import subprocess
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input")
    parser.add_argument("segments_json")
    parser.add_argument("output_dir")
    parser.add_argument("--reencode", action="store_true",
                         help="Recorta con precisión exacta al frame (más lento) en vez de -c copy")
    args = parser.parse_args()

    out_dir = Path(args.output_dir)
    out_dir.mkdir(parents=True, exist_ok=True)
    segments = json.loads(Path(args.segments_json).read_text(encoding="utf-8"))

    for seg in segments:
        out_path = out_dir / f"{seg['name']}.mp4"
        cmd = ["ffmpeg", "-y", "-ss", seg["start"], "-to", seg["end"], "-i", args.input]
        if args.reencode:
            cmd += ["-c:v", "libx264", "-c:a", "aac"]
        else:
            cmd += ["-c", "copy"]
        cmd.append(str(out_path))
        print("Ejecutando:", " ".join(cmd))
        subprocess.run(cmd, check=True)

    print(f"Listo: {len(segments)} segmento(s) en {out_dir}")


if __name__ == "__main__":
    main()
