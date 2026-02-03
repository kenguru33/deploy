$packageName = "choco"
$logPath = "c:\RS-MEM\$packageName-install.log"

Start-Transcript -Path $logPath -Force

$chocoPath = "$env:ProgramData\chocolatey\bin\choco.exe"
$upgradechoco = '& "$env:ProgramData\chocolatey\bin\choco.exe" upgrade all -y --no-progress --limit-output'

# Install choco if not installed
try {
    if (-not(test-path $chocoPath)) {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072 
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
   
    # Create choco update scheduled task
    $taskPath = "\Redningsselskapet\"
    $taskName = "Choco Update v2"
    $task = Get-ScheduledTask -TaskName $taskName -TaskPath $taskPath -ErrorAction SilentlyContinue -OutVariable task 
    if (($task)) {
        Write-Host "Scheduled task already exists"
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
        Write-Host "Deleted schedule task $taskName"
    }

    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -NonInteractive -WindowStyle Hidden -Command $upgradechoco"
    $trigger = New-ScheduledTaskTrigger -Daily -At "11:40 AM" 
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -Hidden
    $principal = New-ScheduledTaskPrincipal -GroupId "BUILTIN\Brukere" -RunLevel Highest
    
    Register-ScheduledTask -Action $action -Trigger $trigger -TaskPath $taskPath -TaskName $taskName -Description "Updates all chocolatey packages" -Settings $settings -Principal $principal
    exit 0
}
catch { exit 1618 }

Stop-Transcript


