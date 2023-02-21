$PROFILE_ALL_USERS_SETTINGS_PATH = "$env:PROGRAMDATA\WindowsTerminal\settings.json"

# Check if settings.json exists in ProgramData
if (-not(Test-Path $PROFILE_ALL_USERS_SETTINGS_PATH)) {
    exit 1618
}

Write-Host "Found $PROFILE_ALL_USERS_SETTINGS_PATH"
exit 0
