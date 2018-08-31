function Convert-Linebreaks
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$File
    )

    $OldFile = "$File"
    $Path = Split-Path -Path $File
    $NewFile = $Path + "\temp.txt"
    Get-Content $OldFile | Set-Content -Path $NewFile
    Remove-Item $OldFile
    Move-Item $NewFile $OldFile
    Write-Output "   ** Completed **"
<#
.SYNOPSIS
Fixes line endings in a given file
.DESCRIPTION
Creates a temporary file with the line endings fixed and copies over the original.
.INPUTS
None. No pipeline input.
.OUTPUTS
None.
.PARAMETER File
The File to update.
.EXAMPLE
Convert-Linebreaks -File .\file.txt
#>
}
