$rootPath = Resolve-Path -Path "$PSScriptRoot"

# Get argument passed to script
$package = $args[0]

# If direktory exist exit script
$packagePath = Join-Path -Path $rootPath/packages -ChildPath $package

if (Test-Path $packagePath) {
    Write-Warning "Package $package already exist. Skipping package creation."
}
else {

    # Create directory for packages
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
    `$source = "winget"
    `$logPath = "c:\RS_MEM_WINGET\`$packageName-install.log"
    Start-Transcript -Path `$logPath -Force
    
    # Install app with winget
    try {
        winget install `$packageName --silent --accept-package-agreements --accept-source-agreements --scope=machine --source `$source
    } catch {
        # retry
        Write-Error "Failed to install `$packageName, retrying..."
        exit 1618
    }
    
    Stop-Transcript
"@

    # Create content for uninstall file
    $uninstallContent = @"
    `$packageName = "$package"
    `$source = "winget"
    
    # Uninstall winget packages
    winget uninstall --silent --source `$source `$packageName
"@

    # Create content for detect file
    $detectContent = @"
    `$packageName = "$package"
    `$source = "winget"
    
    # Detect winget packages
    
    `$found = winget list `$packageName --source `$source --accept-source-agreements | Select-String `$packageName
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






