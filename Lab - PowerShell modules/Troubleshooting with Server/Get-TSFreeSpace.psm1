Function Get-TSFreeSpace {
  [CmdletBinding()]
  param ($ComputerName = $env:COMPUTERNAME)
  $allDisks = Get-WmiObject -ComputerName $ComputerName -Class Win32_
  LogicalDisk -Filter "DriveType='3'"
  foreach ($disk in $allDisks) {
    $results += [PSCustomObject]@{
      'ComputerName' = $disk.DeviceID
      'FreeSpace(GB)'= $([int]($disk.FreeSpace / 1GB))
      'Size(GB)'= $([int]($disk.size / 1GB))
    }
  }
  $results
}