$buildPath = Resolve-Path -Path "$PSScriptRoot/build"
$packagePath = Resolve-Path -Path "$PSScriptRoot/packages"
$package = $args[0]

Write-Information "Creating intune package $package in $buildPath "
# Check if command exist IntuneWinAppUtil.exe exist
if (-not(Get-Command IntuneWinAppUtil.exe -errorAction SilentlyContinue)) {
    Write-Error "IntuneWinAppUtil.exe not found. "
    Write-Error "Please install the IntuneWinAppUtil.exe from https://docs.microsoft.com/en-us/intune/apps/apps-win32-app-management"
    exit 1
}
IntuneWinAppUtil.exe -c $packagePath\$package -s $package -o $buildPath
