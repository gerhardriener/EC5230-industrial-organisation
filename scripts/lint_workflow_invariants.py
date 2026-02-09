#!/usr/bin/env python3
"""
Workflow invariant checks for EC5230.

Checks:
1. Lecture registry artifacts are synced from lecture source files.
2. Lecture ending schema is enforced (Summary + final References slide).
3. Exercise defaults and publication links are consistent.
4. Quality report artifact naming + verdict vocabulary are consistent.
5. quality_score.py contract tokens match repository conventions.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path
from typing import List

from sync_lecture_registry import (  # type: ignore
    QUARTO_CONFIG,
    ROOT,
    LECTURE_INDEX,
    load_lectures,
    render_lecture_index,
    render_quarto_config,
)


ISSUES: List[str] = []


def check(condition: bool, message: str) -> None:
    if not condition:
        ISSUES.append(message)


def check_lecture_registry() -> None:
    entries = load_lectures()
    check(bool(entries), "No lecture sources found in lecture-slides/slides/")

    expected_index = render_lecture_index(entries)
    current_index = LECTURE_INDEX.read_text(encoding="utf-8")
    check(
        current_index == expected_index,
        "lecture-slides/index.qmd is out of sync (run scripts/sync_lecture_registry.py).",
    )

    current_quarto = QUARTO_CONFIG.read_text(encoding="utf-8")
    expected_quarto = render_quarto_config(entries, current_quarto)
    check(
        current_quarto == expected_quarto,
        "_quarto.yml sidebar is out of sync (run scripts/sync_lecture_registry.py).",
    )


def check_lecture_endings() -> None:
    slides_dir = ROOT / "lecture-slides" / "slides"
    for path in sorted(slides_dir.glob("lecture-*.qmd")):
        match = re.match(r"lecture-(\d+)-", path.name)
        if not match:
            continue
        lecture_num = int(match.group(1))
        if lecture_num == 0:
            continue

        text = path.read_text(encoding="utf-8")
        headings = [h.strip() for h in re.findall(r"(?m)^##\s+(.+?)\s*$", text)]
        check(
            "Summary and next week" in headings,
            f"{path.relative_to(ROOT)} missing required heading: '## Summary and next week'.",
        )
        if headings:
            check(
                headings[-1] == "References",
                f"{path.relative_to(ROOT)} last level-2 heading must be '## References'.",
            )
        else:
            check(False, f"{path.relative_to(ROOT)} has no level-2 headings.")


def check_exercise_publication_contract() -> None:
    exercises_dir = ROOT / "exercises"
    for path in sorted(exercises_dir.rglob("*.qmd")):
        if not {"live", "sheets"}.intersection(set(path.parts)):
            continue
        text = path.read_text(encoding="utf-8")
        match = re.search(r"(?m)^solutions:\s*(true|false)\s*$", text)
        check(
            bool(match),
            f"{path.relative_to(ROOT)} missing explicit YAML key: solutions.",
        )
        if match:
            check(
                match.group(1).lower() == "false",
                f"{path.relative_to(ROOT)} must default to solutions: false.",
            )

    index_path = ROOT / "exercises" / "index.qmd"
    index_text = index_path.read_text(encoding="utf-8")
    check(
        bool(re.search(r"-solutions\.html", index_text)),
        "exercises/index.qmd must include instructor HTML links with '-solutions.html'.",
    )
    check(
        bool(re.search(r"-solutions\.pdf", index_text)),
        "exercises/index.qmd must include instructor PDF links with '-solutions.pdf'.",
    )


def check_quality_report_contract() -> None:
    quality_dir = ROOT / "quality_reports"
    for synthesis in sorted(quality_dir.glob("*_exercise_synthesis.md")):
        stem = synthesis.name[: -len("_exercise_synthesis.md")]
        required = [
            quality_dir / f"{stem}_exercise_review.md",
            quality_dir / f"{stem}_solution_check.md",
            quality_dir / f"{stem}_report.md",
        ]
        for req in required:
            check(
                req.exists(),
                f"Missing required artifact for {stem}: {req.relative_to(ROOT)}",
            )

    banned = [r"\bNEEDS WORK\b", r"\bEXCELLENT\+\b"]
    targets = list((ROOT / "quality_reports").glob("*.md")) + [ROOT / "guide" / "workflow-guide.qmd"]
    for target in targets:
        text = target.read_text(encoding="utf-8")
        for pattern in banned:
            if re.search(pattern, text):
                check(False, f"Banned verdict token in {target.relative_to(ROOT)}: {pattern}")


def check_quality_score_contract() -> None:
    path = ROOT / "scripts" / "quality_score.py"
    text = path.read_text(encoding="utf-8")
    check(
        "references.bib" in text,
        "scripts/quality_score.py must reference references.bib.",
    )
    check(
        "_site" in text,
        "scripts/quality_score.py must reference _site output paths.",
    )
    check(
        ".tex" in text.lower(),
        "scripts/quality_score.py must support .tex inputs.",
    )


def main() -> None:
    check_lecture_registry()
    check_lecture_endings()
    check_exercise_publication_contract()
    check_quality_report_contract()
    check_quality_score_contract()

    if ISSUES:
        print("Workflow invariant check failed:\n")
        for issue in ISSUES:
            print(f"- {issue}")
        sys.exit(1)

    print("Workflow invariant check passed.")
    sys.exit(0)


if __name__ == "__main__":
    main()
