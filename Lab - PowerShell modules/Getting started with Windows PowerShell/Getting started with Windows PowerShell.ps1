<# Getting started with Windows PowerShell#>

# Create a local user account named tempuser, and then when prompted, 
# enter Passw0rd! as the pw:
New-LocalUser -Name tempuser -Password (Read-Host "Enter Password" -AsSecureString)

# Assign the value Temporary User to the description of the tempuser user account:
Set-LocalUser -Name tempuser -Description "Temporary User"

# Display the local user accounts:
Get-LocalUser





# Set the TLS level:
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Create a virtual NIC for testing:
Install-Module -Name LoopbackAdapter -Force

# Install Chocolatey:
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Create a loopback adapter named LabNet1:
New-LoopbackAdapter -Name "LabNet1" 


# Configure an IP address of 10.10.10.5, a subnet mask of 255.255.255.0, 
# and a default gateway of 10.10.10.1 on the virtual NIC:
New-NetIPAddress -InterfaceAlias LabNet1 -IPAddress 10.10.10.5 -PrefixLength 24 -DefaultGateway 10.10.10.1

# Configure a DNS server IP address of 8.8.8.8 on the virtual NIC:
Set-DnsClientServerAddress -InterfaceAlias LabNet1 -ServerAddresses 8.8.8.8

# Display the LabNet1 configuration:
Get-NetIPConfiguration -InterfaceAlias LabNet1






# Display system services sorted by status and then by name:
Get-Service | Sort-Object -Property Status,Name

# Write a list of services to a comma-separated values (CSV) file named C:\Class\AllServices:
Get-Service | Export-Csv -Path C:\Class\AllServices.csv

# Display the .exe files in C:\Windows\System32 in descending order by size:
dir C:\Windows\System32\*.exe | Sort-Object -Property Length -Descending 

# Display the 10 processes that consume the most resources, sorted in descending order:
Get-Process | Sort-Object -Property WS -Descending | Select-Object -First 10

# Display all local groups that contain the Admin account:
Get-LocalGroup | Where-Object Name -Like *Admin*

# Display all installed Windows roles and features:
Get-WindowsFeature | Where-Object Installed





# Using variables in PowerShell

# launch a Notepad.exe
notepad

# Stop Notepad.exe
Get-Process Notepad | ForEach-Object Kill

# Notepad.exe again
Notepad

# Switch to Windows PowerShell window, and then run the following command to stop Notepad
# by using standard PowerShell syntax:
Get-Process Notepad | ForEach-Object {$_.Kill()}



# Declaringa variable

# Display PowerShell variables:
dir env:

# Display the values of the following variables:
$PSVersionTable

$HOME

$PSHOME

$True

$false

# Call the values of:
$env:SystemDrive

$env:USERNAME

# Declare a PowerShell cmdlet as a variable:
$VarOne = (Get-Date)

$VarOne




# Creating an array

$Servers = "LabVM","Atlanta-DC","Boston-SVR","Chicago-SVR","Denver-SVR"

$Servers

# Create a .txt file for the Servers
$Servers | Out-File -FilePath C:\Class\Servers.txt

# Open the .txt using Notepad
notepad C:\Class\Servers.txt

# Save the changes to C:\Class\Servers.txt, and then close Notepad:

# Populate the $Servers array by using content of C:\Class\Servers.txt
$Servers = Get-Content C:\Class\Servers.txt 

# Call $Servers array
$Servers




# Managing PowerShell jobs

# Start a background job to collect service information:
Start-Job -Name SVCList {Get-Service} 

# Display the current jobs:
Get-Job

# Create a script named C:\Class\UserScript.ps1:
Notepad

# In Notepad, enter:
New-LocalUser -Name "TestUser" -Description "Test User Account" -NoPassword

# Save the script as C:\Class\UserScript.ps1, and then close Notepad

# Set a trigger:
$Trigger = New-ScheduledTaskTrigger -At 10:00am -Daily

# Specify the account credentials to run the script:
$User = "NT AUTHORITY\SYSTEM"

# Specify which program to run:
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "C:\Class\UserScript.ps1"

# Schedule the task and to name the task CreateUser:
Register-ScheduledTask -TaskName "CreateUser" -Trigger $Trigger -User $User -Action -RunLevel Highest -Force

# Confirm that task is scheduled:
Get-ScheduledTask | Where-Object TaskName -eq "CreateUser"

# To confirm that the account was created:
Get-LocalUser

