function vi ($File){
    $File = $File -replace “\\”, “/”
    bash -c “vim $File”
}


function vim ($File){
    vi $File
}
