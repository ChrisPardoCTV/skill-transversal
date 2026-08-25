#!/usr/bin/env python3
"""Recorta silencio al inicio y/o al final de un archivo de audio (o la pista de audio de un video)."""
import argparse
import subprocess


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input")
    parser.add_argument("output")
    parser.add_argument("--threshold-db", type=float, default=-40.0,
                         help="Umbral de silencio en dB (más negativo = menos sensible)")
    parser.add_argument("--min-silence", type=float, default=0.3,
                         help="Duración mínima en segundos para considerarse silencio")
    parser.add_argument("--both-ends", action="store_true", default=True,
                         help="Recorta al inicio y al final (por defecto). Usa --start-only para solo el inicio.")
    parser.add_argument("--start-only", action="store_true")
    args = parser.parse_args()

    threshold = f"{args.threshold_db}dB"

    start_filter = (
        f"silenceremove=start_periods=1:start_threshold={threshold}:"
        f"start_silence={args.min_silence}:detection=peak"
    )

    if args.start_only:
        af = start_filter
    else:
        end_filter = (
            f"areverse,silenceremove=start_periods=1:start_threshold={threshold}:"
            f"start_silence={args.min_silence}:detection=peak,areverse"
        )
        af = f"{start_filter},{end_filter}"

    cmd = ["ffmpeg", "-y", "-i", args.input, "-af", af, args.output]
    print("Ejecutando:", " ".join(cmd))
    subprocess.run(cmd, check=True)


if __name__ == "__main__":
    main()
