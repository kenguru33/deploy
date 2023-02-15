$packageName = "7-zip"
$source = "winget"

$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
Set-Location $wingetdir

# Detect winget packages
try {
    $wingetPackages = .\winget list --source $source
    $wingetPackages | Select-String $packageName
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Package $packageName is installed"
        exit 0
    } else {
        Write-Host "Package $packageName is not installed"
        exit 1618
    }
}
catch {
    # retry
    Write-Error "Failed to detect $packageName, retrying..."
    exit 1618
}
