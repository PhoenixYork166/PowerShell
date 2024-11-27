#Creating an Azure VM DSC Configuration
# <#TestAzureConfig.ps1#>

Configuration TestAzureConfig
{
    #A type of Web Server, instead of local host
    Node TypeWebServer
    {
        WindowsFeature IIS
        {
            Ensure = 'present'
            Name   = 'Web-Server'
            IncludeAllSubFeature = $true
        }

        File Directory
        {
            Ensure = 'present'
            Type   = 'Directory'
            DestinationPath = 'C:\inetpub\wwwroot\ErrorLog'
        }
    }
    
    Node TypeNotWebServer
    {
        WindowsFeature IIS
        {
            Ensure = 'absent'
            Name   = 'Web-Server'
        }
    }
}