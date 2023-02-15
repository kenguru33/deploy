    $packageName = "sql-server-management-studio"
    $logPath = "c:\RS-MEM\$packageName-install.log"
    Start-Transcript -Path $logPath -Force
    # Set Chocolatey path
    $env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"
    # Install Chocolatey package
    choco install -y $packageName
    Stop-Transcript
