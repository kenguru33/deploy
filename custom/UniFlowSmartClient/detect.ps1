$softwareName = "uniFLOW SmartClient"
$regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
$installed = Get-ItemProperty -Path $regPath | Where-Object { $_.DisplayName -like $softwareName }

if ($installed) {
    Write-Host "$softwareName is installed."
    exit 0
} else {
    Write-Host "$softwareName is NOT installed."
    exit 1618
}
