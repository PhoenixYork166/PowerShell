# Determine the Install State of the Print-Server, FS-Data-Deduplication, 
# BITS, and Windows-Server-Backup features:
Get-WindowsFeature -Name Print-Server,FS-Data-Deduplication,Bits,Windows-Server-Backup

# Install the Windows Server Backup feature:
Install-WindowsFeature -Name Windows-Server-Backup -IncludeManagementTools

# Verify that the Windows Server Backup feature was successfully installed:
Get-WindowsFeature -Name Windows-Server-Backup

@"

# Create a new DSC Configuration named FileServer that accepts
# a parameter named $ComputerName, removes the Windows Server Backup
# feature, installs Print-Server, Data Deduplication, and BITS features,
# and then creates the C:\Logs folder:

Configuration FileServer {
    param (
        [string[]]$ComputerName
    )

    Node $ComputerName {
        WindowsFeature Backup {
            Name = 'Windows-Server-Backup'
            Ensure = 'Absent'
        }

        WindowsFeature PrintServer {
            Name = 'Print-Server'
            Ensure = 'Present'
        }

        WindowsFeature DataDeduplication {
            Name = 'FS-Data-Deduplication'
            Ensure = 'Present'
        }

        WindowsFeature BITS {
            Name = 'BITS'
            Ensure = 'Present'
        }

        File Logs {
            Ensure = 'Present'
            DestinationPath = 'C:\Logs'
            Type = 'Directory'
        }
    }
}

# Run the FileServer configuration to get .mof file
FileServer -OutputPath C:\FileServer -ComputerName LabVM

# View the content of C:\FileServer\LabVM.mof:
ise C:\FileServer\LabVM.mof

# Start the C:\FileServer DSC Configuration using the Wait and Verbose parameter
Start-DscConfiguration -Path C:\FileServer -Wait -Verbose

# Verify the installation state of the Print-Server,FS-Data-Deduplication,BITS, 
# and Windows-Server-Backup features:
Get-WindowsFeature -Name Print-Server,FS-Data-Deduplication,Bits,Windows-Server-Backup



"@
