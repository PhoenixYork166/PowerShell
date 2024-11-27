Get-Help -verb about_*

Get-Service |`
Where {$_.Status -eq "Stopped"}

Get-Service | where {$_.name -like "bits"}

