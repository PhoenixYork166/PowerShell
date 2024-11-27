#Cim Session
#<#CimSession.ps1#>

$node = "CentOS.earthfarm.com"
$Credentials = Get-Credential -UserName:"Root" -Message:"Root Password Please:"

$opt = New-CimSessionOption -UseSsl:$true -SkipCACheck:$true -SkipCNCheck:$true -SkipRevocationCheck:$true
$sess = New-CimSession -Credential $Credentials -ComputerName: $node -Port:5986 -Authentication:basic -SessionOption:$opt -OperationTimeoutSec:90

#Id: 3
#Name: CimSession3
#InstanceId: 
#ComputerName: CentOS.earthfarm.com
#Protocol: WSMAN

#PowerShell
#Start-DscConfiguration -Path:"C:\temp" -CimSession:$Sess -Wait -Verbose

#Linux Terminal
#sudo ./GetDscConfiguration.py
