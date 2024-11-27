#<#ConfigForBootstrap2.ps1#>
#To manage to local configuration manager
#Adopting a Pull Server 

[DSCLocalConfigurationManager()]
Configuration PullClientBootstrap
{
    Node localhost
    {
        Settings
        {
            RefreshMode = 'Pull'
            RefreshFrequencyMins = 30
            RebootNodeIfNeeded = $true
        }
        ConfigurationRepositoryWeb Earthfarm-PullSrv
        {
            ServerURL = 'https://Earthfarm-PullSrv:8080/PSDSCPullServer.svc'
            RegistrationKey = '140a952b-b9d6-406b-b416-e0f759c9c0e4'
            #Setting the server to find IISInstall located in <#ConfigForBootstrap.ps1#>
            ConfigurationNames = @('IISInstall')
        }
    }
}

#Generate a localhost.meta.mof file
PullClientBootstrap

