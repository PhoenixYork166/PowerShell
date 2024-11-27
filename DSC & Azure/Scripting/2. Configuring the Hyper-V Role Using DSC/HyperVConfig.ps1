# Configuring the Hyper-V Role Using DSC
# <#HyperVConfig.ps1

Configuration HyperVConfig

{
    
    param (
            [string]$NodeName = 'localhost'
    )

    Import-DscResource -ModuleName xHyper-V

    node $NodeName {
        
         WindowsFeature 'Hyper-V' {

                Ensure = 'Present'

                Name   = 'Hyper-V'
        }

        WindowsFeature 'Hyper-V-PowerShell' {

                Ensure = 'Present'

                Name   = 'Hyper-V-Powershell'

        }

        File VMsDirectory

        {

            Ensure = 'Present'

            Type   = 'Directory'

            DestinationPath = "$($env:SystemDrive)\VMs"

        }

        #Create virtual networking for Hyper-V server
        xVMSwitch SandboxSwitch {

            DependsOn = '[WindowsFeature]Hyper-V'

            Name = 'SandboxSwitch'

            Ensure = 'Present'

            Type = 'Private'

        }

        xVMSwitch LANSwitch {

            DependsOn = '[WindowsFeature]Hyper-V'

            Name = 'LANSwitch'

            Ensure = 'Present'

            Type = 'External'
            
            NetAdapterName = 'Ethernet'

            AllowManagementOS = $true

        }
}

}

HyperVConfig
