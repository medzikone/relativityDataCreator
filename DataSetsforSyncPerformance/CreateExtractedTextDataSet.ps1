$loadFileName = Read-Host 'Enter Extracted Text Loadfile name'

do {
    try {
        $numOk = $true
        [int]$numberOfLines = Read-Host 'How many documents in the Loadfile?'
        } # end try
    catch {$numOK = $false}
    }
    until ($numberOfLines -ge 1 -and $numOK)

$newDirectoryPath = Read-Host "Provide path where you want to create data: "

$createDirectory = New-Item -Path $newDirectoryPath -Name $loadFileName -type directory
$filepath = "$createDirectory\$loadFileName.txt"

New-Item $filepath -type file

#produce natives and text files

.\Scripts\CreateExtractedText.ps1 $createDirectory

$header = "^Control Number^|^Extracted Text^" #list of Fields Name

add-content $filepath -Value $header

#get list of created files

$directoryWithItems = "$createDirectory\TEXT" #native file location
$listOfItems = Get-ChildItem $directoryWithItems | ForEach-Object { $_.Name }

#create CSV Load File
$currentCount = 0

do {
    try {
        $numOk = $true
        [int]$startControlNumber = Read-Host 'Please provide first Control Number: '
        } 
    catch {$numOK = $false}
    }
    until ($startControlNumber -ge 1 -and $numOK)

while($currentCount -lt $numberOfLines){

foreach($line in $listOfItems) {
   $controlNumber = '{0:d8}' -f ($currentCount+1)
   add-content $filepath -Value "^REL$controlNumber^|^TEXT\$line^"
   $currentCount ++
   IF($currentCount -ge $numberOfLines){
   break
   }
  }
}

Write-Host "You have created $numberOfLines documents in $directoryWithItems"
Write-Host "Please find your loadfile in $filepath"
Read-Host "Press any key to exit..."
exit