    $packageName = "7-zip"
    $source = "winget"
    $logPath = "c:\RS_MEM_WINGET\$packageName-install.log"
    Start-Transcript -Path $logPath -Force
    
    # Install app with winget
    try {
        winget install $packageName --silent --accept-package-agreements --accept-source-agreements --scope=machine --source $source
    } catch {
        # retry
        Write-Error "Failed to install $packageName, retrying..."
        exit 1618
    }
    
    Stop-Transcript
