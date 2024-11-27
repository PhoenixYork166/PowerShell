# Manage Network Settings by Using Windows PowerShell [Guided]

# Open Windows PowerShell as an administrator, 
# and the run the following command to ensure you use TLS version 1.2 
# to download packages from NuGet.org.

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

# Display all of the modules that contain network-related commands:
Get-Module net* -ListAvailable

# Display all of the available commands in the NetAdapter module:
Get-Command -Module NetAdapter

# Review the list of all network-related modules, 
# and then locate the module that contains TCPIP commands, 
# NetTCPIP
Get-Command -Module NetTCPIP

# Prepare a loopback adapter for testing on the VM:
Install-Module -Name LoopbackAdapter -Force

# Prompted, enter Y
New-LoopbackAdapter -Name "LabNet1"

# Prompted, enter Y
Get-NetAdapter

Get-NetAdapter -Name LabNet1 | Format-List -Property *

# Review ifIndex

# Modify the IP address settings of a network adapter:

# Display the IP address details for LabNet1:
Get-NetIPConfiguration -InterfaceAlias LabNet1

# Set a static IP address of 10.0.1.51 & a default gateway of 10.0.1.1 on LabNet1:
New-NetIPAddress -InterfaceAlias LabNet1 -IPAddress 10.0.1.51 -PrefixLength 24 -DefaultGateway 10.0.1.1

# Change the primary DNS address on LabNet1 to 10.0.0.1:
Set-DnsClientServerAddress -InterfaceAlias LabNet1 -ServerAddresses 10.0.0.1

# Display the IP address details for LabNet1 again:
Get-NetIPConfiguration -InterfaceAlias LabNet1

# Display the current DNS suffix search list:
Get-DnsClientGlobalSetting

# To add microsoft.com, bing.com and hotmail.com to the DNS suffix search list:
Set-DnsClientGlobalSetting -SuffixSearchList "microsoft.com","bing.com","hotmail.com"

# Display current DNS suffix search list again:
Get-DnsClientGlobalSetting

# Use NSLookup to test the single-label name www:
NSLookup www

# To test single-label name aka:
NSLookup aka

# To test single-label name pop:
NSLookup pop

# To test the single-label name mail:
NSLookup mail





