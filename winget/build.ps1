$rootPath = Resolve-Path -Path "$PSScriptRoot"
$packagePath = Resolve-Path -Path "$PSScriptRoot/packages"
$package = $args[0]

# Create build directory if it does not exist
if (-not (Test-Path -Path $rootPath/build)) {
    New-Item -ItemType Directory -Path $rootPath/build
}

$buildPath = Resolve-Path -Path "$PSScriptRoot/build"

# Check if command exist IntuneWinAppUtil.exe exist
if (-not(Get-Command IntuneWinAppUtil.exe -errorAction SilentlyContinue)) {
    Write-Error "IntuneWinAppUtil.exe not found. "
    Write-Error "Please install the IntuneWinAppUtil.exe from https://docs.microsoft.com/en-us/intune/apps/apps-win32-app-management"
    exit 1
}

Write-Host $package
# If arg 1 is * loop thorugh all packages in packages folder
if ($package -eq "*") {
    $packages = Get-ChildItem -Path $packagePath -Directory -Name
    Write-Host $packages  
    foreach ($package in $packages) {
        Write-Information "Creating intune package $package in $buildPath "
        IntuneWinAppUtil.exe -c $packagePath/$package -s $package -o $buildPath -q
    }
}
else {
    Write-Information "Creating intune package $package in $buildPath "
    IntuneWinAppUtil.exe -c $packagePath\$package -s $package -o $buildPath -q
}




