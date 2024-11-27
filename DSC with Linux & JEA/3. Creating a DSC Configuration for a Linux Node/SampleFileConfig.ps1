#<#SampleFileConfig.ps1#>
Configuration SampleFileConfig
{
        Import-DscResource -Module nx
        $node = "CentOS.earthfarm.com"

    Node $node
    {
        nxFile DirectoryExample
        {
            Ensure = "present"
            DestinationPath = "/opt/mydir"
            Type = "directory"
        }

        nxfile FileExample
        {
            Ensure = "present"
            DestinationPath = "/opt/mydir/myfile"
            #Content = @"#!/bin/bash`necho "hello world" `n"@
            Content = "hello world `n"
            Mode = "777" #Full permission
            DependsOn = "[nxFile]DirectoryExample"
        }
    }
}

SampleFileConfig -OutputPath:"C:\temp"