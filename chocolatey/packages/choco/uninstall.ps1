$packageName = "choco"

# Set Chocolatey path
$env:Path = "$env:Path;C:\ProgramData\chocolatey\bin"

# Uninstall Chocolatey packages
choco uninstall -y $packageName

# Create choco update scheduled task
$taskPath = "\Redningsselskapet\"
$taskName = "Choco Update v2"
$task = Get-ScheduledTask -TaskName $taskName -TaskPath $taskPath -ErrorAction SilentlyContinue -OutVariable task 
if (($task)) {
    Write-Host "Scheduled task already exists"
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Host "Deleted schedule task $taskName"
}