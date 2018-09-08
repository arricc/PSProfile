#Can't work out any other good way to do this when using a WPAD or Autodetect proxy.
Function Get-ProxyForURL {
    param (
        [Parameter(Mandatory)]
        [string]$URL
    )

    
    $SysProxy = [System.Net.WebRequest]::GetSystemWebProxy().GetProxy($URL) 
    if ($SysProxy.OriginalString -eq $URL) {
        return ""
    } else {
        return ($SysProxy.OriginalString) 
    }
<#
.SYNOPSIS
Returns the proxy settings to use for a specific URL
.DESCRIPTION
This returns the proxy server to use for accessing a URL. 
This can them be used with Invoke-WebRequest or similar in an environment where there could be multiple proxies in use or there is some form of dynamic proxy setup using PAC files/WPAD or proxy autodetection.
.INPUTS
None.
.OUTPUTS
Returns string representing the proxy server and port, or blank if no proxy should be used.
.PARAMETER URL
The URL to test
.EXAMPLE
$Proxy = Get-ProxyForURL -URL "http://github.com"
#>
}