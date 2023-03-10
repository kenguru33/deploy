$packageName = "terminal-settings"
$logPath = "c:\RS-MEM\$packageName-install.log"
Start-Transcript -Path $logPath -Force
    
$PROFILE_ALL_USERS_SETTINGS_PATH = "$env:PROGRAMDATA\WindowsTerminal\settings.json"
$PROFILE_CURRENT_USER_SETTINGS_LINK = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$PROFILE_CURRENT_USER_SETTINGS_PATH = "$env:OneDrive\WindowsTerminal\settings.json"

# Copy settings.json to ProgramData
$directory = Split-Path -Path $PROFILE_ALL_USERS_SETTINGS_PATH -Parent
if (-not(Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory -Force
}
Copy-Item -Path "$PSScriptRoot\settings.json" -Destination $PROFILE_ALL_USERS_SETTINGS_PATH -Force

if (Test-Path $PROFILE_CURRENT_USER_SETTINGS_PATH) {
    New-Item -ItemType SymbolicLink -Path $PROFILE_CURRENT_USER_SETTINGS_LINK -Value $PROFILE_CURRENT_USER_SETTINGS_PATH -Force
}
else {
    New-Item -ItemType SymbolicLink -Path $PROFILE_CURRENT_USER_SETTINGS_LINK -Value $PROFILE_ALL_USERS_SETTINGS_PATH -Force
}

# Copy 10-terminal-settings.ps1 to loginscript
$loginScript = "$env:PROGRAMDATA/rs-login/10-terminal-settings.ps1"
$directory = Split-Path -Path "$loginScript" -Parent
Copy-Item -Path "$PSScriptRoot/10-terminal-settings.ps1" -Destination $loginScript -Force
Stop-Transcript
