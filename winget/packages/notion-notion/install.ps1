$packageId = "Notion.Notion"

$logPath = "c:\RS-MEM\$packageId-install.log"
Start-Transcript -Path $logPath -Force
winget install --id $packageId --exact --silent --accept-package-agreements --accept-source-agreements 
Stop-Transcript
