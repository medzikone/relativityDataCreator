#this script takes range of lines from load file and export them to another loadfile

$filepath =  #filepath with extension
$line = #number of line to start
$timestamp = Get-Date -f HH_mm_ss

$newfile = #path where new file will be created
New-Item -Path $newfile -type file

#count number of lines in file or set $numberOfLines to specify where is end of load file
$measueNumberLines = Get-Content $filepath | Measure-Object
$numberOfLines = $measueNumberLines.Count

Write-Host $numberOfLines

#create file and add header
$destinatioFile = "$newfile\Sample_$timestamp.TXT"
$content = Get-Content $filepath | Select -Index 0
Add-Content -path $destinatioFile -value $content

Get-Content -Path $filepath | Select-Object -Index ($line..$numberOfLines) | Foreach-Object {Add-Content -path $destinatioFile -value $_} 

Remove-Variable -Name * -ErrorAction SilentlyContinue