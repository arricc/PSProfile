Function Throw-Error
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

}