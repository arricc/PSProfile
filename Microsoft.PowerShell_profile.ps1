<#
.SYNOPSIS 
These are the main PowerShell Script I've started using for my local PowerShell profile

.DESCRIPTION
These are designed to be run from %USERPROFILE%\Documents\WindowsPowerShell so they will be executed every time you start a powershell CLI session.

.LINK
https://github.com/arricc/PSProfile
#>

$ProxySettings = New-PSSessionOption -ProxyAccessType IEConfig


If($Host.UI.RawUI.WindowTitle -like "*administrator*")
{
	Write-ASCII "Administrator" -Fore Green
    $IsAdministrator = $true
}

#Load my functions
$functions = Get-ChildItem -Path ($env:USERPROFILE + "\Documents\WindowsPowerShell\Functions") -Filter '*.ps1' 
ForEach ($function in $functions)
{
    Write-host "  Importing $($function.BaseName)" -ForegroundColor Green
    . $function.PSPath
}



$MyModules = @()
$MyModules += "posh-git"
$MyModules += "Get-ChildItemColor"
#$MyModules += "Oh-My-Posh"

$MyModules | Load-Module

#Shouldn't need to explicitly load these
#$MyModules = (get-childitem ($env:USERPROFILE + "\Documents\WindowsPowerShell\Modules") )
#$MyModules | % { Import-Module $_ } 


#Git VCS Settings
$global:GitPromptSettings.BeforeText = '['
$global:GitPromptSettings.AfterText  = '] '
 

##Aliases
Set-Alias ls Get-ChildItemColor -option AllScope
Set-Alias l Get-ChildItemColorFormatWide -option AllScope
Set-Alias dir Get-ChildItemColor -option AllScope
Set-Alias grep Search-TextFile


##Transcription

$TranscriptPath = ($env:USERPROFILE + "\Documents\WindowsPowerShell\Transcripts\")

$null = New-Item -ItemType Directory -Force -Path $TranscriptPath  

if (Test-Path ($env:USERPROFILE + "\Documents\WindowsPowerShell\LocalProfile.ps1")) {
    write-host "Local Profile extras being imported.." -ForegroundColor Yellow
    . ($env:USERPROFILE + "\Documents\WindowsPowerShell\LocalProfile.ps1")
}

write-ascii "Transcript logging..." -Fore Green
write-host ""
$Transcript = Start-Transcript -OutputDirectory $TranscriptPath
write-host $Transcript -ForegroundColor "Green"
write-host ""
