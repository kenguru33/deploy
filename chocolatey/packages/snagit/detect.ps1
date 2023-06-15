    $packageName = "snagit"
    # Set Chocolatey path
    $env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"
    # Check if package is installed
    $found = choco list | Select-String $packageName
    if ($found) {
        Write-Host "Found $packageName"
        exit 0
    }
    # Package not found, Retry
    exit 1618    
