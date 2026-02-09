#!/bin/bash
# sync_to_docs.sh
# Renders Quarto project and publishes to gh-pages branch via `quarto publish`
#
# Usage: ./scripts/sync_to_docs.sh [lecture_name|all]
# Examples:
#   ./scripts/sync_to_docs.sh                    # Render all and publish
#   ./scripts/sync_to_docs.sh lecture-2           # Render specific lecture, then publish
#   ./scripts/sync_to_docs.sh all                 # Publish full project without pre-render filter

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

echo "=== Publishing Quarto site to gh-pages ==="
echo "Repo root: $REPO_ROOT"

# 1. Optionally render a specific lecture first
lecture_arg="${1:-}"
if [ -n "$lecture_arg" ] && [ "$lecture_arg" != "all" ]; then
    echo "Rendering $lecture_arg..."

    matched_qmd=""
    if [ -f "$lecture_arg" ]; then
        matched_qmd="$lecture_arg"
    else
        matched_qmd="$(find lecture-slides/slides -maxdepth 1 -type f -name "${lecture_arg}*.qmd" | sort | head -1 || true)"
    fi

    if [ -z "$matched_qmd" ]; then
        echo "Error: No QMD file found matching '${lecture_arg}' in lecture-slides/slides/"
        exit 1
    fi

    quarto render "$matched_qmd"
fi

# 2. Publish the full project to gh-pages branch
echo "Publishing to gh-pages..."
quarto publish gh-pages --no-browser

echo ""
echo "=== Publish complete! ==="
