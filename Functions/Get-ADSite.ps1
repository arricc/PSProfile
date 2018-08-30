Function Get-ADSite
{
	[CmdletBinding()]
	Param(
		[Parameter(Position=1,ValueFromPipeline)]
		[string]$ComputerName = $env:COMPUTERNAME
		)

	Process {
		#Sadly can't pass this a computer name	
		#$site = ([System.DirectoryServices.ActiveDirectory.ActiveDirectorySite]::GetComputerSite() ).Name
		$site = nltest /server:$ComputerName /dsgetsite 2>$null
		if($LASTEXITCODE -ne 0){ 
			$site = @("Unknown")
		}
		new-object psobject -property  @{ComputerName = $ComputerName; ADSite = $site[0]} 
	}

}

