#Find existing Choco schedule, delete them and create new.

$packageName = "choco"
$logPath = "c:\RS-MEM\$packageName-Remidiation.log"

Start-Transcript -Path $logPath -Force

$upgradechoco = '& "$env:ProgramData\chocolatey\bin\choco.exe" upgrade all -y --no-progress --limit-output'

# Task Schedule details
$taskPath = "\Redningsselskapet\"
$taskNameNew = "Choco Update v2"
$taskNameOld = "Choco Update"

# Get existing tasks

$taskOld = Get-ScheduledTask -TaskName $taskNameOld -TaskPath $taskPath -ErrorAction SilentlyContinue
$taskNew = Get-ScheduledTask -TaskName $taskNameNew -TaskPath $taskPath -ErrorAction SilentlyContinue

# Remove old task if it exists
    if ($null -ne $taskOld) {
    Unregister-ScheduledTask -TaskName $taskNameOld -TaskPath $taskPath -Confirm:$false
    Write-Output "task $taskNameOld was deleted"
}

# Create new task only if it does not exist
try {
if ($null -eq $taskNew) {
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -NonInteractive -WindowStyle Hidden -Command $upgradechoco"
    $trigger = New-ScheduledTaskTrigger -Daily -At "11:40 AM"
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -Hidden
    $principal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Brukere" -RunLevel Highest

    Register-ScheduledTask -TaskName $taskNameNew -TaskPath $taskPath -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Description "Updates all chocolatey packages"
    exit 0
}

else {
    Write-Host "Task Schedule already exist."
    exit 0
}
}
catch{
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    exit 1
}

Stop-Transcript