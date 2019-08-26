$loadFileName = Read-Host 'Enter Loadfile name'
$numberOfLines = Read-Host 'How many documents in the Loadfile?'
$newDirectoryPath = Read-Host "Provide path where you want to create data: "

$createDirectory = New-Item -Path $newDirectoryPath -Name $loadFileName -type directory
$filepath = "$createDirectory\$loadFileName.txt"

New-Item $filepath -type file

#produce natives and text files

.\Scripts\DataCreator.ps1 $createDirectory

$extractedTextGenerator = Read-Host "Do you want to create Extrated Text files?: [Y/N]?"
If($extractedTextGenerator = "y"){
    .\Scripts\CreateExtractedText.ps1
    }

$header = Get-Content -Path "Data\FieldsMapping\100_FieldsHeader.txt" #list of Fields Name

add-content $filepath -Value $header

$fieldscontent = Get-Content -Path "Data\FieldsMapping\FilledFields.txt" #content for Fields

#get list of created files

$directoryWithItems = "$createDirectory\NATIVES" #native file location
$listOfItems = Get-ChildItem $directoryWithItems | ForEach-Object { $_.Name }

#create CSV Load File
$currentCount = 0

while($currentCount -lt $numberOfLines){

foreach($line in $listOfItems) {
   $controlNumber = '{0:d8}' -f ($currentCount+1)
   add-content $filepath -Value "^REL$controlNumber^$fieldscontent^NATIVES\$line^|^$extractedTextPath"
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