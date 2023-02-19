$PS7_PROFILE_PATH = "c:\Program Files\PowerShell\7\profile.ps1"
$PS5_PROFILE_PATH = "c:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1"

if (-not(Test-Path $PS7_PROFILE_PATH)) {
  exit 1618  
}

if (-not(Test-Path $PS5_PROFILE_PATH)) {
  exit 1618  
}

Write-Host "Found $PS7_PROFILE_PATH and $PS5_PROFILE_PATH"
exit 0




