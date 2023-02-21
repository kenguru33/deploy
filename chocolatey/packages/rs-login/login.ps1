$logPath = "$env:SYSTEMDISK\Windows\Temp\login.log"

Start-Transcript -Path $logPath -Force

Write-Host "Running Redningsselskapet Login Script..."

# # Check if the current user has admin rights
# $isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
# if (-not($isAdmin)) {
#     Write-Host "You do not have admin rights. Exiting..." -ForegroundColor Red
#     exit 1
# }

$scriptFolder = "$env:PROGRAMDATA\rs-login"

Get-ChildItem -Path $scriptFolder -Filter "*.ps1" -Recurse | ForEach-Object {
    Write-Host "Running $($PSItem.Name)..."
    Invoke-Expression $_.FullName
}

Stop-Transcript