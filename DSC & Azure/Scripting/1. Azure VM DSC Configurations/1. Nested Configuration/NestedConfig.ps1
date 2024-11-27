#DSC & Azure:
#Nesting DSC Configurations

#<#NestedConfig.ps1#>

Configuration FileConfig
{
    param (
        [Parameter(Mandatory=$true)]
        [String] $CopyFrom,

        [Parameter(Mandatory=$true)]
        [String] $CopyTo
    )

    Import-DscResource -ModuleName PSDesiredStateConfiguration

    File FileTest
        {
            SourcePath = $CopyFrom
            DestinationPath = $CopyTo
            Ensure = 'Present'
        }

}

Configuration NestedFileConfig
{
    Node localhost
    {
        CopyFrom = 'C:\Test\TestFile.txt'
        CopyTo = 'C:\Test2'
    }


}