# check if login.ps1 exists
$loginPath = "c:\RS-MEM\login.ps1"
if (Test-Path $loginPath) {
    Write-Host "Found $loginPath"
    exit 0
}
else {
    exit 1618
}

