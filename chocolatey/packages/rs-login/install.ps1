$packageName = "rs-login"
$logPath = "c:\RS-MEM\$packageName-install.log"
$scriptPath = "C:\RS-MEM\login.ps1"

Start-Transcript -Path $logPath -Force

# Copy login script to c:\RS-MEM
Copy-Item -Path "$PSScriptRoot\login.ps1" -Destination "$scriptPath" -Force

# Run create-schedule-task.ps1
& $PSScriptRoot\create-schedule-task.ps1

# Create script folder if not exist
$scriptFolder = "$env:PROGRAMDATA\rs-login"
if (-not(Test-Path $scriptFolder)) {
    New-Item -ItemType Directory -Path $scriptFolder -Force
}

Stop-Transcript

