# PSProfile

My PowerShell Profile (Minus some local extras I use on my work machine).

With thanks to:

* [@KennyLowe](https://twitter.com/KennyLowe) ([GitHub](https://github.com/KennyLowe/PProfile)) for the intial inspiration and some of the function code.

* [u/PowerShellStunnah](https://www.reddit.com/user/PowerShellStunnah) - included version of [Get-Excuse](https://www.reddit.com/r/PowerShell/comments/2x8n3y/getexcuse/coz53xa/)
* [Matt Parkes](https://github.com/mattparkes) - [PoShFuck Module](https://github.com/mattparkes/PoShFuck)
* Svendsen Tech Write-ASCII Module from [PowerShellAdmin](https://www.powershelladmin.com/wiki/Ascii_art_characters_powershell_script)

## Install

### **WARNING**

For now, this will **wipe** your existing user PowerShell profile and module directory, and any customisations or extra Function files you've added since you last downloaded or updated PSProfile. Everything in `%USERPROFILE%\Documents\WindowsPowerShell` will go.

If in doubt, backup your existing files first!

## Instructions

You can download the [zip](https://github.com/arricc/PSProfile/archive/master.zip) and place the extracted files at `%USERPROFILE%\Documents\WindowsPowerShell`

Or run the following in a PowerShell prompt.

~~~~powershell
$InstallFunc = "https://raw.githubusercontent.com/arricc/PSProfile/master/Functions/Install-PSProfile.ps1?rand=" + (Get-Date -Format "O")
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
iex ((New-Object System.Net.WebClient).DownloadString($InstallFunc))
Install-PSProfile

~~~~

## Updating

To update simply run ````Install-PSProfile```` if you get an error relating to  secure connectivity, try this:

~~~~powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Install-PSProfile
~~~~

### Execution Policy

If when you restart PowerShell you get an error such as:

~~~~powershell

. : File C:\Users\username\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 cannot be loaded because running
scripts is disabled on this system. For more information, see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:3
+ . 'C:\Users\mark\Documents\WindowsPowerShell\Microsoft.PowerShell_pro ...
+   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess
~~~~

Then you need to update the Execution Policy on your system to one of the following:

~~~~powershell

Set-ExecutionPolicy RemoteSigned
Set-ExecutionPolicy Unrestricted
Set-ExecutionPolicy Bypass
~~~~

If you are unsure what the difference between these 3 policy levels is, check the [link in the error message](https:/go.microsoft.com/fwlink/?LinkID=135170) or run:

~~~~powershell
help about_Execution_Policies
~~~~

## Suggestions/Fixes

Pull requests welcome, as are comments and issues logged to the issue tracker.

If you're more comfortable with email: psprofile@arricc.net.

Or you can connect with me on Twitter [@markmcritchie](https://twitter.com/markmcritchie).
