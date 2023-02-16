$logFile = "c:\intune.log"
$scriptName = $MyInvocation.MyCommand.Name

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
    # Fix: Disabling the user notification for drive connection failures
    # In my experience of testing this I have seen the notification appear even when this setting is disabled, it does not appear to be that consistent.
    New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\NetworkProvider -Name RestoreConnection -PropertyType DWord -Value 0 -Force
    log "Fix for GPO Network Drive Notifiaction Disabled installed successfully!"
}
catch {
    log "Failed to install fix for GPO Network Drive Notifiaction Disabled"
    log $_
    exit 1
}
