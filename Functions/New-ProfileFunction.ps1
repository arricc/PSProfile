Function New-ProfileFunction {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)]
        [string]$Name,
        [switch]$EditNow
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
        [Parameter(Mandatory=$True)]
        [string]`$param
    )

    Write-Output ("Param: " + `$param)

}
"@

    New-Item -Path $NewPath -Name ($Name + ".ps1") -ItemType File -Value $Content
    
    If ($EditNow) {
        #This will be swapped to vi after I upgrade my Win10 version
        #vi $NewFile
        notepad $NewFile
    }

}