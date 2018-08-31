Function Get-ADSite
{
	[CmdletBinding()]
	Param(
		[Parameter(Position=1,ValueFromPipeline)]
		[string[]]$ComputerName = $env:COMPUTERNAME
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
<#
.SYNOPSIS
Shows the AD site for a computer.
.DESCRIPTION
Outputs the AD site for a computers using nltest.
.INPUTS
Can accept a pipline list of computer names.
.OUTPUTS
An objects representing:
	ComputerName
	ADSite

.PARAMETER ComputerName
The computer name to search. Defaults to the local machine.
.EXAMPLE
Get-ADSite
ComputerName   ADSite
------------   ------
{computer01}   Site01
.EXAMPLE
Get-ADSite -ComputerName server01
ComputerName   ADSite
------------   ------
{server01}     Site01
.EXAMPLE 
"server01","server02" | Get-ADSite
ComputerName   ADSite
------------   ------
{server01}     Site01
{server01}     Site02

#>
}

