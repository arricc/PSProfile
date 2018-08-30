##
## Install or update the profile
##

$path = ($env:TEMP + "\PSProfile")`
$dest = $env:USERPROFILE + "\Documents\WindowsPowerShell"`
$URL = "https://github.com/arricc/PSProfile/archive/master.zip" 


md $path 
Remove-Item $dest\* -Force -
md $dest

$pieces = $url.Split("/")
$fileName = $pieces[$pieces.Count-1]
$unzipped = "$path\$fileName"

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$SysProxy = [System.Net.WebRequest]::GetSystemWebProxy().GetProxy($url) 

Invoke-WebRequest -Uri $URL  -Proxy ($SysProxy.OriginalString) -OutFile $unzipped

$shellApp = New-Object -com shell.application 
$destination = $shellApp.namespace($path) 
$destination.Copyhere($shellApp.namespace($unzipped).items())
 
Copy-Item ($path + "\PSProfile-master\*") $env:USERPROFILE -recurse
 
Get-ChildItem -Path  $dest  -exclude "Transcripts" | foreach ($_) {
    Remove-Item $_.fullname -Force -Recurse
}
