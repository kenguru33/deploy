    $packageName = "7-zip"
    $source = "winget"
    
    # Uninstall winget packages
    winget uninstall --silent --source $source $packageName
