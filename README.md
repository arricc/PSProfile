# PSProfile
My PowerShell Profile (Minus some local extras I use on my work machine).

A chunk of this is "borrowed" from :
* [@KennyLowe](https://twitter.com/KennyLowe) - [GitHub Project](https://github.com/KennyLowe/PProfile)
* [u/PowerShellStunnah](https://www.reddit.com/user/PowerShellStunnah) - version of [Get-Excuse](https://www.reddit.com/r/PowerShell/comments/2x8n3y/getexcuse/coz53xa/)
* @Others TBC.

# Install/Update
~~~~
$path = ($env:TEMP + "\PSProfile")`
$dest = $env:USERPROFILE + "\Documents\WindowsPowerShell"`
$URL = "https://github.com/arricc/PSProfile/archive/master.zip" 


md $path 
Remove-Item $dest -Force
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
 
Remove-Item $path -recurse -force 