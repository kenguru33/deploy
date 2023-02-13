$packageName = "choco"

# Set Chocolatey path
$env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"

if (-not(Get-Command choco -errorAction SilentlyContinue)) {
    exit 1618
}
Write-Host "Found $packageName"
exit 0

