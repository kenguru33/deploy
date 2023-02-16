$HKLMregistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive'##Path to HKLM keys
$DiskSizeregistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\OneDrive\DiskSpaceCheckThresholdMB'##Path to max disk size key
$TenantGUID = '5ca36054-8791-4403-8ebf-ebf9b3281457'

$scriptName = $MyInvocation.MyCommand.Name
$logFile = "c:\intune.log"

function log {
    param($message)
    $msg = "{0} {1}" -f (Get-TimeStamp), "$message ($scriptName)"
    Write-Output $msg | Out-File $logFile -Append
    Write-Host $msg 
}

function Get-TimeStamp {
    return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
}

try {
    if (!(Test-Path $HKLMregistryPath)) { New-Item -Path $HKLMregistryPath -Force }
    if (!(Test-Path $DiskSizeregistryPath)) { New-Item -Path $DiskSizeregistryPath -Force }

    New-ItemProperty -Path $HKLMregistryPath -Name 'SilentAccountConfig' -Value '1' -PropertyType DWORD -Force | Out-Null ##Enable silent account configuration
    New-ItemProperty -Path $DiskSizeregistryPath -Name $TenantGUID -Value '102400' -PropertyType DWORD -Force | Out-Null ##Set max OneDrive threshold before prompting
    log "OneDrive for Business configured successfully!"
}
catch {
    log "Failed to configure OneDrive for Business"
    log $_
    exit 1
}

