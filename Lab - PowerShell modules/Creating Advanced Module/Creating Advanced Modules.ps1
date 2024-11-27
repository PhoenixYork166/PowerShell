
$freed = Get-PSDrive | Select {$_.Free/1GB}

$used = Get-PSDrive | Select {$_.Used/1GB}

For ( $i = 0; $i -lt $used.length; $i++) {

$free = $freed[$i]
$use = $used[$i]
$total = $free + $use
Write-Host "$total"
Write-Host "$free"
Write-Host "$use"

}

