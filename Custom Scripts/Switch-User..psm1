function switch-psuser {
    
    Param(
        [Parameter(Position=0)]
        [ValidateSet("adminsystem","administrator")]
        $User = "adminsystem"
    )

    switch($User)
    {
        'adminsystem'   { $username = "domain\adminsystem" ; $pw = "yyy"}
        'administrator' { $username = "domain\administrator" ; $pw = "zzz" }
    }

    $password = $pw | ConvertTo-SecureString -AsPlainText -Force
    $cred = New-Object System.Management.Automation.PSCredential -ArgumentList $username,$password
    New-PSSession -Credential $cred | Enter-PSSession
}