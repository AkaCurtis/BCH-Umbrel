# Cleanup script - remove unnecessary files from root
$env:Path += ";C:\Program Files\Git\bin"

Write-Host "=== Cleaning Repository Root ===" -ForegroundColor Cyan
Write-Host ""

# Files to remove from root (they're already in axebch-ath-watcher/)
$toRemove = @(
    "backend.py",
    "docker-compose.yml",
    "icon.svg",
    "umbrel-app.yml",
    "watcher..py",
    "CHECKLIST.md",
    "INSTALL-NO-GIT.md",
    "INSTALL.md",
    "UMBREL-STRUCTURE.md",
    "connect-github.ps1",
    "push-to-github.ps1",
    "setup-github.ps1",
    "umbrel_watch_state.json"
)

foreach ($file in $toRemove) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "Deleted: $file" -ForegroundColor Green
    }
}

# Remove from git
git rm backend.py docker-compose.yml icon.svg umbrel-app.yml watcher..py CHECKLIST.md INSTALL-NO-GIT.md INSTALL.md UMBREL-STRUCTURE.md connect-github.ps1 push-to-github.ps1 setup-github.ps1 umbrel_watch_state.json 2>$null

Write-Host ""
Write-Host "Committing cleanup..." -ForegroundColor Yellow
git add .
git commit -m "Clean repository: remove duplicate files, keep only app folder"

Write-Host ""
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push origin main

Write-Host ""
Write-Host "Done! Repository structure:" -ForegroundColor Green
Write-Host "  - axebch-ath-watcher/   (your app)" -ForegroundColor Cyan
Write-Host "  - README.md             (app store description)" -ForegroundColor Cyan
Write-Host "  - LICENSE               (license file)" -ForegroundColor Cyan
Write-Host "  - .gitignore            (git config)" -ForegroundColor Cyan
