$packageName = "nerdfonts"

# Set Chocolatey path
$env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"

# Set log path
$logPath = "c:\RS_MEM\$packageName-install.log"

# Start log
Start-Transcript -Path $logPath -Force

if (Get-Command choco -errorAction SilentlyContinue) {
    choco install -y cascadia-code-nerd-font
} else {
    # retry
    exit 1618
}

Stop-Transcript


