&{

Write-Output "OS Info:"
Get-CimInstance Win32_OperatingSystem

Get-CimInstance Win32_BIOS

Get-CimInstance Win32_ComputerSystem

Get-Service -DisplayName *firewall*

Get-NetFirewallProfile

Get-Service

Get-WmiObject Win32_Product

Get-WindowsFeature








} > C:\ServerInfo.txt