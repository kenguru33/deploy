$packageName = "choco"

# Set Chocolatey path
$env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"

# Uninstall Chocolatey packages
choco uninstall $packageName -y
