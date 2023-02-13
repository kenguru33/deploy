    $packageName = "7-zip"
    $source = "winget"
    
    # Detect winget packages
    
    $found = winget list $packageName --source $source --accept-source-agreements | Select-String $packageName
    if ($found) {
        Write-Host "Found $packageName"
        exit 0
    }
    exit 1618
