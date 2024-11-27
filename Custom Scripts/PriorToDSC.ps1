#Examining System Configuration Prior to DSC

#Server Manager

#Add Roles and Features Wizard

#Server Selection 

#have to configure ASP, IIS

#Install Windows Feature on Web Server

function SetupWindowsFeature ([string]$serverName, [string]$featureName) {
Write-Host "Checking for $featureName on $serverName"
$feature = Get-WindowsFeature -ComputerName $serverName -Name $featureName

if ($feature.InstallState -eq "Available") {
    Write-Host "'trole not found, adding..."
    $installState = Install-WindowsFeature -ComputerName $serverName -Name $featureName

    if ($installState.RestartNeeded) {
        Write-Host "'tRestart required, restarting $serverName..."
        Restart-Computer -ComputerName $serverName -Wait
    } 
    else
    {
    Write-Host "tRestart not required for $serverName"
    }
    }
}

#To stop a website remotely

function StopDefaultWebsiteRemotely ([string]$serverName) {
    
    Write-Host "Stopping default website on $serverName..."

    $scriptToExecute = {
        $websitename = "Default Web Site"
        if ((Get-WebsiteState -Name $websitename).Value -eq "Started")
        {
            Stop-Website $websitename
        }
    }

    Invoke-Command -ComputerName $serverName -ScriptBlock $scriptToExecute
}

#To create a website remotely

function CreateNewWebsiteRemotely ([string]$servername) {
    
    Write-Host "Creating new website on $serverName..."

    $scriptToExecute = {
        $websitename = "My website"
        $website = Get-Website -Name $websitename
        if ($website -eq $null) {
            New-Website -Name $websitename -PhysicalPath "C:\inetpub\wwwroot\website1" -Port 1234
        } else {
            "`tWebsite found already on $serverName, skipping"
        }
    }
}

#Setup Server to Host a Website
function SetupServerToHostWebsite ([string]$serverName) {
    
    #Install IIS Role
    SetupWindowsFeature $serverName Web-Server

    #Install ASP .Net Role
    SetupWindowsFeature $serverName Web-Asp-Net45

    #Stop default website
    StopDefaultWebsiteRemotely $serverName

    #Copy Website Contents
    Copy-Item -Path "\\DC11\dropfolder\*" -Destination "\\$serverName\c$\inetpub\wwwroot\website1" -Recurse

    #Create website
    CreateNewWebsiteRemotely $serverName
}

