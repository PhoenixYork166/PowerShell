# Set Trigger for a new scheduled job
$Trigger = New-JobTrigger -Once -At (Get-Date).AddMinutes(10)

# Registering a scheduled job
Register-ScheduledJob -Name SVCJob -Trigger $Trigger `
{Get-Service | where {$_.status -eq "running" -and $_.DisplayName`
-match "windows|microsoft|print"}}

# Open the Task Scheduler management console, 
# expand Task Scheduler Library > Microsoft > Windows > PowerShell, 
# and then select ScheduledJobs to view the details of the SVCJob job.

# Display List of Scheduled Jobs
Get-Job

# Run the following command to assign the content of the SVCJob job, 
# including the data stored in the job, to the $ServiceJob variable:
$ServiceJob = Receive-Job SVCJob -Keep

# Run the following command to output the results of the SVCJob job to 
# C:\Class\ServiceStatus.txt without saving the data in the job:
Receive-Job SVCJob | Out-File C:\Class\ServiceStatus.txt

# Run the following command to remove the scheduled SVCJob:
Remove-Job SVCJob

# Run the following command to display the content of the $ServiceJob variable:
$ServiceJob

# Create a scheduled job that sends output to a report file

# Create a new job trigger variable $Trigger that
# will schedule the job to run daily at the same time,
# 10 minutes from current time

$Trigger = New-JobTrigger -Daily -At "9:10 pm"

# Register a scheduled job "Top10ProcsJob", 
# using the $Trigger variable to schedule a command that 
# retrieves the processes, sorted in descending order,
# and then outputs the first 10 processes to a text file:
Register-ScheduledJob -Name Top10ProcsJob -Trigger $Trigger {Get-Process | Sort WS -Descending | Select -First 10 | Out-FIle C:\Class\Top10ProcsJob.txt}

# Display a list of jobs:
Get-Job

# Remove the scheduled Top10ProcsJob:
Unregister-ScheduledJob Top10ProcsJob

# Open C:\Class\Top10ProcsJob.txt in Notepad

C:\Class\Top10ProcsJob.txt

