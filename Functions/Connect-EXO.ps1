Function Connect-EXO {
	$EXOSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
        -Credential $UserCredential -Authentication  Basic -AllowRedirection -SessionOption $ProxySettings
	Import-PSSession $EXOSession
}
