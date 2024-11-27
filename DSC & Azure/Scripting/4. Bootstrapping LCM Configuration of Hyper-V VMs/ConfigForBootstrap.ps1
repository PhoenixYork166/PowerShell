#Bootstrapping LCM Configuration of Hyper-V VMs
#<#ConfigForBootstrap.ps1#>

Configuration IISInstall
{

    Import-DscResource -ModuleName 'PSDesiredStateConfiguration'

    node ('localhost')

    {
        WindowsFeature IIS
        {
            Ensure = 'Present'
            Name   = 'Web-Server'
        }
    }
}

#Generate a local host .mof file
IISInstall
