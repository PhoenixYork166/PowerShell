# Create a DateTime object & stores the object in variable "$var"
$var = New-Object System.DateTime


# Calling constructor with parameters
$sr = New-Object System.IO.StreamReader -ArgumentList "Chapter 1 - Getting started with PowerShell"
$sr.CurrentEncoding

# In many instances, a new object will be created in order to export data or
# pass it to another commandlet
# PSObject = An ojbect w/ multiple Properties
# Key-Value Player

$newObject = New-Object -TypeName PSObject -Property @{
ComputerName = "SERVER1"
Role = "Interface"
Environment = "Production"
}

$newObject.ComputerName

# In case you already have an object, but you only need 1 or 2 properties
# Simply add that property by using Select-Object:

Get-ChildItem | Format-List

Get-ChildItem | Select-Object FullName, Name,
@{Name='DateTime';Expression={Get-Date}},
@{Name='PropertyName';Expression={'CustomValue'}} | Format-List

Get-ChildItem | Select-Object FullName, Name,
@{Name='DateTime';Expression={Get-Date}},
@{Name='PropertyName';Expression={'CustomValue'}},CreationTime,LastWriteTime | Format-List



