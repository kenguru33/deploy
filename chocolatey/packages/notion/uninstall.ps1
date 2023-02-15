    $packageName = "notion"
    $logPath = "c:\RS-MEM\$packageName-install.log"
    Start-Transcript -Path $logPath -Force
    # Set Chocolatey path
    $env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"
    # Install Chocolatey package
    choco uninstall -y $packageName
    Stop-Transcript
