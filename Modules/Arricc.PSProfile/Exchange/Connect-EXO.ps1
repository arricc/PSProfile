Function Connect-EXO {
	$EXOSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
        -Credential $UserCredential -Authentication  Basic -AllowRedirection -SessionOption $ProxySettings
	Import-PSSession $EXOSession
<#
.SYNOPSIS
Connects to Exchange Online PowerShell.
.DESCRIPTION
Prompts for admin credentials and logs in to Exchange Online PowerShell using your system proxy.
Automatically imports the remote Session to the current scope.
.INPUTS
None.

#>
}
