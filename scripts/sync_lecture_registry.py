#!/usr/bin/env python3
"""
Synchronize lecture registry artifacts from lecture source files.

Source of truth:
    lecture-slides/slides/lecture-*.qmd

Generated targets:
    - lecture-slides/index.qmd
    - _quarto.yml sidebar block

Usage:
    python scripts/sync_lecture_registry.py
    python scripts/sync_lecture_registry.py --check
"""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Dict, List


ROOT = Path(__file__).resolve().parents[1]
SLIDES_DIR = ROOT / "lecture-slides" / "slides"
LECTURE_INDEX = ROOT / "lecture-slides" / "index.qmd"
QUARTO_CONFIG = ROOT / "_quarto.yml"


WEEK_BY_LECTURE: Dict[int, str] = {
    0: "Week 0",
    1: "Week 1",
    2: "Week 2",
    3: "Week 3",
    4: "Week 4",
    5: "Week 5",
    6: "Week 7",
    7: "Week 8",
    8: "Week 9",
    9: "Week 11",
    10: "Week 12",
}


@dataclass(frozen=True)
class LectureEntry:
    number: int
    stem: str
    filename: str
    title: str
    short_title: str
    week_label: str

    @property
    def relative_qmd(self) -> str:
        return f"lecture-slides/slides/{self.filename}"

    @property
    def html_link(self) -> str:
        return f"slides/{self.stem}.html"

    @property
    def pdf_link(self) -> str:
        return f"slides/{self.stem}.pdf"


def _extract_title(content: str, fallback: str) -> str:
    match = re.search(r"(?m)^title:\s*['\"]?(.+?)['\"]?\s*$", content)
    if not match:
        return fallback
    return match.group(1).strip()


def _strip_lecture_prefix(title: str) -> str:
    stripped = re.sub(
        r"^\s*Lecture\s*\d+\s*[-–:]\s*",
        "",
        title,
        flags=re.IGNORECASE,
    ).strip()
    return stripped or title


def load_lectures() -> List[LectureEntry]:
    entries: List[LectureEntry] = []
    for qmd in sorted(SLIDES_DIR.glob("lecture-*.qmd")):
        match = re.match(r"lecture-(\d+)-", qmd.name)
        if not match:
            continue
        number = int(match.group(1))
        content = qmd.read_text(encoding="utf-8")
        fallback_title = qmd.stem.replace("-", " ").title()
        title = _extract_title(content, fallback_title)
        short_title = _strip_lecture_prefix(title)
        week_label = WEEK_BY_LECTURE.get(number, f"Week {number}")
        entries.append(
            LectureEntry(
                number=number,
                stem=qmd.stem,
                filename=qmd.name,
                title=title,
                short_title=short_title,
                week_label=week_label,
            )
        )
    return sorted(entries, key=lambda x: x.number)


def render_lecture_index(entries: List[LectureEntry]) -> str:
    lines: List[str] = [
        "---",
        'title: "Lecture Slides"',
        "---",
        "",
        "## All Lectures",
        "",
        "Choose your preferred format: **HTML** (interactive slides) or **PDF** (printable).",
        "",
    ]

    grouped: Dict[str, List[LectureEntry]] = {}
    for entry in entries:
        grouped.setdefault(entry.week_label, []).append(entry)

    def week_sort_key(label: str) -> int:
        match = re.search(r"(\d+)", label)
        return int(match.group(1)) if match else 999

    for week in sorted(grouped, key=week_sort_key):
        lines.extend([f"### {week}", ""])
        for entry in grouped[week]:
            lines.append(f"**Lecture {entry.number}: {entry.short_title}**")
            lines.append("")
            lines.append(f'- [HTML slides]({entry.html_link}){{target="_blank"}}')
            lines.append(f'- [PDF slides]({entry.pdf_link}){{target="_blank"}}')
            lines.append("")
    return "\n".join(lines).rstrip() + "\n"


def render_sidebar_block(entries: List[LectureEntry]) -> str:
    grouped: Dict[str, List[LectureEntry]] = {}
    for entry in entries:
        grouped.setdefault(entry.week_label, []).append(entry)

    def week_sort_key(label: str) -> int:
        match = re.search(r"(\d+)", label)
        return int(match.group(1)) if match else 999

    lines: List[str] = [
        "  sidebar:",
        "    # BEGIN AUTO-LECTURE-SIDEBAR",
        '    - title: "Lecture Slides"',
        '      style: "docked"',
        "      background: light",
        "      contents:",
    ]
    for week in sorted(grouped, key=week_sort_key):
        lines.append(f'        - section: "{week}"')
        lines.append("          contents:")
        for entry in grouped[week]:
            lines.append(f"            - {entry.relative_qmd}")
    lines.append("    # END AUTO-LECTURE-SIDEBAR")
    return "\n".join(lines)


def render_quarto_config(entries: List[LectureEntry], current_text: str) -> str:
    sidebar_block = render_sidebar_block(entries)
    pattern = r"(?s)\n  sidebar:\n.*?\nformat:\n"
    replacement = f"\n{sidebar_block}\n\nformat:\n"
    updated, count = re.subn(pattern, replacement, current_text, count=1)
    if count == 0:
        raise RuntimeError("Could not locate sidebar block in _quarto.yml")
    return updated


def sync(check_only: bool) -> int:
    entries = load_lectures()
    if not entries:
        print("No lecture sources found in lecture-slides/slides/")
        return 1

    expected_index = render_lecture_index(entries)
    current_index = LECTURE_INDEX.read_text(encoding="utf-8")

    current_quarto = QUARTO_CONFIG.read_text(encoding="utf-8")
    expected_quarto = render_quarto_config(entries, current_quarto)

    index_changed = current_index != expected_index
    quarto_changed = current_quarto != expected_quarto

    if check_only:
        if index_changed or quarto_changed:
            print("Lecture registry drift detected:")
            if index_changed:
                print(" - lecture-slides/index.qmd out of sync")
            if quarto_changed:
                print(" - _quarto.yml sidebar out of sync")
            print("Run: python scripts/sync_lecture_registry.py")
            return 1
        print("Lecture registry is in sync.")
        return 0

    if index_changed:
        LECTURE_INDEX.write_text(expected_index, encoding="utf-8")
        print("Updated lecture-slides/index.qmd")
    else:
        print("lecture-slides/index.qmd already in sync")

    if quarto_changed:
        QUARTO_CONFIG.write_text(expected_quarto, encoding="utf-8")
        print("Updated _quarto.yml sidebar")
    else:
        print("_quarto.yml sidebar already in sync")

    return 0


def main() -> None:
    parser = argparse.ArgumentParser(description="Sync lecture registry artifacts.")
    parser.add_argument(
        "--check",
        action="store_true",
        help="Exit with non-zero code if generated files are out of sync.",
    )
    args = parser.parse_args()
    sys.exit(sync(check_only=args.check))


if __name__ == "__main__":
    main()

