"""
Generate all SVG diagrams from .tex source files.
Run: python generate-diagrams.py
"""

import subprocess
import shutil
import re
from pathlib import Path


def render_tikz_svg(
    tikz_picture: str,
    name: str,
    engine: str = "pdflatex",
    cleanup: bool = True,
    keep_pdf: bool = False,
) -> Path:
    """
    Render TikZ code to SVG via pdflatex + pdftocairo.
    Returns: Path to generated SVG file.
    """
    figs_dir = Path("lecture-slides/figs")
    figs_dir.mkdir(parents=True, exist_ok=True)

    tex_file = figs_dir / f"{name}.tex"
    pdf_file = figs_dir / f"{name}.pdf"
    svg_file = figs_dir / f"{name}.svg"

    # Create standalone LaTeX document (use raw f-string to avoid escape issues)
    tex_content = rf"""\documentclass[tikz,border=2pt]{{standalone}}
\usepackage{{pgfplots}}
\usetikzlibrary{{decorations.pathreplacing}}
\pgfplotsset{{compat=1.18}}
\begin{{document}}
{tikz_picture}
\end{{document}}
"""
    tex_file.write_text(tex_content, encoding="utf-8")

    # Compile to PDF
    if not shutil.which(engine):
        raise RuntimeError(f"LaTeX engine not found: {engine}")

    result = subprocess.run(
        [
            engine,
            "-interaction=nonstopmode",
            f"-output-directory={figs_dir}",
            str(tex_file),
        ],
        capture_output=True,
        text=True,
    )

    if not pdf_file.exists():
        raise RuntimeError(f"PDF not produced.\n{result.stdout}\n{result.stderr}")

    # Convert PDF → SVG using pdftocairo (from poppler-utils)
    if not shutil.which("pdftocairo"):
        raise RuntimeError("pdftocairo not found.")

    result = subprocess.run(
        ["pdftocairo", "-svg", str(pdf_file), str(svg_file)],
        capture_output=True,
        text=True,
    )

    if result.returncode != 0:
        raise RuntimeError(f"pdftocairo failed:\n{result.stdout}\n{result.stderr}")

    if not svg_file.exists():
        raise RuntimeError("SVG not produced.")

    # Cleanup
    if cleanup:
        for ext in [
            ".aux",
            ".log",
            ".out",
            ".synctex.gz",
            ".fls",
            ".fdb_latexmk",
            ".tex",
        ]:
            aux_file = figs_dir / f"{name}{ext}"
            if aux_file.exists():
                aux_file.unlink()

        if not keep_pdf and pdf_file.exists():
            pdf_file.unlink()

    return svg_file


# Main execution
source_dir = Path("lecture-slides/figs/source")

if not source_dir.exists():
    print(f"❌ Source directory {source_dir} not found. Run extract-tikz.py first.")
    exit(1)

tex_files = sorted(source_dir.glob("*.tex"))

if not tex_files:
    print(f"❌ No .tex files found in {source_dir}")
    exit(1)

print(f"Found {len(tex_files)} TikZ source files.\n")

for tex_file in tex_files:
    fig_name = tex_file.stem
    tex_content = tex_file.read_text(encoding="utf-8")

    # Extract TikZ code from tikzpicture environment
    match = re.search(
        r"\\begin\{tikzpicture\}.*?\\end\{tikzpicture\}", tex_content, re.DOTALL
    )

    if match:
        tikz_code = match.group(0)  # Include the environment tags
        svg_file = render_tikz_svg(tikz_picture=tikz_code, name=fig_name)
        print(f"[OK] {svg_file}")
    else:
        print(f"[SKIP] Skipped {tex_file.name} (no tikzpicture environment found)")

print(f"\n[OK] Generated {len(tex_files)} SVG diagrams.")
