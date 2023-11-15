#Define a port mapping scheme (equivalent to JavaScript objects)
$portMap = @{
    0 = 'Reserved in programming APIs'
    1 = 'TCP Port Service Multiplexer (TCPMUX)'
    2 = 'compressnet (Management Utility)'
    3 = 'compressnet (Compression Process)'
    5 = 'Remote Job Entry - MIB PIM & IANA services (using socket 5 in its old socket form'
    7 = 'Echo Protocol'
    9 = 'Discard Protocol & Wake-on-LAN'
    11 = 'Active Users (systat service)'
    13 = 'Daytime Protocol'
    15 = 'netstat service'
    17 = 'Quote of the Day (QOTD)'
    18 = 'Message Send Protocol'
    19 = 'Character Generator Procotol (CHARGEN)'
    20 = 'File Transfer Protocol (FTP) data transfer services'
    21 = 'File Transfer Protocol (FTP) control command'
    22 = 'SSH'
    23 = 'Telnet - Unencrypted plain text communications'
    25 = 'Simple Mail Transfer Protocol (SMTP)'
    27 = 'nsw-fe (NSW User System FE)'
    28 = 'Palo Alto Networks Panorama High Availability'
    29 = 'msg-icp (MSG ICP)'
    31 = 'msg-auth (MSG Authentication)'
    33 = 'dsp (Display Support Protocol)'
    37 = 'Time Protocol'
    38 = 'rap (Route Access Protocol)'
    39 = 'rlp (Resource Location Protocol)'
    41 = '6in4 (IPv6 packets encapsulated in IPv4 tunneling)'
    42 = 'Host Name Server Protocol'
    43 = 'WHOIS protocol'
    44 = 'mpm-flags (MPM FLAGS Protocol)'
    45 = 'mpm (Message Processing Module [recv])'
    46 = 'mpm-snd (MPM [default send])'
    47 = 'Reserved port'
    48 = 'auditd (Digital Audit Daemon)'
    49 = 'TACACS Login Host protocol. TACACS+. Used for Use Authentication, Authorization, Accounting purposes'
    50 = 'Internet Key Exchange Protocol'
    #51 = 'Interface Message Processor'
    52 = 'Not assigned/Xerox Network Systems (XNS) Time Protocol'
    53 = 'Domain Name System (DNS)'
    63 = 'Not assigned'
    66 = 'SQL-Net (Oracle SQL*NET)'
    67 = 'Bootstrap Protocol (BOOTP) server used by DHCP'
    68 = 'Bootstrap Protocol (BOOTP) client'
    69 = 'Trivial File Transfer Protocol (TFTP)'
    79 = 'Finger protocol (Show users last login names)'
    80 = 'HTTP'
    81 = 'TorPark (Dark Web browsing) service'
    82 = 'TorPark (Dark Web browsing) control'
    88 = 'Kerberos authentication'
    8080 = 'HTTP'
    443 = 'TLS'
    445 = 'SMB'
    111 = 'Portmapper (RPCBIND) service'
    2049 = 'Network File System (NFS)'
    28260 = 'internal sysd IPC communication for internal processes'
    28261 = 'internal md applications to manage internal processes'
    5985 = 'WinRM PowerShell endpoint'
}

# Iterate through useful IPs and Ports
function Scan-LocalPorts {
    param(
        [string]$currentIP,
        [int]$currentPort,
        [int]$timeoutInSeconds = 15
    )
    $loopback = "127.0.0.1";
    
    Write-Host "Scanning ports for localhost: $loopback";

    foreach ($currentPort in $portMap.Keys) {
    Write-Host "Testing port $currentPort";

    $job = Start-Job -ScriptBlock {
        param($ip, $port)
            Test-NetConnection -ComputerName $ip -Port $port
        } -ArgumentList $loopback, $currentPort

    # Wait for the job to complete or timeout
    $result = Wait-Job $job -Timeout $timeoutInSeconds
    #$test = Test-NetConnection -ComputerName $currentIP -Port $currentPort
    #$test;

    if ($result -eq $null) {
        # Job timed out
        Stop-Job $job
        Remove-Job $job
        Write-Host "Port $currentPort timeout on localhost"

    } else {
        # Job completed successfully
        $test = Receive-Job $job
        Remove-Job $job
                
        if ($test.TcpTestSucceeded -eq "True") {
            Write-Host "Port: $currentPort is OPEN! Service running: $($portMap[$currentPort])"
        } else {
            Write-Host "Port $currentPort is closed on localhost"
          }
    }
  }
}

Scan-LocalPorts;

function Find-UsefulIPs {
$hostIP = (Get-NetIPAddress -AddressFamily IPv4).IPAddress;
$usefulIP = @();
#$hostIP;
for ($i=1; $i -le $hostIP.count; $i++) {
    $currentIP = $hostIP[$i];

    if ($currentIP -match "127\.(\d+)\.(\d+)\.(\d+)" -or
        $currentIP -match "10\.(\d+)\.(\d+)\.(\d+)" -or 
        $currentIP -match "172\.(\d+)\.(\d+)\.(\d+)" -or 
        $currentIP -match "192\.(\d+)\.(\d+)\.(\d+)") {
        $usefulIP += $currentIP;
    }
}

return $usefulIP;

}

# Call function & store result
$result1 = Find-UsefulIPs;

# Display result
#$result1;

# Access the value using the key
#$portMap[5985];

# Iterate through useful IPs and Ports
function Scan-NetworkPorts {
    param(
        [string]$currentIP,
        [int]$currentPort,
        [int]$timeoutInSeconds = 5
    )

    foreach ($currentIP in $result1) {
        Write-Host "Scanning ports for IP: $currentIP";

        foreach ($currentPort in $portMap.Keys) {
            Write-Host "Testing port $currentPort";

            $job = Start-Job -ScriptBlock {
                param($ip, $port)
                Test-NetConnection -ComputerName $ip -Port $port
            } -ArgumentList $currentIP, $currentPort

            # Wait for the job to complete or timeout
            $result = Wait-Job $job -Timeout $timeoutInSeconds
            #$test = Test-NetConnection -ComputerName $currentIP -Port $currentPort
            #$test;

            if ($result -eq $null) {
                # Job timed out
                Stop-Job $job
                Remove-Job $job
                Write-Host "Port $currentPort timeout on $currentIP"

            } else {
                # Job completed successfully
                $test = Receive-Job $job
                Remove-Job $job
                
                if ($test.TcpTestSucceeded -eq "True") {
                    Write-Host "Port: $currentPort is OPEN! Service running: $($portMap[$currentPort])"
                } else {
                    Write-Host "Port $currentPort is closed on $currentIP"
                }
            }
       }
    }

}
