    $packageId = "Notion.Notion"
    $logPath = "c:\RS-MEM\$packageId-install.log"
    Start-Transcript -Path $logPath -Force
    winget uninstall --id $packageId --exact --silent --accept-source-agreements
    Stop-Transcript
    
