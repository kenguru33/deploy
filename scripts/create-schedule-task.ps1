$scriptUrl = "https://raw.githubusercontent.com/Redningsselskapet/RS-Win11-Management/master/login.ps1"
$scriptPath = "c:\login.ps1"
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
    Invoke-RestMethod $scriptUrl -OutFile $scriptPath
    log "Downloaded login script successfully!"
} catch {
    log "Failed to download login script"
    log $_
    exit 1
}


$taskPath = "\Redningsselskapet\"
$taskName = "Map Network Drives"
$delay = New-TimeSpan -Seconds 30
$trigger = New-ScheduledTaskTrigger -AtLogon -RandomDelay $delay 
$trigger.Delay = "PT30S"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass $scriptPath"
$task = Get-ScheduledTask -TaskName $taskName -TaskPath $taskPath -ErrorAction SilentlyContinue -OutVariable task 
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries
$principal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Brukere" -RunLevel Highest

if (-not($task)) {
        Register-ScheduledTask -Action $action -Trigger $trigger -TaskPath $taskPath -TaskName $taskName -Description "Maps Local Network Drives" -Settings $settings -Principal $principal
    log "Scheduled task created successfully!"
} else {
    log "Scheduled task already exists"
}