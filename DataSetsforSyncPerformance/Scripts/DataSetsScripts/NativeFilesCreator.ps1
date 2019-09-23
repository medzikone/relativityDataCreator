$createDirectoryForData = New-Item -Path $createDirectory -type "directory" -Name "NATIVES"
$listOfSupportedFiles = "Data\ListOfSupportedFiles.txt"

#choose file size
If ($fixOrRandom -eq 'R'){

    #input minimum and maxiumum file size
    
    do {
        try {
            $numOk = $true
        }
        catch {$numOK = $false}
    }
    until ($minimumSizeFileRandom -ge 1 -and $maximumSizeFileRandom -ge 1 -and ($minimumSizeFileRandom -lt $maximumSizeFileRandom) -and $numOK)
  
    }
    
    $createdDocuments = 1
    If ($numberofDocuments -eq "A"){
        $numberToCreate = 139}
        else{
            $numberToCreate = $numberofDocuments
        }

    while($createdDocuments -lt $numberToCreate){ 
        foreach($file in Get-Content $listOfSupportedFiles){
            $sizeOfDocuments = Get-Random -Minimum $minimumSizeFileRandom -Maximum $maximumSizeFileRandom
            $sizeOfDocuments = [int]$sizeOfDocuments * 1024
            fsutil file createnew $createDirectoryForData\$createdDocuments'_'$file.$file $sizeOfDocuments
            $createdDocuments++
            If ($createdDocuments -gt $numberToCreate){
                break
                }
            }
        }
    
          
If ($fixOrRandom -eq 'F'){    
    $sizeOfDocuments = [int]$sizeOfDocuments * 1024

    foreach($file in Get-Content $listOfSupportedFiles){
        fsutil file createnew $createDirectoryForData\$file.$file $sizeOfDocuments
        }
    }

Remove-Variable -Name * -ErrorAction SilentlyContinue