$packageName = "powershell-profile"
$scriptName = $MyInvocation.MyCommand.Name

$logPath = "c:\RS_MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force

function log {
  param($message)
  $msg = "{0} {1}" -f (Get-TimeStamp), "$message ($scriptName)"
  Write-Host $msg 
}

function Get-TimeStamp {
  return "[{0:MM/dd/yy} {0:HH:mm:ss}]" -f (Get-Date)
}

$PS_profile = "$env:USERPROFILE\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"

if (-not(Test-Path $PS_profile)) {
    New-Item -Path $PS_profile -ItemType File -Force
    Add-Content $PS_profile -Value "# Generated by install-choco.ps1"
  }
  
  if ((Get-Content $PS_profile -Raw).Length -eq 0) {
    Add-Content $PS_profile -Value "Generated by install-choco.ps1"
  }
  
  if(-not((Get-Content $PS_profile -Raw).Contains("Invoke-Expression (&starship init powershell)"))) {
    Write-Host "Adding Starship to PowerShell profile"
    Add-Content $PS_profile -Value "`n# Load Starship prompt"
    Add-Content $PS_profile -Value "Invoke-Expression (&starship init powershell)"
  }
  
  if (-not((Get-Content $PS_profile -Raw).Contains("(& volta completions powershell) | Out-String | Invoke-Expression"))) {
    Write-Host "Adding Volta completions to PowerShell profile"
    Add-Content $PS_profile -Value "`n# Volta completions"
    Add-Content $PS_profile -Value "if (Get-Command volta -ErrorAction SilentlyContinue){(& volta completions powershell) | Out-String | Invoke-Expression}"
  }
  
  # This only applies to PowerShell 7 and later
  if (-not((Get-Content $PS_profile -Raw).Contains("`$PSStyle.FileInfo.Directory = `"``e[34m`""))) {
    Write-Host "Adding PSStyle to PowerShell profile"
    Add-Content $PS_profile -Value "`n# Fix background color for directory names in PowerShell 7"
    Add-Content $PS_profile -Value "if (`$Host.Version.Major -ge 7) {`$PSStyle.FileInfo.Directory = `"``e[34m`"}"
  }
  
  $PS_profile = "$env:USERPROFILE\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

  if (-not(Test-Path $PS_profile)) {
    New-Item -Path $PS_profile -ItemType File -Force
    Add-Content $PS_profile -Value "# Generated by install-choco.ps1"
  }
  
  if ((Get-Content $PS_profile -Raw).Length -eq 0) {
    Add-Content $PS_profile -Value "Generated by install-choco.ps1"
  }
  
  if(-not((Get-Content $PS_profile -Raw).Contains("Invoke-Expression (&starship init powershell)"))) {
    Write-Host "Adding Starship to PowerShell profile"
    Add-Content $PS_profile -Value "`n# Load Starship prompt"
    Add-Content $PS_profile -Value "Invoke-Expression (&starship init powershell)"
  }
  
  if (-not((Get-Content $PS_profile -Raw).Contains("(& volta completions powershell) | Out-String | Invoke-Expression"))) {
    Write-Host "Adding Volta completions to PowerShell profile"
    Add-Content $PS_profile -Value "`n# Volta completions"
    Add-Content $PS_profile -Value "if (Get-Command volta -ErrorAction SilentlyContinue){(& volta completions powershell) | Out-String | Invoke-Expression}"
  }
  
  # This only applies to PowerShell 7 and later
  if (-not((Get-Content $PS_profile -Raw).Contains("`$PSStyle.FileInfo.Directory = `"``e[34m`""))) {
    Write-Host "Adding PSStyle to PowerShell profile"
    Add-Content $PS_profile -Value "`n# Fix background color for directory names in PowerShell 7"
    Add-Content $PS_profile -Value "if (`$Host.Version.Major -ge 7) {`$PSStyle.FileInfo.Directory = `"``e[34m`"}"
  }

  # Create Symlink to profile.json
  $profile_json = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
  $profile_json_link = "$env:USERPROFILE\Documents\WindowsTerminal\settings.json"
  if (-not(Test-Path $profile_json_link)) {
    New-Item -ItemType File -Path $profile_json_link -Force
    Copy-Item -Path .\powershell-profile -Destination $profile_json_link 
  }

  New-Item -ItemType SymbolicLink -Path $profile_json -Value $profile_json_link -Force

log "Generated PowerShell profiles"

Stop-Transcript