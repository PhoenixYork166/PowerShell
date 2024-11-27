# Save the script in C:\Class using the name Maintenance.ps1:

@"

<# Maintenance.ps1 #>

param (
    [string[]]$ComputerName=$env:COMPUTERNAME
    )

md C:\Logs -ErrorAction SilentlyContinue | Out-Null
foreach ($Computer in $ComputerName) {
    dir C:\*.tmp -Recurse -ErrorAction SilentlyContinue |
        Remove-Item -Recurse -ErrorAction SilentlyContinue
    
    Write-Host "Finished removing temp files on $Computer"

    Get-EventLog -LogName System -Message *error* |
        Out-File -FilePath "C:\Logs\$Computer-Events.log"

    Write-Host "Finished finding Events on $Computer"

    Get-Service | Where-Object {$_.Name -like "*win*" -and $_.Status -eq "Running"} |
        Out-File -FilePath "C:\Logs\$Computer-Services.log"

    Write-Host "Finished finding services on $Computer"
}



"@


@"
<# MaintenanceWF.ps1#>

Workflow MaintenanceWF {
    sequence {
        inlinescript {
            md C:\Logs -ErrorAction SilentlyContinue | Out-Null
        }

        parallel {
            
            sequence {
                dir C:\*.tmp -Recurse -ErrorAction SilentlyContinue
                    Remove-Item -Recurse -ErrorAction SilentlyContinue
                inlinescript {Write-Host "Finished removing temp files on $($env:COMPUTERNAME)"}
            }
            
            sequence {
                Get-EventLog -LogName System -Message *error* |
                    Out-File -FilePath "C:\Logs\$($env:COMPUTERNAME)-Events.log"
                inlinescript {Write-Host "Finished finding events on $($env:COMPUTERNAME)"}
            }

            sequence {
                Get-Service | Where-Object {$_.Name -like "*win*" -and $_.Status -eq "Running"} |
                    Out-File -FilePath "C:\Logs\$($env:COMPUTERNAME)-Services.log"
                inlinescript {Write-Host "Finished finding services on $($env:COMPUTERNAME)"}
            }
        }
    }
}

# Run the workflow against the LabVM computer:
MaintenanceWF -PSComputerName LabVM



"@
