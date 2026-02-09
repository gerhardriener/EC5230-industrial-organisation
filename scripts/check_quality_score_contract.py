#!/usr/bin/env python3
"""
Regression checks for scripts/quality_score.py contract behavior.

Focus:
1. Valid Pandoc citation key should not be flagged as broken.
2. Invalid Pandoc citation key should be flagged as broken.
"""

from __future__ import annotations

import importlib.util
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
SCORER = ROOT / "scripts" / "quality_score.py"

VALID_KEY = "belleflammeIndustrialOrganizationMarkets2015"
INVALID_KEY = "definitelyMissingCitationKey2026"


def load_module():
    spec = importlib.util.spec_from_file_location("quality_score_module", SCORER)
    if spec is None or spec.loader is None:
        raise RuntimeError("Failed to load quality_score.py module spec")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def run_check() -> int:
    module = load_module()

    bib_path = module._find_bibliography_path()
    bib_keys = module._load_bib_keys(bib_path)

    valid_content = f"Following @{VALID_KEY}, IO emphasizes strategic interaction."
    invalid_content = f"This claim cites [@{INVALID_KEY}]."

    valid_keys = module._extract_qmd_citations(valid_content)
    invalid_keys = module._extract_qmd_citations(invalid_content)

    if VALID_KEY not in valid_keys:
        print("Valid citation key was not parsed correctly.")
        return 1
    if INVALID_KEY not in invalid_keys:
        print("Invalid citation key string was not parsed correctly.")
        return 1

    valid_broken = valid_keys - bib_keys
    invalid_broken = invalid_keys - bib_keys

    if valid_broken:
        print("Valid citation was incorrectly flagged as broken.")
        print(f"Unexpected broken keys: {sorted(valid_broken)}")
        return 1

    if INVALID_KEY not in invalid_broken:
        print("Invalid citation was not flagged as broken.")
        return 1

    print("Quality score contract check passed.")
    return 0


if __name__ == "__main__":
    sys.exit(run_check())
