$packageName = "terminal-settings"
$logPath = "c:\RS-MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force
write-host "Uninstalling $packageName - does nothing"
Stop-Transcript
