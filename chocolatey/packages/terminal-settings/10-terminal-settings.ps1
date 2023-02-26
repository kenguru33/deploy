$PROFILE_ALL_USERS_SETTINGS_PATH = "$env:PROGRAMDATA\WindowsTerminal\settings.json"
$PROFILE_CURRENT_USER_SETTINGS_LINK = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$PROFILE_CURRENT_USER_SETTINGS_PATH = "$env:OneDrive\WindowsTerminal\settings.json"

$currentUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if ($currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Get directory of current user settings file
    $PROFILE_CURRENT_USER_SETTINGS_DIRECTORY = Split-Path $PROFILE_CURRENT_USER_SETTINGS_PATH -Parent

    # Create directory for current user settings if it doesn't exist
    if (!(Test-Path $PROFILE_CURRENT_USER_SETTINGS_DIRECTORY)) {
        New-Item -ItemType Directory -Path $PROFILE_CURRENT_USER_SETTINGS_DIRECTORY -Force
    }

    attrib +h "$PROFILE_CURRENT_USER_SETTINGS_DIRECTORY"

    # Copy all users settings to current user settings if it doesn't exist
    if (!(Test-Path $PROFILE_CURRENT_USER_SETTINGS_PATH)) {
        Copy-Item -Path $PROFILE_ALL_USERS_SETTINGS_PATH -Destination $PROFILE_CURRENT_USER_SETTINGS_PATH -Force
    }

    # Link all users settings to all users settings if current user settings doesn't exist
    if (!(Test-Path $PROFILE_CURRENT_USER_SETTINGS_PATH)) {
        New-Item -ItemType SymbolicLink -Path $PROFILE_CURRENT_USER_SETTINGS_LINK -Value $PROFILE_ALL_USERS_SETTINGS_PATH -Force
    }
    else {
        # Link current user settings to current user settings link
        New-Item -ItemType SymbolicLink -Path $PROFILE_CURRENT_USER_SETTINGS_LINK -Value $PROFILE_CURRENT_USER_SETTINGS_PATH -Force
    }
}
else {
    if (!(Test-Path $PROFILE_CURRENT_USER_SETTINGS_PATH)) {
        Copy-Item -Path $PROFILE_ALL_USERS_SETTINGS_PATH -Destination $PROFILE_CURRENT_USER_SETTINGS_LINK -Force
    }
    else {
        # Link current user settings to current user settings link
        Copy-Item -Path $PROFILE_CURRENT_USER_SETTINGS_PATH -Destination $PROFILE_CURRENT_USER_SETTINGS_LINK -Force
    }
}



