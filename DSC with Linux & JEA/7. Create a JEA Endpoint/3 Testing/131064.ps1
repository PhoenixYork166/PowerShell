#<#131064.ps1#>
# To install xJea DSC resources module
Install-Module xJEA

# Use this to check EndPoints
#After creating a DemoEP1 EndPoint
Get-PSSessionConfiguration


Enter-PSSession -ComputerName localhost -ConfigurationName Demo1EP

Stop-Process -Name notepad

Stop-Process -Name ServerManager

Exit-PSSession -ComputerName localhost

#C:\Program Files\WindowsPowerShell\Modules\xJea\0.2.16.6\Examples
#Find Demo1.ps1 & SetupJea.ps1

