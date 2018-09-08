function Search-TextFile {
  param( 
    [parameter(mandatory=$true,Position=2)]
    [string]$File,
    [parameter(mandatory=$true,Position=1)]
    [string]$SearchText
  )
  if ( !(test-path $File) ) {
      "File not found:" + $File; break
  }
  $fullPath = Resolve-Path $file | Select-Object -ExpandProperty path
  $lines = [system.io.file]::ReadLines($fullPath)
  Foreach ($line in $lines) { 
    if ($line -match $SearchText) {
      $line
    } 
  }
<#
.SYNOPSIS
Searches a for text in a file
.DESCRIPTION
Searches a given file and returns all lines containing a given string.
.INPUTS
None. No pipeline input.
.OUTPUTS
Outputs all lines with a match for the given string
.PARAMETER File
The File  to search
.PARAMETER SearchText 
The string to search for
.EXAMPLE
Search-TextFile -SearchText Search .\Search-TextFile.ps1
function Search-TextFile {
    [string]$SearchText
    if ($line -match $SearchText) {
Searches a for text in a file
Searches a given file and returns all lines containing a given string.
The File  to search
#>
} 
