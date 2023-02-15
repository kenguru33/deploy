$packageId = "Volta.Volta"

$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
Set-Location $wingetdir

# check if winget package is installed
$found = (.\winget list $packageId --exact --accept-source-agreements | Out-String ) -match "$packageId"

if ($found) {
    Write-Host "Found $packageId"
    exit 0
}
else {
    exit 1618
}
