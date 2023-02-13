$package = $args[0]

# check if build directory exist
if (-not (Test-Path -Path "$PSScriptRoot/build")) {
    Write-Error "Build directory does not exist."
    exit 1
}

# Delete all files in the build directory
$buildPath = Resolve-Path -Path "$PSScriptRoot/build"

# Delete package from build directory
if ($package -eq "*") {
    Write-Host "Deleting all packages in $buildPath"
    Remove-Item -Path $buildPath -Recurse -Force
}
else {
    # check if package exist
    if (-not (Test-Path -Path "$buildPath/$package.intunewin")) {
        Write-Error "Package $package does not exist."
        exit 1
    }
    Remove-Item -Path "$buildPath/$package.intunewin" -Force
    Write-Host "Deleted $package in $buildPath"
}

