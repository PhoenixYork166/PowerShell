#Seperate file created by another team
# <#SQLConfig.ps1#>

Configuration SQLConfig
{
    param (
        [pscredential]$SetupCredential
    )
 
 Import-DscResource -Module xSQLServer

    Node localhost
    PSDSCAllowDomainUser = $true
    {
            xSqlServerSetup 'SqlServerSetup'
        {
            DependsOn = "[WindowsFeature]NET-Framework-Core"
            SourcePath = '\SqlServer2016'
            SetupCredential = $SetupCredential
            InstanceName = 'MSSQLSERVER'
            Features = 'SQLENGINE,FULLTEXT,RS,AS,IS'
            SQLSysAdminAccounts = 'BUILTINADMINISTRATORS'
        }

        xSqlServerFirewall 'SqlFirewall'
        {
            DependsOn = '[xSqlServerSetup]SqlServerSetup'
            SourcePath = '\SqlServer2016'
            InstanceName = 'MSSQLSERVER'
            Features = 'SQLENGINE,FULLTEXT,RS,AS,IS'
        }
    }
}

SQLConfig