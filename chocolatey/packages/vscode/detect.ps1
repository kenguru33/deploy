$packageName = "vscode"
# Detect Chocolatey packages
$found = choco list --local-only | Select-String $packageName
if ($found) {
    Write-Host "Found $packageName"
    exit 0
}
exit 1618
