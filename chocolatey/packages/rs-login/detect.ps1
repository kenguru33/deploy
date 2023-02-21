# check if login.ps1 exists
$scriptPath = "c:\RS-MEM\login.ps1"
if (Test-Path $scriptPath) {
    Write-Host "Found $scriptPath"
    exit 0
}
else {
    exit 1618
}

