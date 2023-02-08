$packageName = "powershell-core"

# Set Chocolatey path
$env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"

$logPath = "c:\RS_MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force

# Write path
Write-Host $env:Path

if (Get-Command choco -errorAction SilentlyContinue) {
    choco install $packageName -y
} else {
    # retry
    exit 1618
}

Stop-Transcript


