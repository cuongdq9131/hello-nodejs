$targetfolder='H:\Setup'
$dataColl = @()
gci -recurse -force $targetfolder -ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | foreach {
$len = 0
gci -recurse -force $_.fullname -ErrorAction SilentlyContinue | % { $len += $_.length }
$foldername = $_.fullname
$foldersize= '{0:N2}' -f ($len / 1Mb)
$dataObject = New-Object PSObject
Add-Member -inputObject $dataObject -memberType NoteProperty -name “Folder Name” -value $foldername
Add-Member -inputObject $dataObject -memberType NoteProperty -name “Folder SizeGb” -value $foldersize
$dataColl += $dataObject
}

$dataColl|Sort-object @{Expression = "Folder Name";}| Out-GridView -Title “Size of subdirectories”
#$dataColl|Export-Csv "F:\Setup\abc.csv"

abc
