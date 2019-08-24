$directoryWithItems = "S:\DataSetsforSyncPerformance\FilesfromEDRM\1KB_SupportedFiles"
$listOfItems = "S:\DataSetsforSyncPerformance\FilesfromEDRM\listofitems.txt"

Get-ChildItem $directoryWithItems | ForEach-Object { $_.Name } > $listOfItems
