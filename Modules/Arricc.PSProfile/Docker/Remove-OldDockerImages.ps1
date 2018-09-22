function Remove-OldDockerImages {
    $images = (docker image ls | ConvertFrom-Docker | Where-Object {$_.tag -eq "<none>"} | Select-Object imageid).ImageId 
    
    If ($images) {
        $images | ForEach-Object { docker image rm $_}
    }
}