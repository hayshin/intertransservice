# One-command production deploy for https://intertransservice.kz
# Commits local changes (if any) and pushes to origin/master (hayshin/intertransservice).

param(
    [string]$Message = "chore: deploy to production"
)

$ErrorActionPreference = "Stop"

$ProductionRemote = "origin"
$ProductionRepo = "hayshin/intertransservice"

function Get-RemoteUrl($name) {
    $previousPreference = $ErrorActionPreference
    $ErrorActionPreference = "SilentlyContinue"
    $url = (git remote get-url $name 2>$null)
    $ErrorActionPreference = $previousPreference
    if ($LASTEXITCODE -ne 0 -or -not $url) {
        return $null
    }
    return $url.Trim()
}

function Assert-ProductionRemote {
    $url = Get-RemoteUrl $ProductionRemote
    if (-not $url) {
        Write-Error "Production remote '$ProductionRemote' is missing. Run: npm run setup:git"
    }
    if ($url -notmatch [regex]::Escape($ProductionRepo)) {
        Write-Error "Remote '$ProductionRemote' must point to $ProductionRepo (current: $url). Run: npm run setup:git"
    }
}

function Warn-ForkPushOnly {
    $forkUrl = Get-RemoteUrl "fork"
    if (-not $forkUrl) {
        return
    }
    Write-Host ""
    Write-Host "Note: remote 'fork' is backup only and does NOT update intertransservice.kz." -ForegroundColor Yellow
}

$branch = git rev-parse --abbrev-ref HEAD
if ($branch -ne "master") {
    Write-Error "Switch to master before deploy (current branch: $branch)."
}

Assert-ProductionRemote

Write-Host "==> Staging changes..."
git add .

$hasStagedChanges = $true
git diff --cached --quiet 2>$null
if ($LASTEXITCODE -eq 0) {
    $hasStagedChanges = $false
}

if ($hasStagedChanges) {
    Write-Host "==> Committing: $Message"
    git commit -m $Message
    if ($LASTEXITCODE -ne 0) {
        Write-Error "git commit failed."
    }
} else {
    Write-Host "==> No staged changes to commit."
}

$ahead = git rev-list --count "$ProductionRemote/master..HEAD" 2>$null
if (-not $ahead) { $ahead = 0 }

if ([int]$ahead -eq 0 -and -not $hasStagedChanges) {
    Write-Host ""
    Write-Host "Already up to date with $ProductionRemote/master. Nothing to deploy."
    exit 0
}

Write-Host "==> Pushing to $ProductionRemote/master (production)..."
git push $ProductionRemote master
if ($LASTEXITCODE -ne 0) {
    Write-Error "git push $ProductionRemote master failed."
}

$sha = (git rev-parse --short HEAD).Trim()

Write-Host ""
Write-Host "Deploy started successfully." -ForegroundColor Green
Write-Host "  Commit:  $sha"
Write-Host "  Remote:  $ProductionRepo"
Write-Host "  Actions: https://github.com/$ProductionRepo/actions"
Write-Host "  Site:    https://intertransservice.kz (updates in 1-2 min)"

Warn-ForkPushOnly
