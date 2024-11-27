# Display a list of local groups where it contains Admin:
Get-LocalGroup *Admin*

Get-LocalGroup | Where-Object Name -Like *Admin*

# Display a list of running services:
Get-Service | Where-Object Status -eq Running

# Display all processes having a Working Set (WS) greater than 50MB:
Get-Process | Where WS -gt 50mb

# Return a list of all installed roles & features:
Get-WindowsFeature | Where-Object Installed

# Display a list of all processes where the company property contains
# Microsoft, then display a table that contains PM, ID, Company, Name Properties:
Get-Process | Where-Object Company -like *Microsoft* | Format-List PM,ID,Company,Name

# # Display a list of all processes where the company property NOT contains
# Microsoft, then display a table that contains PM, ID, Company, Name Properties:
Get-Process | Where-Object Company -NotLike *Microsoft* | Format-List PM,ID,Company,Name

# Display a list of local groups where Name contains Admin
Get-LocalGroup | Where-Object {$_.Name -like "*Admin*"}

# Display a list of SVCHost processes that have a paged memory value greater than 5MB, 
# sorted by paged memory in descending order:
Get-Process | Where-Object {$_.Name -eq "SVCHost" -and $_.PM -gt 5mb} | Sort-Object -Property PM -Descending

# Identify the process ID of the SVCHost that has Largest Paged Memory value, 
# then record the process ID in the text box on the main instructions page:

# Display the services that contain the Process ID <SVCHost>:
Get-WmiObject Win32_Service | Where-Object {$_.ProcessID -eq <SVCHost_ID>}

Get-WmiObject Win32_Service | Where-Object {$_.ProcessID -eq 844}

# Display a list of System EventLog errors that have a source that contains 
# the keyword service:
Get-EventLog System | Where-Object {$_.EntryType -eq "Error" -and $_.Source -like "*Service*"}

# Display a list of file in C:\Windows\System32 containing "Windows" or
# "Microsoft" in their file name, that have .DLL extension and have a file 
# size greater than 1MB:
Get-ChildItem C:\Windows\System32 | Where-Object {($_.Name -like "*Windows*" -or $_.Name -like "*Microsoft*")`
 -and $_.Extension -eq ".dll" -and $_.Length -gt 1mb}

 # Return services that are Stopped and that contain the word "Print" in their DisplayName, 
 # and then send the services to a command that will start them:
 Get-Service | Where-Object {$_.DisplayName -like "*Print*"}

 Get-Service | Where-Object {$_.DisplayName -like "*Print*" -and $_.Status -eq "Stopped"}

Get-Service | Where-Object {$_.DisplayName -like "*Print*" -and $_.Status -eq "Stopped"} | Start-Service

Get-Service | Where-Object {$_.DisplayName -like "*Print*"}

