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


If ($null -eq (Get-AppxPackage -Name MicrosoftTeams -AllUsers)) {
    log "Microsoft Teams Personal App not present"
}
Else {
    Try {
        If (Get-Process msteams -ErrorAction SilentlyContinue) {
            Try {
                log "Stopping Microsoft Teams Personal app process"
                Stop-Process msteams -Force
                log "Teams Personal app process stopped"
            }
            catch {
                log "Unable to stop process, trying to remove anyway"
            }
           
        }
        Get-AppxPackage -Name MicrosoftTeams -AllUsers | Remove-AppPackage -AllUsers
        log "Microsoft Teams Personal App removed successfully"
    }
    catch {
        log "Error removing Microsoft Teams Personal App"
    }
}