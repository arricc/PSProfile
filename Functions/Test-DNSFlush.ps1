

function Test-DNSFlush
{
    Param(
        [Parameter(Mandatory=$True)]
        [string]$address
    )

    Write-Output " ** Ctrl-C to Quit **"
    
    Do 
    {
        ipconfig /flushdns
        Start-Sleep 10
        ping -n 1 $address
    }
    While ($true)
<#
.SYNOPSIS
Repeatedly clears the DNS cache and Pings the given address.
.DESCRIPTION
Clears the local DNS cache, sleeps for 10 seconds, and the pings the given address once forcing a new hostname lookup.
It is possible to pass an IP address to this function, but that will only result in the cache being cleared every 10 seconds as no DNS lookup will occur.
.INPUTS
None. No pipeline input.
.OUTPUTS
Output from Ping command.
.PARAMETER address
The address to ping.
#>
}