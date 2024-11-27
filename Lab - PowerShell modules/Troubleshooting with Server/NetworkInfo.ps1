&{

Write-Output "Network Information:"
Get-NetAdapter

Get-NetAdapterAdvancedProperty

Get-NetIPConfiguration

Write-Output "Connectivity"
Test-Connection -ComputerName Server1

Test-Connection 192.168.1.1

Test-NetConnection 192.168.1.1

Test-NetConnection -CommonTCPPort http

} > C:\NetworkInfo.txt
