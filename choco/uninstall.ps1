$packageName = "choco"

# set choco path
$chocoPath = "C:\ProgramData\chocolatey\bin\choco.exe"
# Add choco to path
$env:Path += ";$chocoPath"

# Uninstall Chocolatey packages
choco uninstall $packageName -y
