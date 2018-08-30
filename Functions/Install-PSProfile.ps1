##
## Install or update the profile
##
Function Install-PSProfile {

    $path = ($env:TEMP + "\PSProfile")
    $dest = $env:USERPROFILE + "\Documents\WindowsPowerShell2"
    $URL = "https://github.com/arricc/PSProfile/archive/master.zip" 


    $null = md $path -Force
    Get-ChildItem -Path  $dest  -exclude "Transcripts","LocalProfile.ps1" | foreach ($_) {
        Remove-Item $_.fullname -Force -Recurse
    }
    $null = md $dest -Force

    $pieces = $url.Split("/")
    $fileName = $pieces[$pieces.Count-1]
    $zip = "$path\arricc-PSProfile.zip"

    $SysProxy = [System.Net.WebRequest]::GetSystemWebProxy().GetProxy($url) 
    if ($SysProxy.OriginalString -eq $URL) {
        Invoke-WebRequest -Uri $URL -OutFile $zip
    } else {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $URL -Proxy ($SysProxy.OriginalString) -OutFile $zip
    }

    $shellApp = New-Object -com shell.application 
    $destination = $shellApp.namespace($path) 
    $destination.Copyhere($shellApp.namespace($zip).items())
 
    Copy-Item ($path + "\PSProfile-master\*") $dest -recurse
 
    rm $path -Force -Recurse
}