$createDirectoryForData = New-Item -Path $createDirectory -type "directory" -Name "IMAGES"
$listOfSupportedFiles = @("JPEG", "ICO", "BMP", "GIF", "TIFF", "TIF", "JNG", "KOALA", "LBM", "PBM", "IFF", "PCD", "PCX", "PGM", "PPM", "RAS", "TARGA", "TGA", "WBMP", "PSD", "CUT", "XBM", "DDS", "FAX", "SGI", "PNG", "EXF", "EXIF", "WEBP", "WDP")

#choose file size
$fixOrRandom = Read-Host -Prompt "Do you want use random or fixed size files?: [R]andom/[F]ixed"
If ($fixOrRandom -eq 'R'){

    #input minimum and maxiumum file size

    while($minimumSizeFileRandom -ge $maximumSizeFileRandom){
    $minimumSizeFileRandom = Read-Host -Prompt "Minimum file size in KB?: "
    $maximumSizeFileRandom = Read-Host -Prompt "Maxiumum file size in KB?: "

    if ($minimumSizeFileRandom -ge $maximumSizeFileRandom){
        Write-Host "Minimum has to be less or equal Maxiumum"
        }           
    }
    Write-Host "If you want to create all of supported documents type '[A]ll' or number greater than 138"
    $numberofDocuments = Read-Host "How many uniqe random docs do you want to create?: "
    $createdDocuments = 1
    If ($numberofDocuments -eq "A"){
        $numberToCreate = 139}
        else{
            $numberToCreate = $numberofDocuments
        }

    while($createdDocuments -lt $numberToCreate){ 
        foreach($file in  $listOfSupportedFiles){
            $sizeOfDocuments = Get-Random -Minimum $minimumSizeFileRandom -Maximum $maximumSizeFileRandom
            $sizeOfDocuments = [int]$sizeOfDocuments * 1024
            fsutil file createnew $createDirectoryForData\$createdDocuments'_'$file.$file $sizeOfDocuments
            $createdDocuments++
            If ($createdDocuments -gt $numberToCreate){
                break
                }
            }
        }
    }
          
If ($fixOrRandom -eq 'F'){    
    $sizeOfDocuments = Read-Host -Prompt "What size of document in KB?"
    $sizeOfDocuments = [int]$sizeOfDocuments * 1024

    foreach($file in $listOfSupportedFiles){
        fsutil file createnew $createDirectoryForData\$file.$file $sizeOfDocuments
        }
    }

Remove-Variable -Name * -ErrorAction SilentlyContinue