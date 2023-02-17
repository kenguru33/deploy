$packageName = "powershell-profile"

# Detect Chocolatey packages
if (Test-Path $env:OneDrive\Documents\WindowsTerminal\settings.json) {
    Write-Host "Found $packageName"
    exit 0
}
exit 1618


