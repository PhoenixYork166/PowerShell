# Initial File Path to find C:\Users\USER\Desktop
$file_path = [Environment]::GetFolderPath("Desktop")

# Re-defining File Path as C:\Users\USER\Desktop\Jobs
$file_path = $file_path + '\Jobs\'

# Move working directory to C:\Users\USER\Desktop\Jobs\
cd $file_path

# Getting all the .CSV files in $file_path
$files = Get-ChildItem -Path $file_path -Filter "*.csv"

# Creating an empty array preparing to store all the contents in the .CSV files
$raw = @()

# Getting contents from all .CSV log files
ForEach ($file in $files)

{

# Storing all contents of .CSV log files to an array
$raw += cat $file_path

# $raw is a multiple array

}

# Counting how many lines that $raw contains
$line_count = $raw.Count

# Conceptual findings: $raw[0..2] displays line 1 to line 3 contents in $raw array

$pattern_count = 0

# To store Pattern count
ForEach ($line in $raw)

{

    # If there is a line matching #MODE_ENABLE, then count = count + 1 (count starting from 0)
    If ($line -contains "#MODE_ENABLE")

    {

        $pattern_count = $pattern_count + 1

    }

}


# Finding Pattern: ]]> line locations for Log file splitting

# $locator is an array to store Pattern locations starting from line 1 indicated by $raw[0]
$locators =@(0)

# Loop through every line in $raw to find Pattern: ]]> which indicates the Line Location for each separator ]]>
For ($i = 0; $i -le $line_count; $i++)

{

    if ($raw[$i] -match "]]>")
    {

        $locators += $i

    }

}

$locators += $line_count

# Creating an empty array to store $start enumerator: 0, 1, 2, 3, ..., $pattern_count
$start = @()

For ($a = 0; $a -le $pattern_count; $a++)

{

    $start += $a

}

# Creating an empty array to store $end enumerator: 1, 2, 3, ..., $pattern_count+1
$end = @()

For ($b = 1; $b -le ($pattern_count+1); $b++)

{

    $end += $b

}

# $tuple = [System.Tuple]::Create(@{n='Start array';e=$start}, @{n='End array';e=$end})

# $start_tuple = $tuple.Item1.Values

# $end_tuple = $tuple.Item2.Values

# $content_array[$start] = $locators[$start]

# Extracting Network Device Names with empty lines in between
$device_names = @()

ForEach ($device in $raw)

{

    # If there is #]]> , then Network Device + 1
    If ($device -match "#]]>")
        
    {
        $device_names += $device.Split("#]]>")
    }

}

# Removing empty lines in $device_names array

$file_names = @()


For ($a = 0; $a -le (($pattern_count)*5); $a = $a + 5)

{

$file_names += $device_names[$a]

}

# Adding - (hiven) to the end of each Network Device Name
$fileNames_array = @()

ForEach ($file_name in $file_names)

{

    $fileNames_array += "$file_name extracted-"

}

# Conceptual findings:
# locators[$start]
# 0
# 4122
# 9366
# 11211
# 13057
# 18300
# 25170
# Figures in each line must + 1: 0+1, 4122+1, 9366+1, ..., 25170+1

# locators[$end]:
# 4122
# 9366
# 11211
# 13057
# 18300
# 25170
# 25172

# Array of Content starting line numbers
$cstart = $locators[$start]

# Adding 1 back to each line number in $cstart array
For ($adding = 0; $adding -le $pattern_count; $adding++)

{

    $cstart[$adding] = $cstart[$adding]+1

}

# Array of Numbers for each Log ending Line (integer)
$cend = $locators[$end]

# Creating an empty array $content_array to store each set of Log
$temp_array = @()

$temp_name = @()

$c_array = @()

For ($c = 0; $c -le $pattern_count; $c++) # I used $pattern_count = 1 for testing here

{

$temp_array += $raw[$cstart[$c]..$cend[$c]]

$temp_name += $fileNames_array[$c]

# Tell user how many lines are in each Log file...
Write-Host -ForegroundColor Green "The temp content count for $temp_name is: " $temp_array.Count

# Tell user what the Network Device name is for each Log file...
Write-Host -ForegroundColor Green "The Network Device name is: " $temp_name

# Saving contents (as an array) for each Network Device Log file temporarily stored in $c_array to $file_path
# before cleansing $c_array for next incoming content array
Write-Host -ForegroundColor Green "Saving the Log.txt for Network device: "$fileNames_array[$c]" into a .txt file..."

# The line below did not work well for Logs saving...
# New-Item -Path $file_path -Name $fileNames_array[$c] -Value $temp_array -Force

$temp_array | Out-File -FilePath "$file_path$temp_name"

# Replacing - with .txt
ls -Path $file_path | Rename-Item -NewName { $_.Name -replace ' extracted-', '.txt' }

# Cleansing $temp_array after each log file saving action
$temp_array = @()

# Cleansing $temp_name array after each log file saving action
$temp_name = @()

}

