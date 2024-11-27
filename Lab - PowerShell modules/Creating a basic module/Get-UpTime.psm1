Function Get-UpTime {
    Param (
            [string[]]$ComputerName
           )

    Foreach ($Computer in $ComputerName) {
        $os = Get-WmiObject Win32_OperatingSystem -ComputerName $ComputerName
        $LastBoot = $os.ConvertToDateTime($os.lastbootuptime)
        $UpTime = (Get-Date) - $LastBoot
    

        $UpTimeObj = New-Object PSObject -Property @{ComputerName=$Computer;
                                                Days=$UpTime.Days;
                                                Hours=$UpTime.Hours;
                                                Minutes=$UpTime.Minutes}
    
    Write-Output $UpTimeObj
    }
}

Get-PSDrive -Name * | where @{'Total Size'=$_.Free/1GB+$_.Used/1GB}