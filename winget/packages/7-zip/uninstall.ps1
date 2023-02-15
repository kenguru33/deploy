$packageName = "7-zip"
$source = "winget"
    
# query for directory most updated winget.exe is stored in
$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
# output directory
Write-Host "cd to directory: $wingetdir"
# navigate to directory containing winget.exe
Set-Location $wingetdir

# Uninstall winget packages
.\winget uninstall --silent --source $source $packageName
