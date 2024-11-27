#<#SetupJea.ps1#>

Configuration SetupJea
{
    Import-DscResource -ModuleName xjea
    Node localhost
    {
        xJeaEndPoint CleanAll
        {
            Name     = 'CleanALL'
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
