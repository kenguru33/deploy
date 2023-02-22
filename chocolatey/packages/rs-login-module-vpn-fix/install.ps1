$packageName = "rs-login-module-vpn-fix"
$logPath = "c:\RS-MEM\$packageName-install.log"
$scriptPath = "$env:PROGRAMDATA\rs-login\$packageName.ps1"

Start-Transcript -Path $logPath -Force

Copy-Item -Path "$PSScriptRoot\$packageName.ps1" -Destination "$scriptPath" -Force
    
Stop-Transcript
