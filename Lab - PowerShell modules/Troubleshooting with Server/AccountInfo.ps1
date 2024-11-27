&{
Get-LocalGroupMember -Group "Administrators"

Write-Output "Administrators Info:"
Get-CimInstance Win32_OperatingSystem | Select-Object -Property *users*



} > C:\AccountInfo.txt