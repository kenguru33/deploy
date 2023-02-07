$packageName = "neovim"

# set choco path
$chocoPath = "C:\ProgramData\chocolatey\bin\choco.exe"
# Add choco to path
$env:Path += ";$chocoPath"

# Detect Chocolatey packages
$found = choco list --local-only | Select-String $packageName
if ($found) {
    Write-Host "Found $packageName"
}

