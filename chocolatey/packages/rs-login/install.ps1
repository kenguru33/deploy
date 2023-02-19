$packageName = "rs-login"
$logPath = "c:\RS-MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force
# Copy login script to c:\RS-MEM
Copy-Item -Path ".\login.ps1" -Destination "c:\RS-MEM\login.ps1" -Force
# Run create-schedule-task.ps1
.\create-schedule-task.ps1
Stop-Transcript
