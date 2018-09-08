Function Enable-Module
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True,ValueFromPipeline=$true)]
        [string]$Module
    )
    Begin {
        ##Force install of NuGet Provider if it doesn't exist or is too old..
        $NugetVer = (Get-PackageProvider -name NuGet ).Version
        if ($NugetVer -lt $NugetMinVersion) {
            Write-Host "Updating NuGet"
            Install-PackageProvider -Name NuGet -MinimumVersion $NugetMinVersion -Force
        } else {
            Write-Host "Nuget meets version requirement " $NugetVer ">=" $NugetMinVersion
        }
    }

    Process {
        Write-Host "Enabling Module: " $Module
        if (!($mod = Import-Module $Module -ErrorAction SilentlyContinue -PassThru ))   {
            Write-Host "Installing Module: " $Module
            if ($IsAdministrator) { 
                install-module $_ -Force  
            } else {
                install-module $_ -Force -Scope CurrentUser
            }
            $mod = Import-Module $_ -PassThru -InformationAction Ignore
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