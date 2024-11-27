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

FileServer