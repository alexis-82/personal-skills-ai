# Installazione skill Feature-Driven Workflow per Claude Code (Windows)
# Uso: .\install.ps1

$ErrorActionPreference = 'Stop'

$skills = @(
    '01-spec',
    '02-clarify',
    '03-plan-tasks',
    '04-analyze',
    '05-implement',
    '06-test',
    '07-review',
    '08-refactor',
    '09-commit',
    '10-guardrail-scope'
)

$sourceDir = $PSScriptRoot
$targetDir = Join-Path $env:USERPROFILE '.claude\skills'

Write-Host "Installazione skill in: $targetDir" -ForegroundColor Cyan
Write-Host ""

if (-not (Test-Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
    Write-Host "Creata directory $targetDir"
}

# Rimuovi le versioni precedenti senza numerazione (evita skill duplicate)
foreach ($skill in $skills) {
    $legacy = Join-Path $targetDir ($skill -replace '^\d{2}-', '')
    if (Test-Path $legacy) {
        Remove-Item -Recurse -Force $legacy
        Write-Host "  RM  $(Split-Path $legacy -Leaf) (vecchio nome)" -ForegroundColor Yellow
    }
}

# Copia (o sovrascrivi) le skill correnti
$installed = 0
foreach ($skill in $skills) {
    $src = Join-Path $sourceDir $skill
    $dst = Join-Path $targetDir $skill

    if (-not (Test-Path $src)) {
        Write-Warning "Sorgente mancante: $src (skip)"
        continue
    }

    if (Test-Path $dst) {
        Remove-Item -Recurse -Force $dst
    }

    Copy-Item -Recurse -Path $src -Destination $dst
    Write-Host "  OK  $skill" -ForegroundColor Green
    $installed++
}

Write-Host ""
Write-Host "Installate $installed/$($skills.Count) skill." -ForegroundColor Cyan
Write-Host "Riavvia Claude Code per caricarle."
