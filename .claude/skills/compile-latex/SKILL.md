---
name: compile-latex
description: Compile a Beamer LaTeX lecture file with a 3-pass XeLaTeX/BibTeX pipeline.
disable-model-invocation: true
argument-hint: "[path/to/file.tex]"
---

# Compile LaTeX (Beamer)

> **⚠️ Legacy skill.** The primary PDF format for this project is now **`clean-typst`**, compiled automatically by `quarto render --to clean-typst`. Use this skill only for compiling standalone Beamer `.tex` documents or historical files. For lecture slides, use `/deploy` or run `quarto render` directly.

Use this skill when a standalone `.tex` Beamer file must be compiled and checked.

## Steps

1. Resolve `$ARGUMENTS` to a `.tex` file path.
2. Run first pass:
   - `xelatex -interaction=nonstopmode -halt-on-error <file.tex>`
3. If citations are present, run:
   - `bibtex <file_stem>`
4. Run two more XeLaTeX passes.
5. Check `<file_stem>.log` for:
   - undefined citations
   - overfull hbox warnings
6. Report compile status and warnings.

## Output

- PDF path
- Warning summary
- Pass/fail verdict

