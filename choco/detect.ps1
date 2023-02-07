$packageName = "choco"

# set choco path
$chocoPath = "C:\ProgramData\chocolatey\bin\choco.exe"
# Add choco to path
$env:Path += ";$chocoPath"

if (-not(test-path $chocoPath)) {
    exit 1618
}
Write-Host "Found $packageName"


