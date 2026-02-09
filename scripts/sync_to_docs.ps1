#!/usr/bin/env pwsh
# sync_to_docs.ps1
# Renders Quarto project and publishes to gh-pages branch via `quarto publish`
#
# Usage:
#   pwsh -File ./scripts/sync_to_docs.ps1 [lecture_name|all]
# Examples:
#   pwsh -File ./scripts/sync_to_docs.ps1                  # Render all and publish
#   pwsh -File ./scripts/sync_to_docs.ps1 lecture-2        # Render matching lecture, then publish
#   pwsh -File ./scripts/sync_to_docs.ps1 all              # Publish full project without pre-render filter

param(
  [Parameter(Position = 0)]
  [string]$LectureName
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location -LiteralPath $repoRoot

Write-Host "=== Publishing Quarto site to gh-pages ==="
Write-Host "Repo root: $repoRoot"

if ($LectureName -and $LectureName -ne "all") {
  Write-Host "Rendering $LectureName..."

  $matchedQmd = $null

  if (Test-Path -LiteralPath $LectureName) {
    $item = Get-Item -LiteralPath $LectureName
    if ($item.PSIsContainer -or $item.Extension -ne ".qmd") {
      throw "Error: '$LectureName' is not a .qmd file."
    }
    $matchedQmd = $item.FullName
  } else {
    $pattern = "$LectureName*.qmd"
    $matchedQmd = Get-ChildItem -Path "lecture-slides/slides" -Filter $pattern -File |
      Sort-Object Name |
      Select-Object -First 1 |
      Select-Object -ExpandProperty FullName
  }

  if (-not $matchedQmd) {
    throw "Error: No QMD file found matching '$LectureName' in lecture-slides/slides/"
  }

  & quarto render $matchedQmd
  if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
  }
}

Write-Host "Publishing to gh-pages..."
& quarto publish gh-pages --no-browser
if ($LASTEXITCODE -ne 0) {
  exit $LASTEXITCODE
}

Write-Host ""
Write-Host "=== Publish complete! ==="
