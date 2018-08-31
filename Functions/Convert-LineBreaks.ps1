function Fix-Linebreaks
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$file
    )

    $OldFile = "$file"
    $Path = Split-Path -Path $file
    $Newfile = $Path + "\temp.txt"
    Get-Content $OldFile | Set-Content -Path $NewFile
    del $OldFile
    move $NewFile $OldFile
    Echo "   ** Completed **"
}
