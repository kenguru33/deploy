$packageName = "choco"
$logPath = "$Env:Programfiles\RS_MEM\$packageName-install.log"

Start-Transcript -Path $logPath -Force

$chocoPath = "C:\ProgramData\chocolatey\bin\choco.exe"

# Install choco if not installed
try {
    if (-not(test-path $chocoPath)) {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
    
    exit 0
}
catch { exit 1618 }

Stop-Transcript


