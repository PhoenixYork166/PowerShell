#DSC & Azure
#Partial Configuration
# <#OSConfig.ps1#>

Configuration OSConfig
{
    Param (
        [Parameter(Mandatory, 
                    HelpMessage="Domain credentials required to add SQL service account to the local Administrators group.")]
        [ValidateNotNullOrEmpty()]
        [pscredential]$Credential
        )

        Import-DscResource -ModuleName PSDesiredStateConfiguration

        #In case of collaborated development of codes consisting of 2 teams

        #To reduce conflicts of codes between the 2 teams

        #Partial Configuration allows 2 streams of development for the generation of individual .mof files

        #Then when we need to call the configurations to be applied

        #We can publish the 2 streams of configurations 

        #Then we can call for that single unit to be applied onto a local system


        Node localhost

        {
            
            #Defining an operating standard for hosting a SQL server on a local domain
            #with Windows feature .NET framework core

            WindowsFeature "NET-Framework-Core"
            {
                Ensure = "Present"
                Name = "NET-Framework-Core"
                Source = "\WindowsServer2012R2sxs"

            }

            #Windows feature compulsory for hosting a web server on local host

            WindowsFeature IIS
            {
                Ensure = 'present'
                Name = 'Web-Server'
                IncludeAllSubFeature = $true
            }

            #Active Directory settings
            Group LocalAdmins
            {
                GroupName        = 'Administrators'
                MembersToInclude = 'earthfarm\sql_service_account',
                                   'earthfarm\sqladmins'

                Ensure           = 'Present'
                Credential      = $Credential
            }
        }
}

#Executing the configuration to generate the .mof file
OSConfig