---
name: deploy
description: Render Quarto slides and publish to GitHub Pages via `quarto publish gh-pages`. Use when deploying lecture slides after making changes.
disable-model-invocation: true
argument-hint: "[lecture-N-name or 'all']"
---

# Deploy Slides to GitHub Pages

Render the Quarto project and publish to the `gh-pages` branch using `quarto publish gh-pages`.

## Steps

1. **Run the publish script:**
   - If `$ARGUMENTS` is provided (e.g., "lecture-2"): `./scripts/sync_to_docs.sh $ARGUMENTS`
   - If no argument: `./scripts/sync_to_docs.sh` (renders all and publishes)

2. **Verify the published site:**
   - Check that `quarto publish` completed without errors
   - Confirm the gh-pages branch was updated (`git log gh-pages --oneline -1`)

3. **Verify interactive charts** (if applicable):
   - Grep rendered HTML in `_site/` for interactive widget count
   - Confirm count matches expected

4. **Verify TikZ SVGs** (if applicable):
   - Check that all referenced SVG files exist in `lecture-slides/figs/`

5. **Open in browser** for visual verification:
   - `open _site/lecture-slides/slides/lecture-X-name.html`
   - Confirm slides render, images display, navigation works

6. **Report results** to the user

## What the publish script does:

- Optionally renders a specific lecture QMD file if an argument is given
- Runs `quarto publish gh-pages --no-browser` to render the full project and push to the `gh-pages` branch
- No manual `docs/` sync needed — Quarto handles everything
