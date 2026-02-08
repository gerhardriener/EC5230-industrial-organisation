#!/bin/bash
# sync_to_docs.sh
# Renders Quarto project and publishes to gh-pages branch via `quarto publish`
#
# Usage: ./scripts/sync_to_docs.sh [lecture_name]
# Examples:
#   ./scripts/sync_to_docs.sh                    # Render all and publish
#   ./scripts/sync_to_docs.sh lecture-2           # Render specific lecture, then publish

set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

echo "=== Publishing Quarto site to gh-pages ==="
echo "Repo root: $REPO_ROOT"

# 1. Optionally render a specific lecture first
if [ -n "$1" ]; then
    echo "Rendering $1..."
    matched_qmd=$(ls lecture-slides/slides/${1}*.qmd 2>/dev/null | head -1)
    if [ -n "$matched_qmd" ]; then
        quarto render "$matched_qmd"
    else
        echo "Error: No QMD file found matching '${1}' in lecture-slides/slides/"
        exit 1
    fi
fi

# 2. Publish the full project to gh-pages branch
echo "Publishing to gh-pages..."
quarto publish gh-pages --no-browser

echo ""
echo "=== Publish complete! ==="
