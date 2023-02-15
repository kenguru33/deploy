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
`$logPath = "c:\RS-MEM\`$packageName-install.log"
Start-Transcript -Path `$logPath -Force
`$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
Set-Location `$wingetdir
.\winget install `$packageName --silent --accept-package-agreements --accept-source-agreements --scope=machine --source `$source
Stop-Transcript
"@
    # Create content for uninstall file
    $uninstallContent = @"
`$packageName = "$package"
`$source = "winget"
`$logPath = "c:\RS-MEM\`$packageName-install.log"
Start-Transcript -Path `$logPath -Force
`$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
Set-Location `$wingetdir
.\winget uninstall `$packageName --silent --accept-package-agreements --accept-source-agreements --scope=machine --source `$source
Stop-Transcript
"@

# Create content for detect file
$detectContent = @"
`$packageName = "$package"
`$source = "winget"

`$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
Set-Location `$wingetdir

# Detect winget packages
try {
    `$wingetPackages = .\winget list --source `$source
    `$wingetPackages | Select-String `$packageName
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Package `$packageName is installed"
        exit 0
    } else {
        Write-Host "Package `$packageName is not installed"
        exit 1618
    }
}
catch {
    # retry
    Write-Error "Failed to detect `$packageName, retrying..."
    exit 1618
}
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






