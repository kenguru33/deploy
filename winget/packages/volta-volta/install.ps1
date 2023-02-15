$packageId = "Volta.Volta"

$logPath = "c:\RS-MEM\$packageId-install.log"
Start-Transcript -Path $logPath -Force
$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
Set-Location $wingetdir
.\winget install --id $packageId --exact --silent --accept-package-agreements --accept-source-agreements --scope=machine 
Stop-Transcript
