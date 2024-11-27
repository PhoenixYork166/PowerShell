# Deploy an ARM Template That Contains a PowerShell DSC Extension [Guided]

https://github.com/LODSContent/ChallengeLabs_Resources/blob/master/ais-008/

# Select Deploy to Azure

# Create a virtual machine that has a DSC extension by using a custom deployment ARM template
# Deploy the custom template by using the values in the following table. For any property that is not specified, use the default value.

# Property	Value
# Resource group	rg1lod22851607
# Vm Name	VM1
# Vm Size	Standard_DS1_v2
# Admin Password	zQw6BBd10#h!eD
# Dsc Configuration Url	https://raw.githubusercontent.com/LODSContent/ChallengeLabs_Resources/master/ais-008/WebApp.zip
# Dsc Configuration Script	WebApp.ps1
# Dsc Configuration Function	WebApp

# Once the VM is created
# On the Deployment page, select Go to resource group, and then select VM1.

# On the Overview page, in Essentials, copy the Public IP address, and then paste it in the Public IP Address text box.

# Open a new browser window, go to http://20.25.102.183, and then verify that the Test Web App Deployment page is displayed.