#<#131066.ps1#>

Get-PSSessionConfiguration

Configuration Clean
{
    Import-DscResource -ModuleName xjea
    
    Node localhost
    {
        xJeaEndPoint CleanAll
        {
            Name     = "CleanAll"
            CleanAll = $true
        }

    }
}

$mofPath = "C:\dsc"

Clean -OutputPath $mofPath

Start-DscConfiguration -Path $mofPath -Wait -Verbose -Force

Get-PSSessionConfiguration
