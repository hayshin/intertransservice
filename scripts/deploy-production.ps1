# Deploy to production (intertransservice.kz)
# Production is served from hayshin/intertransservice via GitHub Actions + Pages.
# Pushing only to origin (fork) does NOT update the live site.

$ErrorActionPreference = "Stop"

function Require-GitRemote($name) {
    git remote get-url $name 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Git remote '$name' is not configured."
    }
}

Require-GitRemote "upstream"
Require-GitRemote "origin"

$branch = git rev-parse --abbrev-ref HEAD
if ($branch -ne "master") {
    Write-Error "Switch to master branch before deploying (current: $branch)."
}

$uncommitted = git status --short
if ($uncommitted) {
    Write-Error "Working tree is not clean. Commit changes before deploy."
}

$aheadOfUpstream = git rev-list --count upstream/master..HEAD 2>$null
if (-not $aheadOfUpstream) { $aheadOfUpstream = 0 }

if ([int]$aheadOfUpstream -eq 0) {
    Write-Host "Nothing to deploy: master is already synced with upstream/master."
    exit 0
}

Write-Host "Deploying $aheadOfUpstream commit(s) to upstream/master (production)..."
git push upstream master
if ($LASTEXITCODE -ne 0) {
    Write-Error "git push upstream master failed."
}

Write-Host ""
Write-Host "Deploy triggered. Track workflow:"
Write-Host "  https://github.com/hayshin/intertransservice/actions"
Write-Host "Live site (may take 1-2 min): https://intertransservice.kz"
