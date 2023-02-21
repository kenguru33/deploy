$scriptPath = "c:\RS-MEM\login.ps1"

$taskPath = "\Redningsselskapet\"
$taskName = "RS Login Script"
$delay = New-TimeSpan -Seconds 30
$trigger = New-ScheduledTaskTrigger -AtLogon -RandomDelay $delay 
$trigger.Delay = "PT30S"
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass $scriptPath"
$task = Get-ScheduledTask -TaskName $taskName -TaskPath $taskPath -ErrorAction SilentlyContinue -OutVariable task 
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries
$principal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Brukere" -RunLevel Highest

# delete old schedule task if it exists
if (($task)) {
    Write-Host "Scheduled task already exists"
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Host "Deleted schedule task $taskName"
}

# hacky way to delete old login script schedule task - to be removed in future
Unregister-ScheduledTask -TaskName "Map Network Drives" -TaskPath "\Redningsselskapet\" -Confirm:$false -ErrorAction SilentlyContinue
Remove-Item c:\login.ps1 -ErrorAction SilentlyContinue
# end hacky way

# create new login script schedule task
Register-ScheduledTask -Action $action -Trigger $trigger -TaskPath $taskPath -TaskName $taskName -Description "Redningsselskapet Login Script" -Settings $settings -Principal $principal
Write-Host "Scheduled task created successfully!"