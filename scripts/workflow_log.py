#!/usr/bin/env python3
"""
Create and append plan/session logs for multi-step workflows.

Usage:
  python scripts/workflow_log.py init --task "Create lecture 5 draft" --slug lecture-5-draft
  python scripts/workflow_log.py append --slug lecture-5-draft --note "Completed first review pass"
  python scripts/workflow_log.py close --slug lecture-5-draft --summary "All checks passed"
"""

from __future__ import annotations

import argparse
from datetime import datetime
from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
PLANS_DIR = ROOT / "quality_reports" / "plans"
SESSION_DIR = ROOT / "quality_reports" / "session_logs"


def _timestamp() -> str:
    return datetime.now().strftime("%Y-%m-%d %H:%M")


def _date() -> str:
    return datetime.now().strftime("%Y-%m-%d")


def _plan_path(slug: str) -> Path:
    return PLANS_DIR / f"{_date()}_{slug}.md"


def _session_path(slug: str) -> Path:
    return SESSION_DIR / f"{_date()}_{slug}.md"


def _ensure_dirs() -> None:
    PLANS_DIR.mkdir(parents=True, exist_ok=True)
    SESSION_DIR.mkdir(parents=True, exist_ok=True)


def init(task: str, slug: str) -> int:
    _ensure_dirs()
    plan_file = _plan_path(slug)
    session_file = _session_path(slug)

    if not plan_file.exists():
        plan_file.write_text(
            "\n".join(
                [
                    f"# Plan: {slug}",
                    f"**Date:** {_timestamp()}",
                    "**Status:** DRAFT",
                    f"**Task:** {task}",
                    "",
                    "## Approach",
                    "1. Define scope and constraints.",
                    "2. Implement changes incrementally.",
                    "3. Verify outputs and quality gates.",
                    "",
                    "## Files to Modify",
                    "- [to be filled during implementation]",
                    "",
                    "## Verification",
                    "- [ ] Run relevant lint/tests",
                    "- [ ] Validate generated outputs",
                ]
            )
            + "\n",
            encoding="utf-8",
        )
        print(f"Created plan: {plan_file.relative_to(ROOT)}")
    else:
        print(f"Plan already exists: {plan_file.relative_to(ROOT)}")

    if not session_file.exists():
        session_file.write_text(
            "\n".join(
                [
                    f"# Session Log: {slug}",
                    f"**Date:** {_date()}",
                    f"**Task:** {task}",
                    "",
                    "## Timeline",
                    f"- **{_timestamp()}** Initialized plan and session log.",
                ]
            )
            + "\n",
            encoding="utf-8",
        )
        print(f"Created session log: {session_file.relative_to(ROOT)}")
    else:
        print(f"Session log already exists: {session_file.relative_to(ROOT)}")

    return 0


def append(slug: str, note: str) -> int:
    _ensure_dirs()
    session_file = _session_path(slug)
    if not session_file.exists():
        session_file.write_text(
            "\n".join(
                [
                    f"# Session Log: {slug}",
                    f"**Date:** {_date()}",
                    "",
                    "## Timeline",
                ]
            )
            + "\n",
            encoding="utf-8",
        )
    with session_file.open("a", encoding="utf-8") as f:
        f.write(f"- **{_timestamp()}** {note}\n")
    print(f"Appended to session log: {session_file.relative_to(ROOT)}")
    return 0


def close(slug: str, summary: str) -> int:
    _ensure_dirs()
    plan_file = _plan_path(slug)
    session_file = _session_path(slug)
    if plan_file.exists():
        content = plan_file.read_text(encoding="utf-8")
        content = content.replace("**Status:** DRAFT", "**Status:** COMPLETED")
        content = content.replace("**Status:** IN PROGRESS", "**Status:** COMPLETED")
        plan_file.write_text(content, encoding="utf-8")
        print(f"Updated plan status: {plan_file.relative_to(ROOT)}")
    else:
        print(f"Warning: plan file not found for slug '{slug}'")

    if not session_file.exists():
        session_file.write_text(
            f"# Session Log: {slug}\n**Date:** {_date()}\n\n## Timeline\n",
            encoding="utf-8",
        )
    with session_file.open("a", encoding="utf-8") as f:
        f.write("\n## Completion\n")
        f.write(f"- **{_timestamp()}** {summary}\n")
    print(f"Closed session log: {session_file.relative_to(ROOT)}")
    return 0


def main() -> None:
    parser = argparse.ArgumentParser(description="Workflow plan/session logging helper.")
    subparsers = parser.add_subparsers(dest="command", required=True)

    init_parser = subparsers.add_parser("init", help="Create plan + session log files.")
    init_parser.add_argument("--task", required=True, help="Task description.")
    init_parser.add_argument("--slug", required=True, help="Short slug, e.g. lecture-5-refactor.")

    append_parser = subparsers.add_parser("append", help="Append timeline entry.")
    append_parser.add_argument("--slug", required=True, help="Session slug.")
    append_parser.add_argument("--note", required=True, help="Timeline note.")

    close_parser = subparsers.add_parser("close", help="Mark plan completed and append summary.")
    close_parser.add_argument("--slug", required=True, help="Session slug.")
    close_parser.add_argument("--summary", required=True, help="Completion summary.")

    args = parser.parse_args()
    if args.command == "init":
        sys.exit(init(task=args.task, slug=args.slug))
    if args.command == "append":
        sys.exit(append(slug=args.slug, note=args.note))
    if args.command == "close":
        sys.exit(close(slug=args.slug, summary=args.summary))
    sys.exit(1)


if __name__ == "__main__":
    main()

