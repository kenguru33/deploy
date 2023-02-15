    $packageId = "Neovim.Neovim"
    $logPath = "c:\RS-MEM\$packageId-install.log"
    Start-Transcript -Path $logPath -Force
    $wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
    Set-Location $wingetdir
    .\winget uninstall --id $packageId --exact --silent --accept-source-agreements --scope=machine
    Stop-Transcript
    
