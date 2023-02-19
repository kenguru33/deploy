$scriptPath = "c:\RS-MEM\login.ps1"
Start-Transcript -Path $logPath -Force
# Delete schedule task Redningsselskapet
$taskName = "Redningsselskapet"
$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($task) {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Host "Deleted schedule task $taskName"
}
# Delete login.ps1
if (Test-Path $scriptPath) {
    Remove-Item -Path $scriptPath -Force
}
Stop-Transcript

