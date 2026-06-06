# Optional: sync master to personal fork (NOT production).

$ErrorActionPreference = "Stop"

if (-not (git remote get-url fork 2>$null)) {
    Write-Error "Remote 'fork' is not configured. This script is optional."
}

$branch = git rev-parse --abbrev-ref HEAD
if ($branch -ne "master") {
    Write-Error "Switch to master before syncing backup (current: $branch)."
}

Write-Host "Syncing master to fork (backup only, NOT production)..."
git push fork master
if ($LASTEXITCODE -ne 0) {
    Write-Error "git push fork master failed."
}

Write-Host "Backup remote updated." -ForegroundColor Green
