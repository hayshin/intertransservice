# Configure git remotes for predictable production deploy.
# origin  -> hayshin/intertransservice (production, GitHub Pages)
# fork    -> personal fork (backup only, optional)

$ErrorActionPreference = "Stop"

$ProductionUrl = "https://github.com/hayshin/intertransservice.git"
$ForkUrl = "https://github.com/b95236027-wq/intertransservice.git"

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

Write-Host "Configuring production git remotes..."

$originUrl = Get-RemoteUrl "origin"
$upstreamUrl = Get-RemoteUrl "upstream"
$forkUrl = Get-RemoteUrl "fork"

# Legacy layout: origin=fork, upstream=production
if ($originUrl -match "b95236027-wq/intertransservice" -and $upstreamUrl -match "hayshin/intertransservice") {
    Write-Host "Detected legacy remotes (origin=fork, upstream=production). Renaming..."
    git remote rename origin fork
    git remote rename upstream origin
}

# Fresh clone from fork only
elseif ($originUrl -match "b95236027-wq/intertransservice" -and -not $forkUrl) {
    Write-Host "Detected fork-only clone. Adding production remote..."
    git remote rename origin fork
    git remote add origin $ProductionUrl
}

# Fresh clone from production
elseif ($originUrl -match "hayshin/intertransservice") {
    Write-Host "origin already points to production."
    if (-not $forkUrl) {
        git remote add fork $ForkUrl
        Write-Host "Added optional backup remote: fork"
    }
}

else {
    Write-Error "Unexpected remote layout. Set origin to $ProductionUrl manually."
}

git fetch origin
git branch --set-upstream-to=origin/master master
git config core.hooksPath .githooks

Write-Host ""
Write-Host "Remotes configured:" -ForegroundColor Green
git remote -v
Write-Host ""
Write-Host "Production deploy: npm run deploy"
Write-Host "Backup sync (optional): npm run deploy:backup"
