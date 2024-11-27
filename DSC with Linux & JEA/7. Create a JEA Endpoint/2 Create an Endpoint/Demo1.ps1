cls
#<#Demo1.ps1#>
Configuration Demo1
{
    Import-DscResource -ModuleName xjea
    
    xJeaToolKit Process
    {
            Name = 'Process'
            # .csv list of command specifications in the order: 1.Name, 2.Parameter etc.
            CommandSpecs = @" 
Name, Parameter, ValidateSet, ValidatePattern
Get-Process
Get-Service
Stop-Process,Name,calc;notepad
Restart-Service,Name,,^A
"@
        }

        xJeaEndPoint Demo1EP
        {
            Name                 = 'Demo1EP'
            Toolkit              = 'Process'
            SecurityDescriptorSddl  = 'O:NSG:BAD:P(A;;GX;;;WD)S:P(AU;FA;GA;;;WD)(AU;SA;GXGW;;;WD)'
            DependsOn            = '[xJeaToolkit]Process'
        }
    
}

Demo1 -OutputPath C:\JeaDemo

Set-DscLocalConfigurationManager -Path C:\JeaDemo -Verbose

Start-DscConfiguration -Path C:\JeaDemo -ComputerName localhost -Verbose -Wait -Debug -ErrorAction SilentlyContinue -ErrorVariable $errors
if($errors | ? FullyQualifiedErrorId -ne 'HRESULT 0x803381fa')
{
    $errors | Write-Error
}

Start-sleep -Seconds 30 #Wait for WINRM to restart

$s = New-PSSession -ComputerName . -ConfigurationName Demo1EP
icm $s {get-command} | out-string
icm $s {get-command stop-process -Syntax}
# Enter-PSSession $s

Remove-PSSession $s

#EOF