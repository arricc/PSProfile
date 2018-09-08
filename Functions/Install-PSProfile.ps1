##
## Install or update the profile
##
Function Install-PSProfile {

    $path = ($env:TEMP + "\PSProfile")
    $dest = $env:USERPROFILE + "\Documents\WindowsPowerShell"
    $URL = "https://github.com/arricc/PSProfile/archive/master.zip" 


    $null = mkdir $path -Force
    Get-ChildItem -Path  $dest  -exclude "Transcripts","LocalProfile.ps1" | ForEach-Object ($_) {
        Remove-Item $_.fullname -Force -Recurse
    }
    $null = mkdir $dest -Force

    $zip = "$path\arricc-PSProfile.zip"

    $SysProxy = [System.Net.WebRequest]::GetSystemWebProxy().GetProxy($url) 
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    if ($SysProxy.OriginalString -eq $URL) {
        Invoke-WebRequest -Uri $URL -OutFile $zip
    } else {
        Invoke-WebRequest -Uri $URL -Proxy ($SysProxy.OriginalString) -OutFile $zip
    }

    $shellApp = New-Object -com shell.application 
    $destination = $shellApp.namespace($path) 
    $destination.Copyhere($shellApp.namespace($zip).items())
 
    Copy-Item ($path + "\PSProfile-master\*") $dest -recurse -Exclude ".gitignore"
 
    Remove-Item $path -Force -Recurse
    Write-Output ("PSProfile updated. Please restart PowerShell CLI for latest changes")
<#
.SYNOPSIS
Installs or updates the PSProfile bundle.
.DESCRIPTION
** This is currently a destructive operation and will wipe your existing Profile directory entirely. 
** This includes and user specific modules.

Automatically downloads and unpacks the latest PSProfile bundle to your local PowerShell CLI profile.

.INPUTS
None.
.OUTPUTS
None.
#>
}