$softwareName = "uniFLOW SmartClient"
$productCode = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like $softwareName } | Select-Object -ExpandProperty IdentifyingNumber

if ($productCode) {
    Start-Process -Wait -FilePath msiexec.exe -ArgumentList "/x $productCode /qn"
} else {
    Write-Host "$softwareName is not installed."
}