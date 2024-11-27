Configuration WebServerConfiguration
{
  Node "localhost"
  {
    WindowsFeature WebServer
    {
    Name = "Web-Server"
    Ensure = "Present"
    }
    WindowsFeature ManagementTools
    {
    Name = "Web-Mgmt-Tools"
    Ensure = "Present"
    }
    WindowsFeature DefaultDoc
    {
    Name = "Web-Default-Doc"
    Ensure = "Present"
    }
  }
}

$path = "D:\WebServerConfiguration"

WebServerConfiguration -OutputPath $path

Start-DscConfiguration -Path $path -Verbose

Test-DscConfiguration -Verbose