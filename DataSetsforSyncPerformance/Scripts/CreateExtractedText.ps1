#Extracted Text generator

$createDirectoryForText = New-Item -Path $createDirectory -type "directory" -Name "TEXT"

#choose file size
$fixOrRandomText = Read-Host -Prompt "Do you want use random or fixed EXTRACTED TEXT size files?: [R]andom/[F]ixed"
If ($fixOrRandomText -eq 'R'){

    $numberofTextDocuments = Read-Host "How many uniqe random text files do you want to create?: "

    #input minimum and maxiumum file size
    Write-Host "Minimum has to be less than Maxiumum"

    do {
        try {
            $numOk = $true
        [int]$minimumTextSizeFileRandom = Read-Host -Prompt "Minimum file size in KB?: "
        [int]$maximumTextSizeFileRandom = Read-Host -Prompt "Maxiumum file size in KB?: " 
        }
        catch {$numOK = $false}
    }
    until ($minimumTextSizeFileRandom -ge 1 -and $maximumTextSizeFileRandom -ge 1 -and ($minimumTextSizeFileRandom -lt $maximumTextSizeFileRandom) -and $numOK)
  
    $createdTextDocuments = 1
    
    #data creator
    for($textFile=0; $textFile -lt $numberofTextDocuments; $textFile++){

        $generateOneKB = Get-Random -Minimum $minimumTextSizeFileRandom -Maximum $maximumTextSizeFileRandom

        $extractedText = -join((33..126) *11*100 | Get-Random -Count 1024 | % {[char]$_})
        Add-Content -NoNewline -path "$createDirectoryForText\TEXT$textFile.txt" -value ($extractedText*$generateOneKB)

        }
    }
          
If ($fixOrRandomText -eq 'F'){    
        $sizeOfText = Read-Host  "What size of text in KB?: "
       
        $extractedText = -join((33..126) *11*100 | Get-Random -Count 1024 | % {[char]$_})
        Add-Content -NoNewline -path "$createDirectoryForText\TEXT.txt" -value ($extractedText*$sizeOfText)
            
    }

Remove-Variable -Name * -ErrorAction SilentlyContinue