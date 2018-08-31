Function Enable-Module
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [string]$Module
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
<#
.SYNOPSIS
Installs and imports a module.
.DESCRIPTION
Imports a module if it is installed, otherwise installs if off PSGallery or any other repository configured locally.
Installs in global scope if the user is an administrator, otherwise, CurrentUser.
.INPUTS
Accepts a pipeline list of modules
.OUTPUTS
None.
.PARAMETER Module
The module to enable

#>
}