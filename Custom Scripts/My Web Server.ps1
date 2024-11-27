#Working with Local Dependencies

Configuration MyWebServer
{
    param
    (
    [string[]]$NodeName = "localhost",
    [parameter(mandatory)]
    [ValidateNotNullorEmpty()]
    [String[]]$WebSiteName,

    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [String]$SourcePath,

    [Parameter(Mandatory)]
    [ValidateNotNullorEmpty()]
    [String]$Destinationpath
    )

    Node $NodeName
    {
        windowsFeature IIS
        {
            Ensure = "Present"
            Name = "Web-Server"
        }

        WindowsFeature AspNet45
        {
            Ensure = "Present"
            Name = "Web-Asp-Net45"
        }

        File WebContent
        {
            Ensure = "Present"
            SourcePath = $SourcePath
            DestinationPath = $Desi
            Recurse = $true
            Type = "Directory"

            xWebsite NewWebsite
            {
                Ensure = "Present"
                Name = "Started"
                PhysicalPath = $Destinationpath
                BindingInfo = MSFT_xWebBindingInfomation
                    {
                    Port = 1234
                    }
            }
        }
    }
}

Start-Process iexplorer.exe http://localhost:80