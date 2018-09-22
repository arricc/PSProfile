# Taken from http://overpoweredshell.com/Working-with-Plaster/

Write-Output "Loading.."

$functionFolders = @('public', 'internal', 'classes')
ForEach ($folder in $functionFolders)
{
    $folderPath = Join-Path -Path $PSScriptRoot -ChildPath $folder
    If (Test-Path -Path $folderPath)
    {
        Write-Verbose -Message "Importing from $folder"
        $functions = Get-ChildItem -Path $folderPath -Filter '*.ps1'
        ForEach ($function in $functions)
        {
            Write-Verbose -Message "  Importing $($function.BaseName)"
            . $function.PSPath
        }
    }
}
$publicFunctions = @()
$publicFunctions += (Get-ChildItem -Path "$PSScriptRoot\ActiveDirectory" -Filter '*.ps1').BaseName
$publicFunctions += (Get-ChildItem -Path "$PSScriptRoot\Docker" -Filter '*.ps1').BaseName
$publicFunctions += (Get-ChildItem -Path "$PSScriptRoot\Exchange" -Filter '*.ps1').BaseName
$publicFunctions += (Get-ChildItem -Path "$PSScriptRoot\Misc" -Filter '*.ps1').BaseName
$publicFunctions += (Get-ChildItem -Path "$PSScriptRoot\PSProfile" -Filter '*.ps1').BaseName

Export-ModuleMember -Function $publicFunctions