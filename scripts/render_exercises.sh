#!/bin/bash
# Render student and instructor versions for all exercises.
#
# Usage:
#   ./scripts/render_exercises.sh
#   ./scripts/render_exercises.sh --check

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

check_mode="false"
if [[ "${1:-}" == "--check" ]]; then
  check_mode="true"
fi

render_one() {
  local path="$1"
  local dir
  local stem
  dir="$(dirname "$path")"
  stem="$(basename "$path" .qmd)"

  local targets=(
    "html|${stem}.html|solutions:false"
    "html|${stem}-solutions.html|solutions:true"
    "pdf|${stem}.pdf|solutions:false"
    "pdf|${stem}-solutions.pdf|solutions:true"
  )

  for entry in "${targets[@]}"; do
    IFS='|' read -r to out meta <<<"$entry"
    local out_path="${dir}/${out}"
    if [[ "$check_mode" == "true" ]]; then
      if [[ ! -f "$out_path" ]]; then
        echo "Missing rendered exercise artifact: $out_path" >&2
        exit 1
      fi
      continue
    fi
    echo "Rendering ${path} -> ${out} [${meta}]"
    quarto render "$path" --to "$to" --output "$out" -M "$meta"
  done
}

mapfile -t exercise_files < <(find exercises/sheets exercises/live -maxdepth 1 -name "*.qmd" -type f | sort)
if [[ ${#exercise_files[@]} -eq 0 ]]; then
  echo "No exercise .qmd files found." >&2
  exit 1
fi

for f in "${exercise_files[@]}"; do
  render_one "$f"
done

if [[ "$check_mode" == "true" ]]; then
  echo "Exercise artifact check passed."
else
  echo "Exercise rendering complete."
fi

