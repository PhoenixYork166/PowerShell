
Get-Process | Export-Csv -Path C:\processes.csv
Get-Service | Export-Csv -Path C:\services.csv
Get-WindowsFeature | Export-Csv -Path C:\roles.csv

Get-NetIPConfiguration | ConvertTo-HTML > C:\network.html

# Create an HTML file named D:\events.html that contains the five most recent Event Viewer System log file entries by using the Get-EventLog and the ConvertTo-HTML cmdlet.
Get-EventLog -LogName System -Newest 5 | ConvertTo-html > C:\events.html

# Create a CSV file named D:\ADusers.csv that contains a list of Active Directory® user accounts by using the Get-ADUser Windows PowerShell cmdlet.
Get-ADUser -Filter * | Export-Csv -Path C:\ADusers.csv




