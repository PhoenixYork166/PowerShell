Configuration MyConfig
{
    Node localhost {
    Service myBitsSvc
        {
        Name = "BITS"
        State = "Running"
        StartupType = "Automatic"
        }
       }
}

MyConfig

Ise ".\MyConfig\localhost.mof"
$path = "C:\DSC\119521\MyConfig\localhost.mof"

ise $path

Get-Service -Name "BITS" -ComputerName localhost

Start-DscConfiguration -Path "C:\DSC\119521\MyConfig" -Wait -Verbose -ComputerName localhost -Force
