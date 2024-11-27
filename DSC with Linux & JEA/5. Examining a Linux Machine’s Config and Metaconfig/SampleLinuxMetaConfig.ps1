#<#SampleLinuxMetaConfig

[DscLocalConfigurationManager()]
Configuration SampleLinuxMetaConfig
{
    Node "mylinuxserver"
    {
        Settings
            {
            RefreshFrequencyMins = 30;
            RefreshMode = "PULL";
            ConfigurationMode = "ApplyAndMonitor";
            AllowModuleOverwrite = $true;
            RebootNodeIfNeeded = $true;
            ConfigurationModeFrequencyMins = 60;
            }

        ConfigurationRepositoryWeb ConfigurationManager
        {
            ServerURL = "https://PullServerMachine:8080/psdscpullserver.svc"
            RegistryKey = "140a952b-b9d6-406b-b416-e0f759c9c0e4"
            ConfigurationNames = @("MySQLRole")
        }
    }
}

SampleLinuxMetaConfig -OutputPath C:\temp\meta\

$Node = "CentOS.earthfarm.com"
$Credentials = Get-Credential -UserName:"root" -Message:"Enter Password:"

$opt = New-CimSessionOption -UseSsl:$true -SkipCACheck:$true -SkipCNCheck:$true -SkipRevocationCheck:$true
$Sess = New-CimSession -Credential:$Credentials -ComputerName:$Node -Port:5986 -Authentication:basic -SessionOption:$opt -OperationTimeoutSec:90

Set-DscLocalConfigurationManager -CimSession $Sess -Path c:\temp\meta -Verbose
