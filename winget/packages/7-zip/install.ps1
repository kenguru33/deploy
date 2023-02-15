$packageName = "7-zip"
$source = "winget"
$logPath = "c:\RS_MEM_WINGET\$packageName-install.log"
Start-Transcript -Path $logPath -Force
    
# query for directory most updated winget.exe is stored in
$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
# output directory
Write-Host "cd to directory: $wingetdir"
# navigate to directory containing winget.exe
Set-Location $wingetdir

# Install app with winget
try {
    Write-Host "Running winget install $packageName"
    .\winget install $packageName --accept-package-agreements --accept-source-agreements --scope=machine --source $source
    Write-Host "Winget install complete"
}
catch {
    # retry
    Write-Error "Failed to install $packageName, retrying..."
    exit 1618
}
    
Stop-Transcript
