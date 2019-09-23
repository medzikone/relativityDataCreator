$loadFileName = Read-Host 'Enter Loadfile name'

$numberOfLines = Read-Host 'How many documents in the Loadfile?'

$newDirectoryPath = Read-Host "Provide path where you want to create data: "

$fixOrRandom = Read-Host -Prompt "Do you want use random or fixed size files?: [R]andom/[F]ixed"

If ($fixOrRandom -eq 'R'){

    #input minimum and maxiumum file size
    Write-Host "If you want to create all of supported documents type '[A]ll' or number greater than 138"
    $numberofDocuments = Read-Host "How many uniqe random docs do you want to create?: "
    Write-Host "Minimum has to be less than Maxiumum"

    do {
        try {
            $numOk = $true
        [int]$minimumSizeFileRandom = Read-Host -Prompt "Minimum file size in KB?: "
        [int]$maximumSizeFileRandom = Read-Host -Prompt "Maxiumum file size in KB?: " 
        }
        catch {$numOK = $false}
    }
    until ($minimumSizeFileRandom -ge 1 -and $maximumSizeFileRandom -ge 1 -and ($minimumSizeFileRandom -lt $maximumSizeFileRandom) -and $numOK)
  
    }
             
If ($fixOrRandom -eq 'F'){    
    $sizeOfDocuments = Read-Host -Prompt "What size of document in KB?"
    }

$extractedTextGenerator = Read-Host "Do you want to create Extrated Text files?: [Y/N]?"

$sizeOfText = Read-Host  "What size of text in KB?: "

$startControlNumber = Read-Host 'Please provide first Control Number: '

.\Scripts\CreateDataSet.ps1