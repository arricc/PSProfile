function Get-DriveSpace {
    [cmdletbinding()]
    param( 
        [parameter(Position=1,ValueFromPipeline)]
        [string]$Computer = $env:COMPUTERNAME
    )

    Process {

        if ($computer -like "*.*") {
            $cred = Get-Credential
            $qry = Get-WmiObject Win32_LogicalDisk -Filter drivetype=3 -ComputerName $computer -Credential $cred 
        }
        else { 
            $qry = Get-WmiObject Win32_LogicalDisk -filter drivetype=3 -comp $computer 
        }  
        $qry | % {
            new-object psobject -property @{ 
                Drive   = $_.deviceID; 
                GBFree  = "{0:N2}" -f ($_.freespace / 1gb) ;
                TotalGB = "{0:N0}" -f ($_.size / 1gb) ;
                FreePct = "{0:P0}" -f ($_.FreeSpace / $_.size);
                Name    = $_.volumeName
            }
        }
    }
}