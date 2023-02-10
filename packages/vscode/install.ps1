$packageName = "vscode"

$logPath = "c:\RS_MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force

if (Get-Command choco -errorAction SilentlyContinue) {
    choco install $packageName -y
} else {
    # retry
    exit 1618
}

Stop-Transcript
