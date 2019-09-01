$loadFileName = Read-Host 'Enter Loadfile name'

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

#create physical files
.\Scripts\DataCreator.ps1 $createDirectory

$header = Get-Content -Path "Data\FieldsMapping\100_FieldsHeader.txt" #list of Fields Name

add-content $filepath -Value $header

$fieldscontent = Get-Content -Path "Data\FieldsMapping\FilledFields.txt" #content for Fields

#get list of created files

$directoryWithItems = "$createDirectory\NATIVES" #native file location
$listOfItems = Get-ChildItem $directoryWithItems | ForEach-Object { $_.Name }

<#
######## TBC
Write-Host $extractedTextSize
#> #extracted text

$extractedTextGenerator = Read-Host "Do you want to create Extrated Text files?: [Y/N]?"
If($extractedTextGenerator -eq "y"){
    .\Scripts\CreateExtractedText.ps1
    $extractedTextSize = (get-item $createDirectory\TEXT\TEXT.txt).length/1KB
    $extractedTextLoadFile = "^TEXT\TEXT.txt^|^$extractedTextSize^"
    }


########

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
   $controlNumber = '{0:d8}' -f ($currentCount+$startControlNumber)
   add-content $filepath -Value "^REL$controlNumber^$fieldscontent^NATIVES\$line^|$extractedTextLoadFile"
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