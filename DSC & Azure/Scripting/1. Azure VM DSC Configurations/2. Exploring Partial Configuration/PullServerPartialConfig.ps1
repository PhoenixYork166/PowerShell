# <#PullServerPartialConfig.ps1#>
# To deploy [PartialConfiguration]OSConfig & [PartialConfiguration]SQLConfig as a whole

[DscLocalConfigurationManager()]
Configuration PartialConfigDemoConfigNames
{

    Settings
    {
        RefreshFrequencyMins           = 30;
        RefreshMode                    = "PULL";
        ConfigurationMode              = "ApplyAndAutocorrect";
        AllowModuleOverwrite           = $true;
        RebootNodeIfNeeded             = $true;
        ConfigurationModeFrequencyMins = 60;
    }
    ConfigurationRepositoryWeb Earthfarm-PullSrv
    {
        ServerURL                      = 'https://Earthfarm-PullSrv:8080/PSDSCPullServer.svc'
        RepositoryKey                  = 5b41f4e6-5e6d-45f5-8102-f2227468ef38
        ConfigurationNames             = @("OSConfig", "SQLConfig")
    }

    #Keyword PartialConfiguration to publish individual .mof files
    PartialConfiguration OSConfig
    {
        Description                    = "OSConfig"
        ConfigurationSource            = @("[ConfigurationRepositoryWeb]Earthfarm-PullSrv")
    }

    PartialConfiguration SQLConfig
    {
        Description                    = "SQLConfig"
        ConfigurationSource            = @("[ConfigurationRepositoryWeb]Earthfarm-PullSrv")
        DependsOn                      = '[PartialConfiguration]OSConfig'
    }
}
