#Powershell script that checks if apps are installed and installs them if they aren't

#Query for directory most updated winget.exe is stored in
$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
#Output directory
Write-Host "cd to directory: $wingetdir"
#navigate to directory containing winget.exe
cd $wingetdir