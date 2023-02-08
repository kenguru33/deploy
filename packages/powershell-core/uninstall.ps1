$packageName = "powershell-core"

# set choco path
$chocoPath = "C:\ProgramData\chocolatey\bin\choco.exe"
# Add choco to path
$env:Path += ";$chocoPath"

$logPath = "$Env:Programfiles\RS_MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force

# Uninstall Chocolatey packages
Write-Host "Uninstalling Chocolatey $packageName"
choco uninstall $packageName -y

Stop-Transcript
