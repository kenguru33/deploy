# Remove always on vpn connections
Write-Information "Checking VPN connections configuration" 
try {
    Get-VpnConnection -ErrorAction stop
} catch {
    Write-Warning "Remove faulty vpn configuration" 
    rasdial /disconnect 
    Remove-VpnConnection -Name "RS AlwaysOn VPN" -Force
}   

