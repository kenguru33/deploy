$packageName = "rs-login-module-vpn-fix"
$logPath = "c:\RS-MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force
$scriptPath = "$env:PROGRAMDATA\rs-login\$packageName.ps1"
if (Test-Path $scriptPath) {
    Write-Host "Found $scriptPath"
    Remove-Item -Path $scriptPath -Force
}
Stop-Transcript
