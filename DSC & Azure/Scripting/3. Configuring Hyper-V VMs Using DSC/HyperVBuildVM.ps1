#Configuring Hyper-V VMs Using DSC
#<#HyperVBuildVM.ps1#>

Configuration BuildVM

{

    param (
        [string[]]$NodeName = 'localhost'

    )

    Import-DscResource -ModuleName xHyper-V

    node $NodeName
    {
        
        #Build a virtual harddrive for Hyper-V server
        xVHD TestServerVHDX
        {

            Ensure           = 'Present'
            Name             = 'TestServerVHDX'
            Path             = 'C:\VMs\TestServer.vhdx'
            Generation       = "vhdx"
        }

        xVMHyperV TestServer
        {
            Ensure = 'Present'
            DependsOn = '[xVHD]TestServerVHDX'
            Name = 'TestServer'
            VhdPath = 'C:\VMs\TestServer.vhdx'
            SwitchName = 'LANSwitch'
            State = 'Running'
            Path = 'C:\VMs'
            Generation = 'VHDx'
            StartupMemory = 4GB
            ProcessorCount = 2
        }
    }
}

#Run this scriptt to generate a .mof file
BuildVM