$packageName = "rs-login-module-vpn-fix"
$scriptFolder = "$env:PROGRAMDATA\rs-login"
$scriptPath = "$scriptFolder\$packageName.ps1"

if (Test-Path $scriptPath) {
    Write-Host "Found $scriptPath"
    exit 0
}
else {
    exit 1618
}
