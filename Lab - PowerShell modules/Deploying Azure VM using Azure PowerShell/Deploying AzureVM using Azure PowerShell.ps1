# Deploy an Azure Virtual Machine by Using Azure PowerShell [Guided]

New-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $VMName -Location "East US" -VirtualNetworkName "VNet1" -SubnetName "Subnet1-22851719" -Size "Standard_D3_v2" -SecurityGroupName "SG1-22851719"

# Get Public IP of $VMName
# 20.127.111.8
Get-AzureRmPublicIpAddress -Name PIP1-22851719 -ResourceGroupName "AZ300-RGlod22851719"


mstsc /v:20.127.111.8

# Install an IIS web server on a Windows VM in Azure
Install-WindowsFeature -Name Web-Server -IncludeManagementTools 

# Close the RDP connection to WinRM

# In a browser on your local computer, display the IIS Welcome page of the new web server hosted on WinVM by using the IP address http://20.127.111.8.

# Because IIS is installed and port 80 is open to allow traffic from the internet, you can view the default IIS Welcome page by using the public IP address of WinVM.

