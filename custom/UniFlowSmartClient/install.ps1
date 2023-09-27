    # $logPath = "c:\RS-MEM\$packageName-install.log"
    # Start-Transcript -Path $logPath -Force
    Start-Process -Wait -FilePath msiexec.exe -ArgumentList "/i `".\uniFLOW SmartClient.msi`" /qn"
    # Stop-Transcript
