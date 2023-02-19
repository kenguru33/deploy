$packageName = "terminal-settings"
$logPath = "c:\RS-MEM\$packageName-install.log"

Start-Transcript -Path $logPath -Force

$PS7_PROFILE_PATH = "C:\Program Files\powershell\7\profile.ps1"
$PS5_PROFILE_PATH = "c:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1"
 
Copy-Item -Path "$PSScriptRoot\profile.ps1" -Destination $PS7_PROFILE_PATH -Force
Copy-Item -Path "$PSScriptRoot\profile.ps1" -Destination $PS5_PROFILE_PATH -Force

Stop-Transcript


