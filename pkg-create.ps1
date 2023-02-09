$rootPath = Resolve-Path -Path "$PSScriptRoot/packages"
$buildPath = Resolve-Path -Path "$PSScriptRoot/build"
# Get argument passed to script
$package = $args[0]

# If direktory exist exit script
$packagePath = Join-Path -Path $rootPath -ChildPath $package
if (Test-Path $packagePath) {
    Write-Warning "Package $package already exist. Skipping package creation."
}
else {

    # Create directory for package
    if (-not(Test-Path $packagePath)) {
        New-Item -Path $packagePath -ItemType Directory 
    }

    # Create content for setup file
    $setupContent = @"
packageName
"@

    # Create content for install file
    $installContent = @"
`$packageName = "$package"

`$logPath = "c:\RS_MEM\`$packageName-install.log"
Start-Transcript -Path `$logPath -Force

if (Get-Command choco -errorAction SilentlyContinue) {
    choco install `$packageName -y
} else {
    # retry
    exit 1618
}

Stop-Transcript
"@

    # Create content for uninstall file
    $uninstallContent = @"
`$packageName = "$package"

# Uninstall Chocolatey packages
choco uninstall `$packageName -y
"@

    # Create content for detect file
    $detectContent = @"
`$packageName = "$package"
# Detect Chocolatey packages
`$found = choco list --local-only | Select-String `$packageName
if (`$found) {
    Write-Host "Found `$packageName"
    exit 0
}
exit 1618
"@

    # Create setup file in package directory
    $setupPath = Join-Path -Path $packagePath -ChildPath "$package"
    if (-not(Test-Path $setupPath)) {
        New-Item -Path $setupPath -ItemType File
        # add content to file
        $setupContent | Out-File -FilePath $setupPath
    }

    # Create uninstall file in package directory
    $uninstallPath = Join-Path -Path $packagePath -ChildPath "uninstall.ps1"
    if (-not(Test-Path $uninstallPath)) {
        New-Item -Path $uninstallPath -ItemType File
        # add content to file
        $uninstallContent | Out-File -FilePath $uninstallPath
    }

    # Create detect file in package directory
    $detectPath = Join-Path -Path $packagePath -ChildPath "detect.ps1"
    if (-not(Test-Path $detectPath)) {
        New-Item -Path $detectPath -ItemType File
        # add content to file
        $detectContent | Out-File -FilePath $detectPath
    }

    # Create install file in package directory
    $installPath = Join-Path -Path $packagePath -ChildPath "install.ps1"
    if (-not(Test-Path $installPath)) {
        New-Item -Path $installPath -ItemType File
        # add content to file
        $installContent | Out-File -FilePath $installPath
    }
}






