$taskPath     = "\Redningsselskapet\"
$taskNameOld  = "Choco Update"
$taskNameNew  = "Choco Update v2"

try {
    $choco = Get-Command choco -ErrorAction SilentlyContinue

    $oldTask = Get-ScheduledTask -TaskName $taskNameOld -TaskPath $taskPath -ErrorAction SilentlyContinue
    $newTask = Get-ScheduledTask -TaskName $taskNameNew -TaskPath $taskPath -ErrorAction SilentlyContinue

    if ($choco -and $oldTask) {
        Write-Output "Chocolatey is installed and old task '$taskNameOld' exists."
        exit 1
    }

    if ($choco -and -not $newTask) {
        Write-Output "Chocolatey is installed but new task '$taskNameNew' is missing."
        exit 1
    }

    Write-Output "Chocolatey not installed or required scheduled task already exists."
    exit 0
}
catch {
    Write-Error "Unexpected error: $($_.Exception.Message)"
    exit 1
}