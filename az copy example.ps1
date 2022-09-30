 
Connect-AzAccount -TenantId xxxxxx-02d4-4dcc-9466-46f32a7294f8
 
$storageAccountRG = "Batch10"
$storageAccountName = "sreestorage123"
$storageContainerName = "container"
$localPath = "$HOME\Downloads\packer_new"
 
 
$storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $storageAccountRG -AccountName $storageAccountName).Value[0]
 
$destinationContext = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey
 
$containerSASURI = New-AzStorageContainerSASToken -Context $destinationContext -ExpiryTime(get-date).AddSeconds(3600) -FullUri -Name $storageContainerName -Permission rw
 
azcopy copy $localPath $containerSASURI --recursive
 
