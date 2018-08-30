function prompt {
    $origLastExitCode = $LastExitCode
    Write-VcsStatus

    Write-Host "$env:USERNAME" -NoNewline -ForegroundColor Green
    Write-Host "@" -NoNewline #-ForegroundColor Green
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Green
    Write-Host " : " -NoNewline -ForegroundColor DarkGray

    $curPath = $ExecutionContext.SessionState.Path.CurrentLocation.Path
    if ($curPath.ToLower().StartsWith($Home.ToLower()))
    {
        $curPath = "~" + $curPath.SubString($Home.Length)
    }

    Write-Host $curPath -NoNewline -ForegroundColor Yellow
    Write-Host " : " -NoNewline -ForegroundColor Blue
#    Write-Host (Get-Date -Format G) -ForegroundColor Magenta
    $LastExitCode = $origLastExitCode
#    Write-Host $curPath -NoNewline -ForegroundColor Yellow
    if ($IsAdministrator) { return " # " } else { return " $ "}
}
