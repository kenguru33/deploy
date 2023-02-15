    $packageName = "sql-server-management-studio"
    # Set Chocolatey path
    $env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"
    # Check if package is installed
    $found = choco list --local-only | Select-String $packageName
    if ($found) {
        Write-Host "Found $packageName"
        exit 0
    }
    # Package not found, Retry
    exit 1618    
