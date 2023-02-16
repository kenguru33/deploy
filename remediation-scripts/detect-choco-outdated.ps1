$packages = choco outdated

if ($packages.Count -eq 0) {
    Write-Host "No outdated packages found."
    Exit 0
}
choco upgrade all -y

