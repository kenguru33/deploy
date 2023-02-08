$packageName = "neovim"

# Set Chocolatey path
$env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"

# Start log
Start-Transcript -Path $logPath -Force

# Uninstall Chocolatey package
choco uninstall $packageName -y


