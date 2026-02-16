#!/usr/bin/env python3
"""
Quality scoring for EC5230 course materials.

Aligns scoring with canonical rules in:
    .claude/rules/quality-gates.md

Usage examples:
    python scripts/quality_score.py lecture-slides/slides/lecture-3-innovation.qmd
    python scripts/quality_score.py exercises/sheets/exercises-1.qmd --summary
    python scripts/quality_score.py lecture-slides/slides/lecture-5-multi-stage-games.qmd --json
    python scripts/quality_score.py lecture-slides/slides/lecture-5-multi-stage-games.tex
    python scripts/quality_score.py scripts/figures/my_script.R
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Dict, List, Set, Tuple

ROOT = Path(__file__).resolve().parents[1]
QUARTO_CONFIG = ROOT / "_quarto.yml"
DEFAULT_BIB = ROOT / "references.bib"
DEFAULT_SITE_DIR = ROOT / "_site"

THRESHOLDS = {
    "commit": 80,
    "pr": 90,
    "excellence": 95,
}

POINTS = {
    # Quarto
    "compilation_failure": 100,
    "equation_overflow": 20,
    "broken_citation": 15,
    "missing_plotly_chart": 10,
    "hardcoded_citation": 5,
    "text_overflow": 5,
    "font_size_reduction": 1,
    # R
    "syntax_error": 100,
    "hardcoded_path": 20,
    "missing_set_seed": 10,
    # TeX
    "latex_compilation_failure": 100,
    "undefined_citation": 15,
    "overfull_hbox": 20,
}


def _read_text(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def _find_bibliography_path() -> Path:
    if QUARTO_CONFIG.exists():
        text = _read_text(QUARTO_CONFIG)
        match = re.search(r"(?m)^bibliography:\s*['\"]?([^'\"\n]+)['\"]?\s*$", text)
        if match:
            bib = Path(match.group(1).strip())
            if not bib.is_absolute():
                bib = ROOT / bib
            return bib
    return DEFAULT_BIB


def _load_bib_keys(bib_path: Path) -> Set[str]:
    if not bib_path.exists():
        return set()
    content = _read_text(bib_path)
    return set(k.strip() for k in re.findall(r"@\w+\{([^,]+),", content))


def _extract_qmd_citations(content: str) -> Set[str]:
    keys: Set[str] = set()

    # [@a; @b]
    for match in re.finditer(r"\[@([^\]]+)\]", content):
        payload = match.group(1)
        keys.update(re.findall(r"@([A-Za-z0-9:_-]+)", payload))

    # Inline: Following @key
    inline_pattern = re.compile(r"(?<![A-Za-z0-9_./-])@([A-Za-z0-9:_-]+)")
    keys.update(inline_pattern.findall(content))

    return keys


def _extract_tex_citations(content: str) -> Set[str]:
    keys: Set[str] = set()
    for match in re.finditer(r"\\cite\w*\{([^}]+)\}", content):
        for raw in match.group(1).split(","):
            key = raw.strip()
            if key:
                keys.add(key)
    return keys


def _detect_equation_overflow(content: str) -> List[Tuple[int, int]]:
    """
    Heuristic: flag display equations where a line exceeds 120 chars.
    """
    findings: List[Tuple[int, int]] = []
    for match in re.finditer(r"\$\$(.*?)\$\$", content, flags=re.DOTALL):
        block = match.group(1)
        max_len = max((len(line.rstrip()) for line in block.splitlines()), default=0)
        if max_len > 120:
            start_line = content[: match.start()].count("\n") + 1
            findings.append((start_line, max_len))
    return findings


def _detect_text_overflow(content: str) -> List[Tuple[int, int]]:
    findings: List[Tuple[int, int]] = []
    for line_no, line in enumerate(content.splitlines(), start=1):
        stripped = line.rstrip()
        if len(stripped) > 180 and not stripped.lstrip().startswith("http"):
            findings.append((line_no, len(stripped)))
    return findings


def _detect_hardcoded_citations(content: str) -> List[int]:
    """
    Detect likely hardcoded author-year citations without @key.
    """
    pattern = re.compile(r"\([A-Z][A-Za-z'\-]+(?:\s+et\s+al\.)?,\s*\d{4}[a-z]?\)")
    lines = []
    for line_no, line in enumerate(content.splitlines(), start=1):
        if "@" in line:
            continue
        if pattern.search(line):
            lines.append(line_no)
    return lines


def _detect_font_reductions(content: str) -> List[int]:
    pattern = re.compile(r"font-size\s*:\s*0\.[0-8]\d?em|\.small(er|est)")
    findings = []
    for line_no, line in enumerate(content.splitlines(), start=1):
        if pattern.search(line):
            findings.append(line_no)
    return findings


def _count_plotly_expected(content: str) -> int:
    return len(re.findall(r"plotly::plot_ly\s*\(", content)) + len(
        re.findall(r"ggplotly\s*\(", content)
    )


def _count_plotly_rendered(html_path: Path) -> int:
    if not html_path.exists():
        return 0
    html = _read_text(html_path)
    return html.count("htmlwidget")


def _check_qmd_compile(path: Path, skip_render: bool) -> Tuple[bool, str]:
    if skip_render:
        return True, "skipped"
    try:
        result = subprocess.run(
            ["quarto", "render", str(path), "--to", "html"],
            cwd=ROOT,
            capture_output=True,
            text=True,
            timeout=240,
        )
    except FileNotFoundError:
        return False, "quarto not installed"
    except subprocess.TimeoutExpired:
        return False, "quarto render timeout (>240s)"

    if result.returncode != 0:
        snippet = (result.stderr or result.stdout).strip()[:400]
        return False, snippet
    return True, ""


def _check_r_syntax(path: Path) -> Tuple[bool, str]:
    try:
        result = subprocess.run(
            ["Rscript", "-e", f'parse(file="{path.as_posix()}")'],
            cwd=ROOT,
            capture_output=True,
            text=True,
            timeout=60,
        )
    except FileNotFoundError:
        return False, "Rscript not installed"
    except subprocess.TimeoutExpired:
        return False, "R syntax check timeout (>60s)"

    if result.returncode != 0:
        snippet = (result.stderr or result.stdout).strip()[:400]
        return False, snippet
    return True, ""


def _run_command(cmd: List[str], cwd: Path, timeout: int = 180) -> Tuple[bool, str]:
    try:
        result = subprocess.run(
            cmd,
            cwd=cwd,
            capture_output=True,
            text=True,
            timeout=timeout,
        )
    except FileNotFoundError:
        return False, f"command not found: {cmd[0]}"
    except subprocess.TimeoutExpired:
        return False, f"command timeout: {' '.join(cmd)}"

    if result.returncode != 0:
        output = (result.stderr or result.stdout).strip()[:400]
        return False, output
    return True, ""


def _check_tex_compile(path: Path, skip_render: bool) -> Tuple[bool, str, str]:
    """
    Compile TeX with xelatex/bibtex passes.
    Returns: (success, error_msg, log_content)
    """
    if skip_render:
        log_path = path.with_suffix(".log")
        log_content = _read_text(log_path) if log_path.exists() else ""
        return True, "skipped", log_content

    cwd = path.parent
    tex_name = path.name
    stem = path.stem

    ok, msg = _run_command(
        ["xelatex", "-interaction=nonstopmode", "-halt-on-error", tex_name],
        cwd=cwd,
        timeout=240,
    )
    if not ok:
        return False, msg, ""

    content = _read_text(path)
    if re.search(r"\\cite\w*\{", content):
        _run_command(["bibtex", stem], cwd=cwd, timeout=120)
        ok, msg = _run_command(
            ["xelatex", "-interaction=nonstopmode", "-halt-on-error", tex_name],
            cwd=cwd,
            timeout=240,
        )
        if not ok:
            return False, msg, ""
        ok, msg = _run_command(
            ["xelatex", "-interaction=nonstopmode", "-halt-on-error", tex_name],
            cwd=cwd,
            timeout=240,
        )
        if not ok:
            return False, msg, ""

    log_path = cwd / f"{stem}.log"
    log_content = _read_text(log_path) if log_path.exists() else ""
    return True, "", log_content


def _detect_overfull_hbox(log_content: str) -> List[float]:
    findings = []
    for value in re.findall(r"Overfull \\hbox \(([0-9.]+)pt too wide\)", log_content):
        try:
            width = float(value)
        except ValueError:
            continue
        if width > 10:
            findings.append(width)
    return findings


def _detect_undefined_citations(log_content: str) -> List[str]:
    return re.findall(r"Citation [`']([^`']+)[`'] on page .* undefined", log_content)


class QualityScorer:
    def __init__(
        self, filepath: Path, verbose: bool = False, skip_render: bool = False
    ):
        self.filepath = filepath.resolve()
        self.verbose = verbose
        self.skip_render = skip_render
        self.score = 100
        self.auto_fail = False
        self.issues: Dict[str, List[Dict[str, object]]] = {
            "critical": [],
            "major": [],
            "minor": [],
        }

    def _add_issue(
        self,
        severity: str,
        issue_type: str,
        description: str,
        details: str,
        points: int,
    ) -> None:
        self.issues[severity].append(
            {
                "type": issue_type,
                "description": description,
                "details": details,
                "points": points,
            }
        )
        if severity == "critical" and points >= 100:
            self.auto_fail = True
            self.score = 0
            return
        self.score -= points

    def _relpath(self, path: Path) -> str:
        try:
            return str(path.relative_to(ROOT))
        except ValueError:
            return str(path)

    def score_qmd(self) -> Dict[str, object]:
        content = _read_text(self.filepath)

        compiled, reason = _check_qmd_compile(self.filepath, self.skip_render)
        if not compiled:
            self._add_issue(
                "critical",
                "compilation_failure",
                "Quarto compilation failed",
                reason,
                POINTS["compilation_failure"],
            )
            return self.report()

        bib_path = _find_bibliography_path()
        bib_keys = _load_bib_keys(bib_path)
        citations = _extract_qmd_citations(content)
        missing = sorted(citations - bib_keys)
        for key in missing:
            self._add_issue(
                "critical",
                "broken_citation",
                f"Citation key not in bibliography: {key}",
                f"Add key to {self._relpath(bib_path)} or fix the citekey.",
                POINTS["broken_citation"],
            )

        for line_no, length in _detect_equation_overflow(content):
            self._add_issue(
                "critical",
                "equation_overflow",
                f"Potential equation overflow at line {line_no}",
                f"Display equation line length {length} exceeds heuristic threshold.",
                POINTS["equation_overflow"],
            )

        for line_no in _detect_hardcoded_citations(content):
            self._add_issue(
                "major",
                "hardcoded_citation",
                f"Hardcoded author-year citation at line {line_no}",
                "Use Pandoc citations with @key syntax.",
                POINTS["hardcoded_citation"],
            )

        for line_no, length in _detect_text_overflow(content):
            self._add_issue(
                "major",
                "text_overflow",
                f"Potential text overflow at line {line_no}",
                f"Line length {length} exceeds heuristic threshold.",
                POINTS["text_overflow"],
            )

        for line_no in _detect_font_reductions(content):
            self._add_issue(
                "minor",
                "font_size_reduction",
                f"Font-size reduction pattern at line {line_no}",
                "Prefer spacing/layout fixes before reducing font size.",
                POINTS["font_size_reduction"],
            )

        try:
            rel = self.filepath.relative_to(ROOT)
            html_path = DEFAULT_SITE_DIR / rel.with_suffix(".html")
        except ValueError:
            html_path = self.filepath.with_suffix(".html")

        expected_plotly = _count_plotly_expected(content)
        actual_plotly = _count_plotly_rendered(html_path)
        if expected_plotly > 0 and actual_plotly < expected_plotly:
            missing_count = expected_plotly - actual_plotly
            self._add_issue(
                "critical",
                "missing_plotly_chart",
                f"{missing_count} Plotly widget(s) missing in rendered HTML",
                f"Expected {expected_plotly}, found {actual_plotly} in {self._relpath(html_path)}.",
                POINTS["missing_plotly_chart"] * missing_count,
            )

        return self.report()

    def score_r(self) -> Dict[str, object]:
        content = _read_text(self.filepath)

        valid, reason = _check_r_syntax(self.filepath)
        if not valid:
            self._add_issue(
                "critical",
                "syntax_error",
                "R syntax error",
                reason,
                POINTS["syntax_error"],
            )
            return self.report()

        for line_no, line in enumerate(content.splitlines(), start=1):
            if re.search(r"['\"]([A-Za-z]:[/\\]|/[^\s'\"]+)", line):
                if not re.search(r"https?://|file://", line):
                    self._add_issue(
                        "critical",
                        "hardcoded_path",
                        f"Hardcoded absolute path at line {line_no}",
                        "Use repository-relative paths.",
                        POINTS["hardcoded_path"],
                    )

        has_random = bool(
            re.search(r"\b(rnorm|runif|sample|rbinom|rpois|rnbinom)\s*\(", content)
        )
        has_seed = bool(re.search(r"\bset\.seed\s*\(", content))
        if has_random and not has_seed:
            self._add_issue(
                "major",
                "missing_set_seed",
                "Missing set.seed() for reproducibility",
                "Add a single set.seed(YYYYMMDD) near the top of the script.",
                POINTS["missing_set_seed"],
            )

        return self.report()

    def score_tex(self) -> Dict[str, object]:
        content = _read_text(self.filepath)

        compiled, reason, log_content = _check_tex_compile(
            self.filepath, self.skip_render
        )
        if not compiled:
            self._add_issue(
                "critical",
                "latex_compilation_failure",
                "XeLaTeX compilation failed",
                reason,
                POINTS["latex_compilation_failure"],
            )
            return self.report()

        bib_path = _find_bibliography_path()
        bib_keys = _load_bib_keys(bib_path)
        citations = _extract_tex_citations(content)
        missing = sorted(citations - bib_keys)
        for key in missing:
            self._add_issue(
                "critical",
                "broken_citation",
                f"Citation key not in bibliography: {key}",
                f"Add key to {self._relpath(bib_path)} or fix the citekey.",
                POINTS["broken_citation"],
            )

        undefined = _detect_undefined_citations(log_content)
        for key in sorted(set(undefined)):
            self._add_issue(
                "critical",
                "undefined_citation",
                f"Undefined citation warning for key: {key}",
                "Run full LaTeX/BibTeX passes and ensure citation keys exist.",
                POINTS["undefined_citation"],
            )

        for width in _detect_overfull_hbox(log_content):
            self._add_issue(
                "critical",
                "overfull_hbox",
                f"Overfull hbox > 10pt detected ({width:.1f}pt)",
                "Reduce line width or reflow content.",
                POINTS["overfull_hbox"],
            )

        return self.report()

    def report(self) -> Dict[str, object]:
        self.score = max(0, self.score)
        if self.auto_fail:
            status = "FAIL"
            threshold = "None (auto-fail)"
        elif self.score >= THRESHOLDS["excellence"]:
            status = "EXCELLENCE"
            threshold = "excellence"
        elif self.score >= THRESHOLDS["pr"]:
            status = "PR_READY"
            threshold = "pr"
        elif self.score >= THRESHOLDS["commit"]:
            status = "COMMIT_READY"
            threshold = "commit"
        else:
            status = "BLOCKED"
            threshold = "None (below commit)"

        counts = {
            "critical": len(self.issues["critical"]),
            "major": len(self.issues["major"]),
            "minor": len(self.issues["minor"]),
        }
        counts["total"] = counts["critical"] + counts["major"] + counts["minor"]

        return {
            "filepath": self._relpath(self.filepath),
            "score": self.score,
            "status": status,
            "threshold": threshold,
            "auto_fail": self.auto_fail,
            "issues": {
                "critical": self.issues["critical"],
                "major": self.issues["major"],
                "minor": self.issues["minor"],
                "counts": counts,
            },
            "thresholds": THRESHOLDS,
        }

    def print_report(self, report: Dict[str, object], summary_only: bool) -> None:
        counts = report["issues"]["counts"]
        print(f"\n# Quality Score: {report['filepath']}\n")
        print(f"## Overall Score: {report['score']}/100 [{report['status']}]")
        print(f"**Threshold:** {report['threshold']}")

        if summary_only:
            print(
                "\n"
                f"Issues: {counts['total']} total "
                f"({counts['critical']} critical, {counts['major']} major, {counts['minor']} minor)"
            )
            return

        for severity in ("critical", "major", "minor"):
            issue_list = report["issues"][severity]
            print(f"\n## {severity.capitalize()} Issues: {len(issue_list)}")
            if not issue_list:
                print("None")
                continue
            if severity == "minor" and not self.verbose:
                print("Use --verbose to display minor issue details.")
                continue
            for idx, issue in enumerate(issue_list, start=1):
                print(f"{idx}. {issue['description']} (-{issue['points']})")
                print(f"   - {issue['details']}")


def _expand_paths(raw_paths: List[str]) -> List[Path]:
    paths: List[Path] = []
    for raw in raw_paths:
        matched = list(ROOT.glob(raw))
        if matched:
            paths.extend(p for p in matched if p.is_file())
            continue
        path = Path(raw)
        if not path.is_absolute():
            path = ROOT / path
        if path.exists() and path.is_file():
            paths.append(path)
        else:
            print(f"Error: File not found: {raw}")
    # Preserve order, remove duplicates
    unique: List[Path] = []
    seen = set()
    for path in paths:
        if path in seen:
            continue
        seen.add(path)
        unique.append(path)
    return unique


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Calculate quality scores for EC5230 materials",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python scripts/quality_score.py lecture-slides/slides/lecture-3-innovation.qmd
  python scripts/quality_score.py lecture-slides/slides/lecture-*.qmd --summary
  python scripts/quality_score.py lecture-slides/slides/lecture-5-multi-stage-games.tex
  python scripts/quality_score.py scripts/**/*.R

Thresholds:
  80/100 = Commit threshold
  90/100 = PR threshold
  95/100 = Excellence

Exit codes:
  0 = Score >= 80
  1 = Score < 80
  2 = Auto-fail (compilation/syntax failure)
        """,
    )
    parser.add_argument(
        "filepaths", nargs="+", help="File paths (supports glob patterns)"
    )
    parser.add_argument(
        "--summary", action="store_true", help="Show summary output only"
    )
    parser.add_argument(
        "--verbose", action="store_true", help="Include minor issue details"
    )
    parser.add_argument("--json", action="store_true", help="Output JSON")
    parser.add_argument(
        "--skip-render",
        action="store_true",
        help="Skip Quarto/LaTeX compilation (useful for parser regression tests)",
    )
    args = parser.parse_args()

    targets = _expand_paths(args.filepaths)
    if not targets:
        sys.exit(1)

    exit_code = 0
    reports = []

    for path in targets:
        scorer = QualityScorer(path, verbose=args.verbose, skip_render=args.skip_render)

        suffix = path.suffix.lower()
        if suffix == ".qmd":
            report = scorer.score_qmd()
        elif suffix == ".r":
            report = scorer.score_r()
        elif suffix == ".tex":
            report = scorer.score_tex()
        else:
            print(f"Skipping unsupported file type: {path}")
            continue

        reports.append(report)
        if not args.json:
            scorer.print_report(report, summary_only=args.summary)

        if report["auto_fail"]:
            exit_code = max(exit_code, 2)
        elif report["score"] < THRESHOLDS["commit"]:
            exit_code = max(exit_code, 1)

    if args.json:
        print(json.dumps(reports, indent=2))

    sys.exit(exit_code)


if __name__ == "__main__":
    main()
