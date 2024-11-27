# Another version of PowerShell fundamentals

# Showing Objects
dir | sort-object

dir | sort-object -Descending -Property LastWriteTime

dir | foreach {"$($_.GetType().FullName) - $_.Name"}

New-Object -TypeName System.Threading.AbandonedMutexException

# Formally codename Monad a long time ago
# Provides an env for both executing live commands & creating powerful scripts
# Built on .NET framework (.NET core) & is focused around obj enabling rich
# sequences to be created which can perform complex tasks
# Uses a common syntax & common verb-noun pair command naming for cmdlets


# New core cmdlets related to new functionality & also changes to
# existing cmdlets to match simpler syntax & more features 
# e.g. Get-ChildItem
# PowerShell can manage non-Windows such as Linux as WSMan & CIM (WMI2)
# are default protocols for management
# Ps Core uses SSH in addition to WSMan
# Remote Management is enabled by default

# PowerShell v2 is available for
# Win Srv 2008 SP1 +
# Win VIsta SP 2+
# Win XP SP 2+

# PowerShell 3 - 
# Standard in Win Srv 2012 & Win 8
# Also avail. as part of Windows Management Framework (WMF) 3.0
# Avail. for Win Srv 2008 SP2, 2008 R2 SP1 & Win7 SP1

# PowerShell Core [6]
# Originally part of Nano Server but now the feature of PowerShell
# For Hyper-V server
# PowerShell Core runs on .NET Core
# Enables cross-platform usage e.g. MAC, Linux

# PowerShell 6 
# Get-Module -ListAvailable
# Get-Module -ListAvailable | Install-Module -Verbose -Force
