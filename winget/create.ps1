$rootPath = Resolve-Path -Path "$PSScriptRoot"

# Get argument passed to script
$packageId = $args[0]

$found = (winget list --id $package --exact --accept-source-agreements | Out-String ) -match "$packageId" 

if (-not($found)) {
    Write-Warning "Package $package not found in winget. Skipping package creation."
    exit 1
}
$package = $packageId.ToLower().replace(".", "-")

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
$package
"@

# Create content for install file
$installContent = @"
`$packageId = "$packageId"

`$logPath = "c:\RS-MEM\`$packageId-install.log"
Start-Transcript -Path `$logPath -Force
`$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
Set-Location `$wingetdir
.\winget install --id `$packageId --exact --silent --accept-package-agreements --accept-source-agreements --scope=machine 
Stop-Transcript
"@
    # Create content for uninstall file
    $uninstallContent = @"
    `$packageId = "$packageId"
    `$logPath = "c:\RS-MEM\`$packageId-install.log"
    Start-Transcript -Path `$logPath -Force
    `$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
    Set-Location `$wingetdir
    .\winget uninstall --id `$packageId --exact --silent --accept-source-agreements --scope=machine
    Stop-Transcript
    
"@

# Create content for detect file
$detectContent = @"
`$packageId = "$packageId"

`$wingetdir = (Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe" | Sort-Object -Property Path | Select-Object -Last 1)
Set-Location `$wingetdir

# check if winget package is installed
`$found = (.\winget list `$packageId --exact --accept-source-agreements | Out-String ) -match "`$packageId"

if (`$found) {
    Write-Host "Found `$packageId"
    exit 0
}
else {
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






