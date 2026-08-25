#!/usr/bin/env python3
"""Cambia la velocidad de un video (video + audio) usando ffmpeg,
encadenando el filtro atempo automáticamente para factores fuera de [0.5, 2.0]."""
import argparse
import subprocess


def atempo_chain(factor):
    """atempo solo acepta [0.5, 2.0] por instancia; encadena varias si es necesario."""
    filters = []
    remaining = factor
    while remaining < 0.5 or remaining > 2.0:
        step = 2.0 if remaining > 2.0 else 0.5
        filters.append(f"atempo={step}")
        remaining /= step
    filters.append(f"atempo={remaining:.6f}")
    return ",".join(filters)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input")
    parser.add_argument("output")
    parser.add_argument("--factor", type=float, required=True, help="2.0 = doble de velocidad, 0.5 = mitad")
    args = parser.parse_args()

    if args.factor <= 0:
        raise SystemExit("--factor debe ser mayor que 0")

    video_filter = f"setpts={1/args.factor}*PTS"
    audio_filter = atempo_chain(args.factor)

    cmd = [
        "ffmpeg", "-i", args.input,
        "-vf", video_filter,
        "-af", audio_filter,
        args.output,
    ]
    print("Ejecutando:", " ".join(cmd))
    subprocess.run(cmd, check=True)


if __name__ == "__main__":
    main()
