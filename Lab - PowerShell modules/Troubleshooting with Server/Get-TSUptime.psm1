Function Get-TSUptime {

param ($ComputerName = $env:COMPUTERNAME)
$WmiOS = Get-WmiObject Win32_OperatingSystem -ComputerName $ComputerName
[Management.ManagementDateTimeConverter]::ToDateTime($WmiOS.LastBootUpTime)
}

