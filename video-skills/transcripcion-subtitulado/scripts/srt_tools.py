#!/usr/bin/env python3
"""Utilidades para crear, validar y transformar archivos SRT/VTT."""
import re
import sys
import argparse
from dataclasses import dataclass


@dataclass
class Cue:
    start: float
    end: float
    text: str


TIME_SRT = re.compile(r"(\d+):(\d{2}):(\d{2}),(\d{3})")
TIME_VTT = re.compile(r"(\d+):(\d{2}):(\d{2})\.(\d{3})")


def to_seconds(h, m, s, ms):
    return int(h) * 3600 + int(m) * 60 + int(s) + int(ms) / 1000


def seconds_to_srt_time(t):
    if t < 0:
        t = 0
    h = int(t // 3600)
    m = int((t % 3600) // 60)
    s = int(t % 60)
    ms = int(round((t - int(t)) * 1000))
    return f"{h:02d}:{m:02d}:{s:02d},{ms:03d}"


def seconds_to_vtt_time(t):
    return seconds_to_srt_time(t).replace(",", ".")


def parse_srt(path):
    content = open(path, encoding="utf-8").read()
    blocks = re.split(r"\n\s*\n", content.strip())
    cues = []
    for block in blocks:
        lines = block.strip().splitlines()
        if not lines:
            continue
        # skip index line if present
        idx = 0
        if lines[0].strip().isdigit():
            idx = 1
        if idx >= len(lines):
            continue
        m = re.search(
            r"(\d+):(\d{2}):(\d{2})[,.](\d{3})\s*-->\s*(\d+):(\d{2}):(\d{2})[,.](\d{3})",
            lines[idx],
        )
        if not m:
            continue
        start = to_seconds(*m.groups()[0:4])
        end = to_seconds(*m.groups()[4:8])
        text = "\n".join(lines[idx + 1 :])
        cues.append(Cue(start, end, text))
    return cues


def write_srt(cues, path):
    with open(path, "w", encoding="utf-8") as f:
        for i, c in enumerate(cues, 1):
            f.write(f"{i}\n")
            f.write(f"{seconds_to_srt_time(c.start)} --> {seconds_to_srt_time(c.end)}\n")
            f.write(f"{c.text}\n\n")


def write_vtt(cues, path):
    with open(path, "w", encoding="utf-8") as f:
        f.write("WEBVTT\n\n")
        for c in cues:
            f.write(f"{seconds_to_vtt_time(c.start)} --> {seconds_to_vtt_time(c.end)}\n")
            f.write(f"{c.text}\n\n")


def cmd_shift(args):
    cues = parse_srt(args.input)
    shifted = [Cue(c.start + args.seconds, c.end + args.seconds, c.text) for c in cues]
    write_srt(shifted, args.output)
    print(f"Escrito {args.output} con {len(shifted)} cues desplazados {args.seconds}s")


def cmd_to_vtt(args):
    cues = parse_srt(args.input)
    write_vtt(cues, args.output)
    print(f"Escrito {args.output} ({len(cues)} cues)")


def cmd_validate(args):
    cues = parse_srt(args.input)
    problems = []
    for i, c in enumerate(cues):
        if c.end <= c.start:
            problems.append(f"Cue {i+1}: fin <= inicio ({c.start} -> {c.end})")
        if i > 0 and c.start < cues[i - 1].end:
            problems.append(f"Cue {i+1}: se solapa con el anterior")
        if not c.text.strip():
            problems.append(f"Cue {i+1}: texto vacío")
    if problems:
        print(f"{len(problems)} problema(s) encontrados:")
        for p in problems:
            print(f"  - {p}")
        sys.exit(1)
    print(f"OK: {len(cues)} cues, sin problemas detectados")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_shift = sub.add_parser("shift", help="Desplaza todos los timestamps por N segundos")
    p_shift.add_argument("input")
    p_shift.add_argument("output")
    p_shift.add_argument("--seconds", type=float, required=True)
    p_shift.set_defaults(func=cmd_shift)

    p_vtt = sub.add_parser("to-vtt", help="Convierte un SRT a VTT")
    p_vtt.add_argument("input")
    p_vtt.add_argument("output")
    p_vtt.set_defaults(func=cmd_to_vtt)

    p_val = sub.add_parser("validate", help="Valida formato, solapamientos y cues vacíos")
    p_val.add_argument("input")
    p_val.set_defaults(func=cmd_validate)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
