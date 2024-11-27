# Getting Azure VM size
Get-AzureRMVMSize -ResourceGroup $ResoureGroupName -VMName $VMName


$VM = Get-AzureRMVM -ResourceGroup $ResourceGroupName -VMName $VMName

$Size = "Standard_D2_v2"

$VM.HardwareProfile.VMSize = $Size

Update-AzureRMVm -VM $VM -ResourceGroupName $ResoureGroupName


