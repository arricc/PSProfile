

function Test-DNSFlush
{
    Param(
        [Parameter(Mandatory=$True)]
        [string]$url
    )

    Echo " ** Ctrl-C to Quit **"
    
    Do 
    {
        ipconfig /flushdns
        Start-Sleep 10
        ping $url
    }
    While ($true)
}