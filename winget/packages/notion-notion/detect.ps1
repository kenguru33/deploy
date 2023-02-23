$packageId = "Notion.Notion"

# check if winget package is installed
$found = (winget list $packageId --exact --accept-source-agreements | Out-String ) -match "$packageId"

if ($found) {
    Write-Host "Found $packageId"
    exit 0
}
else {
    exit 1618
}
