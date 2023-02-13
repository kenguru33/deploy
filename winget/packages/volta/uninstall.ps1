    $packageName = "volta"
    $source = "winget"
    
    # Uninstall winget packages
    winget uninstall --silent --source $source $packageName
