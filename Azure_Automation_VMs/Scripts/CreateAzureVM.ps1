#<#CreateAzureVM.ps1#>

# Import the Azure PowerShell module
Import-Module -Name Az -Force -Verbose

# Connect to an Azure account
Connect-AzAccount

# Define Azure variables for a virtual machine
$vmName = "TestVM"
$resourceGroup = "TestRG"

# Create Azure credentials
$adminCredential = Get-Credential -Message "Enter a username & p/w for the VM administrator"

# Create a virtual machine in Azure
New-AzVm -ResourceGroupName $resourceGroup -Name $vmName -Credential $adminCredential -Image UbuntuLTS

# Extra variables
# $loc = "East US"
# $iterations = 3
# New-AzResourceGroup -Name "MyResourceGroup" -Location $loc
# For loop
# For ($i = 1; $i -lt 3; $i++)
# {
#   $i
# }

# Parameters
# We can pass arguments on cmd line to help extract the values e.g.
# .\setupEnvironment.ps1 -size 5 -location "East US"

# Inside the script, capture values into variables e.g.
# param(
# [int]$size,
# [string]$location
# )

# Thus, we can omit the names frm cmd line e.g.
# .\setupEnvironment.ps1 5 "East US"



