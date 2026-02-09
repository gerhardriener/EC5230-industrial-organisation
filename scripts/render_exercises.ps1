#!/usr/bin/env pwsh
# Render student and instructor versions for all exercises.
#
# Usage:
#   pwsh -File ./scripts/render_exercises.ps1
#   pwsh -File ./scripts/render_exercises.ps1 --check

param(
  [switch]$Check
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
Set-Location -LiteralPath $repoRoot

function Render-ExerciseVariants {
  param(
    [Parameter(Mandatory = $true)][string]$Path
  )

  $file = Get-Item -LiteralPath $Path
  $dir = $file.DirectoryName
  $stem = $file.BaseName

  $targets = @(
    @{ To = "html"; Out = "$stem.html"; Meta = "solutions:false" },
    @{ To = "html"; Out = "$stem-solutions.html"; Meta = "solutions:true" },
    @{ To = "pdf"; Out = "$stem.pdf"; Meta = "solutions:false" },
    @{ To = "pdf"; Out = "$stem-solutions.pdf"; Meta = "solutions:true" }
  )

  foreach ($target in $targets) {
    $outPath = Join-Path $dir $target.Out
    if ($Check) {
      if (-not (Test-Path -LiteralPath $outPath)) {
        throw "Missing rendered exercise artifact: $outPath"
      }
      continue
    }

    Write-Host "Rendering $Path -> $($target.Out) [$($target.Meta)]"
    & quarto render $Path --to $target.To --output $target.Out -M $target.Meta
    if ($LASTEXITCODE -ne 0) {
      exit $LASTEXITCODE
    }
  }
}

$exerciseFiles = @()
$exerciseFiles += Get-ChildItem -Path "exercises/sheets" -Filter "*.qmd" -File
$exerciseFiles += Get-ChildItem -Path "exercises/live" -Filter "*.qmd" -File

if (-not $exerciseFiles) {
  throw "No exercise .qmd files found."
}

foreach ($exercise in $exerciseFiles) {
  Render-ExerciseVariants -Path $exercise.FullName
}

if ($Check) {
  Write-Host "Exercise artifact check passed."
} else {
  Write-Host "Exercise rendering complete."
}

