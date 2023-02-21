$packageName = "rs-login"
$scriptPath = "c:\login.ps1"
$logPath = "C:\RS-MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force
$taskPath = "\Redningsselskapet\"
$taskName = "RS Login Script"

$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($task) {
    Unregister-ScheduledTask -TaskName $taskName -TaskPath $taskPath -Confirm:$false
    Write-Host "Deleted schedule task $taskName"
}
# Delete login.ps1
if (Test-Path $scriptPath) {
    Remove-Item -Path $scriptPath -Force
}
Stop-Transcript

