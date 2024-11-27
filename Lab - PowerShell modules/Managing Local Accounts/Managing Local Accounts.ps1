# List all available modules on the system:
Get-Module -ListAvailable

# Display all of the available commands in the Microsoft.PowerShell.LocalAccounts module:
Get-Command -Module Microsoft.PowerShell.LocalAccounts

# Display the current local user accounts:
Get-LocalUser

# Create a new account for a user named LabUserOne using LabPa55w.rd1 as pw:
New-LocalUser -Name LabUserOne -Password (Read-Host "Enter Password" -AsSecureString)

# Display the local accounts again:
Get-LocalUser

# Display all of the properties of the LabUserOne account:
Get-LocalUser LabUserOne | Format-List -Property *

# Change the description property of the LabUserOne account to "This is a test lab user account: "
Set-LocalUser -Name LabUserOne -Description "This is a test lab user account"

# Display all of the properties of the LabUserOne account again:
Get-LocalUser LabUserOne | Format-List -Property *

# Creating a local group

# Display the current local groups on the system:
Get-LocalGroup

# Create a group named Lab IT Admins on the local server:
New-LocalGroup -Name "Lab IT Admins"

# Change the description of the group to Group for IT Admins:
Set-LocalGroup -Name "Lab IT Admins" -Description "Group for IT Admins"

# Display the new group and all of its properties:
Get-LocalGroup -Name "Lab IT Admins" | Format-List -Property *

# Display the members of the Lab IT Admins Group:
Get-LocalGroupMember -Name "Lab IT Admins"

# Add LabUserOne to the "Lab IT Admins" group:
Add-LocalGroupMember -Name "Lab IT Admins" -Member LabUserOne

# Display the members of the group again:
Get-LocalGroupMember -Name "Lab IT Admins"

