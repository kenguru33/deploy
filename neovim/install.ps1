$packageName = "neovim"

# set choco path
$chocoPath = "C:\ProgramData\chocolatey\bin\choco.exe"
# Add choco to path
$env:Path += ";$chocoPath"
$logPath = "$Env:Programfiles\RS_MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force

if (Get-Command choco -errorAction SilentlyContinue) {
    choco install $packageName -y
} else {
    # retry
    exit 1618
}

Stop-Transcript


