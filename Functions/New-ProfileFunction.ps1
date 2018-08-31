Function New-ProfileFunction {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$Name,
        [switch]$NoEdit
    )

    $NewPath = $env:USERPROFILE + "\Documents\WindowsPowerShell\Functions\" 
    $NewFile = $NewPath + $Name + ".ps1"
    if (Test-Path $NewFile) {
        Throw-Error -Message ($Name + ".ps1 function file already exists") 
    }

$Content = @"
Function $Name
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=`$True)]
        [string]`$param
    )

    Write-Output ("Param: " + `$param)
<#
.SYNOPSIS
Short description of the function
.DESCRIPTION
Longer description of the function
.INPUTS
Any inputes
.OUTPUTS
Any outputs
.PARAMETER param
param description
.EXAMPLE
$Name -param  "string1"
Param: string1
#>
}
"@

    New-Item -Path $NewPath -Name ($Name + ".ps1") -ItemType File -Value $Content
    
    If (!$NoEdit) {
        #This will be swapped to vi after I upgrade my Win10 version
        #vi $NewFile
        notepad $NewFile
    }
<#
.SYNOPSIS
Creates a new function to be auto imported in your the PS CLI Profile
.DESCRIPTION
Creates a template file based on the Name parameter, and opens an editor.
This is then auto-imported next time PowerShell CLI is started.
.INPUTS
None.
.OUTPUTS
None.
.PARAMETER Name
The name of the new function to create
.PARAMETER NoEdit
Switch. If set, the editor will not be started.
.EXAMPLE
New-ProfileFunction -Name Get-JellyBeans
#>
}