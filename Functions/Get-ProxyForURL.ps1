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
}