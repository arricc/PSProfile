# PSProfile
My PowerShell Profile (Minus some local extras I use on my work machine).

With thanks to:
* [@KennyLowe](https://twitter.com/KennyLowe) ([GitHub](https://github.com/KennyLowe/PProfile)) for the intial inspiration and some of the function code.

* [u/PowerShellStunnah](https://www.reddit.com/user/PowerShellStunnah) - included version of [Get-Excuse](https://www.reddit.com/r/PowerShell/comments/2x8n3y/getexcuse/coz53xa/)


# Install/Update

## **WARNING**
For now, this will **wipe** your existing user PowerShell profile and module directory, and any customisations or extra Function files you've added since you last downloaded or updated PSProfile. Everything in `%USERPROFILE%\Documents\WindowsPowerShell` will go.

If in doubt, backup your existing files first!

## Instructions


You can download the [zip](https://github.com/arricc/PSProfile/archive/master.zip) and place the extracted files at `%USERPROFILE%\Documents\WindowsPowerShell`

Or run the following in a PowerShell prompt.

~~~~
$InstallFunc = "https://raw.githubusercontent.com/arricc/PSProfile/master/Functions/Install-PSProfile.ps1?rand=" + (Get-Date -Format "O")
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
iex ((New-Object System.Net.WebClient).DownloadString($InstallFunc))
Install-PSProfile

~~~~

# Suggestions/Fixes
Pull requests welcome, as are comments and issues logged to the issue tracker.

If you're more comfortable with email: psprofile@arricc.net.

Or you can connect with me on Twitter [@markmcritchie](https://twitter.com/markmcritchie).

