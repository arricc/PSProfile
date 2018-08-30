Function Load-Module
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [string[]]$Module
    )

    Process {
        if (!($null = Import-Module $Module -ErrorAction SilentlyContinue -PassThru ))   { 
            if ($IsAdministrator) { 
                install-module $_ -Force  
            } else {
                install-module $_ -Force -Scope CurrentUser
            }
            $null = Import-Module $_ -PassThru -InformationAction Ignore 
        }
    }

}