$packageName = "powershell-core"
$logPath = "c:\RS-MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force
# Set Chocolatey path
$env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"
# Install Chocolatey package
choco install -y $packageName

# Set PowerShell 7 profile path
$PS7_PROFILE_PATH = "C:\Program Files\powershell\7\profile.ps1"
# Copy profile.ps1 to PowerShell 7 profile path
Copy-Item -Path "$PSScriptRoot\profile.ps1" -Destination $PS7_PROFILE_PATH -Force

Stop-Transcript
