Invoke-Expression (&starship init powershell)
if ($Host.Version.Major -ge 7) {
    $PSStyle.FileInfo.Directory = e[34m
}

