#https://www.reddit.com/r/PowerShell/comments/2x8n3y/getexcuse/
function Get-Excuse {
    if(!(Get-Variable -Scope Global -Name "excuses" -ErrorAction SilentlyContinue)){
        $global:excuses = (Invoke-WebRequest http://pages.cs.wisc.edu/~ballard/bofh/excuses).content.split([Environment]::NewLine)
    };
    Get-Random $global:excuses
}

function Forget-Excuses {
    Remove-Variable -Scope Global -Name "excuses"
}