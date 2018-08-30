function Get-ProxyForURL {
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