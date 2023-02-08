$packageName = "neovim"

# Set Chocolatey path
$env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"

# Detect Chocolatey packages
$found = choco list --local-only | Select-String $packageName
if ($found) {
    Write-Host "Found $packageName"
    exit 0
}
exit 1618
