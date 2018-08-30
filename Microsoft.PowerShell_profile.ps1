$ProxySettings = New-PSSessionOption -ProxyAccessType IEConfig


If($Host.UI.RawUI.WindowTitle -like "*administrator*")
{
	Write-ASCII "Administrator" -Fore Green
    $IsAdministrator = $true
}



$MyModules = @()
$MyModules += "posh-git"
$MyModules += "Get-ChildItemColor"
#$MyModules += "Oh-My-Posh"


$MyModules | % {if (!(Import-Module $_ -ErrorAction SilentlyContinue -PassThru )) 
    { 
        if ($IsAdministrator) { 
            install-module $_ -Force  
        } else {
            install-module $_ -Force -Scope CurrentUser
        }
        Import-Module $_
    }
}


$MyModules = (get-childitem ($env:USERPROFILE + "\Documents\WindowsPowerShell\Modules") )
$MyModules | % { Import-Module $_ } 


#My Functions


$functions = Get-ChildItem -Path ($env:USERPROFILE + "\Documents\WindowsPowerShell\Functions") -Filter '*.ps1' 
ForEach ($function in $functions)
{
    Write-host "  Importing $($function.BaseName)" -ForegroundColor Green
    . $function.PSPath
}



$global:GitPromptSettings.BeforeText = '['
$global:GitPromptSettings.AfterText  = '] '
 

##Aliases

Set-Alias ls Get-ChildItemColor -option AllScope
Set-Alias l Get-ChildItemColorFormatWide -option AllScope
Set-Alias dir Get-ChildItemColor -option AllScope
Set-Alias grep Search-TextFile


##Set Theme



##Transcription

$TranscriptPath = ($env:USERPROFILE + "\Documents\WindowsPowerShell\Transcripts\")

$tLoc = New-Item -ItemType Directory -Force -Path $TranscriptPath  

if (Test-Path ($env:USERPROFILE + "\Documents\WindowsPowerShell\LocalProfile.ps1")) {
    write-host "Local Profile extras being imported.." -ForegroundColor Yellow
    . ($env:USERPROFILE + "\Documents\WindowsPowerShell\LocalProfile.ps1")
}

write-ascii "Transcript logging..." -Fore Green
write-host ""
$Transcript = Start-Transcript -OutputDirectory $TranscriptPath
write-host $Transcript -ForegroundColor "Green"
write-host ""


