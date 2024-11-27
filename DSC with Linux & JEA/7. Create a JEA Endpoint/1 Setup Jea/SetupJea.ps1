#<#SetupJea.ps1#>
Configuration SetupJea
{
    Import-DscResource -ModuleName xJea
    Node localhost
    {
        xJeaEndPoint CleanAll
        {
            Name     = 'CleanAll'
            CleanAll = $true
        }

        LocalConfigurationManager
        {
            RefreshFrequencyMins = 30
            ConfigurationMode    = "ApplyAndAutoCorrect"
            DebugMode            = "ForceModuleImport" #This disables provider caching
        }
    }
}

SetupJea -OutputPath C:\JeaDemo

Set-DscLocalConfigurationManager -Path C:\JeaDemo -Verbose

Start-DscConfiguration -Path C:\JeaDemo -Wait -Verbose

#EOF