function Get-DriveSpace {
    [cmdletbinding()]
    param( 
        [parameter(Position=1,ValueFromPipeline)]
        [string]$Computer = $env:COMPUTERNAME,
        [string]$DomainName
    )
    Begin {
        $cred=$null 

    }

    Process {
        if ($DomainName -and $Computer -notlike "*.*") {$Computer = "$Computer.$DomainName"} 
        
        if ($computer -like "*.*") {
            if(!$cred)  { $cred = Get-Credential }
            $qry = Get-WmiObject Win32_LogicalDisk -Filter drivetype=3 -ComputerName $computer -Credential $cred 
        }
        else { 
            $qry = Get-WmiObject Win32_LogicalDisk -filter drivetype=3 -comp $computer 
        }  
        $qry | % {
            $hash = [ordered]@{ 
                Drive   = $_.deviceID; 
                GBFree  = "{0:N2}" -f ($_.freespace / 1gb) ;
                TotalGB = "{0:N0}" -f ($_.size / 1gb) ;
                FreePct = "{0:P0}" -f ($_.FreeSpace / $_.size);
                Name    = $_.volumeName
                Computer = $Computer
            }
            new-object psobject -property $hash 
            
        }
    }
    <#
.SYNOPSIS
Returns the drive  usage.
.DESCRIPTION
Returns the disk usage for a given computer, or the local machine.
If any FQDNs are checked you will be prompted for credentials. The same credentials will then be reused for each computer.

Does not return mount point utilisation.
.INPUTS
Pipleline list of hostnames to check.
.OUTPUTS
Returns an objects representing:
    Drive    - system disk letter. E.g. C:
    GBFree   - Free Space in GB
    TotalGB  - Total size in GB
    FreePct  - Free space as a percentage
    Name     - Any name associated with the drive
    Computer - The relevant hostname 
.PARAMETER DomainName
OPTIONAL. Domain name to append to each non-FQDN host.
.PARAMETER Computer
The Computer (or list of computers) to check
.EXAMPLE
Get-DriveSpace
Drive    : C:
GBFree   : 208.68
TotalGB  : 476
FreePct  : 44%
Name     : MYPC
Computer : MYPC
.EXAMPLE
Get-DriveSpace -Computer server01 -DomainName example.com
cmdlet Get-Credential at command pipeline position 1
Supply values for the following parameters:
Credential


Drive    : C:
GBFree   : 14.74
TotalGB  : 50
FreePct  : 30%
Name     :
Computer : server01.example.com
.EXAMPLE
"server01","server02" | Get-DriveSpace -DomainName example.com | ft -AutoSize
cmdlet Get-Credential at command pipeline position 1
Supply values for the following parameters:
Credential

Drive GBFree TotalGB FreePct Name       Computer
----- ------ ------- ------- ----       --------
C:    14.73  50      30%                server01.example.com
C:    30.67  150     21%                server02.example.com
D:    90.09  350     26%     New Volume server02.example.com
S:    0.47   0       97%     Data       server02.example.com

#>
}