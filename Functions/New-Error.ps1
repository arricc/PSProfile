Function New-Error
{
	Param(
		[Parameter(Mandatory=$true,Position=1)]
		[string]$message,
		[switch]$Continue
	)

	If (!$Continue) {
		$ErrorActionPreference = "Stop"
	}

	Write-Error ($message)
<#
.SYNOPSIS
Outputs and error and optionally ceases execution of the script.
.DESCRIPTION
Outputs and error message and terminates the script
.INPUTS
None. No pipeline input.
.OUTPUTS
Output from Ping command.
.PARAMETER message
The error message to return
.PARAMETER Continue
Switch. Output the error, but do not terminate.
.EXAMPLE
New-Error -message "Something has gone wrong"
Neww-Error : Something has gone wrong
At line:1 char:1
+ New-Error -message "Something has gone wrong"
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,New-Error
#>
}