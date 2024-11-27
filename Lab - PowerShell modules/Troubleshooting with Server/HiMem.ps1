$ComputerName = "LabVM"
$NumItems = 10
$ReportFile = "C:\Class\Top10Mem.txt"

$ReportData = Get-Process -ComputerName $ComputerName | Sort-Object -Property WS -Descending | Select-Object -First $NumItems

if ($ReportFile) {
    $ReportData | Out-File -FilePath $ReportFile
} else {
    Write-Output $ReportFile
}
