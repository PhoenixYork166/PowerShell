@"
<# SystemReport.ps1#>

# Creating HTML report

if (-not (Test-Path "C:\Class")) {
    md "C:\Class" | Out-Null
    }

param (
    [string[]]$ComputerName = $env:COMPUTERNAME,
    [string]$ReportFolder="C:\Reports"
    )

# Create a $ReportFolder path if folder does not exist
if (-not (Test-Path $ReportFolder)) {
    md $ReportFolder | Out-Null
    }

# To handle multiple computer names, retrieve running services from the 
# current computer, output only the Name, StartType, and DisplayName
# properties, and then outpout the HTML file to $ReportFolder by 
# using the text SystemReport and the name of the current computer:
foreach ($Computer in $ComputerName) {
    Get-Service | Where-Object {$_.Status -eq "Running"} |
    ConvertTo-Html -Property Name,StartType,DisplayName | 
    Out-File "$ReportFolder\SystemReport-$Computer.htm"
    }


# Convert the XML data from C:\Class\LocalUsers.xml into 
# a Windows PowerShell XML variable named $XMLTest:
[xml]$XMLTest = Get-Content C:\Class\LocalUsers.xml 

# Display all of the account nodes in the XMLTest variable:
$XMLTest.webaccounts.account

# Display the title of the first account
$XMLTest.webaccounts.account[0].title

# To create a string parameter named $Path:
Param (
    [string]$Path
    )

    [xml]$XMLData = Get-Content -Path $Path

    # To loop through the items in the $XMLData array:
    foreach ($Item in $XMLData.webaccounts.account) {
    $Name = $Item.first + $Item.last
    $FullName = $Item.first + " " + $Item.last
    $Description = "Address: " + $Item.address + " - Phone: " + $Item.phone
    $Password = "Pa55w.rd" | ConvertTo-SecureString -AsPlainText -Force
    New-LocalUser -Name $Name -FullName $FullName -Description $Description -Password $Password
    }

# Execute the script
.\ImportLocalAccounts.ps1 -Path C:\Class\LocalUsers.xml

# Verify that the user accounts were created:
Get-LocalUser

<# SystemReport.ps1#>

"@

@"

<#GetIP.ps1#>
# Creating a custom error message and user breakpoints

param (
    [string[]]$ComputerName = $env:COMPUTERNAME,
    [switch]$LogErrors,
    [string]$LogFile="C:\Logs\Error.log"
    )

md (Split-Path $LogFile) | Out-Null

# md (Split-Path $LogFile) -ErrorAction SilentlyContinue | Out-Null 

foreach ($Computer in $ComputerName) {
    Get-NetIPAddress |
        Select-Object IPAddress
    }

$Error | Out-File $LogFile

"@

@"

# Using breakpoints to analyze and debug a script

# Create a folder named UpTime in C:\Program Files\WindowsPowerShell\Modules:

New-Item -Path "C:\Program Files\WindowsPowerShell\Modules" -Name "UpTime" -ItemType "directory" 

# Create a new script, and then save the script as C:\Program Files\WindowsPowerShell\Modules\UpTime\UpTime.ps1

Function Get-UpTime {
    Param (
        [string[]]$ComputerName = "."
        )
    foreach ($Computer in $ComputerName) {
        $os = Get-WmiObject win32_OperatingSystem -ComputerName $Computer
        $LastBoot = $os.ConvertToDateTime($os.lastbootuptime)
        $UpTime = (Get-Date) - $LastBoot
        $UpTimeObj = New-Object PSObject -Property @{ComputerName=$Computer;Days=$UpTime.Days;Hours=$UpTime.Hours;Minutes=$UpTime.Minutes}
        
    Write-Output $UpTimeObj
    }
}

# Run the command to execute the Get-UpTime cmdlet by using the computer name LabVM:
Get-UpTime -ComputerName LabVM

# Change $LastBoot to $

"@

@"

# Implementing a PowerShell workflow

<# Info.ps1 #>
<# in C:\Class\ #>

param (
    [string[]]$ComputerName = $env:COMPUTER
    )

md C:\Logs -ErrorAction SilentlyContinue | Out-Null

foreach ($Computer in $ComputerName) {
    Get-WindowsFeature |
        Out-File -FilePath "C:\Logs\$Computer-InstalledFeatures.log"
    Write-Host "Finished finding installed features on $Computer"
    Get-NetIPAddress |
        Out-File -FilePath "C:\Logs\$Computer-Network.log"
    Write-Host "Finished finding network information on $Computer"
    Get-Partition | Out-File -FilePath "C:\Logs\$Computer-Storage.log"
    Write-Host "Finished finding storage space on $Computer"
}


"@

@"

<# InfoWF.ps1 #>

<# in C:\Class\InfoWF.ps1 #>

# Create a Work Flow that will process the primary function in sequence, but
# process the the Get-WindowsFeature, Get-NetIPAddress, and Get-Partition functions 
# in parallel:

workflow MaintenanceWF {
    Sequence {
        InlineScript {
            md C:\Logs -ErrorAction SilentlyContinue | Out-Null
        }
        Parallel {
            Sequence {
                Get-WindowsFeature | 
                    Out-File -FilePath "C:\Logs\$($env:COMPUTERNAME) -InstalledFeatures.log"
                InlineScript {Write-Host "Finished finding installed features on $($env:COMPUTERNAME)"}
            Sequence {
                Get-NetIPAddress |
                    Out-File -FilePath "C:\Logs\$($env:COMPUTERNAME)-Network.log"
                InlineScript {Write-Host "Finished network information on $($env:COMPUTERNAME)"}
            Sequence {
                Get-Partition | Out-File -FilePath "C:\Logs\$($env:COMPUTERNAME)-Storage.log"
                InlineScript {Write-Host "Finished finding storage space on $($env:COMPUTERNAME)"}
            }
        }
    }
}


"@