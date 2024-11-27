function Get-LastLogon {
    
    param (
    [string[]]$user
    )

Get-ADUser -Identity $user -Properties LastLogon | Select Name, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}}

}